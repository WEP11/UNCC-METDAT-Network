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
$hour = 60;
$day = 1440;
$week = 10080;
$month = 43200;
$year = 525600;

$timeSpan = $day;
$interval = 15;

$filter = $timeSpan / $interval;
$rows = (int) ($grabCount[0]);

$rowStart = ($rows - 1440);
$rowEnd = $rows;


// Query the Database for what you want
$myquery = "SELECT * FROM archive ORDER BY dateTime ASC LIMIT $rowStart, $rowEnd";

$query = mysql_query($myquery);

 if ( ! $query ) 
 {
        echo mysql_error();
        die;
}

// Build an array thats Google Charts Readable ... ... ...
$table=array();
$table['cols'] = array(
	// Chart Labels (i.e. column headers)
	array('label' => 'dateTime', 'type' => 'string'),
	array('label' => 'Heat Index', 'type' => 'number'),
	array('label' => 'Wind Chill', 'type' => 'number')
);

$rows = array();

while($r = mysql_fetch_assoc($query))
{
	$mdat = $r['dateTime'];
	if ( ($mdat % 900) == 0) // If it's the top of the hour, save the rainfall total
	{
		$tdat = new DateTime("@$mdat");
		$tdat->setTimeZone(new DateTimeZone('America/New_York'));
		$rdat = $tdat->format('H:i');
		$pdat = $r['heatindex'];
		$pdat = number_format($pdat, 2, '.', '');
		$wdat = $r['windchill'];
		$wdat = number_format($wdat, 2, '.', '');
		$temp = array();
	    $temp[] = array('v' => (string) $rdat); 
	    $temp[] = array('v' => (float) $pdat);
		$temp[] = array('v' => (float) $wdat);
	    $rows[] = array('c' => $temp);
    }
}

$table['rows'] = $rows;
$jsonTable = json_encode($table);

// Close up
mysql_close($server);

// Send back to Javascript ...
echo $jsonTable;
?>
