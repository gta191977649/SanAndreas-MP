/*
	送匹萨小任务
	By Episodes

*/
//支持库
#include <SA/Mission/PizzaBoy/Locations>
#include <SA/Mission/PizzaBoy/Text>
#include <SA/Mission/PizzaBoy/Player>
#include <SA/Mission/PizzaBoy/Object>
#include <SA/Mission/PizzaBoy/Vehicle>



//按键定义
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
//向量方向
#define VECTOR_LEFT 0
#define VECTOR_RIGHT 1

#define MAX_PIZZA 6


static gPIZZA_HasCB[9];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//your OnGameModeInit pre code here

	//function hook checks

	gPIZZA_HasCB[0] = funcidx("PIZZA_OnPlayerConnect") != -1;
	gPIZZA_HasCB[1] = funcidx("PIZZA_OnPlayerDeath") != -1;
	gPIZZA_HasCB[2] = funcidx("PIZZA_OnPlayerDisconnect") != -1;
	gPIZZA_HasCB[3] = funcidx("PIZZA_OnPlayerEnterCheckpoint") != -1;
	gPIZZA_HasCB[4] = funcidx("PIZZA_OnPlayerKeyStateChange") != -1;
	gPIZZA_HasCB[5] = funcidx("PIZZA_OnPlayerStateChange") != -1;
	gPIZZA_HasCB[6] = funcidx("PIZZA_OnVehicleDeath") != -1;
	gPIZZA_HasCB[7] = funcidx("PIZZA_PHY_OnObjectUpdate") != -1;
	gPIZZA_HasCB[8] = funcidx("PIZZA_OnPlayerExitVehicle") != -1;
	
	if (funcidx("PIZZA_OnGameModeInit") != -1)
	{
		return CallLocalFunction("PIZZA_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit PIZZA_OnGameModeInit
forward PIZZA_OnGameModeInit();

//--------------PHY_OnObjectUpdate Hook-------------------

public PHY_OnObjectUpdate(objectid)
{
	//your PHY_OnObjectUpdate code here
	PIZZA_OnObjectUpdate(objectid);
	if (gPIZZA_HasCB[7])
	{
		return CallLocalFunction("PIZZA_PHY_OnObjectUpdate", "i",objectid);
	}
	return 1;
}
#if defined _ALS_PHY_OnObjectUpdate
	#undef PHY_OnObjectUpdate
#else
	#define _ALS_PHY_OnObjectUpdate
#endif
#define PHY_OnObjectUpdate PIZZA_PHY_OnObjectUpdate
forward PIZZA_PHY_OnObjectUpdate(objectid);

//--------------OnPlayerExitVehicle Hook-------------------

public OnPlayerExitVehicle(playerid, vehicleid)
{
	//your OnPlayerExitVehicle code here
	if(PIZZA_IsPlayerInMission(playerid))
	{
		if()
	}

	if (gPIZZA_HasCB[0])
	{
		return CallLocalFunction("PIZZA_OnPlayerExitVehicle", "ii",playerid, vehicleid);
	}
	return 1;
}
#if defined _ALS_OnPlayerExitVehicle
	#undef OnPlayerExitVehicle
#else
	#define _ALS_OnPlayerExitVehicle
#endif
#define OnPlayerExitVehicle PIZZA_OnPlayerExitVehicle
forward PIZZA_OnPlayerExitVehicle(playerid, vehicleid);





//--------------OnPlayerConnect Hook-------------------

public OnPlayerConnect(playerid)
{
	//your OnPlayerConnect code here

	if (gPIZZA_HasCB[0])
	{
		return CallLocalFunction("PIZZA_OnPlayerConnect", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect PIZZA_OnPlayerConnect
forward PIZZA_OnPlayerConnect(playerid);



//--------------OnPlayerDeath Hook-------------------

public OnPlayerDeath(playerid, killerid,  reason)
{
	//your OnPlayerDeath code here

	if (gPIZZA_HasCB[1])
	{
		return CallLocalFunction("PIZZA_OnPlayerDeath", "iii",playerid, killerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath PIZZA_OnPlayerDeath
forward PIZZA_OnPlayerDeath(playerid, killerid,  reason);



//--------------OnPlayerDisconnect Hook-------------------

public OnPlayerDisconnect(playerid,  reason)
{
	//your OnPlayerDisconnect code here
	if(PIZZA_IsPlayerInMission(playerid)) PIZZA_PLAYER_reset(playerid);
		
	if (gPIZZA_HasCB[2])
	{
		return CallLocalFunction("PIZZA_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect PIZZA_OnPlayerDisconnect
forward PIZZA_OnPlayerDisconnect(playerid,  reason);



//--------------OnPlayerEnterCheckpoint Hook-------------------

public OnPlayerEnterCheckpoint(playerid)
{
	//your OnPlayerEnterCheckpoint code here

	if (gPIZZA_HasCB[3])
	{
		return CallLocalFunction("PIZZA_OnPlayerEnterCheckpoint", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerEnterCheckpoint
	#undef OnPlayerEnterCheckpoint
#else
	#define _ALS_OnPlayerEnterCheckpoint
#endif
#define OnPlayerEnterCheckpoint PIZZA_OnPlayerEnterCheckpoint
forward PIZZA_OnPlayerEnterCheckpoint(playerid);



//--------------OnPlayerKeyStateChange Hook-------------------

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	//your OnPlayerKeyStateChange code here
	if(KEY_MISSION)
	{
		if(PIZZA_IsPlayerInMission(playerid)) return 1;
			//开始任务
		if(PIZZA_IsInVaildVeh(playerid))
		{
			PIZZA_PLAYER_start(playerid);
		}
	}
	
	//丢PIZZA
	if (HOLDING( KEY_LOOK_LEFT))
	{
		if(!PIZZA_IsPlayerInMission(playerid)) return 1;
		//printf("KEY_LOOK_LEFT");
		if (PRESSED( KEY_FIRE ))
		{
			PIZZA_LunchObject(playerid,VECTOR_LEFT);
			//printf("KEY_ACTION");
		}
	
	}
	if(HOLDING( KEY_LOOK_RIGHT))
	{
		if(!PIZZA_IsPlayerInMission(playerid)) return 1;
		//printf("KEY_LOOK_RIGHT");
		if (PRESSED( KEY_FIRE ))
		{
			PIZZA_LunchObject(playerid,VECTOR_RIGHT);
			//printf("KEY_ACTION");
		}
	}
	if (gPIZZA_HasCB[4])
	{
		return CallLocalFunction("PIZZA_OnPlayerKeyStateChange", "iii",playerid, newkeys, oldkeys);
	}
	return 1;
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange PIZZA_OnPlayerKeyStateChange
forward PIZZA_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);



//--------------OnPlayerStateChange Hook-------------------

public OnPlayerStateChange(playerid, newstate,  oldstate)
{
	//your OnPlayerStateChange code here
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) 
    {
		if(PIZZA_IsInVaildVeh(playerid))
		{
			if(!PIZZA_IsPlayerInMission(playerid)) SG_Textbox(playerid,"Press 2 to start Pizza Boy Missions.",3000);
		}
    }
	
	if (gPIZZA_HasCB[5])
	{
		return CallLocalFunction("PIZZA_OnPlayerStateChange", "iii",playerid, newstate,  oldstate);
	}
	return 1;
}
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange PIZZA_OnPlayerStateChange
forward PIZZA_OnPlayerStateChange(playerid, newstate,  oldstate);



//--------------OnVehicleDeath Hook-------------------

public OnVehicleDeath(vehicleid)
{
	//your OnVehicleDeath code here
	
	if (gPIZZA_HasCB[6])
	{
		return CallLocalFunction("PIZZA_OnVehicleDeath", "i",vehicleid);
	}
	return 1;
}
#if defined _ALS_OnVehicleDeath
	#undef OnVehicleDeath
#else
	#define _ALS_OnVehicleDeath
#endif
#define OnVehicleDeath PIZZA_OnVehicleDeath
forward PIZZA_OnVehicleDeath(vehicleid);



