<%@	Language=VBScript
	EnableSessionState=True %>
<%
Option Explicit

Response.Expires = 0
Response.Buffer = True


%>
<!--#include file="scripts\config.asp"-->
<!--#include file="scripts\include_db_begin.asp"-->
<!--#include file="scripts\include_picture2.asp"-->
<!--#include file="scripts\include_relations.asp"-->
<%


SUB deleteSupportingPictures( id )
	DIM	sSelect
	sSelect = "SELECT " _
		&		"* " _
		&	"FROM pictures " _
		&	"WHERE PageID=" & id & " " _
		&	";"
	
	DIM	oRS
	SET oRS = dbQueryUpdate( g_DC, sSelect )

	
	IF NOT oRS.EOF THEN
	
		'DIM sFile
		
		'DIM	oPicture
		'SET oPicture = oRS.Fields("File")
		
		oRS.MoveFirst		
		DO UNTIL oRS.EOF
			'sFile = recString(oPicture)
			'IF "" <> sFile THEN picture_delete sFile
			
			oRS.Delete adAffectCurrent
			oRS.MoveNext
		LOOP
	END IF
	
	Set oRS.ActiveConnection = Nothing
	oRS.Close
	SET oRS = Nothing

END SUB


SUB deleteSchedules( id )

	DIM sSelect
	sSelect = "" _
		&	"SELECT " _
		&	" * " _
		&	"FROM schedules " _
		&	"WHERE " _
		&	" PageID=" & id & " " _
		&	";"

	DIM oRS
	SET oRS = dbQueryUpdate( g_DC, sSelect )
	IF NOT oRS IS Nothing THEN
		IF NOT oRS.EOF THEN
			oRS.MoveFirst
			DO UNTIL oRS.EOF
				oRS.Delete 1
				oRS.MoveNext
			LOOP
		END IF
		oRS.Close
		SET oRS = Nothing
	END IF

END SUB


DIM	sID
sID = TRIM(Request("page"))

DIM	sQualCategory
sQualCategory = Request("QualCategory")


IF "" <> sID THEN

	DIM	sWhere
	IF 0 < INSTR(sID,",") THEN
		sWhere = " RID IN (" & sID & ") "
	ELSE
		sWhere = " RID=" & sID & " "
	END IF


	DIM	sSelect
	sSelect = "SELECT " _
		&		"* " _
		&	"FROM pages " _
		&	"WHERE " _
		&		sWhere _
		&	";"

	DIM	g_RS
	SET g_RS = dbQueryUpdate( g_DC, sSelect )

	
	IF NOT g_RS.EOF THEN
	
		DIM sFile
		
		DIM	oPicture
		SET oPicture = g_RS.Fields("Picture")
		
		
		DIM	oID
		SET oID = g_RS.Fields("RID")

		picture_findPath "Pages"
		
		g_RS.MoveFirst		
		DO UNTIL g_RS.EOF
			sFile = recString(oPicture)
			IF "" <> sFile THEN picture_delete sFile

			deleteSupportingPictures recNumber(oID)
			
			deleteSchedules recNumber(oID)
			
			g_RS.Delete adAffectCurrent
			g_RS.MoveNext
		LOOP

	END IF
	
	Set g_RS.ActiveConnection = Nothing
	g_RS.Close
	SET g_RS = Nothing

END IF

SET g_RS = Nothing

%>
<!--#include file="scripts\include_db_end.asp"-->
<%

Response.Redirect "pages.asp?category=" & sQualCategory

%>