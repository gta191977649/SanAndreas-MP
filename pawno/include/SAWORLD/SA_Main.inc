//For more info on ALS Hooking check
//http://forum.sa-mp.com/showthread.php?t=85907
#include <SAWORLD/SA_WeaponSkill>
#include <SAWORLD/Enviroment/Veh/SA_WorldVehicles>
#include <SAWORLD/Enviroment/NPC/SA_WorldNPC>

#define GAMEMODE "SAMP圣安地列斯v0.1"
static gMAIN_HasCB[3];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	SetGameModeText(GAMEMODE);
	printf("Main Moudel Is Loaded.");
	//加载世界系统车辆
	new WORLD_VEH = SYSTEM_LoadSAWorldVehicle();

	
	printf("[世界交通工具]: 已经加载:%d个",WORLD_VEH);
	//function hook checks

	gMAIN_HasCB[0] = funcidx("MAIN_OnPlayerConnect") != -1;
	gMAIN_HasCB[1] = funcidx("MAIN_OnPlayerDisconnect") != -1;
	gMAIN_HasCB[2] = funcidx("MAIN_OnPlayerSpawn") != -1;
	if (funcidx("MAIN_OnGameModeInit") != -1)
	{
		return CallLocalFunction("MAIN_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit MAIN_OnGameModeInit
forward MAIN_OnGameModeInit();



//--------------OnPlayerConnect Hook-------------------

public OnPlayerConnect(playerid)
{
	

	if (gMAIN_HasCB[0])
	{
		return CallLocalFunction("MAIN_OnPlayerConnect", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect MAIN_OnPlayerConnect
forward MAIN_OnPlayerConnect(playerid);



//--------------OnPlayerDisconnect Hook-------------------

public OnPlayerDisconnect(playerid,  reason)
{
	//your OnPlayerDisconnect code here

	if (gMAIN_HasCB[1])
	{
		return CallLocalFunction("MAIN_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect MAIN_OnPlayerDisconnect
forward MAIN_OnPlayerDisconnect(playerid,  reason);



//--------------OnPlayerSpawn Hook-------------------

public OnPlayerSpawn(playerid)
{
	//your OnPlayerSpawn code here

	if (gMAIN_HasCB[2])
	{
		return CallLocalFunction("MAIN_OnPlayerSpawn", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn MAIN_OnPlayerSpawn
forward MAIN_OnPlayerSpawn(playerid);



