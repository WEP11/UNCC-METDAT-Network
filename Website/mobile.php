<!DOCTYPE html>
<html>
	<head>
		
		<!-- Include meta tag to ensure proper rendering and touch zooming -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script type="text/javascript" src="https://www.google.com/jsapi"></script>
		
		<link rel="stylesheet" href="themes/mobile.min.css" />
		<link rel="stylesheet" href="themes/jquery.mobile.icons.min.css" />
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile.structure-1.4.5.min.css" />
		<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
		
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		
		<script>
			(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
				(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
				m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
				})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
			ga('create', 'UA-54843224-1', 'auto');
			ga('require', 'displayfeatures');
			ga('send', 'pageview');
		</script>

	</head>
	<body>
		
		<div data-role="page" id="pageone">
			
			<div data-role="header">
				<h3>Current Weather</h3>
			</div>
			<div id="UNCC_Alerts">
			<div id="www-uncc-edu-alert"></div></div>
			<div data-role="main" class="ui-content">
				<div id="dattim"></div>
				<div id="gages">
					<div id="gage1" style="float:left;"></div>
					<div id="gage2" style="float:left;"></div>
				</div>
				<table data-role="table" class="ui-responsive ui-shadow" id="myTable">
					<thead>
						<th></th>
						<th></th>
					</thead>
					<tbody>
						<tr>
						<td><b>Temperature:</b></td>
						<td id="T"> </td>
						</tr>
						
						<tr>
						<td><b>Feels Like:</b></td>
						<td id="HI"> </td>
						</tr>
												
						<tr>
						<td><b>Dewpoint:</b></td>
						<td id="Td"> </td>
						</tr>
						
						<tr>
						<td><b>Humidity:</b></td>
						<td id="RH"> </td>
						</tr>
											
						<tr>
						<td><b>Wind:</b></td>
						<td id="w"> </td>
						</tr>
						
						<tr>
						<td><b>Rain Rate:</b></td>
						<td id="rr"> </td>
						</tr>
						
						<tr>
						<td><b>UV Index:</b></td>
						<td id="UV"> </td>
						</tr>
						
					</tbody>
				</table>
				<div data-role="controlgroup" data-type="horizontal">
				  <a href="#pagetwo" class="ui-btn" data-transition="slide">Radar</a>
				  <a href="#pagethree" class="ui-btn" data-transition="slide">Graphs</a>
				  <a href="#pagefour" class="ui-btn" data-transition="slide">Hazards</a>
				</div>
			</div>
			<div data-role="footer">
				<h1>V1.0 - weather.uncc.edu</h1>
			</div>
		</div> 
		<div data-role="page" id="pagetwo">
			<div data-role="header">
				<h1>UNC Charlotte Weather</h1>
			</div>
			
			<div data-role="main" class="ui-content">
				<img id="the_pic" align="center" src="data/nexrad/gif/CLT_TR0.gif" width="100%">
			</div>
			<div data-role="footer">
				<div data-role="navbar">
				<ul>
					<li><a href="#info" class="ui-btn ui-icon-info ui-btn-icon-top" data-transition="slide">Information</a></li>
					<li><a href="#pageone" class="ui-btn ui-icon-home ui-btn-icon-top" data-transition="slide">Home</a></li>
					<li><a href="#" data-rel="back" class="ui-btn ui-icon-back ui-btn-icon-top" data-transition="slide">Back</a></li>
				</ul>
				</div>
			</div>
		</div>
		
		
		<div data-role="page" id="pagethree">
			<div data-role="header">
				<h1>UNC Charlotte Weather</h1>
			</div>
			
			<div data-role="main" class="ui-content">
				<div data-role="controlgroup" data-type="horizontal">
				  <a href="#tempgraf" class="ui-btn" data-transition="slide">Temp/Dewp</a>
				  <a href="#windgraf" class="ui-btn" data-transition="slide">Wind</a>
				  <a href="#raingraf" class="ui-btn" data-transition="slide">Rain</a>
				</div>
			</div>
			<div data-role="footer">
				<div data-role="navbar">
				<ul>
					<li><a href="#info" class="ui-btn ui-icon-info ui-btn-icon-top" data-transition="slide">Information</a></li>
					<li><a href="#pageone" class="ui-btn ui-icon-home ui-btn-icon-top" data-transition="slide">Home</a></li>
					<li><a href="#" data-rel="back" class="ui-btn ui-icon-back ui-btn-icon-top" data-transition="slide">Back</a></li>
				</ul>
				</div>
			</div>
		</div>
		<div data-role="page" id="tempgraf">
			<div data-role="header">
				<h1>UNC Charlotte Weather</h1>
			</div>
			
			<div data-role="main" class="ui-content">
				<img id="temp_pic" align="center" src="data/stnplot/daytempdew.png" width="100%">
				<div data-role="controlgroup" data-type="horizontal">
				  <input type="button" value="Day" id="TempDay" onclick="tempClick(this.id)">
				  <input type="button" value="Week" id="TempWeek" onclick="tempClick(this.id)">
				  <input type="button" value="Month" id="TempMonth" onclick="tempClick(this.id)">
				  <input type="button" value="Year" id="TempYear" onclick="tempClick(this.id)">
				</div>
			</div>
			<div data-role="footer">
				<div data-role="navbar">
				<ul>
					<li><a href="#info" class="ui-btn ui-icon-info ui-btn-icon-top" data-transition="slide">Information</a></li>
					<li><a href="#pageone" class="ui-btn ui-icon-home ui-btn-icon-top" data-transition="slide">Home</a></li>
					<li><a href="#" data-rel="back" class="ui-btn ui-icon-back ui-btn-icon-top" data-transition="slide">Back</a></li>
				</ul>
				</div>
				
			</div>
		</div>
		<div data-role="page" id="windgraf">
			<div data-role="header">
				<h1>UNC Charlotte Weather</h1>
			</div>
			
			<div data-role="main" class="ui-content">
				<img id="wind_pic" align="center" src="data/stnplot/daywind.png" width="100%">
				<div data-role="controlgroup" data-type="horizontal">
				  <input type="button" value="Day" id="WindDay" onclick="tempClick(this.id)">
				  <input type="button" value="Week" id="WindWeek" onclick="tempClick(this.id)">
				  <input type="button" value="Month" id="WindMonth" onclick="tempClick(this.id)">
				  <input type="button" value="Year" id="WindYear" onclick="tempClick(this.id)">
				</div>
			</div>
			<div data-role="footer">
				<div data-role="navbar">
				<ul>
					<li><a href="#info" class="ui-btn ui-icon-info ui-btn-icon-top" data-transition="slide">Information</a></li>
					<li><a href="#pageone" class="ui-btn ui-icon-home ui-btn-icon-top" data-transition="slide">Home</a></li>
					<li><a href="#" data-rel="back" class="ui-btn ui-icon-back ui-btn-icon-top" data-transition="slide">Back</a></li>
				</ul>
				</div>
				
			</div>
		</div>
		<div data-role="page" id="raingraf">
			<div data-role="header">
				<h1>UNC Charlotte Weather</h1>
			</div>
			
			<div data-role="main" class="ui-content">
				<img id="rain_pic" align="center" src="data/stnplot/dayrain.png" width="100%">
				<div data-role="controlgroup" data-type="horizontal">
				  <input type="button" value="Day" id="RainDay" onclick="tempClick(this.id)">
				  <input type="button" value="Week" id="RainWeek" onclick="tempClick(this.id)">
				  <input type="button" value="Month" id="RainMonth" onclick="tempClick(this.id)">
				  <input type="button" value="Year" id="RainYear" onclick="tempClick(this.id)">
				</div>
			</div>
			<div data-role="footer">
				<div data-role="navbar">
				<ul>
					<li><a href="#info" class="ui-btn ui-icon-info ui-btn-icon-top" data-transition="slide">Information</a></li>
					<li><a href="#pageone" class="ui-btn ui-icon-home ui-btn-icon-top" data-transition="slide">Home</a></li>
					<li><a href="#" data-rel="back" class="ui-btn ui-icon-back ui-btn-icon-top" data-transition="slide">Back</a></li>
				</ul>
				</div>
				
			</div>
		</div>
		
		
		<div data-role="page" id="pagefour">
			<div data-role="header">
				<h1>UNC Charlotte Weather</h1>
			</div>
			
			<div data-role="main" class="ui-content">
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
				<a href="#pageone" class="ui-btn" data-transition="slide">Go Back...</a>
			</div>
			<div data-role="footer">
				<h1>V1.0 - weather.uncc.edu</h1>
			</div>
		</div>
		<div data-role="page" id="info">
			
	  		<div data-role="header">
	  			<h1>Information</h1>
	  		</div>
	  		<div data-role="main" class="ui-content">
	  			<img id="logo_pic" align="center" src="http://advancement.uncc.edu/sites/advancement.uncc.edu/files/media/crown.gif" width="40%"> <img id="logo_pic" align="center" src="src/LogoIdea.png" width="40%">
		 		<p>The UNC Charlotte Mobile Weather Portal is provided by the UNC Charlotte Meteorology Program, a part of the Department of Geography and Earth Sciences. For additional information, go to http://weather.uncc.edu/faq or http://geoearth.uncc.edu/ .</p>
  				<a href="#" align="center" data-rel="back" class="ui-btn ui-btn-inline ui-shadow ui-corner-all" data-transition="slide">Go Back</a>
		  	</div>
	  		<div data-role="footer">
				<h1>V1.0 - weather.uncc.edu</h1>
			</div>
			
		</div> 
		

		<script src="mobileStats.js" type="text/javascript"></script>
		<script>
			function tempClick(value)
			{
			        
			        if (value == "TempDay"){
			        	temp_pic.src = "data/stnplot/daytempdew.png";
			        } else if (value == "TempWeek"){
			        	temp_pic.src = "data/stnplot/weektempdew.png";
			        } else if (value == "TempMonth"){
			        	temp_pic.src = "data/stnplot/monthtempdew.png";
			    	} else if (value == "TempYear"){
			        	temp_pic.src = "data/stnplot/yeartempdew.png";
			        } else if (value == "WindDay"){
			        	wind_pic.src = "data/stnplot/daywind.png";
			        } else if (value == "WindWeek"){
			        	wind_pic.src = "data/stnplot/weekwind.png";
			    	} else if (value == "WindMonth"){
			        	wind_pic.src = "data/stnplot/monthwind.png";
			        } else if (value == "WindYear"){
			        	wind_pic.src = "data/stnplot/yearwind.png";
			        } else if (value == "RainDay"){
			        	rain_pic.src = "data/stnplot/dayrain.png";
			    	} else if (value == "RainWeek"){
			        	rain_pic.src = "data/stnplot/weekrain.png";
			        } else if (value == "RainMonth"){
			        	rain_pic.src = "data/stnplot/monthrain.png";
			    	} else if (value == "RainYear"){
			        	rain_pic.src = "data/stnplot/yearrain.png";
			        }
	        };
			    
		</script>
		<script type="text/javascript" src="unccAlert.js" defer="defer"></script>
	</body>
</html>
