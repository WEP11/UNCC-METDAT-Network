<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="description" content="Current weather for UNC Charlotte and the greater Charlotte-Mecklenburg region. This weather portal is operated by the UNC Charlotte Meteorology Program.">
		<meta name="author" content="Warren Pettee">
		<title>UNC Charlotte Weather</title>
		
		<!--<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="-1">-->
		<link rel="stylesheet" type="text/css" href="main.css"/>
		<!--Load the AJAX API-->
		<script type="text/javascript" src="https://www.google.com/jsapi"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script src="tabcontent.js" type="text/javascript"></script>
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script src="src/jquery.tabSlideOut.v1.3.js"></script>
		
		<!-- LOADD MEE -->
		<script>
		$(window).load(function() {
		    $('#load_screen').fadeOut('slow');
		});
		</script>
		<script>
			(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
				(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
				m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
				})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
			ga('create', 'UA-54843224-1', 'auto');
			ga('require', 'displayfeatures');
			ga('send', 'pageview');
		</script>

	    <script type="text/javascript">
	    $(function(){
	        $('.slide-out-div').tabSlideOut({
	            tabHandle: '.handle',                     //class of the element that will become your tab
	            pathToTabImage: 'src/alerts.png', //path to the image for the tab //Optionally can be set using css
	            imageHeight: '122px',                     //height of tab image           //Optionally can be set using css
	            imageWidth: '40px',                       //width of tab image            //Optionally can be set using css
	            tabLocation: 'right',                      //side of screen where tab lives, top, right, bottom, or left
	            speed: 300,                               //speed of animation
	            action: 'click',                          //options: 'click' or 'hover', action to trigger animation
	            topPos: '150px',                          //position from the top/ use if tabLocation is left or right
	            leftPos: '20px',                          //position from left/ use if tabLocation is bottom or top
	            fixedPosition: false                      //options: true makes it stick(fixed position) on scroll
	        });
	
	    });
	
	    </script>
	    <script type="text/javascript">
		  if (screen.width <= 800) {
		  	if (confirm('Would you like to use the mobile version?')) {
			    window.location = "http://weather.uncc.edu/mobile.php";
			} else {
			    // Do nothing!
			}
		    
		  } else if (screen.width <= 600){
		  	window.location = "http://weather.uncc.edu/mobile.php";
		  }
		</script>
	</head>
    
	<body>
		<script type="application/ld+json">
		{
			"@context" : "http://schema.org",
  			"@type" : "EducationalOrganization",
  			"url": "http://weather.uncc.edu/",
  			"logo": "http://weather.uncc.edu/src/LogoIdea.png",
  			"name": "UNC Charlotte Meteorology Program",
  			"description": "The UNC Charlotte Meteorology program provides current weather data to UNC Charlotte and the greater Charlotte-Mecklenburg area through its online Campus Weather Portal . The meteorology program is under the Department of Geography and Earth Sciences at the University of North Carolina at Charlotte.",
  			"address":[{
  				"@type": "PostalAddress",
  				"streetaddress": "9201 University City Blvd",
  				"addressLocality": "Charlotte",
  				"addressRegion": "North Carolina",
  				"postalCode": "28223",
  				"addressCountry": "United States"}]
		}
		</script>
		<div id="wrapper">
		<div id="UNCC_Alerts">
			<div id="www-uncc-edu-alert"></div>
		</div>
		<div id="backgroundImg" style="position:absolute; z-index:-10;">
			<img src="res/unccwxslide.png" align="middle" width="100%" height="100%">
		</div>
		<div id="load_screen">
			<div id="loading" style="text-align:center;margin-left:auto;margin-right:auto;">
				<img src="src/20.gif" id="loader"><br><br><i>Connecting...</i>
			</div>
		</div>
		
		<div id="masthead">
			<h1>University of North Carolina at Charlotte</h1>
			<h2>Campus Weather Portal</h2>
		</div>
		<div id="schoolLogo">
			<p align="right">
				<a href="http://www.uncc.edu/"><img id = "school" src="http://weather.uncc.edu/src/UNCC_Crown_Logo_1c.png"  width="80%" height="80%"/></a>
			</p>
		</div>
		<ul id="navtabs">
			<li id="navtab1" class="navigate"><a href="http://weather.uncc.edu/">Wx Station</a></li>
			<li id="navtab2" class="navigate"><a href="http://weather.uncc.edu/obs/">Observations</a></li>
			<li id="navtab3" class="navigate"><a href="http://weather.uncc.edu/radar/">Radar Room</a></li>
			<li id="navtab4" class="navigate"><a href="http://weather.uncc.edu/climate">Climate</a></li>
			<li id="navtab5" class="navigate"><a href="http://weather.uncc.edu/AirQuality">Air Quality</a></li>
			<li id="navtab6" class="navigate"><a href="http://weather.uncc.edu/res">Resources</a></li>
			<li id="navtab7" class="navigate"><a href="http://weather.uncc.edu/faq">Contact Us...</a></li>
		</ul>
			
		<br>
		<div id="stats_group" >
			<div class="stats">
				<div class="stats_header" >
					<b>Current Conditions</b><br>
					<div id="dattim"><br> </div>
					<div id="icon"></div>
				</div>
				<table style="width:100%">
					<tbody>
						<tr>
						<td class="stats_label">Temperature</td>
						<td class="stats_data" id="T"> </td>
						</tr>
						<tr> </tr>
						<tr>
						<td class="stats_label">Windchill</td>
						<td class="stats_data" id="WC"> </td>
						</tr>
						<tr> </tr>
						<tr>
						<td class="stats_label">Heat Index</td>
						<td class="stats_data" id="HI"> </td>
						</tr>
						<tr>
						<td class="stats_label">Dewpoint</td>
						<td class="stats_data" id="Td"> </td>
						</tr>
						<tr>
						<td class="stats_label">Humidity</td>
						<td class="stats_data" id="RH"> </td>
						</tr>
						<tr>
						<td class="stats_label">Barometer</td>
						<td class="stats_data" id="p"> </td>
						</tr>
						<tr>
						<td class="stats_label">Wind</td>
						<td class="stats_data" id="w"> </td>
						</tr>
						<tr>
						<td class="stats_label">Rain Rate</td>
						<td class="stats_data" id="rr"> </td>
						</tr>
						<tr>
						<td class="stats_label">UV Index</td>
						<td class="stats_data" id="UV"> </td>
						</tr>
						<tr>
						<td class="stats_label">Solar Radiation</td>
						<td class="stats_data" id="sun"> </td>
						</tr>
						<tr>
						<td class="stats_label">LCL</td>
						<td class="stats_data" id="lcl"> </td>
						</tr>
						
					</tbody>
				</table>
				<br>
				<table style="width:100%">
					<tbody>
						<div class="stats_header" >
							Today's Statistics
						</div>
						<tr>
							<td class="stats_label">High Temp:</td>
							<td class="stats_data" id="hi"> </td>
						</tr>
						<tr>
							<td class="stats_label">Low Temp:</td>
							<td class="stats_data" id="lo"> </td>
						</tr>
						<tr>
							<td class="stats_label">Rain:</td>
							<td class="stats_data" id="24rain"> </td>
						</tr>
						<tr>
							<td class="stats_label">High Wind:</td>
							<td class="stats_data" id="24wind"> </td>
						</tr>
						<tr>
							<td class="stats_label">High Pressure:</td>
							<td class="stats_data" id="24hiP"> </td>
						</tr>
						<tr>
							<td class="stats_label">Low Pressure:</td>
							<td class="stats_data" id="24loP"> </td>
						</tr>
					</tbody>
				</table>
				<br>
				<div class="climo" title="View current and past text reports"><a href="text.html">Text Reports</a></div>
				<div class="climo" title="Create custom charts with archived data"><a href="archive/index.php">Archive</a></div>
				<div class="climo" title="View better for mobile devices"><a href="mobile.php">Mobile</a></div>
			</div>
			<br>
			<div id="footer">
		  		<a href="http://emergency.uncc.edu/"><img src="src/badge.png" width="5%" height="5%" style="vertical-align: middle;"><span style="vertical-align: middle;"><b>Campus safety information is available at <i>emergency.uncc.edu</i></b></span><img src="src/badge.png" width="5%" height="5%" style="vertical-align: middle;"></a>
			</div>
		</div>
		
		<br>
		<div id="gages"></div>
		<div id="CHARTS">
			<ul class="tabs" data-persist="true">
	            <li><a href="#view1">Temp/Dew</a></li>
		    	<li><a href="#view2">Pressure</a></li>
		    	<li><a href="#view3">Wind</a></li>
		    	<li><a href="#view4">Hourly Rain</a></li>
		    	<li><a href="#view5">Solar / UV</a></li>
		    	<li><a href="#view6">Heat Index / Wind Chill</a></li>
	        </ul>
	        <div class="tabcontents">
	            <div id="view1">
	            	<div id="Tchart_div"></div>		   
	            </div>
	   	    	<div id="view2">
	                <div id="Pchart_div"></div>
	            </div>
		    	<div id="view3">
	                <div id="Wchart_div"></div>
	            </div>
	            <div id="view4">
	                <div id="Rchart_div"></div>
	            </div>
	            <div id="view5">
	                <div id="Schart_div"></div>
	            </div>
	            <div id="view6">
	                <div id="Hchart_div"></div>
	            </div>
	            
	            
	       </div>
		</div>
				
		</div>	
		
		
		<div class="slide-out-div">
            <a class="handle" href="http://link-for-non-js-users.html">Hazards</a>
            <div id="hazards" style="color:black;text-align:center;">
					<h3 style="color:black;text-align:center;"><b>HAZARDS</b></h3>
					
					<table border="0" style="text-align:center; color:black;">
						<tr>
							<?php 
							$DefaultZone = 'NCZ071'; // set to your NOAA zone
							$detailpage  = 'wxadvisory.php'; // overrides $hurlURL setting
							$doSummary   = false;  // display alert links only, not full alert details
							$includeOnly = false;  // include mode
							$noprint     = false;  // required for echo $advisory_html output
							include 'atom-advisory.php';
							if (preg_match("|There are no active|i",$advisory_html) ||
							   preg_match("|Advisory Information Unavailable|i",$advisory_html)) {
							   echo '<div class="advisoryBoxnoactive">' .$advisory_html .'</div>';
							}else{
							   echo '<div class="advisoryBox">' . $advisory_html .'</div>';
							}
							?>
							
						</tr>
					</table>
					<br>
					<b>Campus safety information is available at <i><a href="http://emergency.uncc.edu/">emergency.uncc.edu</a></i></b>            	
	 	</div>
  </div>
  
     <script src="updateData.js" type="text/javascript"></script>
	 <script src="statsData.js" type="text/javascript"></script>
	 <script type="text/javascript" src="unccAlert.js" defer="defer"></script>
	 <script type="text/javascript" src="plotChart.js"></script>
	</body>
</html>
