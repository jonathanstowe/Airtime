<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta charset="utf-8" />

<title>test</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/themes/smoothness/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>

<script src="http://hq.futuremusic.fm/widgets/js/jquery.showinfo.js" type="text/javascript"></script>




<script>

function updateClock ( )
{
  var currentTime = new Date ( );
  var currentHours = currentTime.getHours ( );
  var currentMinutes = currentTime.getMinutes ( );
  var currentSeconds = currentTime.getSeconds ( );
  currentMinutes = ( currentMinutes < 10 ? "0" : "" ) + currentMinutes;
  currentSeconds = ( currentSeconds < 10 ? "0" : "" ) + currentSeconds;
  var timeOfDay = ( currentHours < 12 ) ? "AM" : "PM";
  currentHours = ( currentHours > 12 ) ? currentHours - 12 : currentHours;
  currentHours = ( currentHours == 0 ) ? 12 : currentHours;
  var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds + " " + timeOfDay;
 // document.getElementById("clock").firstChild.nodeValue = currentTimeString;
}
</script>
<script>
$(document).ready(function() {
	$("#scheduleTabs").airtimeWeekSchedule({
sourceDomain: "http://hq.futuremusic.fm/", dowText:{monday:"Mon", tuesday:"Tue", wednesday:"Wed", thursday:"Thu", friday:"Fri", saturday:"Sat", sunday:"Sun", nextmonday:"Mon"}, miscText: {utcTime:"Time GMT", localTime:"Time", programName:"Program Name", details:"Details", readMore:"Read More"}, updatePeriod: 600});
	var d = new Date().getDay();
 //   $('#scheduleTabs').tabs({selected: d === 0 ? 6 : d-1, fx: { opacity: 'toggle' }});
	
	$('#scheduleTabs').tabs({ active: 2 });
});
</script>
<link rel="stylesheet" href="style.css" type="text/css" />
</head>
<body onload="updateClock(); setInterval('updateClock()', 1000 )">
    <?php
	function GetUserTZOffsetMins()
  	{
		if(!isset($_COOKIE['UTC_Bias']))
		{   ?>
			<script type="text/javascript">
				 var Cookies = {};
				 Cookies.create = function (name, value, days) {
					 if (days) {
						 var date = new Date();
						 date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
						 var expires = "; expires=" + date.toGMTString();
					 } else {
						var expires = "";
					 }
					 document.cookie = name + "=" + value + expires + "; path=/";
					 this[name] = value;
				 }
				 var now = new Date();
				 Cookies.create("UTC_Bias",now.getTimezoneOffset(),1);
				 window.location = "<?php echo $_SERVER['PHP_SELF'];?>";
			</script>
<?php  
		} else {
			$ListenerTimeOffsetMins = $_COOKIE['UTC_Bias'];
		}
		return $ListenerTimeOffsetMins;
	}
?>
    <div style="width:100%;">
    	<?php // <div style="width: 100%; height:36px;" > ?>
        <div id="scheduleTabs"></div>
        <div class="current-timebar" ></div>
	</div>
</body>
</html>