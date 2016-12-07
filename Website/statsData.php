<?php // content="text/plain; charset=utf-8"

ob_start();

ob_end_clean();

// Create connection
$server = mysql_connect($server, $username, $password);
$connection = mysql_select_db($database, $server);

// Go through all this trouble for a row count ... ... ...
$count = mysql_query("select count(1) FROM archive");
$grabCount = mysql_fetch_array($count);

 if ( ! $count ) 
 {
        echo mysql_error();
        die;
}
 
// ROW BOUNDARIES  ... ... ...
$rows = (int) ($grabCount[0]);

// Let's assume that the max time between yesterday and today will only ever be 48 hours
$rowStart = ($rows - 1440);
$rowEnd = $rows;

// We need to find the timestamps between the two dates we want...
//$startDay = strtotime('today midnight');
//$endDay = strtotime('yesterday midnight');
$endDay = strtotime('today midnight');
// Now the row number of yesterday morning at midnight

// Query the Database for what you want
$myquery = "SELECT * FROM archive ORDER BY dateTime ASC LIMIT $rowStart, $rowEnd";

$query = mysql_query($myquery);

 if ( ! $query ) 
 {
        echo mysql_error();
        die;
}


$data = array(); //Prep array

$hTtim = 0;
$ht = 0;
$lTtim = 0;
$lt = 9999;
$rainTot = 0;
$hiWnd = 0;
$hiWndTim = 0;
$hiPres = 0;
$hiPresTim = 0;
$loPres = 9999;
$loPresTim = 0;

while($r = mysql_fetch_assoc($query))
{
	
		$tempT = $r['outTemp'];
		$tempW = $r['windSpeed'];
		$tempP = $r['barometer'];
		$tempTime = $r['dateTime'];
		$rainDrop = $r['rain'];
	if($tempTime >= $endDay){	
		if ($tempT > $ht){
			$ht = $tempT;
			$hTtim = $tempTime;
		}
		if ($tempT < $lt){
			$lt = $tempT;
			$lTtim = $tempTime;
		}
		if ($tempW > $hiWnd){
			$hiWnd = $tempW;
			$hiWndTim = $tempTime;
		}
		if ($tempP > $hiPres){
			$hiPres = $tempP;
			$hiPresTim = $tempTime;
		}
		if ($tempP < $loPres){
			$loPres = $tempP;
			$loPresTim = $tempTime;
		}
		$rainTot = $rainTot + $rainDrop;
	}
}
$hTtim = new DateTime("@$hTtim");
$hTtim->setTimeZone(new DateTimeZone('America/New_York'));
$hTtim = $hTtim->format('H:i d-M');

$lTtim = new DateTime("@$lTtim");
$lTtim->setTimeZone(new DateTimeZone('America/New_York'));
$lTtim = $lTtim->format('H:i d-M');

$hiWndTim = new DateTime("@$hiWndTim");
$hiWndTim->setTimeZone(new DateTimeZone('America/New_York'));
$hiWndTim = $hiWndTim->format('H:i d-M');

$hiPresTim = new DateTime("@$hiPresTim");
$hiPresTim->setTimeZone(new DateTimeZone('America/New_York'));
$hiPresTim = $hiPresTim->format('H:i d-M');

$loPresTim = new DateTime("@$loPresTim");
$loPresTim->setTimeZone(new DateTimeZone('America/New_York'));
$loPresTim = $loPresTim->format('H:i d-M');

$data[0] = $hTtim;
$data[1] = $ht;
$data[2] = $lTtim;
$data[3] = $lt;
$data[4] = $hiWndTim;
$data[5] = $hiWnd;
$data[6] = $hiPresTim;
$data[7] = $hiPres;
$data[8] = $loPresTim;
$data[9] = $loPres;
$data[10] = $rainTot;

$jsonTable = json_encode($data);

// Close up
mysql_close($server);

// Send back to Javascript ...
echo $jsonTable;
?>
