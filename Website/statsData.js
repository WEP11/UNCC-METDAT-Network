$(function () 
  {
  	function getStats()
  	{
    //-----------------------------------------------------------------------
    // 2) Send a http request with AJAX http://api.jquery.com/jQuery.ajax/
    //-----------------------------------------------------------------------
    $.ajax({ 
      cache: false,                    // Forces new request                                     
      url: 'statsData.php',            //the script to call to get data          
      data: "",                        //you can insert url argumnets here to pass to api.php , for example "id=5&parent=6"
      async: false,                    //Async runs request in background. Allows the refresh to happen.
      dataType: 'json',                //data format      
      success: function(data)          //on recieve of reply
      {
        var hiTime = data[0];
        var hi = data[1];
        var loTime = data[2];
        var lo = data[3];
        var hiWndTime = data[4];
        var hiWnd = data[5];
        var hiPresTime = data[6];
        var hiPres = data[7];
        var loPresTime = data[8];
        var loPres = data[9];
        var rain = data[10];
        
        
        var hiPres = hiPres * 33.8637526;
        var loPres = loPres * 33.8637526;
        
        var hi = parseFloat(hi).toFixed(2);
        var lo = parseFloat(lo).toFixed(2);
        var rain = parseFloat(rain).toFixed(2);
        var hiWnd = parseFloat(hiWnd).toFixed(2);
        var hiPres = parseFloat(hiPres).toFixed(2);
        var loPres = parseFloat(loPres).toFixed(2);
        
        //--------------------------------------------------------------------
        // 3) Update html content
        //--------------------------------------------------------------------
        document.getElementById("hi").innerHTML = hi + "&#176;F @ " + hiTime;
        document.getElementById("lo").innerHTML = lo + "&#176;F @ " + loTime;
        document.getElementById("24rain").innerHTML = rain + " in";
        document.getElementById("24wind").innerHTML = hiWnd + " mph @ " + hiWndTime;
        document.getElementById("24hiP").innerHTML = hiPres + " mb @ " + hiPresTime;
        document.getElementById("24loP").innerHTML = loPres + " mb @ " + loPresTime;
      } 
    });
   }
   getStats();
   window.setInterval(function(){getStats()}, 60000);
   
   
  }); 