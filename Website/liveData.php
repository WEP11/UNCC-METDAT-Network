<?php 

	ob_start();

	ob_end_clean();
	
	// Create connection
	$server = mysql_connect($server, $username, $password);
	$connection = mysql_select_db($database, $server);
	//--------------------------------------------------------------------------
	// 2) Query database for data
	//--------------------------------------------------------------------------
	$result = mysql_query("SELECT * FROM archive ORDER BY dateTime DESC LIMIT 1");          //query
	$array = mysql_fetch_row($result);                          //fetch result  
	$array[0] = new DateTime("@$array[0]");
	$array[0]->setTimeZone(new DateTimeZone('America/New_York'));
	$array[0] = $array[0]->format('d-M-Y H:i');  
	
	//--------------------------------------------------------------------------
	// 3) echo result as json 
	//--------------------------------------------------------------------------
	mysql_close($server);
	echo json_encode($array);
	unset($result,$array,$server,$connection);

?>
