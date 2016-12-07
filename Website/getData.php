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
$endDay = strtotime('today midnight');

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
	array('label' => 'Temp', 'type' => 'number'),
	array('label' => 'Dew', 'type' => 'number'),
	//array('label' => 'Heat Index', 'type' => 'number'),
	//array('label' => 'Wind Chill', 'type' => 'number'),
	//array('label' => 'Pressure', 'type' => 'number'),
	//array('label' => 'Radiation', 'type' => 'number'),
	//array('label' => 'UV Index', 'type' => 'number'),
	//array('label' => 'WindSpeed', 'type' => 'number'),
	//array('label' => 'WindGustSpeed', 'type' => 'number')	
);

$rows = array();

while($r = mysql_fetch_assoc($query))
{
	$mdat = $r['dateTime'];
	if ($mdat > $endDay){
		if ( ($mdat % 900) == 0) // If it's within our interval, save the data
		{
			// Date/Time
			$tdat = new DateTime("@$mdat");
			$tdat->setTimeZone(new DateTimeZone('America/New_York'));
			$rdat = $tdat->format('H:i');
			
			//Temp/Dew
			$Tdat = $r['outTemp'];
			$Tdat = number_format($Tdat, 2, '.', '');
			$Ddat = $r['dewpoint'];
			$Ddat = number_format($Ddat, 2, '.', '');
			
			//Heat Index/Wind Chill
			//$HIdat = $r['heatindex'];
			//$HIdat = number_format($pdat, 2, '.', '');
			//$WCdat = $r['windchill'];
			//$WCdat = number_format($wdat, 2, '.', '');
			
			//Pressure
			//$Pdat = $r['barometer'];
			//if ($Pdat == 0)
			//{
			//	$Pdat = 29.92;
			//}
			//$Pdat = $Pdat * 33.8637526;
			//$Pdat = number_format($Pdat, 2, '.', '');
			
			//Solar
			//$RADdat = $r['radiation'];
			//$RADdat = number_format($RADdat, 2, '.', '');
			//$Udat = $r['UV'];
			
			//Wind
			//$Wdat = $r['windSpeed'];
			//$Wdat = number_format($Wdat, 2, '.', '');
			//$Gdat = $r['windGust'];
			
			// Now save everything in an array...
			$temp = array();
		    $temp[] = array('v' => (string) $rdat);  //Time
		    $temp[] = array('v' => (float) $Tdat);   //Temp
			$temp[] = array('v' => (float) $Ddat);   //Dewp
			//$temp[] = array('v' => (float) $HIdat);  //Heat Index
			//$temp[] = array('v' => (float) $WCdat);  //Wind Chill
			//$temp[] = array('v' => (float) $Pdat);   //Pressure
			//$temp[] = array('v' => (float) $RADdat); //Solar Radiation
			//$temp[] = array('v' => (float) $Udat);   //UV Index
			//$temp[] = array('v' => (float) $Wdat);   //Wind Speed
			//$temp[] = array('v' => (float) $Gdat);   //Wind Gusts
			
			
			// Make the previous array a row in this new array
		    $rows[] = array('c' => $temp);
	    }
    }
}

$table['rows'] = $rows; // Build a table out of the rows array
$jsonTable = json_encode($table); //encode the table into the json format

// Close up
mysql_close($server);

// Send back to Javascript ...
echo $jsonTable;
?>
