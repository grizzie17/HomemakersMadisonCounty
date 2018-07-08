<% 

' UpcomingEvents
'	mo,fr		indicates every monday and friday
'

'	Currently inherrited from default
'g_UE_sSchedule = "mo,fr"

'g_UE_nDurationCalendar = 6

'g_UE_nDurationForum = 8

g_UE_nDurationAnnounce = 6

g_bDBDSN = true
IF LCASE(Request.ServerVariables("SERVER_NAME")) = "localhost" THEN
	IF g_bDBDSN THEN
		g_sDBSource = "madisoncountyhomemakers"
	ELSE
		g_sDBSource = "dbtemplate"
	END IF
ELSE
	g_sDBSource = "dbtemplate"
END IF
g_sDBSource = "madisoncountyhomemakers"
g_sDBUser = "grizzie_dbadmin"		'grizzie_dbadmin
g_sDBPassword = "170101Admin!"		'170101Admin!

g_sDBAdmin = "grizzie_dbadmin"
g_sDBAdminPassword = "170101Admin!"

g_sChapterNeighbors = "al-h,al-y,al-t"


g_bCalendarPrefaceOption = FALSE


g_sCalendarList = "" _
	&	"All" & vbTAB & "" & vbTAB & "Events" & vbLF _
	&	"Club" & vbTAB & "club" & vbTAB & "Club Events" & vbLF _
	&	"County" & vbTAB & "county" & vbTAB & "County Events" & vbLF _
	&	"District" & vbTAB & "district" & vbTAB & "District Events" & vbLF _
	&	"State" & vbTAB & "state" & vbTAB & "State Events" & vbLF _
	&	"Meetings" & vbTAB & "meeting" & vbTAB & "Meetings" & vbLF _
	&	"Deadlines" & vbTAB & "deadline" & vbTAB & "Deadlines" _
'g_sCalendarHiddenList = ""

%>