//For more info on ALS Hooking check
//http://forum.sa-mp.com/showthread.php?t=85907

#include <SA/Mission/Paramedic/Player>
#include <SA/Mission/Paramedic/Vehicle>
#include <SA/Mission/Paramedic/Updater>
#include <SA/Mission/Paramedic/Animation>

#define KEY_MISSION (newkeys & KEY_SUBMISSION) && !(oldkeys & KEY_SUBMISSION)
#define KEY_ALT  (newkeys &  KEY_WALK ) && !(oldkeys &  KEY_WALK )

//For more info on ALS Hooking check
//http://forum.sa-mp.com/showthread.php?t=85907

static gAMB_HasCB[6];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//your OnGameModeInit pre code here
	SetTimer("AMB_OnIndicatorUpdate", 1000, true); 
	//function hook checks

	gAMB_HasCB[0] = funcidx("AMB_OnPlayerDeath") != -1;
	gAMB_HasCB[1] = funcidx("AMB_OnPlayerDisconnect") != -1;
	gAMB_HasCB[2] = funcidx("AMB_OnPlayerEnterVehicle") != -1;
	gAMB_HasCB[3] = funcidx("AMB_OnPlayerKeyStateChange") != -1;
	gAMB_HasCB[4] = funcidx("AMB_OnPlayerStateChange") != -1;
	gAMB_HasCB[5] = funcidx("AMB_OnVehicleDeath") != -1;
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



//--------------OnPlayerDeath Hook-------------------

public OnPlayerDeath(playerid, killerid,  reason)
{
	//your OnPlayerDeath code here
	if(AMB_IsPlayerInMission(playerid)) 
	{
		AMB_SetPlayerMissionStatus(playerid,false);
	}
	if (gAMB_HasCB[0])
	{
		return CallLocalFunction("AMB_OnPlayerDeath", "iii",playerid, killerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath AMB_OnPlayerDeath
forward AMB_OnPlayerDeath(playerid, killerid,  reason);



//--------------OnPlayerDisconnect Hook-------------------

public OnPlayerDisconnect(playerid,  reason)
{
	//your OnPlayerDisconnect code here
	if(AMB_IsPlayerInMission(playerid)) 
	{
		AMB_SetPlayerMissionStatus(playerid,false);
	}
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



//--------------OnPlayerEnterVehicle Hook-------------------

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	//your OnPlayerEnterVehicle code here

	if (gAMB_HasCB[2])
	{
		return CallLocalFunction("AMB_OnPlayerEnterVehicle", "iii",playerid, vehicleid, ispassenger);
	}
	return 1;
}
#if defined _ALS_OnPlayerEnterVehicle
	#undef OnPlayerEnterVehicle
#else
	#define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle AMB_OnPlayerEnterVehicle
forward AMB_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);



//--------------OnPlayerKeyStateChange Hook-------------------

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	//your OnPlayerKeyStateChange code here
	if(KEY_MISSION)
	{
		if(!AMB_IsPlayerInMission(playerid) && AMB_IsVaildVehicle(playerid)) 
		{
			AMB_SetPlayerMissionStatus(playerid,true);
			SG_Sub(playerid,"Treat a ~r~patient~w~.",5);
		}
	}
	
	if(KEY_ALT)
	{
		new near = AMB_GetNearstPatient(playerid);
		if(near != -1) 
		{
			AMB_TreatPlayer(playerid,near);
			
		}
	}
	if (gAMB_HasCB[3])
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



//--------------OnPlayerStateChange Hook-------------------

public OnPlayerStateChange(playerid, newstate,  oldstate)
{
	//your OnPlayerStateChange code here
	
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) // Player entered a vehicle as a driver
	{
		if(!AMB_IsPlayerInMission(playerid) && AMB_IsVaildVehicle(playerid)) ShowInfoBox(playerid,INFO_BoxBG,3,"Press ~k~~TOGGLE_SUBMISSIONS~  to start paramedic mission.");
	}
	if (gAMB_HasCB[4])
	{
		return CallLocalFunction("AMB_OnPlayerStateChange", "iii",playerid, newstate,  oldstate);
	}
	return 1;
}
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange AMB_OnPlayerStateChange
forward AMB_OnPlayerStateChange(playerid, newstate,  oldstate);



//--------------OnVehicleDeath Hook-------------------

public OnVehicleDeath(vehicleid)
{
	//your OnVehicleDeath code here

	if (gAMB_HasCB[5])
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



