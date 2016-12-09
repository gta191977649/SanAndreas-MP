/*
								The MIT License  
								
	Copyright (c) 2015 JavaSparrow Project
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:  

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.  
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.  
	=====================================
	<Single_sub.inc>
	This is the libary that handles all the subtites and texdraw acted like in
	single player.
	Developer:Episodes
	=====================================   
*/	

//#include <a_samp>
//#include <YSI\y_hooks>
new PlayerText:PCommon[MAX_PLAYERS];
new PlayerText:PCSub[MAX_PLAYERS];
new PlayerText:PRIGHT[MAX_PLAYERS];
new PlayerText:MISSIONTEXT[MAX_PLAYERS];
//new TdelyTimer[MAX_PLAYERS];
new bool:SUB_IsShow[MAX_PLAYERS];
#define C_MISSION 0xD3900DFF
public OnPlayerConnect(playerid)
{
	
    #if defined SUB_OnPlayerConnect
        SUB_OnPlayerConnect(playerid);
    #endif
	//Sub 
	PCommon[playerid] = CreatePlayerTextDraw(playerid, 20.333337, 117.392578, "This is the sample Text");
	PlayerTextDrawLetterSize(playerid, PCommon[playerid],0.5, 2.0);
	PlayerTextDrawTextSize(playerid, PCommon[playerid], 225.000000, 40.000000);
	PlayerTextDrawAlignment(playerid, PCommon[playerid], 1);
	PlayerTextDrawColor(playerid, PCommon[playerid], 0xC0C0C0FF);
	PlayerTextDrawUseBox(playerid, PCommon[playerid], true);
	PlayerTextDrawBoxColor(playerid, PCommon[playerid], 0x00000088);
	/*
	PlayerTextDrawSetShadow(playerid, PCommon[playerid], 2);
	PlayerTextDrawSetOutline(playerid, PCommon[playerid], 1);
	//PlayerTextDrawBackgroundColor(playerid, PCommon[playerid], 51);
	PlayerTextDrawFont(playerid, PCommon[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PCommon[playerid], 1);
	*/
	//TextDraw
	PCSub[playerid] = CreatePlayerTextDraw(playerid, 396.666595, 343.051971, "This is the area that will be used to display ~r~subtitles~w~.");
	PlayerTextDrawLetterSize(playerid, PCSub[playerid],0.5, 2.0);
	PlayerTextDrawAlignment(playerid, PCSub[playerid], 2);
	PlayerTextDrawColor(playerid, PCSub[playerid], -1);
	PlayerTextDrawSetShadow(playerid, PCSub[playerid], 2);
	PlayerTextDrawSetOutline(playerid, PCSub[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, PCSub[playerid], 255);
	PlayerTextDrawFont(playerid, PCSub[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PCSub[playerid], 1);
	
	PRIGHT[playerid] = CreatePlayerTextDraw(playerid,478.0, 236.0, "RIGHTTEST");
	PlayerTextDrawLetterSize(playerid, PRIGHT[playerid],0.453666, 2.010666);
	PlayerTextDrawAlignment(playerid, PRIGHT[playerid],2);
	PlayerTextDrawColor(playerid, PRIGHT[playerid],0xC6E2FFFF);
	PlayerTextDrawSetShadow(playerid, PRIGHT[playerid],0);
	PlayerTextDrawSetOutline(playerid, PRIGHT[playerid],2);
	PlayerTextDrawBackgroundColor(playerid, PRIGHT[playerid], 255);
	PlayerTextDrawFont(playerid, PRIGHT[playerid], 2);
	PlayerTextDrawSetProportional(playerid, PRIGHT[playerid],1);
	//MissionTest(Faild)
	MISSIONTEXT[playerid] = CreatePlayerTextDraw(playerid, 331.133209, 173.890441, "mission passed!");
	PlayerTextDrawLetterSize(playerid, MISSIONTEXT[playerid], 1.411334, 4.362665);
	PlayerTextDrawAlignment(playerid, MISSIONTEXT[playerid], 2);
	PlayerTextDrawColor(playerid, MISSIONTEXT[playerid], C_MISSION);
	PlayerTextDrawSetShadow(playerid, MISSIONTEXT[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MISSIONTEXT[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, MISSIONTEXT[playerid], 51);
	PlayerTextDrawFont(playerid, MISSIONTEXT[playerid], 3);
	PlayerTextDrawSetProportional(playerid, MISSIONTEXT[playerid], 1);



	return 1;
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect SUB_OnPlayerConnect
#if defined SUB_OnPlayerConnect
    forward SUB_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect(playerid,reason)
{
    #if defined SUB_OnPlayerDisconnect
        SUB_OnPlayerDisconnect(playerid,reason);
    #endif
	
	PlayerTextDrawDestroy(playerid,PCSub[playerid]);
	PlayerTextDrawDestroy(playerid,PCommon[playerid]);
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect SUB_OnPlayerDisconnect
#if defined SUB_OnPlayerDisconnect
    forward SUB_OnPlayerDisconnect(playerid,reason);
#endif

stock SG_RightSub(playerid,string[],toggle)
{
	if(toggle)
	{
		PlayerTextDrawSetString(playerid,PRIGHT[playerid],string);
		PlayerTextDrawShow(playerid,PRIGHT[playerid]);
	}
	else
	{
		PlayerTextDrawHide(playerid,PRIGHT[playerid]);
	}

}

stock SG_TextMission(playerid,string[],time)
{
	PlayerTextDrawSetString(playerid,MISSIONTEXT[playerid],string);
	PlayerTextDrawShow(playerid,MISSIONTEXT[playerid]);
	SetTimerEx("TextMissonDestoryTimer",time*1000, false, "d", playerid);
}
stock SG_Textbox(playerid,string[],time)
{
	PlayerTextDrawSetString(playerid,PCommon[playerid],string);
	PlayerTextDrawShow(playerid,PCommon[playerid]);
	SetTimerEx("TextboxDistoryTimer",time*1000, false, "d", playerid);

}

forward TextboxDistoryTimer(playerid);
public TextboxDistoryTimer(playerid)
{
	PlayerTextDrawHide(playerid,PCommon[playerid]);
}
forward TextMissonDestoryTimer(playerid);
public TextMissonDestoryTimer(playerid)
{
	PlayerTextDrawHide(playerid,MISSIONTEXT[playerid]);
}


forward TextSubDistoryTimer(playerid);
public TextSubDistoryTimer(playerid)
{
	PlayerTextDrawHide(playerid,PCSub[playerid]);
	SUB_IsShow[playerid] = false;

}


stock SG_Sub(playerid,string[],time)
{
	if(SUB_IsShow[playerid]) TextSubDistoryTimer(playerid);
	PlayerTextDrawSetString(playerid,PCSub[playerid],string);
	PlayerTextDrawShow(playerid,PCSub[playerid]);
	SUB_IsShow[playerid] = true;
	SetTimerEx("TextSubDistoryTimer",time*1000, false, "d", playerid);
}




