//For more info on ALS Hooking check
//http://forum.sa-mp.com/showthread.php?t=85907

static gobjtive_HasCB[2];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//your OnGameModeInit pre code here

	//function hook checks

	gobjtive_HasCB[0] = funcidx("objtive_OnPlayerConnect") != -1;
	gobjtive_HasCB[1] = funcidx("objtive_OnPlayerDisconnect") != -1;
	if (funcidx("objtive_OnGameModeInit") != -1)
	{
		return CallLocalFunction("objtive_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit objtive_OnGameModeInit
forward objtive_OnGameModeInit();



//--------------OnPlayerConnect Hook-------------------

public OnPlayerConnect(playerid)
{
	//your OnPlayerConnect code here
	ResetPlayerObjecitve(playerid);
	
	if (gobjtive_HasCB[0])
	{
		return CallLocalFunction("objtive_OnPlayerConnect", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect objtive_OnPlayerConnect
forward objtive_OnPlayerConnect(playerid);



//--------------OnPlayerDisconnect Hook-------------------

public OnPlayerDisconnect(playerid,  reason)
{
	//your OnPlayerDisconnect code here

	ResetPlayerObjecitve(playerid);
	
	if (gobjtive_HasCB[1])
	{
		return CallLocalFunction("objtive_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect objtive_OnPlayerDisconnect
forward objtive_OnPlayerDisconnect(playerid,  reason);



