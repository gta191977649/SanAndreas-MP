/*
	Textdraws Include (textdraws.inc)
	* Handy functions and usefull  for textdraws!
	* Now player textdraw fader which will let you make single player featured fading texts!
	* Automatically destroy all global TDs on script exit!
 	Author: (creator)
	* Gammix
	(c) Copyright 2015
  	* This file is provided as is (no warranties).
*/
/*
FUNCTIONS:
native IsValidTextDraw(Text:text);
native IsValidPlayerTextDraw(playerid, PlayerText:text);
native _
native Text:TextDrawCreateEx(Float:posX, Float:posY, string[], bgcolor, font, Float:lettersizeX, Float:lettersizeY, textcolor, allign = 0, outline = 1, bool:proportional = true, shadow = 1, bool:usebox = false, boxcolor = 0, Float:textsizeX = -1.0, Float:textsizeY = -1.0, model = 0, Float:rotX = 0.0, Float:rotY = 0.0, Float:rotZ = 0.0, Float:zoom = 1.0, bool:selectable = false);
native PlayerText:CreatePlayerTextDrawEx(playerid, Float:posX, Float:posY, string[], bgcolor, font, Float:lettersizeX, Float:lettersizeY, textcolor, allign = 0, outline = 1, bool:proportional = true, shadow = 1, bool:usebox = false, boxcolor = 0, Float:textsizeX = -1.0, Float:textsizeY = -1.0, model = 0, Float:rotX = 0.0, Float:rotY = 0.0, Float:rotZ = 0.0, Float:zoom = 1.0, bool:selectable = false);
native DestroyAllTextDraws();
native DestroyAllPlayerTextDraws(playerid);
native ShowAllPlayerTextDraws(playerid);
native HideAllPlayerTextDraws(playerid);
native ShowAllTextDrawsForPlayer(playerid);
native HideAllTextDrawsForPlayer(playerid);
native _
native PlayerTextDrawFade(playerid, PlayerText:text, color, updatetick = 30, displaytime = 1500);
native PlayerTextDrawUnfade(playerid, PlayerText:text);
native IsPlayerTextDrawFading(playerid, PlayerText:text);
CALLBACKS:
public OnPlayerTextDrawFadeComplete(playerid, PlayerText:text)
*/

//validity functions

static bool:gTextdrawExist[MAX_TEXT_DRAWS];
static bool:gPlayerTextdrawExist[MAX_PLAYERS][MAX_PLAYER_TEXT_DRAWS];

stock Text:TD_TextDrawCreate(Float:x, Float:y, string[])
{
	static Text:gTextDraw;
    gTextDraw = TextDrawCreate(x, y, string);

    gTextdrawExist[_:gTextDraw] = true;
    return gTextDraw;
}
#if defined _ALS_TextDrawCreate
    #undef TextDrawCreate
#else
    #define _ALS_TextDrawCreate
#endif
#define TextDrawCreate TD_TextDrawCreate

stock PlayerText:TD_CreatePlayerTextDraw(playerid, Float:x, Float:y, string[])
{
	static PlayerText:gTextDraw;
    gTextDraw = CreatePlayerTextDraw(playerid, x, y, string);

    gPlayerTextdrawExist[playerid][_:gTextDraw] = true;
    return gTextDraw;
}
#if defined _ALS_CreatePlayerTextDraw
    #undef CreatePlayerTextDraw
#else
    #define _ALS_CreatePlayerTextDraw
#endif
#define CreatePlayerTextDraw TD_CreatePlayerTextDraw

stock TD_TextDrawDestroy(Text:text)
{
	if(! gTextdrawExist[_:text]) return false;

    gTextdrawExist[_:text] = false;
    text = Text:INVALID_TEXT_DRAW;
    return TextDrawDestroy(text);
}
#if defined _ALS_TextDrawDestroy
    #undef TextDrawDestroy
#else
    #define _ALS_TextDrawDestroy
#endif
#define TextDrawDestroy TD_TextDrawDestroy

stock TD_PlayerTextDrawDestroy(playerid, PlayerText:text)
{
	if(! gPlayerTextdrawExist[playerid][_:text]) return false;

    gPlayerTextdrawExist[playerid][_:text] = false;
    text = PlayerText:INVALID_TEXT_DRAW;
    return PlayerTextDrawDestroy(playerid, text);
}
#if defined _ALS_PlayerTextDrawDestroy
    #undef PlayerTextDrawDestroy
