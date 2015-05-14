 var AIRTIME_API_VERSION = "1.1";
 
function formatTimeAMPM(date) {
    function pad(n) { return (n < 10) ? '0' + n : n; }
   	var time = new Date(date);
    var hours = time.getHours();
    var minutes = time.getMinutes();
	var ext ='am';
    if (hours >= 12) {
        hours -= 12;
		ext ='pm';
    }
	if(hours === 0) { hours = 12; }
    return hours + ':' + pad(minutes) + ext;
}

(function($){
 $.fn.airtimeShowSchedule = function(options) {
    var defaults = {
        updatePeriod: 20, //seconds
        sourceDomain: "http://localhost/", //where to get show status from
        text: {onAirToday:"On air today"},
        showLimit: 5
    };
    options = $.extend(true, defaults, options);
    options.sourceDomain = addEndingBackslash(options.sourceDomain);

    return this.each(function() {
        var obj = $(this);
        var sd;

        getServerData();

        function updateWidget(){
            var currentShow = sd.getCurrentShow();
            var nextShows = sd.getNextShows();
            var shows = currentShow.length == 0 ? nextShows : currentShow.concat(nextShows);
            tableString = "";
            tableString += "<h3>" + options.text.onAirToday + "</h3>";
            tableString += "<table width='70%' border='0' cellspacing='0' cellpadding='0' class='widget widget now-playing-list small'>"+
                "<tbody>";
            
            for (var i=0; i<shows.length; i++){
                tableString +=
                "<tr>" +
                "<td class='time'>"+shows[i].getRange()+"</td>";

                var url = shows[i].getURL();
                if (url.length > 0) {
                    tableString += "<td><a href='" + shows[i].getURL() + "'>" + shows[i].getName() + "</a></td></tr>";
                } else {
                    tableString += "<td>" + shows[i].getName() + "</td></tr>";
                }  
            }
            tableString += "</tbody></table>";
            obj.empty();
            obj.append(tableString);
        }

        function processData(data){
            checkWidgetVersion(data);
            sd = new ScheduleData(data);
            updateWidget();
        }

        function airtimeScheduleJsonpError(jqXHR, textStatus, errorThrown){
        }

        function getServerData(){
            /* Live Info */
			$.ajax({url: options.sourceDomain + "api/live-info/", 
			data: {type:"endofday",limit: options.showLimit}, dataType: "jsonp", success:function(data) { processData(data); }, error: airtimeScheduleJsonpError});
            setTimeout(getServerData, options.updatePeriod*1000);
        }
    });
 };
})(jQuery);


(function($){
 $.fn.airtimeLiveInfo = function(options) {

    var defaults = {
        updatePeriod: 5, //seconds
        sourceDomain: "http://localhost/", //where to get show status from
        text: {onAirNow:"On Air Now", offline:"Offline", current:"Current", next:"Next"}
    };
    options = $.extend(true, defaults, options);    
    options.sourceDomain = addEndingBackslash(options.sourceDomain);
    
	return this.each(function() {
        var obj = $(this);
        var sd = null;
        getServerData();
        setInterval(updateWidget, 1000);

        function updateWidget(){
            if (sd == null){ return; }  
            var currentShow = sd.getCurrentShow();
            var nextShows = sd.getNextShows();
            var showStatus = options.text.offline;
            var currentShowName = "";
            var timeElapsed = "";
            var timeRemaining = "";
            var nextShowName = "";
            var nextShowRange = "";
            if (currentShow.length > 0){
                showStatus = options.text.onAirNow;
                currentShowName = currentShow[0].getName();
                timeElapsed = sd.getShowTimeElapsed(currentShow[0]);
                timeRemaining = sd.getShowTimeRemaining(currentShow[0]);
            }
            if (nextShows.length > 0){
                nextShowName = nextShows[0].getName();
                nextShowRange = nextShows[0].getRange();
            }
            obj.empty();
            obj.append("<h4>"+showStatus+" &gt;&gt;</h4>");
            obj.append("<ul class='widget now-playing-bar'>" +
                 "<li class='current'>"+options.text.current+": "+currentShowName+
                "<span id='time-elapsed' class='time-elapsed'>"+timeElapsed+"</span>" +
                "<span id='time-remaining' class='time-remaining'>"+timeRemaining+"</span>"+
                "</li>" +
                "<li class='next'>"+options.text.next+": "+nextShowName+"<span>"+nextShowRange+"</span></li>" +
                "</ul>");
        }

        function processData(data){
            checkWidgetVersion(data);
            sd = new ScheduleData(data);
        }

        function airtimeScheduleJsonpError(jqXHR, textStatus, errorThrown){
        }

        function getServerData(){
            $.ajax({url: options.sourceDomain + "api/live-info/", 
                    data: {type:"interval",limit:"5"}, 
                    dataType: "jsonp", 
                    success: function(data) {
                        processData(data);
                    }, 
                    error: airtimeScheduleJsonpError});
            setTimeout(getServerData, options.updatePeriod*1000);
        }
    });
 };
})(jQuery);
/*
  function ReadCookie(cookieName) {
	var theCookie=" "+document.cookie;
	var ind=theCookie.indexOf(" "+cookieName+"=");
	if (ind==-1) ind=theCookie.indexOf(";"+cookieName+"=");
	if (ind==-1 || cookieName=="") return "";
	var ind1=theCookie.indexOf(";",ind+1);
	if (ind1==-1) ind1=theCookie.length; 
	return unescape(theCookie.substring(ind+cookieName.length+2,ind1));
}

function SetCookie(cookieName,cookieValue,nDays) {
	 var today = new Date();
	 var expire = new Date();
	 if (nDays==null || nDays==0) nDays=1;
	 expire.setTime(today.getTime() + 3600000*24*nDays);
	 document.cookie = cookieName+"="+escape(cookieValue) + ";expires="+expire.toGMTString();
}
*/

