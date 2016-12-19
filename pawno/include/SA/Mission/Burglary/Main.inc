
#define MAX_BURGLARY 10
#define MAX_BURGLARY_PLAYER 4 //最多一个任务可以加入多少玩家
#define MAX_FUNITURE 10 //一个房子里面最大有多少家具

//-------Mission STATUS--------------
#define MISSION_BURGLARY_DO 0
#define MISSION_BURGLARY_RETURN 1

#include <SA/Mission/Burglary/Map>
#include <SA/Mission/Burglary/Animation>
#include <SA/Mission/Burglary/Locations>
#include <SA/Mission/Burglary/IO>
#include <SA/Mission/Burglary/Funiture>

#include <SA/Mission/Burglary/Text>
#include <SA/Mission/Burglary/Room>
#include <SA/Mission/Burglary/Player>
#include <SA/Mission/Burglary/Vehicle>

#define KEY_ENTER (newkeys & KEY_SECONDARY_ATTACK ) && !(oldkeys & KEY_SECONDARY_ATTACK )

static gBurg_HasCB[9];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//your OnGameModeInit pre code here
	Burglary_ReCreateMap();
	BurglaryRoomPlayersReset();
	
	//function hook checks
	
	gBurg_HasCB[0] = funcidx("Burg_OnPlayerConnect") != -1;
	gBurg_HasCB[1] = funcidx("Burg_OnPlayerDeath") != -1;
	gBurg_HasCB[2] = funcidx("Burg_OnPlayerDisconnect") != -1;
	gBurg_HasCB[3] = funcidx("Burg_OnPlayerEnterCheckpoint") != -1;
	gBurg_HasCB[4] = funcidx("Burg_OnPlayerInteriorChange") != -1;
	gBurg_HasCB[5] = funcidx("Burg_OnPlayerKeyStateChange") != -1;
	gBurg_HasCB[6] = funcidx("Burg_OnPlayerStateChange") != -1;
	gBurg_HasCB[7] = funcidx("Burg_OnVehicleDeath") != -1;
	gBurg_HasCB[8] = funcidx("Burg_OnPlayerPickUpPickup") != -1;
	if (funcidx("Burg_OnGameModeInit") != -1)
	{
		return CallLocalFunction("Burg_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Burg_OnGameModeInit
forward Burg_OnGameModeInit();


//--------------OnPlayerPickUpPickup Hook-------------------

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	//your OnPlayerPickUpPickup code here
	
	if(Burglary_IsPlayerInMission(playerid)) //如果玩家在任务模式中
	{
		new PlayerTeam = Burglary_PlayerRoomGet(playerid);//获取玩家的组id
		new HourseId = Burglary_GetHouseID(PlayerTeam);
		
		if(pickupid == BurglaryRoom[PlayerTeam][b_entrypickup]) //进入
		{
			//执行接入室内传送....
			SetPlayerPosFront(playerid,BurlagryHoursesLS[HourseId][3],BurlagryHoursesLS[HourseId][4],BurlagryHoursesLS[HourseId][5],0.0,2);
		}
		if(pickupid == BurglaryRoom[PlayerTeam][b_exitpickup]) //离开
		{
			//执行接入室内传送....
			SetPlayerPosFront(playerid,BurlagryHoursesLS[HourseId][0],BurlagryHoursesLS[HourseId][1],BurlagryHoursesLS[HourseId][2],0.0,2);
		}
	
	}
	if (gBurg_HasCB[0])
	{
		return CallLocalFunction("Burg_OnPlayerPickUpPickup", "ii",playerid, pickupid);
	}
	return 1;
}
#if defined _ALS_OnPlayerPickUpPickup
	#undef OnPlayerPickUpDynamicPickup
#else
	#define _ALS_OnPlayerPickUpPickup
#endif
#define OnPlayerPickUpDynamicPickup Burg_OnPlayerPickUpPickup
forward Burg_OnPlayerPickUpPickup(playerid, pickupid);



//--------------OnPlayerConnect Hook-------------------

public OnPlayerConnect(playerid)
{
	//your OnPlayerConnect code here
	//if(!IsPlayerNPC(playerid)) RemoveSABurglaryObject(playerid);
	PreloadAnimLib(playerid,"CARRY");
	
	if (gBurg_HasCB[0])
	{
		return CallLocalFunction("Burg_OnPlayerConnect", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Burg_OnPlayerConnect
forward Burg_OnPlayerConnect(playerid);



//--------------OnPlayerDeath Hook-------------------

public OnPlayerDeath(playerid, killerid,  reason)
{
	//your OnPlayerDeath code here

	if (gBurg_HasCB[1])
	{
		return CallLocalFunction("Burg_OnPlayerDeath", "iii",playerid, killerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath Burg_OnPlayerDeath
forward Burg_OnPlayerDeath(playerid, killerid,  reason);



//--------------OnPlayerDisconnect Hook-------------------

public OnPlayerDisconnect(playerid,  reason)
{
	//your OnPlayerDisconnect code here

	if (gBurg_HasCB[2])
	{
		return CallLocalFunction("Burg_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect Burg_OnPlayerDisconnect
forward Burg_OnPlayerDisconnect(playerid,  reason);



//--------------OnPlayerEnterCheckpoint Hook-------------------

public OnPlayerEnterCheckpoint(playerid)
{
	//your OnPlayerEnterCheckpoint code here

	if (gBurg_HasCB[3])
	{
		return CallLocalFunction("Burg_OnPlayerEnterCheckpoint", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerEnterCheckpoint
	#undef OnPlayerEnterCheckpoint
#else
	#define _ALS_OnPlayerEnterCheckpoint
#endif
#define OnPlayerEnterCheckpoint Burg_OnPlayerEnterCheckpoint
forward Burg_OnPlayerEnterCheckpoint(playerid);



//--------------OnPlayerInteriorChange Hook-------------------

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	//your OnPlayerInteriorChange code here

	if (gBurg_HasCB[4])
	{
		return CallLocalFunction("Burg_OnPlayerInteriorChange", "iii",playerid, newinteriorid, oldinteriorid);
	}
	return 1;
}
#if defined _ALS_OnPlayerInteriorChange
	#undef OnPlayerInteriorChange
#else
	#define _ALS_OnPlayerInteriorChange
#endif
#define OnPlayerInteriorChange Burg_OnPlayerInteriorChange
forward Burg_OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);



//--------------OnPlayerKeyStateChange Hook-------------------

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	//your OnPlayerKeyStateChange code here

	if(KEY_MISSION)
	{
		if(Burglary_IsPlayerInMission(playerid)) return 1;
		if(!BurglaryIsVaildVeh(playerid)) return 1;
		//开始任务
		Burglary_PlayerStart(playerid);
	}
	
	if(KEY_ENTER)
	{
		if(!Burglary_IsPlayerInMission(playerid)) return 1;//无视玩家不在任务的
		new PlayerTeam = Burglary_PlayerRoomGet(playerid);
		new nearFuniture = BurglaryGetClostFuniture(playerid,PlayerTeam);
		
		if(nearFuniture != NULL)//如果附近有家具
		{
			BurglaryPlayerLiftFuniture(playerid,nearFuniture);
		}
	}
	if (gBurg_HasCB[5])
	{
		return CallLocalFunction("Burg_OnPlayerKeyStateChange", "iii",playerid, newkeys, oldkeys);
	}
	return 1;
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange Burg_OnPlayerKeyStateChange
forward Burg_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);



//--------------OnPlayerStateChange Hook-------------------

public OnPlayerStateChange(playerid, newstate,  oldstate)
{
	//your OnPlayerStateChange code here
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) // Player entered a vehicle as a driver
    {
		
		if(!Burglary_IsPlayerInMission(playerid) && BurglaryIsVaildVeh(playerid)) ShowInfoBox(playerid,INFO_BoxBG,3,BURGLARY_TOOGLE);
    }
	
	if (gBurg_HasCB[6])
	{
		return CallLocalFunction("Burg_OnPlayerStateChange", "iii",playerid, newstate,  oldstate);
	}
	return 1;
}
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange Burg_OnPlayerStateChange
forward Burg_OnPlayerStateChange(playerid, newstate,  oldstate);



//--------------OnVehicleDeath Hook-------------------

public OnVehicleDeath(vehicleid)
{
	//your OnVehicleDeath code here

	if (gBurg_HasCB[7])
	{
		return CallLocalFunction("Burg_OnVehicleDeath", "i",vehicleid);
	}
	return 1;
}
#if defined _ALS_OnVehicleDeath
	#undef OnVehicleDeath
#else
	#define _ALS_OnVehicleDeath
#endif
#define OnVehicleDeath Burg_OnVehicleDeath
forward Burg_OnVehicleDeath(vehicleid);