#else
    #define _ALS_PlayerTextDrawDestroy
#endif
#define PlayerTextDrawDestroy TD_PlayerTextDrawDestroy

stock IsValidTextDraw(Text:text) return gTextdrawExist[_:text];

stock IsValidPlayerTextDraw(playerid, PlayerText:text) return gPlayerTextdrawExist[playerid][_:text];

//easy functions

stock Text:TextDrawCreateEx(Float:posX, Float:posY, string[], bgcolor, font, Float:lettersizeX, Float:lettersizeY, textcolor, allign = 0, outline = 1, bool:proportional = true, shadow = 1, bool:usebox = false, boxcolor = 0, Float:textsizeX = -1.0, Float:textsizeY = -1.0, model = 0, Float:rotX = 0.0, Float:rotY = 0.0, Float:rotZ = 0.0, Float:zoom = 1.0, bool:selectable = false)
{
	static Text:gTextDraw;
    gTextDraw = TextDrawCreate(posX, posY, string);
	TextDrawBackgroundColor(gTextDraw, bgcolor);
	TextDrawFont(gTextDraw, font);
	TextDrawLetterSize(gTextDraw, lettersizeX, lettersizeY);
	TextDrawColor(gTextDraw, textcolor);
	TextDrawAlignment(gTextDraw, allign);
	TextDrawSetOutline(gTextDraw, outline);
	TextDrawSetProportional(gTextDraw, proportional);
	TextDrawSetShadow(gTextDraw, shadow);
	TextDrawUseBox(gTextDraw, usebox);
	if(usebox) TextDrawBoxColor(gTextDraw, boxcolor);
	if(textsizeX != -1.0 && textsizeY != -1.0) TextDrawTextSize(gTextDraw, textsizeX, textsizeY);
	if(font == 5)
	{
		TextDrawSetPreviewModel(gTextDraw, model);
		TextDrawSetPreviewRot(gTextDraw, rotX, rotY, rotZ, zoom);
	}
	if(selectable)
	{
		TextDrawSetSelectable(gTextDraw, 1);
	}
	else
	{
		TextDrawSetSelectable(gTextDraw, 0);
	}
	return gTextDraw;
}

stock PlayerText:CreatePlayerTextDrawEx(playerid, Float:posX, Float:posY, string[], bgcolor, font, Float:lettersizeX, Float:lettersizeY, textcolor, allign = 0, outline = 1, bool:proportional = true, shadow = 1, bool:usebox = false, boxcolor = 0, Float:textsizeX = -1.0, Float:textsizeY = -1.0, model = 0, Float:rotX = 0.0, Float:rotY = 0.0, Float:rotZ = 0.0, Float:zoom = 1.0, bool:selectable = false)
{
	static PlayerText:gTextDraw;
    gTextDraw = CreatePlayerTextDraw(playerid, posX, posY, string);
	PlayerTextDrawBackgroundColor(playerid, gTextDraw, bgcolor);
	PlayerTextDrawFont(playerid, gTextDraw, font);
	PlayerTextDrawLetterSize(playerid, gTextDraw, lettersizeX, lettersizeY);
	PlayerTextDrawColor(playerid, gTextDraw, textcolor);
 	PlayerTextDrawAlignment(playerid, gTextDraw, allign);
	PlayerTextDrawSetOutline(playerid, gTextDraw, outline);
	PlayerTextDrawSetProportional(playerid, gTextDraw, proportional);
	PlayerTextDrawSetShadow(playerid, gTextDraw, shadow);
	PlayerTextDrawUseBox(playerid, gTextDraw, usebox);
	if(usebox) PlayerTextDrawBoxColor(playerid, gTextDraw, boxcolor);
	if(textsizeX != -1.0 && textsizeY != -1.0) PlayerTextDrawTextSize(playerid, gTextDraw, textsizeX, textsizeY);
	if(font == 5)
	{
		PlayerTextDrawSetPreviewModel(playerid, gTextDraw, model);
		PlayerTextDrawSetPreviewRot(playerid, gTextDraw, rotX, rotY, rotZ, zoom);
	}
	if(selectable)
	{
		PlayerTextDrawSetSelectable(playerid, gTextDraw, 1);
	}
	else
	{
		PlayerTextDrawSetSelectable(playerid, gTextDraw, 0);
	}
	return gTextDraw;
}

