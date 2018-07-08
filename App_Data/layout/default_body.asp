<%
''<head>
''<title>3-Column (FFD)</title>
''<meta name="navigate" content="tab">
''<meta name="description" content="fixed2,fixed1,dynamic">
''</head>

%>
<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableoutercolset">
<tr>
<td id="colfixed2">
<%
'========================
' ColFixed2
'========================


''1
''<head>
''<title>Forum Local</title>
''<meta name="navigate" content="tab">
''<meta name="description" content="Summary of recent forum postings for your group">
''</head>


RSSForum "forum.xml", g_sDomain, "localforum", g_sSiteTitle & " Forum", 20

''<head>
''<title>Announcements Local</title>
''<meta name="navigate" content="tab">
''<meta name="description" content="Announcements from your local announcements (Extra!) category">
''</head>

makeAnnouncements

''<head>
''<title>Humor</title>
''<meta name="navigate" content="tab">
''<meta name="description" content="Jokes and trivia to lighten your day">
''</head>


outputDynamic "humor", "loadextras.asp?q=humor&t=15", "humor.htm", "1.5", "n", 15, "d"



%>
</td>
<td id="colfixed1">
<%
'========================
' ColFixed1
'========================


''2
''<head>
''<title>Homepage Articles</title>
''<meta name="navigate" content="tab">
''<meta name="description" content="Short articles to be included on your homepage">
''</head>


Response.Write "<div id=""homebodycontent"">" & vbCRLF
pagebody_saveFuncs
outputMultiplePages TRUE	' TRUE to generate an enclosing table
pagebody_restoreFuncs
Response.Write "</div>" & vbCRLF



%>
</td>
<td id="coldynamic">
<%
'========================
' ColDynamic
'========================


''3
''<head>
''<title>Calendar Next Meeting</title>
''<meta name="navigate" content="tab">
''<meta name="description" content="Notice our your next group meeting">
''</head>


SUB makeCalendarNextMeeting()

	DIM	nDateBegin
	DIM	nDateEnd

	nDateBegin = jdateFromVBDate( NOW )
	nDateEnd = nDateBegin + 7 * 12

Response.Write "<div class=""calendarcontent"">" & vbCRLF
Response.Write "<div class=""BlockHead"">Next Monthly Gathering</div>" & vbCRLF
Response.Write "<div class=""BlockBody"">"

outputDynamic "calendarnextmeeting", _
"loadcalendar.asp?f=calendarnextmeeting.htm&i=h&v=24&r=d&b=" & nDateBegin & "&e=" & nDateEnd & "&c=" & LCASE(g_sSiteChapterID) & "-gathering" & "&h=ignore&t=false&x=scripts/remind_gathering.xslt", _
		"calendarnextmeeting.htm", "0.5", "h", 24, "d"

Response.Write "</div>" & vbCRLF
Response.Write "</div>" & vbCRLF


END SUB
makeCalendarNextMeeting

''<head>
''<title>Calendar Pending Events</title>
''<meta name="navigate" content="tab">
''<meta name="description" content="Upcoming events for your group, but organized differently">
''</head>

SUB makeCalendarPendingEvents()

	DIM	nDateBegin, nDateEnd

	nDateBegin = jdateFromVBDate( NOW )
	nDateEnd = -180


Response.Write "<div class=""calendarcontent"">" & vbCRLF
Response.Write "<div class=""BlockHead""><a href=""calendar.asp""> Events</a></div>" & vbCRLF
Response.Write "<div class=""BlockBody"">"

outputDynamic "calendarpending180", _
"loadcalendar.asp?f=calendarpending.htm&i=h&v=24&r=d&b=" & nDateBegin & "&e=" & nDateEnd & "&c=~c-meeting&h=holiday,usa,none&t=true&x=scripts/remind.xslt", _
		"calendarpending.htm", "0.5", "h", 24, "d"

Response.Write "</div>" & vbCRLF
Response.Write "</div>" & vbCRLF


END SUB
makeCalendarPendingEvents

''<head>
''<title>Calendar Birthdays</title>
''<meta name="navigate" content="tab">
''<meta name="description" content="Monthly birthday and anniversary announcements">
''</head>

'loadcalendar.asp?f=cachefile.htm&i=h&v=6&r=d&b=begindate&e=enddate&c=categories&h=holidaycats&t=showtoday&x=xsltfile

SUB makeCalendarBirthdays()

	DIM	nYear, nYearEnd
	DIM	nMon, nMonEnd
	DIM	nDateBegin, nDateEnd

	nYear = YEAR(NOW)
	nMon = MONTH(NOW)
	nMonEnd = nMon + 1
	IF 12 < nMonEnd THEN
		nYearEnd = nYear + FIX(nMonEnd/12)
		nMonEnd = nMonEnd MOD 12
	ELSE
		nYearEnd = nYear
	END IF

	nDateBegin = jdateFromGregorian( 1, nMon, nYear )
	nDateEnd = jdateFromGregorian( 1, nMonEnd, nYearEnd ) - 1


	DIM	sRmdCat
	sRmdCat = "birthday,anniversary"


Response.Write "<div class=""calendarcontent"">" & vbCRLF
Response.Write "<div class=""BlockHead""><a href=""calendar.asp?cat=" & sRmdCat & """>Birthdays / Anniversaries</a></div>" & vbCRLF
Response.Write "<div class=""BlockBody"">"

outputDynamic "calendarbirthday", _
"loadcalendar.asp?f=homebday.htm&i=d&v=7&r=m&b=" & nDateBegin & "&e=" & nDateEnd & "&c=" & sRmdCat & "&h=ignore&t=false&x=scripts/remind.xslt", _
		"homebday.htm", "0.5", "d", 7, "m"

Response.Write "</div>" & vbCRLF
Response.Write "</div>" & vbCRLF

END SUB
makeCalendarBirthdays

''<head>
''<title>Email Notification Link</title>
''<meta name="navigate" content="tab">
''<meta name="description" content="Link providing for registration for email of upcoming events">
''</head>


%>
<div id="emailevents">
	<div class="BlockHead">
	<a href="notification_upcoming.asp">Chapter Event Notification</a>
	</div>
	<div class="BlockBody">
		<a href="notification_upcoming.asp">Manage</a> your email notification of upcoming 
		Chapter Rides &amp; Events.
	</div>
</div>
<%

''<head>
''<title>Calendar Last Modified</title>
''<meta name="navigate" content="tab">
''<meta name="description" content="Display the date/time the calendar was last updated">
''</head>


IF ISDATE( dRemindLastModified ) THEN

%>
<p style="color:#999999; font-family: sans-serif; font-size: xx-small;">Calendar 
Updated: <%=DATEADD("h", g_nServerTimeZoneOffset, dRemindLastModified)%></p>
<%

END IF




%>
</td>
</tr>
</table>