(function($){
    $.fn.airtimeLiveTrackInfo = function(options) {
       
	   var defaults = {
           updatePeriod: 5, //seconds
           sourceDomain: "http://localhost/", //where to get show status from
           text: {onAirNow:"On Air Now", offline:"Offline", current:"Current", next:"Next"}
       };
       options = $.extend(true, defaults, options);    
       options.sourceDomain = addEndingBackslash(options.sourceDomain);

       return this.each(function() {
           var obj = $(this);
           var sd = null;
           getServerData();
           setInterval(updateWidget, 1000);

           function updateWidget(){
               if (sd == null){
                   return;
               }
               var currentShow = sd.getCurrentShow();
               var nextShows = sd.getNextShows();
               var showStatus = options.text.offline;
               var currentShowName = "";
               var timeElapsed = "";
               var timeRemaining = "";
               var nextShowName = "";
               var nextShowRange = "";
               if (currentShow.length > 0){
                   showStatus = options.text.onAirNow;
                   currentShowName = currentShow[0].getName();
                   timeElapsed = sd.getShowTimeElapsed(currentShow[0]);
                   timeRemaining = sd.getShowTimeRemaining(currentShow[0]);
               }
               if (nextShows.length > 0){
                   nextShowName = nextShows[0].getName();
                   nextShowRange = nextShows[0].getRange();
               }
               obj.empty();
               obj.append("<span id='status-current-show' style='display:inline'><span style='color:#741d00;'>"+showStatus+"</span>&nbsp;<img src='/at-widget/css/widget-img/anim-radio.GIF'</img>&nbsp;"+currentShowName+"</span>" +
                       "<span class='current' id='time-elapsed' class='time-elapsed'>"+timeElapsed+"</span>" +
                       "<span class='current' id='time-remaining' class='time-remaining'>"+timeRemaining+"</span>");
               obj.append("<ul class='widget now-playing-bar'>" +
                   "<li class='current track-metadata'><span style='display:inline-block; width:80%;overflow:hidden;'>"+options.text.current+": "+sd.currentTrack.getTitle()+"</span></li>" +
                   "<li class='next track-metadata'><span style='display:inline-block; width:80%;overflow:hidden;'>"+options.text.next+": "+sd.nextTrack.getTitle()+"</span></li>" +                   
                   "</ul>");
           }

           function processData(data){
               checkWidgetVersion(data);
               sd = new ScheduleData(data);
           }

           function airtimeScheduleJsonpError(jqXHR, textStatus, errorThrown){
           }

           function getServerData(){
               $.ajax({url: options.sourceDomain + "api/live-info/", data: {type:"interval",limit:"5"}, dataType: "jsonp", success: function(data) { processData(data); }, error: airtimeScheduleJsonpError});
               setTimeout(getServerData, options.updatePeriod*1000);
           }
       });
    };
   })(jQuery);