stock DestroyAllTextDraws()
{
	for(new i; i < MAX_TEXT_DRAWS; i++)
	{
	    TextDrawDestroy(Text:i);
	}
	return true;
}

stock DestroyAllPlayerTextDraws(playerid)
{
	for(new i; i < MAX_PLAYER_TEXT_DRAWS; i++)
	{
	    PlayerTextDrawDestroy(playerid, PlayerText:i);
	}
	return true;
}

stock ShowAllPlayerTextDraws(playerid)
{
	for(new i; i < MAX_PLAYER_TEXT_DRAWS; i++)
	{
	    PlayerTextDrawShow(playerid, PlayerText:i);
	}
	return true;
}

stock HideAllPlayerTextDraws(playerid)
{
	for(new i; i < MAX_PLAYER_TEXT_DRAWS; i++)
	{
	    PlayerTextDrawHide(playerid, PlayerText:i);
	}
	return true;
}

stock ShowAllTextDrawsForPlayer(playerid)
{
	for(new i; i < MAX_PLAYER_TEXT_DRAWS; i++)
	{
	    TextDrawShowForPlayer(playerid, Text:i);
	}
	return true;
}

stock HideAllTextDrawsForPlayer(playerid)
{
	for(new i; i < MAX_PLAYER_TEXT_DRAWS; i++)
	{
	    TextDrawHideForPlayer(playerid, Text:i);
	}
	return true;
}

//player textdraw fader

#define MAX_FADES_AT_A_TIME 5//more tha value, more bigger the array, mor is the file size and more memory and maybe lag!
//and after all i am using 3D arrays which normally increase the AMX size as well!

#define FADE_UPDATE_VALUE  15//this is the value been set for td color on every timer update. THe update rate of color!

enum TextDrawFadeEnum
{
	PlayerText:player_fade_td,
	player_fade_color,
	player_fade_timer,
	player_fade_showtime,
	player_fade_updatetime
}
static gPlayerTextDrawFade[MAX_PLAYERS][MAX_FADES_AT_A_TIME][TextDrawFadeEnum];

//internal function
stock static TD_SetTransparency(color, alpha = 0xFF)
{
    static newcolor;

    alpha = clamp(alpha, 0x00, 0xFF);

    newcolor = (color & ~0xFF) | alpha;
    return newcolor;
}
//

