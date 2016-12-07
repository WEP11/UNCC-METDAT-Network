<?php
	$dir = 'data/NOAA';
	$files = scandir($dir);
	$jsonTable = json_encode($files);
	echo $jsonTable;
?>