//For more info on ALS Hooking check
//http://forum.sa-mp.com/showthread.php?t=85907

#include <fun/Sys_PlayerMission>

#define KEY_MISSION (newkeys & KEY_SUBMISSION) && !(oldkeys & KEY_SUBMISSION)
#define KEY_ALT  (newkeys &  KEY_WALK ) && !(oldkeys &  KEY_WALK )

static gAMB_HasCB[4];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//your OnGameModeInit pre code here

	//function hook checks

	gAMB_HasCB[0] = funcidx("AMB_OnPlayerConnect") != -1;
	gAMB_HasCB[1] = funcidx("AMB_OnPlayerDisconnect") != -1;
	gAMB_HasCB[2] = funcidx("AMB_OnPlayerKeyStateChange") != -1;
	gAMB_HasCB[3] = funcidx("AMB_OnVehicleDeath") != -1;
	if (funcidx("AMB_OnGameModeInit") != -1)
	{
		return CallLocalFunction("AMB_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit AMB_OnGameModeInit
forward AMB_OnGameModeInit();



//--------------OnPlayerConnect Hook-------------------

public OnPlayerConnect(playerid)
{
	//your OnPlayerConnect code here

	if (gAMB_HasCB[0])
	{
		return CallLocalFunction("AMB_OnPlayerConnect", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect AMB_OnPlayerConnect
forward AMB_OnPlayerConnect(playerid);



//--------------OnPlayerDisconnect Hook-------------------

public OnPlayerDisconnect(playerid,  reason)
{
	//your OnPlayerDisconnect code here

	if (gAMB_HasCB[1])
	{
		return CallLocalFunction("AMB_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect AMB_OnPlayerDisconnect
forward AMB_OnPlayerDisconnect(playerid,  reason);



//--------------OnPlayerKeyStateChange Hook-------------------

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	//your OnPlayerKeyStateChange code here
	if(KEY_MISSION)
	{
		if(AMB_IsPlayerInMission(playerid)) return 1;
		//开始任务
		if(AMB_IsVaildVehicle(playerid))
		{
			AMB_SetPlayerMissionStatus(playerid,true);
			SG_Sub(playerid,"treat the ~r~paitents~w~.",5);
			
		}
	}
	
	//
	if(KEY_ALT)
	{
		
		
	
	}
	
	if (gAMB_HasCB[2])
	{
		return CallLocalFunction("AMB_OnPlayerKeyStateChange", "iii",playerid, newkeys, oldkeys);
	}
	return 1;
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange AMB_OnPlayerKeyStateChange
forward AMB_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);



//--------------OnVehicleDeath Hook-------------------

public OnVehicleDeath(vehicleid)
{
	//your OnVehicleDeath code here

	if (gAMB_HasCB[3])
	{
		return CallLocalFunction("AMB_OnVehicleDeath", "i",vehicleid);
	}
	return 1;
}
#if defined _ALS_OnVehicleDeath
	#undef OnVehicleDeath
#else
	#define _ALS_OnVehicleDeath
#endif
#define OnVehicleDeath AMB_OnVehicleDeath
forward AMB_OnVehicleDeath(vehicleid);







//------------------Restore Indicator-------------------

stock UpdateMapIndicator(playerid)
{
	for(new i = 0; i < MAX_PLAYERS; i ++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNpc(i))
		{
			new Float:health;
			GetPlayerHealth(i,health);
			if(health < 95.0)
			{
				SetPlayerMarkerForPlayer( playerid, i, C_RED);
			}
		}
	}
}

stock RestoreMapIndicator(playerid)
{
	for(new i = 0; i < MAX_PLAYERS; i ++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNpc(i))
		{
			SetPlayerMarkerForPlayer( playerid, i, GetPlayerColor(i));
		}
	}
}



