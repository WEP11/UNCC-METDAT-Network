$(function() 
  {
  	function liveStn()
  	{
	    //-----------------------------------------------------------------------
	    // 2) Send a http request with AJAX http://api.jquery.com/jQuery.ajax/
	    //-----------------------------------------------------------------------
	    $.ajax({   
	      cache: false,                                   
	      url: 'liveData.php',                  //the script to call to get data          
	      data: "",                        //you can insert url argumnets here to pass to api.php , for example "id=5&parent=6"
	      async: false,                    //Async runs request in background. Allows the refresh to happen.
	      loadonce: false,
	      dataType: 'json',                //data format      
	      success: function(data)          //on recieve of reply
	      {
	        var dateTime = data[0];              
	        var barometer = data[3];           
	        var outTemp = data[7];
	        var RH = data[9];
	        var wndspd = data [10];
	        var wnddir = data[11];
	        var wndgst = data[12];
	        var rainRate = data[14];
	        var dewpoint = data[16];
	        var wndchl = data[17];
	        var htindx = data[18];
	        var radia = data[20];
	        var UV = data[21];
	        
	        var barometer = barometer * 33.8637526;
	        
	        var outTemp = parseFloat(outTemp).toFixed(2);
	        var wndchl = parseFloat(wndchl).toFixed(2);
	        var htindx = parseFloat(htindx).toFixed(2);
	        var dewpoint = parseFloat(dewpoint).toFixed(2);
	        var RH = parseFloat(RH).toFixed(2);
	        var barometer = parseFloat(barometer).toFixed(2);
	        var wndspd = parseFloat(wndspd).toFixed(2);
	        var wnddir = parseFloat(wnddir).toFixed(0);
	        var rainRate = parseFloat(rainRate).toFixed(2);
	        var UV = parseFloat(UV).toFixed(1);
	        var radia = parseFloat(radia).toFixed(2);
	        
	        var temp = (outTemp + 459) * (5/9);
	        var dewp = (dewpoint + 459) * (5/9);
	        
	        var LCL = 125 * (temp - dewp);
	        var LCL = parseFloat(LCL).toFixed(2);
	       
	        //--------------------------------------------------------------------
	        // 3) Update html content
	        //--------------------------------------------------------------------
	        document.getElementById("dattim").innerHTML = dateTime;
	        document.getElementById("T").innerHTML = outTemp + "&#176;F";
	        document.getElementById("WC").innerHTML = wndchl + "&#176;F";
	        document.getElementById("HI").innerHTML = htindx + "&#176;F";
	        document.getElementById("Td").innerHTML = dewpoint + "&#176;F";
	        document.getElementById("RH").innerHTML = RH + "%";
	        document.getElementById("p").innerHTML = barometer + " mb";
	        document.getElementById("w").innerHTML = wndspd + " mph from " + wnddir;
	        document.getElementById("rr").innerHTML = rainRate + " in/hr";
	        document.getElementById("UV").innerHTML = UV ;
	        document.getElementById("sun").innerHTML = radia + " W/m&#178;";
	        document.getElementById("lcl").innerHTML = LCL + " ft";
	        
	        var d = new Date()
	        var hour = d.getHours()
	        
	        if(rainRate == 0 && hour > 18 || rainRate == 0 && hour < 6) {
	        	document.getElementById("icon").innerHTML = "";
	        	var elem = document.createElement("img");
	        	//elem.setAttribute("height", "2%");
				elem.setAttribute("width", "10%");
				elem.setAttribute("alt", "Clear");
				elem.setAttribute("class", "currentIcon")
	        	elem.src = 'src/icons/9.png';
	        	document.getElementById("icon").appendChild(elem);
	        	
	        	setIcon('9.ico')
	        }
	        else if (rainRate == 0 && radia < 100 && hour < 18 && hour > 6) {
	        	document.getElementById("icon").innerHTML = "";
	        	var elem = document.createElement("img");
	        	//elem.setAttribute("height", "2%");
				elem.setAttribute("width", "10%");
				elem.setAttribute("alt", "Raining");
				elem.setAttribute("class", "currentIcon")
	        	elem.src = 'src/icons/2.png';
	        	document.getElementById("icon").appendChild(elem);
	        	
	        	setIcon('2.ico')
	        }
	        else if(rainRate == 0 && hour < 18 && hour > 6){
	        	document.getElementById("icon").innerHTML = "";
	        	var elem = document.createElement("img");
	        	//elem.setAttribute("height", "2%");
				elem.setAttribute("width", "10%");
				elem.setAttribute("alt", "Sunny");
				elem.setAttribute("class", "currentIcon")
	        	elem.src = 'src/icons/1.png';
	        	document.getElementById("icon").appendChild(elem);
	        	
	        	setIcon('1.ico')
	        }
	        else if (rainRate > 0) {
	        	document.getElementById("icon").innerHTML = "";
	        	var elem = document.createElement("img");
	        	//elem.setAttribute("height", "2%");
				elem.setAttribute("width", "10%");
				elem.setAttribute("alt", "Raining");
				elem.setAttribute("class", "currentIcon")
	        	elem.src = 'src/icons/5.png';
	        	document.getElementById("icon").appendChild(elem);
	        	
	        	setIcon('5.ico')
	        }
	        
	        //setIcon('1.ico');
	        
	        //alert(data[0]); // DEBUG
	        /*
	        //--------------------------------------------------------------------
	        // 4) Make fancy meters
	        //--------------------------------------------------------------------
			google.charts.load('current', {'packages':['gauge']});
			google.charts.setOnLoadCallback(drawChart);
			function drawChart() {
				var data = google.visualization.arrayToDataTable([
					['Label', 'Value'],
					['Temp (F)', eval(outTemp)]
					//['Humidity', eval(RH)],
					//['Wind Speed', eval(wndspd)]
				]);
				
				var options = {
					width: 400, height: 120,
					max: 100, min:-10,
					redFrom: 90, redTo: 100,
					yellowFrom:75, yellowTo: 90,
					greenColor:'#59b1ff', greenFrom:-10,greenTo: 32,
					minorTicks: 5
				};
				
				var gaugeChart = new google.visualization.Gauge(document.getElementById('gages'));
					
				gaugeChart.draw(data, options);
				
				var data = google.visualization.arrayToDataTable([
					['Label', 'Value'],
					//['Temp (F)', eval(outTemp)]
					['Humidity', eval(RH)]
					//['Wind Speed', eval(wndspd)]
				]);
				var options = {
					width: 400, height: 120,
					max: 100, min:0,
					redFrom: 0, redTo: 10,
					yellowFrom:10, yellowTo: 40,
					//greenColor:'#59b1ff', greenFrom:-10,greenTo: 32,
					minorTicks: 5
				};
				gaugeChart.draw(data, options);
			}*/
		} 
		});
	}
	
	liveStn();
	window.setInterval(function(){liveStn()}, 60000);
	   
  	function setIcon(iconName) {
	    var link = document.querySelector("link[rel*='icon']") || document.createElement('link');
	    link.type = 'image/x-icon';
	    link.rel = 'icon';
	    link.href = 'src/icons/' + iconName;
	    document.getElementsByTagName('head')[0].appendChild(link);
	}  
});
