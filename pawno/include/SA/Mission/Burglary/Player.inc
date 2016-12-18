

new PlayerBurglaryRoom[MAX_PLAYERS];


stock PlayerBurglaryRoomReset()
{
	for(new i=0; i < MAX_PLAYERS;i++)
		PlayerBurglaryRoom[MAX_PLAYERS] = NULL;
}
stock Burglary_IsPlayerInMission(playerid)
{
	if(GetPlayerMissionID(playerid) == MISSION_BURGLARY && IsPlayerInMission(playerid)) return true;
	else return false;
}
stock Burglary_SetPlayerMissionStatus(playerid,bool:toogle)
{
	if(toogle)
	{
		SetPlayerMissionStatus(playerid,MISSION_BURGLARY,true);
		
	}
	else
	{
		SetPlayerMissionStatus(playerid,MISSION_BURGLARY,false);
		Burglary_PLAYER_reset(playerid);
	}
}

stock Burglary_PlayerStart(playerid)
{


	//获取房间ID
	new roomid = Burglary_GetAvaiableRoomID();
	if(roomid == NULL)
	{
		ShowInfoBox(playerid,INFO_BoxBG,5,BURGLARY_NOROOM);
		return 1;
	}
	
	Burglary_PlayerRoomSet(playerid,roomid);
	printf("Burglary_PlayerRoomSet");
	//加入房间
	Burglary_PlayerJoin(roomid,playerid);
	printf("Burglary_PlayerJoin");
	//设置任务状态
	Burglary_SetVehicle(roomid,GetPlayerVehicleID(playerid));
	printf("Burglary_SetVehicle");
	//分配盗窃房子
	new houseid = Burglary_GenRobbryHouseID();
	printf("Burglary_GenRobbryHouseID");
	
	//创建室内家具
	Burglary_CreateFuniture(roomid,houseid);
	//创建PickUp
	Burglary_CreatePickUp(roomid,houseid);
	//创建地图图标
	Burglary_CreateMarker(roomid,houseid);
	//更新任务提示
	Burglary_UpdateMissionObj(roomid,houseid);
	
	printf("入室任务开始");
	
	return 1;
}
stock Burglary_PLAYER_reset(playerid)
{
	/*
	Burglary_PlayerExit(playerid);
	
	
	Burglary_PlayerRoomReset(playerid);
	*/
	
}
stock Burglary_PlayerJoin(roomid,playerid)
{
	printf("pre Burglary_PlayerJoin");
	new playerSlot = Burglary_GetAvaiablePlayerSlot(roomid);
	
	printf("Burglary_GetAvaiablePlayerSlot");
	Burglary_SetPlayerSlot(roomid,playerSlot,playerid);
	printf("Burglary_SetPlayerSlot");
	//设置任务状态
	Burglary_SetPlayerMissionStatus(playerid,true);
	printf("Burglary_PlayerJoin Out");
}
stock Burglary_PlayerExit(playerid)
{
	Burglary_SetPlayerSlot(PlayerBurglaryRoom[playerid],slot,playerid)
}
stock Burglary_PlayerRoomSet(playerid,roomid)
{
	PlayerBurglaryRoom[playerid] = roomid;
}
stock Burglary_PlayerRoomReset(playerid)
{
	PlayerBurglaryRoom[playerid] = NULL;
}

stock Burglary_PlayerRoomGet(playerid)
{
	return PlayerBurglaryRoom[playerid];
}