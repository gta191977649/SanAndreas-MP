#include <SA/Mission/CarShop/Vehicles>
#include <SA/Mission/CarShop/Player>


#define KEY_MISSION (newkeys & KEY_SUBMISSION) && !(oldkeys & KEY_SUBMISSION)
#define KEY_ALT  (newkeys &  KEY_WALK ) && !(oldkeys &  KEY_WALK )

//For more info on ALS Hooking check
//http://forum.sa-mp.com/showthread.php?t=85907
//-1970.7388, 297.4897, 34.7497

static gCARSHOP_HasCB[8];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//Mission Location
	
	//function hook checks

	gCARSHOP_HasCB[0] = funcidx("CARSHOP_OnPlayerConnect") != -1;
	gCARSHOP_HasCB[1] = funcidx("CARSHOP_OnPlayerDeath") != -1;
	gCARSHOP_HasCB[2] = funcidx("CARSHOP_OnPlayerDisconnect") != -1;
	gCARSHOP_HasCB[3] = funcidx("CARSHOP_OnPlayerEnterDynamicCP") != -1;
	gCARSHOP_HasCB[4] = funcidx("CARSHOP_OnPlayerExitVehicle") != -1;
	gCARSHOP_HasCB[5] = funcidx("CARSHOP_OnPlayerKeyStateChange") != -1;
	gCARSHOP_HasCB[6] = funcidx("CARSHOP_OnVehicleDeath") != -1;
	gCARSHOP_HasCB[7] = funcidx("CARSHOP_OnPlayerStateChange") != -1;
	if (funcidx("CARSHOP_OnGameModeInit") != -1)
	{
		return CallLocalFunction("CARSHOP_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit CARSHOP_OnGameModeInit
forward CARSHOP_OnGameModeInit();



//--------------OnPlayerConnect Hook-------------------

public OnPlayerConnect(playerid)
{
	//your OnPlayerConnect code here
	CarShop_PlayerCreateCP(playerid);
	if (gCARSHOP_HasCB[0])
	{
		return CallLocalFunction("CARSHOP_OnPlayerConnect", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect CARSHOP_OnPlayerConnect
forward CARSHOP_OnPlayerConnect(playerid);



//--------------OnPlayerDeath Hook-------------------

public OnPlayerDeath(playerid, killerid,  reason)
{
	//your OnPlayerDeath code here

	if (gCARSHOP_HasCB[1])
	{
		return CallLocalFunction("CARSHOP_OnPlayerDeath", "iii",playerid, killerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath CARSHOP_OnPlayerDeath
forward CARSHOP_OnPlayerDeath(playerid, killerid,  reason);



//--------------OnPlayerDisconnect Hook-------------------

public OnPlayerDisconnect(playerid,  reason)
{
	//your OnPlayerDisconnect code here
	if(CarShop_IsPlayerInMission(playerid)) 
	{
		if(CarShop_VehicleIsVaild(playerid))
		{
			CarShop_PlayerFaild(playerid);
		}
	}
	if (gCARSHOP_HasCB[2])
	{
		return CallLocalFunction("CARSHOP_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect CARSHOP_OnPlayerDisconnect
forward CARSHOP_OnPlayerDisconnect(playerid,  reason);



//--------------OnPlayerEnterDynamicCP Hook-------------------

public OnPlayerEnterDynamicCP(playerid,checkpointid)
{
	//判断是否完结在在任务
	if(checkpointid == CarShop_Player[playerid][CP])
	{
		if(CarShop_IsPlayerInMission(playerid)) return 1;
		CarShop_PlayerStart(playerid);
		SG_Sub(playerid,"Get in the ~y~Car~w~ for the test drive.",5);
	}	
	if (gCARSHOP_HasCB[3])
	{
		return CallLocalFunction("CARSHOP_OnPlayerEnterDynamicCP", "ii",playerid,checkpointid);
	}
	return 1;
}
#if defined _ALS_OnPlayerEnterDynamicCP
	#undef OnPlayerEnterDynamicCP
#else
	#define _ALS_OnPlayerEnterDynamicCP
#endif
#define OnPlayerEnterDynamicCP CARSHOP_OnPlayerEnterDynamicCP
forward CARSHOP_OnPlayerEnterDynamicCP(playerid,checkpointid);



//--------------OnPlayerExitVehicle Hook-------------------

public OnPlayerExitVehicle(playerid, vehicleid)
{
	//your OnPlayerExitVehicle code here
	if(CarShop_IsPlayerInMission(playerid)) 
	{
		if(CarShop_VehicleIsVaild(playerid))
		{
			CarShop_PlayerFaild(playerid);
			SG_Sub(playerid,"~r~ You have left the vehicle.",5);
		}
	}
	
	if (gCARSHOP_HasCB[4])
	{
		return CallLocalFunction("CARSHOP_OnPlayerExitVehicle", "ii",playerid, vehicleid);
	}
	return 1;
}
#if defined _ALS_OnPlayerExitVehicle
	#undef OnPlayerExitVehicle
#else
	#define _ALS_OnPlayerExitVehicle
#endif
#define OnPlayerExitVehicle CARSHOP_OnPlayerExitVehicle
forward CARSHOP_OnPlayerExitVehicle(playerid, vehicleid);



//--------------OnPlayerKeyStateChange Hook-------------------

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	//your OnPlayerKeyStateChange code here

	
	if (gCARSHOP_HasCB[5])
	{
		return CallLocalFunction("CARSHOP_OnPlayerKeyStateChange", "iii",playerid, newkeys, oldkeys);
	}
	return 1;
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange CARSHOP_OnPlayerKeyStateChange
forward CARSHOP_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);

//--------------OnPlayerStateChange Hook-------------------

public OnPlayerStateChange(playerid, newstate,  oldstate)
{
	//your OnPlayerStateChange code here
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) // Player entered a vehicle as a driver
    {
		//如果玩家在任务里面
		if(CarShop_IsPlayerInMission(playerid)) 
		{
			if(CarShop_VehicleIsVaild(playerid))
			{
				//销毁OBJECTIVE
				SetPlayerObjective(playerid,CarShop_PlayerVehGet(playerid),false);
				//提示玩家试驾
				new cartype = CarShop_PlayerGetVehType(playerid);
				switch(cartype)
				{
					case VEHICLE_FAST: SG_Sub(playerid,"Drive this car as fast as possible.",5);
					case VEHICLE_SLOW: SG_Sub(playerid,"Drive this car as slowly as possible.",5);
				}
			}
		}
		
    }
	
	if (gCARSHOP_HasCB[0])
	{
		return CallLocalFunction("CARSHOP_OnPlayerStateChange", "iii",playerid, newstate,  oldstate);
	}
	return 1;
}
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange CARSHOP_OnPlayerStateChange
forward CARSHOP_OnPlayerStateChange(playerid, newstate,  oldstate);





//--------------OnVehicleDeath Hook-------------------

public OnVehicleDeath(vehicleid)
{
	//your OnVehicleDeath code here

	if (gCARSHOP_HasCB[6])
	{
		return CallLocalFunction("CARSHOP_OnVehicleDeath", "i",vehicleid);
	}
	return 1;
}
#if defined _ALS_OnVehicleDeath
	#undef OnVehicleDeath
#else
	#define _ALS_OnVehicleDeath
#endif
#define OnVehicleDeath CARSHOP_OnVehicleDeath
forward CARSHOP_OnVehicleDeath(vehicleid);



