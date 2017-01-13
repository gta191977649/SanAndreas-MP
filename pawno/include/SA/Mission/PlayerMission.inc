static gMission_HasCB[1];

enum MissionInfo
{
	MissionID,
}

new PlayerMission[MAX_PLAYERS][MissionInfo];

stock SetPlayerMissionID(playerid,Missionid)
{
	PlayerMission[playerid][MissionID] = Missionid;
}

stock GetPlayerMissionID(playerid)
{
	return PlayerMission[playerid][MissionID];
}
stock IsPlayerInMission(playerid)
{
	return PlayerMission[playerid][MissionID] == MISSION_NONE ? false : true;
}
stock SetPlayerMissionStatus(playerid,Missionid,bool:start)
{
	if(start)
	{
		//垃圾回收
		ResetPlayerMission(playerid,PlayerMission[playerid][MissionID]);
		PlayerMission[playerid][MissionID] = Missionid;
	}
	else 
	{
		PlayerMission[playerid][MissionID] = MISSION_NONE;
	}
}
stock ResetPlayerMission(playerid,missionid)
{
	if(missionid!= MISSION_NONE)
	{	
		switch (missionid)
		{
			case MISSION_HOTDOG: HOTDOG_SetPlayerMissionStatus(playerid,false);
			case MISSION_ICECREAM: IceCream_PLAYER_reset(playerid);
			case MISSION_PARAMEDIT: AMB_SetPlayerMissionStatus(playerid,false);
			case MISSION_PIZZA: PIZZA_SetPlayerMissionStatus(playerid,false);
			case MISSION_CARSHOP: CarShop_SetPlayerMissionStatus(playerid,false);
			case MISSION_BURGLARY: Burglary_SetPlayerMissionStatus(playerid,false);
		}
	}
}

stock ShowMissionFailed(playerid)
{
	SG_TextMission(playerid,"~r~任务失败!",5);
}
stock ShowMissionPass(playerid,bouns[])
{
	new str[125];
	format(str,sizeof(str),"任务通过!~n~%s",bouns);
	SG_TextMission(playerid,str,5);
}

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//your OnGameModeInit pre code here

	//function hook checks
	print("============================");
	print("SA Mission Library");
	print("By Liberty_Episodes");
	print("Loaded.");
	print("============================");

	gMission_HasCB[0] = funcidx("Mission_OnPlayerDisconnect") != -1;
	if (funcidx("Mission_OnGameModeInit") != -1)
	{
		return CallLocalFunction("Mission_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Mission_OnGameModeInit
forward Mission_OnGameModeInit();



//--------------OnPlayerDisconnect Hook-------------------

public OnPlayerDisconnect(playerid,  reason)
{
	//your OnPlayerDisconnect code here
	//复位玩家任务状态
	ResetPlayerMission(playerid,GetPlayerMissionID(playerid));
	
	if (gMission_HasCB[0])
	{
		return CallLocalFunction("Mission_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect Mission_OnPlayerDisconnect
forward Mission_OnPlayerDisconnect(playerid,  reason);