(function($){
 $.fn.airtimeWeekSchedule = function(options) {
	function jTimeSecs(){ x=new Date(); x.setTime(x.getTime()); return x; } 
	function jTimeMins(x){ return (x>9)?x:'0'+x; } 
	function jTimeHours(x){ if(x==0){ x=12; } return x; } 
	function jbcy2(x){ x=(x<500)?x+1900:x; return String(x).substring(2,4) } 
	function jbcdT(){ document.getElementById('tP').innerHTML=eval(oT); setTimeout('dT()',1000); } 
	function jbcaP(x){ return (x>11)?'pm':'am'; } 
	
	var jDay=new Array('Sun','Mon','Tue','Wed','Thu','Fri','Sat');
	var jMonth=new Array('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
	var jbcoT="jDay[tS().getDay()]+' '+jTimeSecs().getDate()+' '+jMonth[tS().getMonth()]+' '+jbcy2(tS().getYear())+' '+'-'+' '+jTimeHours(jTimeSecs().getHours())+':'+jTimeMins(tS().getMinutes())+':'+jTimeMins(tS().getSeconds())";
	var jbcLocalHours = jTimeHours(jTimeSecs().getHours());
	var jbcd = new Date();
	var jbcHourOffset = ~~(jbcd.getTimezoneOffset() / 60);
    
	var defaults = {
        sourceDomain: "http://localhost/", //where to get show status from
        updatePeriod: 600,
        dowText: {monday:"Monday", tuesday:"Tuesday.", wednesday:"Wednesday.", thursday:"Thursday", friday:"Friday", saturday:"Saturday", tsunday:"Sunday", nextmonday:"Next Monday"},
        miscText: {utcTime:"Time GMT", localTime:"Time", programName:"Program Name", details:"Details", readMore:"Read More", genre:"Genre"}
    };
    options = $.extend(true, defaults, options);
    options.sourceDomain = addEndingBackslash(options.sourceDomain);
    
	return this.each(function() {					  
		/* Start SetUp Day Tabs */
		var obj = $(this);
        obj.empty();
        obj.attr("class", "ui-tabs");
        var dow = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday", "nextmonday"];
        var date = new Date();
        //subtract 1 because javascript date function returns
        //sunday as 0 based, but we want Monday to be 0-based.
        var todayInt = (date.getDay()-1);
		
		var jDate = new Date();
		var jNowInmS = jDate.getTime();
		var jTimeOffsetHours =	((jDate.getTimezoneOffset()) /60);
		var jTimeZone=(jTimeOffsetHours.toString());
		if (jTimeZone.indexOf("-") != -1) {
			jTimeZone = jTimeZone.replace('-','+');
		}else{
			jTimeZone = "-"+jTimeZone;
		}
        if (todayInt < 0) todayInt += 7;
		
        var html = '<div style=" z-index:199; display: block; width:100%; background-color: #f7d28d; position: fixed; top: 0px;"><ul>';	
			for (var i=0; i<dow.length; i++){
				html += '<li'+ (i==todayInt?' class="ui-tabs-selected ui-state-active"':'')+'><a href="#'+dow[i]+'">'+options.dowText[dow[i]]+'</a></li>';
			}
        html += '</ul>';
		html += '<table style="background-color: #f5c367;">'+
                    '<colgroup>'+
                      '<col width="9%" />'+'<col width="3%" />'+'<col width="88%" />'+
                    '</colgroup>'+
                      '<tbody><tr class="head" >'+
						'<td style="color: #333333; border-bottom-style: solid;">'+'GMT'+jTimeZone+'</td>'+
						'<td style="border-bottom-style: solid; border-left:0px; border-right:0px;">&nbsp;</td>'+
                        '<td style="color: #333333; border-bottom-style: solid;">'+options.miscText.programName+'</td>'+
                      '</tr></table></div>';
					  
        for (var i=0; i<dow.length; i++){ html += '<div id="'+dow[i]+'" class="ui-tabs-hide"></div>' }
		
        obj.append(html);	
		 /* End SetUp Day Tabs */
		
        getServerData();
		
        function updateWidget(data){
				var jDate = new Date();
				var jNowInmS = jDate.getTime();
				var jTimeOffsetHours =	((jDate.getTimezoneOffset()) /60);
				var jTimeZone=(jTimeOffsetHours.toString());
				
				if (jTimeZone.indexOf("-") != -1) {
				 	jTimeZone = jTimeZone.replace('-','+');
				}else{
					jTimeZone = "-"+jTimeZone;
				}
				var currentTime = new Date();
				var currentTimezone = currentTime.getTimezoneOffset();
				currentTimezone = (currentTimezone/60) * -1;
				var gmt = 'GMT';
				if (currentTimezone !== 0) {
				  gmt += currentTimezone > 0 ? ' +' : ' ';
				  gmt += currentTimezone;
				}
				var n=gmt.indexOf("-");
				if (n<0){
					var subtractaday=false;	
				} else {
				var subtractaday=true;	
				}

				var jdaySchedule = new Array();
				for (var i=-1; i<11; i++){
					jdaySchedule[i] = new Array();
				}
				
				var showsbyday = new Array(dow.length);
				var orgshowsbyday = new Array(dow.length);
				var k=0;
				var jdaynum = -1;
				var temp2dayofmonth = 0;
				
				for (var i=0; i<dow.length; i++){
	                var daySchedule = data[dow[i]];
		
                	for (var j=0; j<daySchedule.length; j++){					
						var jStartT = daySchedule[j].start_timestamp+' UTC';
						var jNewStartDate=jStartT.replace(/-/gi,"/"); 			
						var jLocalStartTime = new Date(jNewStartDate);
						var temp1dayofmonth = jLocalStartTime.getDate(); 

						if (temp2dayofmonth != temp1dayofmonth) {
							temp2dayofmonth = temp1dayofmonth;
							jdaynum=jdaynum +1;
							k=0;
						}
						
						jdaynum = parseInt(jdaynum);
						var myjdaynum = jdaynum;
						if (subtractaday == true) {
							myjdaynum = jdaynum-1;
						}	
						myjdaynum = parseInt(myjdaynum);
						console.log('i='+i+' myjdaynum = '+myjdaynum+' k='+k);
						jdaySchedule[myjdaynum][k]=new Array( "url", "start_timestamp", "end_timestamp", "name", "description", "genre" );
						jdaySchedule[myjdaynum][k].url = daySchedule[j].url;
						jdaySchedule[myjdaynum][k].start_timestamp = daySchedule[j].start_timestamp;
						jdaySchedule[myjdaynum][k].end_timestamp = daySchedule[j].end_timestamp;
						jdaySchedule[myjdaynum][k].name = daySchedule[j].name;
						jdaySchedule[myjdaynum][k].description = daySchedule[j].description;
						jdaySchedule[myjdaynum][k].genre = daySchedule[j].genre;
						showsbyday[myjdaynum]=k;
						orgshowsbyday[myjdaynum]=j;
						k = k+1; 
					}
				}

				for (var i=0; i<dow.length; i++){
              		 var html = '<table class="widget widget now-playing-list" style="margin-top: 29px;">'+
                    '<colgroup>'+
                      '<col width="9%" />'+
					  '<col width="3%" />'+
                      '<col width="88%" />'+
                    '</colgroup>'+
                      '<tbody><tr class="head">'+
						'<td>'+'GMT'+jTimeZone+'</td>'+
						'<td style="border-left:1px #741d00 dotted;border-right:1px #741d00 dotted;">&nbsp;</td>'+
                        '<td>'+options.miscText.programName+'</td>'+
                      '</tr>';
				
					/* Do Each Day*/	  
				 for (var j=0; j<(showsbyday[i]+1); j++){	 
					jdaynum=i;
					k=j;				

                    var url = jdaySchedule[jdaynum][k].url;
					var jStartT = jdaySchedule[i][j].start_timestamp+' UTC';
					var jNewStartDate=jStartT.replace(/-/gi,"/"); 			
					var jLocalStartTime = new Date(jNewStartDate); 			
					var jEndT = jdaySchedule[i][j].end_timestamp+' UTC';
					var jNewEndDate=jEndT.replace(/-/gi,"/"); 
					var jLocalEndTime = new Date(jNewEndDate);					
					var jLocalSchedStartAMPM = formatTimeAMPM(jLocalStartTime);
					var jLocalSchedEndAMPM = formatTimeAMPM(jLocalEndTime);

					/* If in current show.. */	
					
					if(jDate.getTime() >= jLocalStartTime.getTime() && jDate.getTime() <= jLocalEndTime.getTime()) {
						html +='<tr style="background-color: #ffffda;">';
						 var myanchor = 'currentshow';
					}else{
						html +='<tr>';
						var myanchor = '';
					}
					var $mybgcolor = "";
					var $myfgcolor = "";
					
					switch (jdaySchedule[i][j].genre)
					{
						case "Alt-History":
						// Magenta White
							$mybgcolor = "#ffaaff";
							$myfgcolor = "#000000";
							break;	
						case "Conspiracy":
						case "Geopolitics":
						case "Conspiracies":
						// Grey Black	
							$mybgcolor = "#d9d9d9";
							$myfgcolor = "#000000";
							break;
						case "Cryptids":
						// Yellow Black	
							$mybgcolor = "#ffff44";
							$myfgcolor = "#000000";
							break;
						case "Ecology":
						// Green White
							$mybgcolor = "#44ff44";
							$myfgcolor = "#000000";
							break;		
						case "Education":
							$mybgcolor = "#9cf0ff";
							$myfgcolor = "#000000";
							break;
						case "Esoterica":
							
						// Grey White
							$mybgcolor = "#9898b0";
							$myfgcolor = "#000000";
							break;
						case "History":
						// Lt Magenta Black
							$mybgcolor = "#ffbfff";
							$myfgcolor = "#000000";
							break;
						case "Music":
						// Lt Red Black	
							$mybgcolor = "#55e271";
							$myfgcolor = "#000000";
							break;	
						case "Myths":
						// Orange Black
							$mybgcolor = "#ffba44";
							$myfgcolor = "#000000";
							break;
						case "Mysteries":
						// Lt Orange Black	
							$mybgcolor = "#ffae60";
							$myfgcolor = "#000000";
							break;			
						case "News":
						// Blue White	
							$mybgcolor = "#b4b4ff";
							$myfgcolor = "#000000";
							jdaySchedule[i][j].genre = "THE NEWS";
							break;
						case "Science":
						// Lt Blue Black		
							$mybgcolor = "#cfcfff";
							$myfgcolor = "#000000";
							break;
						case "Security":
						// Red White		
							$mybgcolor = "#ff7777";
							$myfgcolor = "#000000";
							break;
						case "Skepticism":
						// Cyan Black
							$mybgcolor = "#7296a9";
							$myfgcolor = "#000000";
							break;	
						case "Spiritual":
						// Lt Cyan Black
							$mybgcolor = "#bfffff";
							$myfgcolor = "#000000";
							break;	
						case "UFO-Aliens":
						case "UFO/Aliens":
						// Lt Yellow Black
							$mybgcolor = "#ffffaa";
							$myfgcolor = "#000000";
							break;	
						case "Health":
						// Lt Yellow Black
							$mybgcolor = "#79ffce";
							$myfgcolor = "#000000";
							break;	
						case "Alt. Talk Show":
							jdaySchedule[i][j].genre="Alt Chat";
							$mybgcolor = "#eeeeee";
							$myfgcolor = "#000000";
							break;
						default: 
							$mybgcolor = "#eeeeee";
							$myfgcolor = "#000000";
							break;	
					}

					if (jdaySchedule[i][j].genre == "") {
						jdaySchedule[i][j].genre = "Other";
					}

					var spliturl = url.split("|");

					if(typeof spliturl[1] == 'undefined') {
						spliturl[1] = "http://deprogrammedradio.com/images/shows/guy-fawkes-80.jpg";
					
				 	}
					if (myanchor != '') {
						html += '<td colspan="3" valign="top" style="padding-bottom: 19px; padding-top:6px;"><a name="'+myanchor+'"></a><p>Current Show - Now Playing...</p></td></tr><tr style="background-color: #ffffda;">';
					}
					
                    html +=	'<td style="padding-left:0px; padding-right:0px;"><p style="text-align:center;">'+jLocalSchedStartAMPM+'</p><p style="text-align:center;"><img src="http://www.deprogrammedradio.com/images/down-arrow.png"></p><p style="text-align:center; line-height: 8px;">'+jLocalSchedEndAMPM+'</p><p style="text-align:center;">(local)</p></td>';
					
					html +=	'<td valign="top" align="left" style="border-left:1px #741d00 dotted; border-right:1px #741d00 dotted;  background-color: '+$mybgcolor+'"><p class="rotate"><span style="color: '+$myfgcolor+'">'+jdaySchedule[i][j].genre+'</span></p></td>';	
					
					
					if (jdaySchedule[i][j].description == '') {
							html +=	'<td valign="top" style="padding-top:6px;"><div id="widget_logobox"><img src="'+spliturl[1]+'" style="margin-top: -2px;"></div><span id="jbcShowname" style="text-decoration: none;">'+jdaySchedule[i][j].name+'</span></td>';
						} else {
							
							
							if (undefined == spliturl[1]){								
								html += '<td valign="top" style="padding-top:6px;">'+'<span id="jbcShowname" style="text-decoration: none;">'+jdaySchedule[i][j].name+'</span></a><br /><span style=\'font-weight:lighter\; font-style:italic \'>'+jdaySchedule[i][j].description+'</span><br/>'+(url.length > 0 ? '<a href="'+spliturl[0]+'" target="_blank"><span id="jbcReadmore">READ MORE!</span></a>':'')+'</td>';						
							} else { 
								html += '<td valign="top" style="padding-top:6px;"><div id="widget_logobox"><img src="'+spliturl[1]+'" style="margin-top: -2px;"><div style="float:right;">';
								html += '<a href="'+spliturl[0]+'" target="_blank"><span id="jbcReadmore">READ MORE!</span></a>';
								html += '</div></div>'+'<span id="jbcShowname" style="text-decoration: none;">'+jdaySchedule[i][j].name+'</span></a><br /><span id="jbcShowdesc">'+jdaySchedule[i][j].description+'</span></td>';
							}
						}						
						html += '</tr>';			
               		}
	
                	html +=
                    '</tbody>'+
                  	'</table>';
	               
                	$("#"+dow[i]).empty();
                	$("#"+dow[i]).append(html);
            }
        }

        function processData(data){
            checkWidgetVersion(data);
            updateWidget(data);
        }

        function airtimeScheduleJsonpError(jqXHR, textStatus, errorThrown){ }

        function getServerData(){
			/* In Update Widget */																														
			$.ajax({ url: options.sourceDomain + "api2/week-info/", dataType:"jsonp", success:function(data){																													
                        processData(data);
                  }, error:airtimeScheduleJsonpError});
            setTimeout(getServerData, options.updatePeriod*1000);
        }
    });
 };
})(jQuery);

function addEndingBackslash(str){
    if (str.charAt(str.length-1) != '/')
        return str+'/';
    else return str;
}

/* ScheduleData class BEGIN */
function ScheduleData(data){
    this.data = data;
    this.estimatedSchedulePosixTime;

    this.currentShow = new Array();
    if(data.currentShow != undefined) {
        for (var i=0; i< data.currentShow.length; i++){
            this.currentShow[i] = new Show(data.currentShow[i]);
        }
    }

    this.nextShows = new Array();
    if(data.nextShow != undefined) {
        for (var i=0; i< data.nextShow.length; i++) {
            this.nextShows[i] = new Show(data.nextShow[i]);
        }
    }
    
    this.currentTrack = new AudioTrack(data.current);
    this.nextTrack = new AudioTrack(data.next);

    this.schedulePosixTime = convertDateToPosixTime(data.schedulerTime);
    var date = new Date();
    this.localRemoteTimeOffset = date.getTime() - this.schedulePosixTime;
}

ScheduleData.prototype.secondsTimer = function(){
    var date = new Date();
    this.estimatedSchedulePosixTime = date.getTime() - this.localRemoteTimeOffset;
}

ScheduleData.prototype.getCurrentShow = function(){ return this.currentShow; }
ScheduleData.prototype.getNextShows = function() { return this.nextShows; }
ScheduleData.prototype.getShowTimeElapsed = function(show) {
    this.secondsTimer();
    var showStart = convertDateToPosixTime(show.getStartTimestamp());
    return convertToHHMMSS(this.estimatedSchedulePosixTime - showStart);
};

ScheduleData.prototype.getShowTimeRemaining = function(show) {
    this.secondsTimer();
    var showEnd = convertDateToPosixTime(show.getEndTimestamp());
    return convertToHHMMSS(showEnd - this.estimatedSchedulePosixTime);
};
/* ScheduleData class END */

/* Show class BEGIN */
function Show(showData){ this.showData = showData; }

Show.prototype.getURL = function(){ return this.showData.url; }
Show.prototype.getName = function(){ return this.showData.name; }
Show.prototype.getRange = function(){
    return getTime(this.showData.start_timestamp) + " - " + getTime(this.showData.end_timestamp);
}
Show.prototype.getStartTimestamp = function(){ return this.showData.start_timestamp; }
Show.prototype.getEndTimestamp = function(){ return this.showData.end_timestamp; }
/* Show class END */

/* AudioTrack class BEGINS */
function AudioTrack(trackData){ this.trackData = trackData; }

AudioTrack.prototype.getTitle = function(){
    if (this.trackData === null) return "";
    return this.trackData.name;
}
/* AudioTrack class ENDS */
function getDate(timestamp) {
    var mydate = timestamp.split(" ");
	return mydate[0];
};
function getTime(timestamp) {
    var time = timestamp.split(" ")[1].split(":");
    return time[0] + ":" + time[1];
};
function gethour(timestamp) {
    var time = timestamp.split(" ")[1].split(":");
    return time[0];
};
function getmin(timestamp) {
    var time = timestamp.split(" ")[1].split(":");
    return time[1];
};
/* Takes an input parameter of milliseconds and converts these into
 * the format HH:MM:SS */
function convertToHHMMSS(timeInMS){
	var time = parseInt(timeInMS);

	var hours = parseInt(time / 3600000);
	time -= 3600000*hours;

	var minutes = parseInt(time / 60000);
	time -= 60000*minutes;

	var seconds = parseInt(time / 1000);

	hours = hours.toString();
	minutes = minutes.toString();
	seconds = seconds.toString();

	if (hours.length == 1)
		hours = "0" + hours;
	if (minutes.length == 1)
		minutes = "0" + minutes;
	if (seconds.length == 1)
		seconds = "0" + seconds;
	if (hours == "00")
		return minutes + ":" + seconds;
	else
		return hours + ":" + minutes + ":" + seconds;
}

/* Takes in a string of format similar to 2011-02-07 02:59:57,
 * and converts this to epoch/posix time. */
function convertDateToPosixTime(s){
    var datetime = s.split(" ");

    var date = datetime[0].split("-");
    var time = datetime[1].split(":");

	var year = date[0];
	var month = date[1];
	var day = date[2];
	var hour = time[0];
	var minute = time[1];
    var sec = 0;
    var msec = 0;

    if (time[2].indexOf(".") != -1){
        var temp = time[2].split(".");
        sec = temp[0];
        msec = temp[1];
    } else
        sec = time[2];

	return Date.UTC(year, month-1, day, hour, minute, sec, msec);
}

/* Checks the incomming data's widget version tag.
*  The current widget version is 1.
*     -If the value returned is equal to 1 do nothing.
*     -If the value doesn't exist or it is great then 1 throw error warning the user they should upgrade their airtime install.
*     -If the value is less then 1 warn the user that they should upgrade the javascript to a newer version.
*/

function checkWidgetVersion(data){
    var airtimeServerWidgetVersion = data['AIRTIME_API_VERSION'];
    
    if (undefined === airtimeServerWidgetVersion || airtimeServerWidgetVersion >  AIRTIME_API_VERSION )
        throw "The version of widgets you are using is out of date with the Airtime installation, please update your widgets javascript file. (Airtime widget API version is "+airtimeServerWidgetVersion+", this widget's API version is "+AIRTIME_API_VERSION+")";
    else if (airtimeServerWidgetVersion < AIRTIME_API_VERSION )
        throw "The Airtime server has a different version than this widget supports. Please get the correct widget version for your Airtime installation. (Airtime widget API version is "+airtimeServerWidgetVersion+", this widget's API version is "+AIRTIME_API_VERSION+")";
}
