#define KEY_MISSION (newkeys & KEY_SUBMISSION) && !(oldkeys & KEY_SUBMISSION)
#define KEY_ALT  (newkeys &  KEY_WALK ) && !(oldkeys &  KEY_WALK )

//任务地点
#define CP_X -1970.7388
#define CP_Y  297.4897
#define CP_Z  34.7497
#define CP_SIZE  3.0

//-1979.2891,288.7288,35.1719
#define CPB_X -1979.2891
#define CPB_Y 288.7288
#define CPB_Z 35.1719

//递增值
#define ADD_VAL 5

new CarShopCP[2];

#include <SA/Mission/CarShop/Vehicles>
#include <SA/Mission/CarShop/Player>
#include <SA/Mission/CarShop/Updater>

static gCARSHOP_HasCB[8];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//Mission Location
	CarShop_CreateCP();
	//function hook checks
	SetTimer("OnCarShopDrive",1000,true);
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
	if(!IsPlayerNPC(playerid)) CarShop_PlayerCreateCP(playerid);
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
	if(checkpointid == CarShopCP[0])
	{
		if(CarShop_IsPlayerInMission(playerid)) return 1;
		CarShop_PlayerStart(playerid);
		SG_Sub(playerid,"Take the ~y~vehicle~w~ on a test drive.",5);
	}	
	if(checkpointid == CarShopCP[1])
	{
		CarShop_SetPlayerMissionStatus(playerid,false);
		//任务完成!!!!!!!!!!!!!!!!!!!!!!!
		GivePlayerMoney(playerid,1200);
		GameTextForPlayer(playerid, "Payout:~w~$1200", 2000, 6);
		PlayerPlaySound(playerid,SOUND_COMPELETE,0.0,0.0,0.0);
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
				//UI
				CarShop_PlayerCreateUI(playerid);
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


stock CarShop_CreateCP()
{
	CarShopCP[0] = CreateDynamicCP(CP_X,CP_Y,CP_Z,CP_SIZE,-1,-1,-1,50.0);
	CarShopCP[1] = CreateDynamicCP(CPB_X,CPB_Y,CPB_Z,CP_SIZE,-1,-1,-1,-1);
}


