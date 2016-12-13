//For more info on ALS Hooking check
//http://forum.sa-mp.com/showthread.php?t=85907
#include <SA/Mission/Collect/Player.inc>
static gCol_HasCB[3];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//创建物品
	
	COLLECT_CreatePickUp();
	//function hook checks

	gCol_HasCB[0] = funcidx("Col_OnPlayerConnect") != -1;
	gCol_HasCB[1] = funcidx("Col_OnPlayerDisconnect") != -1;
	gCol_HasCB[2] = funcidx("Col_OnPlayerPickUpPickup") != -1;
	if (funcidx("Col_OnGameModeInit") != -1)
	{
		return CallLocalFunction("Col_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Col_OnGameModeInit
forward Col_OnGameModeInit();



//--------------OnPlayerConnect Hook-------------------

public OnPlayerConnect(playerid)
{
	//your OnPlayerConnect code here

	if (gCol_HasCB[0])
	{
		return CallLocalFunction("Col_OnPlayerConnect", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Col_OnPlayerConnect
forward Col_OnPlayerConnect(playerid);



//--------------OnPlayerDisconnect Hook-------------------

public OnPlayerDisconnect(playerid,  reason)
{
	//your OnPlayerDisconnect code here

	if (gCol_HasCB[1])
	{
		return CallLocalFunction("Col_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect Col_OnPlayerDisconnect
forward Col_OnPlayerDisconnect(playerid,  reason);



//--------------OnPlayerPickUpPickup Hook-------------------

public OnPlayerPickUpPickup(playerid, pickupid)
{
	//your OnPlayerPickUpPickup code here

	if (gCol_HasCB[2])
	{
		return CallLocalFunction("Col_OnPlayerPickUpPickup", "ii",playerid, pickupid);
	}
	return 1;
}
#if defined _ALS_OnPlayerPickUpPickup
	#undef OnPlayerPickUpPickup
#else
	#define _ALS_OnPlayerPickUpPickup
#endif
#define OnPlayerPickUpPickup Col_OnPlayerPickUpPickup
forward Col_OnPlayerPickUpPickup(playerid, pickupid);



