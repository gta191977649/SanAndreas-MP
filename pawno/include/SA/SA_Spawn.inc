//For more info on ALS Hooking check
//http://forum.sa-mp.com/showthread.php?t=85907

static gSPAWN_HasCB[2];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//your OnGameModeInit pre code here

	//function hook checks

	gSPAWN_HasCB[0] = funcidx("SPAWN_OnPlayerRequestSpawn") != -1;
	gSPAWN_HasCB[1] = funcidx("SPAWN_OnPlayerSpawn") != -1;
	if (funcidx("SPAWN_OnGameModeInit") != -1)
	{
		return CallLocalFunction("SPAWN_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit SPAWN_OnGameModeInit
forward SPAWN_OnGameModeInit();



//--------------OnPlayerRequestSpawn Hook-------------------

public OnPlayerRequestSpawn(playerid)
{
	//your OnPlayerRequestSpawn code here

	if (gSPAWN_HasCB[0])
	{
		return CallLocalFunction("SPAWN_OnPlayerRequestSpawn", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerRequestSpawn
	#undef OnPlayerRequestSpawn
#else
	#define _ALS_OnPlayerRequestSpawn
#endif
#define OnPlayerRequestSpawn SPAWN_OnPlayerRequestSpawn
forward SPAWN_OnPlayerRequestSpawn(playerid);



//--------------OnPlayerSpawn Hook-------------------

public OnPlayerSpawn(playerid)
{
	//SetPlayerPos(playerid,-1999.2786,288.1255,33.6684);//SF
	SetPlayerPos(playerid,-1999.2786,288.1255,33.6684);
	SetPlayerFacingAngle(playerid,270);
	//your OnPlayerSpawn code here

	if (gSPAWN_HasCB[1])
	{
		return CallLocalFunction("SPAWN_OnPlayerSpawn", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn SPAWN_OnPlayerSpawn
forward SPAWN_OnPlayerSpawn(playerid);



