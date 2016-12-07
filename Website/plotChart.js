	//var chartWidth = 800;
	//var chartHeight = 300;	  
	var chartWidth = window.innerWidth * 0.6;
	var chartHeight = window.innerHeight * 0.5;  
	// Load the Visualization API and the piechart package.
	google.load('visualization', '1', {'packages':['corechart']});
	  
	// Set a callback to run when the Google Visualization API is loaded.
	google.setOnLoadCallback(drawChart);
	  
	function drawChart() {
		
		  var jsonData = $.ajax({
		  url: "getData.php",
		  dataType:"json",
		  async: false
		  }).responseText;
		  
	//window.alert(jsonData);
	// Create our data table out of JSON data loaded from server.
	var data = new google.visualization.DataTable(jsonData);
	
	//data.setView({'cols':[0,1,2]});
	
	var options = {
	    width: chartWidth,
	    height: chartHeight,
	    backgroundColor: '#FFFFFF',
	    legend:{
	    	textStyle:{color:'black'}
	    },
	
	    hAxis: {
	      title: 'Time (EST)',
	      baselineColor: 'black',
	      textStyle:{color:'black',fontSize:'9'},
	      slantedText: true,
	      slantedTextAngle:45,
	      titleTextStyle:{color:'black'}
	    },
	   
	    vAxis: {
	      title: 'Temperature(F)',
	      baselineColor: 'black',
	      textStyle:{color:'black'},
	      titleTextStyle:{color:'black'}
	    },
	   
	    colors: ['#FF0000', '#005F00']
	 		        
	  };
	  
	  // Instantiate and draw our chart, passing in some options.
	  var chart = new google.visualization.LineChart(document.getElementById('Tchart_div'));
	  chart.draw(data, options);
	  
	  var jsonData = $.ajax({
		  url: "getDataP.php",
		  dataType:"json",
		  async: false
		  }).responseText;
		  
	  // Create our data table out of JSON data loaded from server.
	var data = new google.visualization.DataTable(jsonData);
	
	
	var options = {
	    width: chartWidth,
	    height: chartHeight,
	    backgroundColor: '#FFFFFF',
	    legend:{
	    	textStyle:{color:'black'}
	    },
	    hAxis: {
	      title: 'Time (EST)',
	      baselineColor: 'black',
	      textStyle:{color:'black', fontSize:'9'},
	      slantedText: true,
	      slantedTextAngle:45,
	      titleTextStyle:{color:'black'}
	    },
	   
	    vAxis: {
	      title: 'Sea Level Pressure (mb)',
	      baselineColor: 'black',
	      textStyle:{color:'black'},
	      titleTextStyle:{color:'black'}
	        },
	   
	        colors: ['#0066FF', '#007329']
	 		        
	  };
	  
	  // Instantiate and draw our chart, passing in some options.
	  var chart = new google.visualization.LineChart(document.getElementById('Pchart_div'));
	  chart.draw(data, options);
	
	var jsonData = $.ajax({
		  url: "getDataW.php",
		  dataType:"json",
		  async: false
		  }).responseText;
		  
	  // Create our data table out of JSON data loaded from server.
	var data = new google.visualization.DataTable(jsonData);
	
	var options = {
	    width: chartWidth,
	    height: chartHeight,
	    legend:{
	    	textStyle:{color:'black'}
	    },
	    hAxis: {
	      title: 'Time (EST)',
	      baselineColor: 'black',
	      textStyle:{color:'black', fontSize:'9'},
	      slantedText: true,
	      slantedTextAngle:45,
	      titleTextStyle:{color:'black'}
	    },
	    backgroundColor: '#FFFFFF',
	    vAxis: {
	      title: 'Wind Speed (mph)',
	      baselineColor: 'black',
	      textStyle:{color:'black'},
	      titleTextStyle:{color:'black'}
	        },
	   
	        colors: ['#0033CC', '#FF0000']
	 		        
	  };
	  
	  // Instantiate and draw our chart, passing in some options.
	  var chart = new google.visualization.LineChart(document.getElementById('Wchart_div'));
	  chart.draw(data, options);
	
	var jsonData = $.ajax({
		  url: "getDataS.php",
		  dataType:"json",
		  async: false
		  }).responseText;
		  
	  // Create our data table out of JSON data loaded from server.
	var data = new google.visualization.DataTable(jsonData);
	
	var options = {
	    width: chartWidth,
	    height: chartHeight,
	    legend:{
	    	textStyle:{color:'black'}
	    },
	    hAxis: {
	      title: 'Time (EST)',
	      baselineColor: 'black',
	      textStyle:{color:'black',fontSize:'9'},
	      slantedText: true,
	      slantedTextAngle:45,
	      titleTextStyle:{color:'black'}
	    },
	    backgroundColor: '#FFFFFF',
	    vAxis: {
	      0: {title: 'Solar Radiation (w/m^2)',
		      baselineColor: 'black',
		      textStyle:{color:'black'},
		      titleTextStyle:{color:'black'}
		    },
		  1: {
		  		title: 'UV Index',
		      	baselineColor: 'black',
		      	textStyle:{color:'black'},
		      	titleTextStyle:{color:'black'}
		  	}
	        },
	        series: {0: {targetAxisIndex:0},
	                 1:{targetAxisIndex:1}
	               },
	   
	        colors: ['#FFFF00','#FF33CC']
	 		        
	  };
	  
	  // Instantiate and draw our chart, passing in some options.
	  var chart = new google.visualization.LineChart(document.getElementById('Schart_div'));
	  chart.draw(data, options);
	
	var jsonData = $.ajax({
		  url: "getDataH.php",
		  dataType:"json",
		  async: false
		  }).responseText;
		  
	  // Create our data table out of JSON data loaded from server.
	var data = new google.visualization.DataTable(jsonData);
	
	var options = {
	    width: chartWidth,
	    height: chartHeight,
	    legend:{
	    	textStyle:{color:'black'}
	    },
	    hAxis: {
	      title: 'Time (EST)',
	      baselineColor: 'black',
	      textStyle:{color:'black',fontSize:'9'},
	      slantedText: true,
	      slantedTextAngle:45,
	      titleTextStyle:{color:'black'}
	    },
	    backgroundColor: '#FFFFFF',
	    vAxis: {
	      title: 'Apparent Temperature (F)',
	      baselineColor: 'black',
	      textStyle:{color:'black'},
	      titleTextStyle:{color:'black'}
	        },
	   
	        colors: ['#FF0000','#FF33CC']
	 		        
	  };
	  
	  // Instantiate and draw our chart, passing in some options.
	  var chart = new google.visualization.LineChart(document.getElementById('Hchart_div'));
	  chart.draw(data, options);
	
	  
		var jsonDataR = $.ajax({
		  url: "getDataR.php",
		  dataType:"json",
		  async: false
		  }).responseText;
	      
	  // Create our data table out of JSON data loaded from server.
	var Rdata = new google.visualization.DataTable(jsonDataR);
	
	var options = {
	    width: chartWidth,
	    height: chartHeight,
	    legend:{
	    	textStyle:{color:'black'}
	    },
	    hAxis: {
	      title: 'Time (EST)',
	      baselineColor: 'black',
	      textStyle:{color:'black', fontSize:'9'},
	      slantedText: true,
	      slantedTextAngle:45,
	      titleTextStyle:{color:'black'}
	    },
	    backgroundColor: '#FFFFFF',
	    vAxis: {
	     0:{ title: 'Hourly Rainfall (in)',
	      baselineColor: 'black',
	      textStyle:{color:'black'},
	      titleTextStyle:{color:'black'}
	        },
	     1:{ title: 'Accumulated Rainfall (in)',
	      baselineColor: 'black',
	      textStyle:{color:'black'},
	      titleTextStyle:{color:'black'}
	        }
	        },
	   
	        colors: ['#005F00', '#e2431e'],
	        seriesType: 'bars',
	        series: {0:{targetAxisIndex:0, type:'bars'}, 1: {targetAxisIndex:1, type:'line'}},
	        chartArea: {height: 150, width: 650} 
	 		        
	  };
	  
	  // Instantiate and draw our chart, passing in some options.
	  var chart = new google.visualization.ComboChart(document.getElementById('Rchart_div'));
	  chart.draw(Rdata, options);
	}