public OnPlayerConnect(playerid)
{
    for(new i; i < MAX_FADES_AT_A_TIME; i++)
    {
        gPlayerTextDrawFade[playerid][i][player_fade_td] = PlayerText:INVALID_TEXT_DRAW;
        gPlayerTextDrawFade[playerid][i][player_fade_color] = -1;
        gPlayerTextDrawFade[playerid][i][player_fade_timer] = -1;
        gPlayerTextDrawFade[playerid][i][player_fade_showtime] = 3000;
        gPlayerTextDrawFade[playerid][i][player_fade_updatetime] = 50;
    }

	#if defined TD_OnPlayerConnect
       	return TD_OnPlayerConnect(playerid);
	#else
	   	return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect TD_OnPlayerConnect
#if defined TD_OnPlayerConnect
    forward TD_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    for(new i; i < MAX_FADES_AT_A_TIME; i++)
    {
		KillTimer(gPlayerTextDrawFade[playerid][i][player_fade_timer]);
        gPlayerTextDrawFade[playerid][i][player_fade_td] = PlayerText:INVALID_TEXT_DRAW;
        gPlayerTextDrawFade[playerid][i][player_fade_color] = -1;
        gPlayerTextDrawFade[playerid][i][player_fade_timer] = -1;
        gPlayerTextDrawFade[playerid][i][player_fade_showtime] = 3000;
        gPlayerTextDrawFade[playerid][i][player_fade_updatetime] = 50;
    }

	#if defined TD_OnPlayerDisconnect
       	return TD_OnPlayerDisconnect(playerid, reason);
	#else
	   	return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect TD_OnPlayerDisconnect
#if defined TD_OnPlayerDisconnect
    forward TD_OnPlayerDisconnect(playerid, reason);
#endif

stock PlayerTextDrawFade(playerid, PlayerText:text, color, updatetick = 30, displaytime = 1500)
{
	for(new i; i < MAX_FADES_AT_A_TIME; i++)
	{
		if(IsPlayerTextDrawFading(playerid, text)) PlayerTextDrawUnfade(playerid, text);

	    gPlayerTextDrawFade[playerid][i][player_fade_td] = text;
	    gPlayerTextDrawFade[playerid][i][player_fade_showtime] = displaytime;
	    gPlayerTextDrawFade[playerid][i][player_fade_updatetime] = updatetick;
	    gPlayerTextDrawFade[playerid][i][player_fade_color] = color;

		PlayerTextDrawColor(playerid, text, TD_SetTransparency(color, 0));
		PlayerTextDrawShow(playerid, text);

		if(gPlayerTextDrawFade[playerid][i][player_fade_timer] != -1) KillTimer(gPlayerTextDrawFade[playerid][i][player_fade_timer]);
		gPlayerTextDrawFade[playerid][i][player_fade_timer] = SetTimerEx("TD_OnPlayerTextDrawFade", updatetick, false, "iiii", playerid, i, 0, 0);
		return i;
	}
	return -1;
}

stock PlayerTextDrawUnfade(playerid, PlayerText:text)
{
    for(new i; i < MAX_FADES_AT_A_TIME; i++)
    {
		if(gPlayerTextDrawFade[playerid][i][player_fade_td] == text)
		{
		    KillTimer(gPlayerTextDrawFade[playerid][i][player_fade_timer]);

		    gPlayerTextDrawFade[playerid][i][player_fade_td] = PlayerText:INVALID_TEXT_DRAW;
	        gPlayerTextDrawFade[playerid][i][player_fade_color] = -1;
	        gPlayerTextDrawFade[playerid][i][player_fade_timer] = -1;
	        gPlayerTextDrawFade[playerid][i][player_fade_showtime] = 3000;
	        gPlayerTextDrawFade[playerid][i][player_fade_updatetime] = 50;
			return true;
		}
	}
	return false;
}

stock IsPlayerTextDrawFading(playerid, PlayerText:text)
{
    for(new i; i < MAX_FADES_AT_A_TIME; i++)
    {
		if(gPlayerTextDrawFade[playerid][i][player_fade_td] == text) return true;
    }
	return false;
}

forward TD_OnPlayerTextDrawFade(playerid, slot, alpha, type);
public TD_OnPlayerTextDrawFade(playerid, slot, alpha, type)
{
	switch(type)
	{
	    case 0:
		{
		    alpha += FADE_UPDATE_VALUE;
			PlayerTextDrawColor(playerid, gPlayerTextDrawFade[playerid][slot][player_fade_td], TD_SetTransparency(gPlayerTextDrawFade[playerid][slot][player_fade_color], alpha));
			PlayerTextDrawShow(playerid, gPlayerTextDrawFade[playerid][slot][player_fade_td]);

			if(alpha >= 255)
			{
			    PlayerTextDrawColor(playerid, gPlayerTextDrawFade[playerid][slot][player_fade_td], gPlayerTextDrawFade[playerid][slot][player_fade_color]);
				PlayerTextDrawShow(playerid, gPlayerTextDrawFade[playerid][slot][player_fade_td]);

				gPlayerTextDrawFade[playerid][slot][player_fade_timer] = SetTimerEx("TD_OnPlayerTextDrawFade", gPlayerTextDrawFade[playerid][slot][player_fade_showtime], false, "iiii", playerid, slot, 255, 1);
				return 1;
			}

  		 	gPlayerTextDrawFade[playerid][slot][player_fade_timer] = SetTimerEx("TD_OnPlayerTextDrawFade", gPlayerTextDrawFade[playerid][slot][player_fade_updatetime], false, "iiii", playerid, slot, alpha, 0);
		}
		case 1:
		{
			PlayerTextDrawColor(playerid, gPlayerTextDrawFade[playerid][slot][player_fade_td], gPlayerTextDrawFade[playerid][slot][player_fade_color]);
			PlayerTextDrawShow(playerid, gPlayerTextDrawFade[playerid][slot][player_fade_td]);

			gPlayerTextDrawFade[playerid][slot][player_fade_timer] = SetTimerEx("TD_OnPlayerTextDrawFade", gPlayerTextDrawFade[playerid][slot][player_fade_showtime], false, "iiii", playerid, slot, 255, 2);
		}
	    case 2:
		{
		    alpha -= FADE_UPDATE_VALUE;
   			PlayerTextDrawColor(playerid, gPlayerTextDrawFade[playerid][slot][player_fade_td], TD_SetTransparency(gPlayerTextDrawFade[playerid][slot][player_fade_color], alpha));
			PlayerTextDrawShow(playerid, gPlayerTextDrawFade[playerid][slot][player_fade_td]);

			if(alpha <= 0)
			{
			    PlayerTextDrawColor(playerid, gPlayerTextDrawFade[playerid][slot][player_fade_td], gPlayerTextDrawFade[playerid][slot][player_fade_color]);
				PlayerTextDrawHide(playerid, gPlayerTextDrawFade[playerid][slot][player_fade_td]);

				gPlayerTextDrawFade[playerid][slot][player_fade_timer] = -1;
				CallLocalFunction("OnPlayerTextDrawFadeComplete", "ii", playerid, slot);
				return 1;
			}

			gPlayerTextDrawFade[playerid][slot][player_fade_timer] = SetTimerEx("TD_OnPlayerTextDrawFade", gPlayerTextDrawFade[playerid][slot][player_fade_updatetime], false, "iiii", playerid, slot, alpha, 2);
		}
	}
	return 1;
}

forward OnPlayerTextDrawFadeComplete(playerid, PlayerText:text);

//Auto destroyer

//Note: if you use this in a filterscript, please define "FILTERSCRIPT" in your script
#if defined FILTERSCRIPT// if used in a filterscript

	public OnFilterScriptInit()
	{
		for(new i; i < MAX_TEXT_DRAWS; i++)
		{
		    gTextdrawExist[i] = false;
		}

        #if defined TD_OnFilterScriptInit
        	return TD_OnFilterScriptInit();
	    #else
	    	return 1;
	    #endif
	}
	#if defined _ALS_OnFilterScriptInit
	    #undef OnFilterScriptInit
	#else
	    #define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit TD_OnFilterScriptInit
	#if defined TD_OnFilterScriptInit
	    forward TD_OnFilterScriptInit();
	#endif

	public OnFilterScriptExit()
	{
		DestroyAllTextDraws();

	    #if defined TD_OnFilterScriptExit
        	return TD_OnFilterScriptExit();
	    #else
	    	return 1;
	    #endif
	}
	#if defined _ALS_OnFilterScriptExit
	    #undef OnFilterScriptExit
	#else
	    #define _ALS_OnFilterScriptExit
	#endif
	#define OnFilterScriptExit TD_OnFilterScriptExit
	#if defined TD_OnFilterScriptExit
	    forward TD_OnFilterScriptExit();
	#endif

#else// if used in a gamemode

	public OnGameModeInit()
	{
		for(new i; i < MAX_TEXT_DRAWS; i++)
		{
		    gTextdrawExist[i] = false;
		}

	    #if defined TD_OnGameModeInit
        	return TD_OnGameModeInit();
	    #else
	    	return 1;
	    #endif
	}
	#if defined _ALS_OnGameModeInit
	    #undef OnGameModeInit
	#else
	    #define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit TD_OnGameModeInit
	#if defined TD_OnGameModeInit
	    forward TD_OnGameModeInit();
	#endif

	public OnGameModeExit()
	{
		DestroyAllTextDraws();

	    #if defined TD_OnGameModeExit
        	return TD_OnGameModeExit();
	    #else
	    	return 1;
	    #endif
	}
	#if defined _ALS_OnGameModeExit
	    #undef OnGameModeExit
	#else
	    #define _ALS_OnGameModeExit
	#endif
	#define OnGameModeExit TD_OnGameModeExit
	#if defined TD_OnGameModeExit
	    forward TD_OnGameModeExit();
	#endif

#endif