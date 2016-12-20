#define PLAYER_ATTACH_INDEX 9
#define PLAYER_ANIM_DELAY 1500

new PlayerBurglaryRoom[MAX_PLAYERS];
enum PlayerBurglarInfo
{
	bool:ishold,//如果手持家具的话
	b_holdFunitureID//拿起的ID
};

new PlayerBurglar[MAX_PLAYERS][PlayerBurglarInfo];

stock BurglaryPlayerSetHoldID(playerid,var) // 设置拿起来的家具ID
{
	PlayerBurglar[playerid][b_holdFunitureID] = var;
}
stock BurglaryPlayerGetHoldID(playerid) //获取拿起来的家具ID
{
	return PlayerBurglar[playerid][b_holdFunitureID];
}

stock BurglaryPlayerSetHoldStatus(playerid,bool:holditm)
{
	if(holditm) PlayerBurglar[playerid][ishold] = true;
	else PlayerBurglar[playerid][ishold] = false;
}
stock BurglaryPlayerGetHoldStatus(playerid)
{
	return PlayerBurglar[playerid][ishold];
}

//放下家具(地板上)
stock BurglaryPlayerFunitureOnFloor(playerid,funitureidx)
{
	new PlayerGameID = Burglary_PlayerRoomGet(playerid); 

	BurglaryAnimationDown(playerid);
	//设置动作延迟
	SetTimerEx("BurglaryPutDown",PLAYER_ANIM_DELAY, false, "iii",playerid,PlayerGameID,funitureidx);
}
//拿起家具
stock BurglaryPlayerLiftFuniture(playerid,funitureidx)
{
	new PlayerGameID = Burglary_PlayerRoomGet(playerid); 
	BurglaryAnimationPick(playerid);
	//设置动作延迟
	SetTimerEx("BurglaryPickUp",PLAYER_ANIM_DELAY, false, "iii",playerid,PlayerGameID,funitureidx);
}

forward BurglaryPutDown(playerid,GameID,funitureidx);
public BurglaryPutDown(playerid,GameID,funitureidx)
{
	new PlayerGameID = Burglary_PlayerRoomGet(playerid); 
	RemovePlayerAttachedObject(playerid,PLAYER_ATTACH_INDEX);
	BurglaryFunitureShow(playerid,PlayerGameID,funitureidx);
	//清除拿起的家具ID
	BurglaryPlayerSetHoldID(playerid,NULL);
	//设置玩家状态
	BurglaryPlayerSetHoldStatus(playerid,false);
	//清楚动作
	BurglaryAnimationClear(playerid);
}
forward BurglaryPickUp(playerid,GameID,funitureidx);
public BurglaryPickUp(playerid,GameID,funitureidx)
{
	//绑定OBJ给玩家
	new ObjectModel = BurglaryFunitureGetModel(GameID,funitureidx);
	SetPlayerAttachedObject(playerid,PLAYER_ATTACH_INDEX,ObjectModel,1,0,0.6,0,0,90,0,1.000000, 1.000000, 1.000000);
	//隐藏静态OBJ
	BurglaryFunitureHide(GameID,funitureidx);
	//设置动作
	BurglaryAnimationPrtial(playerid);
	//设置拿起ID
	BurglaryPlayerSetHoldID(playerid,funitureidx);
	//设置玩家状态
	BurglaryPlayerSetHoldStatus(playerid,true);
}
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
	
	//加入房间
	Burglary_PlayerJoin(roomid,playerid);
	
	//设置任务状态
	Burglary_SetVehicle(roomid,GetPlayerVehicleID(playerid));
	
	//分配盗窃房子
	new houseid = Burglary_GenRobbryHouseID();
	
	
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