#define PLAYER_ATTACH_INDEX 9
#define PLAYER_ANIM_DELAY 1500


#define BULGRAY_PICKUPMODEL 19198
#define BULGRAY_PICKUPTYPE 1

new PlayerBurglaryRoom[MAX_PLAYERS];
enum PlayerBurglarInfo
{
	bool:ishold,//如果手持家具的话
	b_entrypickup,//进入房子的PickUp
	b_exitpickup,//离开房子的PickUp
	b_holdFunitureID//拿起的ID
};

new PlayerBurglar[MAX_PLAYERS][PlayerBurglarInfo];
stock BurglaryPlayerPickUpCreate(playerid,houseid)
{

	PlayerBurglar[playerid][b_entrypickup] = CreateDynamicPickup(BULGRAY_PICKUPMODEL, BULGRAY_PICKUPTYPE, BurlagryHoursesLS[houseid][0],BurlagryHoursesLS[houseid][1], BurlagryHoursesLS[houseid][2],-1,0,playerid,STREAMER_PICKUP_SD);
	PlayerBurglar[playerid][b_exitpickup] = CreateDynamicPickup(BULGRAY_PICKUPMODEL, BULGRAY_PICKUPTYPE, BurlagryHoursesLS[houseid][4],BurlagryHoursesLS[houseid][5], BurlagryHoursesLS[houseid][6],-1,0,playerid,STREAMER_PICKUP_SD);
}

stock Burglary_PlayerPickUpDelete(playerid)
{
	if(IsValidDynamicPickup(PlayerBurglar[playerid][b_entrypickup])) DestroyDynamicPickup(PlayerBurglar[playerid][b_entrypickup]);
	if(IsValidDynamicPickup(PlayerBurglar[playerid][b_exitpickup])) DestroyDynamicPickup(PlayerBurglar[playerid][b_exitpickup]);
}
stock BurglaryPlayerSetHoldID(playerid,var) // 设置拿起来的家具ID
{
	PlayerBurglar[playerid][b_holdFunitureID] = var;
}
stock BurglaryPlayerGetHoldID(playerid) //获取拿起来的家具ID
{
	return PlayerBurglar[playerid][b_holdFunitureID];
}
stock BuglaryPlayerCreateReturnCP(playerid,city)
{
	switch(city)
	{
		case CITY_LS:
		{
			TogglePlayerDynamicCP(playerid,BurglaryGarageCP[0],true);
			TogglePlayerDynamicCP(playerid,BurglaryGarageCP[1],false);
			TogglePlayerDynamicCP(playerid,BurglaryGarageCP[2],false);
		}
		case CITY_SF:
		{
			TogglePlayerDynamicCP(playerid,BurglaryGarageCP[0],false);
			TogglePlayerDynamicCP(playerid,BurglaryGarageCP[1],true);
			TogglePlayerDynamicCP(playerid,BurglaryGarageCP[2],false);
		}
		case CITY_LV:
		{
			TogglePlayerDynamicCP(playerid,BurglaryGarageCP[0],false);
			TogglePlayerDynamicCP(playerid,BurglaryGarageCP[1],false);
			TogglePlayerDynamicCP(playerid,BurglaryGarageCP[2],true);
		}
	}
	
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

//卸载家具
stock BurglaryPlayerLoadFuniture(playerid,funitureidx)
{
	new PlayerGameID = Burglary_PlayerRoomGet(playerid); 
	
	BurglaryAnimationDown(playerid);
	//设置动作延迟
	SetTimerEx("BurglaryLoadFununture",PLAYER_ANIM_DELAY, false, "iii",playerid,PlayerGameID,funitureidx);
	
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
	BurglaryPlayerSetFontOfFuniture(playerid,PlayerGameID,funitureidx);
	BurglaryAnimationPick(playerid);
	//设置动作延迟
	SetTimerEx("BurglaryPickUp",PLAYER_ANIM_DELAY, false, "iii",playerid,PlayerGameID,funitureidx);
}

forward BurglaryLoadFununture(playerid,GameID,funitureidx);
public BurglaryLoadFununture(playerid,GameID,funitureidx)
{
	new PlayerGameID = Burglary_PlayerRoomGet(playerid); 
	RemovePlayerAttachedObject(playerid,PLAYER_ATTACH_INDEX);
	//BurglaryFunitureShow(playerid,PlayerGameID,funitureidx);
	//加钱
	new cash = Burglary_GetItemCash(BurglaryFunitureGetModel(PlayerGameID,funitureidx));
	Burglary_SetStealCash(PlayerGameID,Burglary_GetStealCash(PlayerGameID)+cash);
	//消除
	BurglaryFunitureDestory(PlayerGameID,funitureidx);
	//清除拿起的家具ID
	BurglaryPlayerSetHoldID(playerid,NULL);
	//设置玩家状态
	BurglaryPlayerSetHoldStatus(playerid,false);
	//清楚动作
	BurglaryAnimationClear(playerid);
	//添加偷到了家具
	Burglary_SetStealAmount(PlayerGameID,Burglary_GetStealAmount(PlayerGameID)+1);
	//提示玩家
	PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
	//更新UI
	Burglary_UpdateUIForAllPlayer(PlayerGameID);
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

	//分配房间
	Burglary_StartRoom(roomid);
	
	//设置任务车辆
	Burglary_SetVehicle(roomid,GetPlayerVehicleID(playerid));
	//设置开始地方
	Burglary_SetCity(roomid,GetPlayerCurrentCity(playerid));
	
	//加入房间
	Burglary_PlayerJoin(roomid,playerid);

	printf("入室任务开始");
	
	return 1;
}

stock Burglary_PLAYER_reset(playerid)
{	
	new PlayerRoom = Burglary_PlayerRoomGet(playerid);
	Burglary_ResetPlayerSlot(Burglary_PlayerRoomGet(playerid),playerid);
	Burglary_PlayerRoomReset(playerid);
	Burglary_PlayerCPReset(playerid);
	Burglary_PlayerDeleteUI(playerid);
	Burglary_PlayerPickUpDelete(playerid);
	Burglary_PlayerDeleteMapMark(playerid);
	printf("重设玩家任务");
	//回收房间资源判断
	new RoomPlayers = Burglary_CountPlayer(PlayerRoom);
	printf("剩余玩家在房间: %d",RoomPlayers);
	if(RoomPlayers == 0) Burglary_EndRoom(PlayerRoom); 
}
stock Burglary_PlayerJoin(roomid,playerid)
{
	new playerSlot = Burglary_GetAvaiablePlayerSlot(roomid);
	
	printf("加入: 获得槽ID:%d",playerSlot);
	Burglary_SetPlayerSlot(roomid,playerSlot,playerid);
	//设置任务状态
	Burglary_SetPlayerMissionStatus(playerid,true);

	Burglary_PlayerRoomSet(playerid,roomid);
	//创建玩家PICKUP
	new GameRoom = Burglary_PlayerRoomGet(playerid);
	new GameHouse = Burglary_GetHouseID(GameRoom);
	
	//创建室内进入表示
	BurglaryPlayerPickUpCreate(playerid,GameHouse);
	//创建地图
	Burglary_PlayerCreateMapMark(playerid,GameHouse);
	

	//提示加入
	new pName[MAX_PLAYER_NAME],str[128];
	GetPlayerName(playerid,pName,sizeof(pName));
	format(str,sizeof(str),BURGLARY_TEXTJOIN,pName);
	Burglary_SendMsgToAll(roomid,str);
	
	//显示任务
	Burglary_PlayerUpdateObj(playerid,GameHouse);
	Burglary_PlayerUpdateUI(playerid);
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

stock Burglary_PlayerCreateMapMark(playerid,houseid)
{
	CreatePlayerObjectiveMarker(playerid,BurlagryHoursesLS[houseid][0],BurlagryHoursesLS[houseid][1], BurlagryHoursesLS[houseid][2],C_MOBJECTIVE);
}
stock Burglary_PlayerDeleteMapMark(playerid)
{
	DestoryPlayerObjectiveMarker(playerid);
}
stock Burglary_PlayerUpdateObj(playerid,houseid)
{
	new str[125];
	format(str,sizeof(str),BURGLARY_OBJ1,GetZoneNameFromPos(BurlagryHoursesLS[houseid][0],BurlagryHoursesLS[houseid][1]));
	SG_Sub(playerid,str,5);
	
	//printf("House: %s",GetZoneNameFromPos(BurlagryHoursesLS[houseid][0],BurlagryHoursesLS[houseid][1]));
}

stock Burglary_PlayerUpdateUI(playerid)
{
	new str[125];
	new PlayerRoom = Burglary_PlayerRoomGet(playerid);
	format(str,sizeof(str),BURGLARY_UIINDICATOR,Burglary_GetStealAmount(PlayerRoom),Burglary_GetMaxStealAmount(PlayerRoom),Burglary_GetStealCash(PlayerRoom));
	SG_RightSub(playerid,str,true);
	//Objs
	new PlayerTeam = Burglary_PlayerRoomGet(playerid);
	if(Burglary_GetStealAmount(PlayerTeam) >= Burglary_GetMaxStealAmount(PlayerTeam)) SG_Sub(playerid,BURGLARY_OBJBACK,5);
	else if(Burglary_GetStealAmount(PlayerTeam) > 1) SG_Sub(playerid,BURGLARY_OBJ5,5);
}
stock Burglary_PlayerDeleteUI(playerid)
{
	SG_RightSub(playerid,"",false);
}



stock Burglary_PlayerCPReset(playerid)
{
	//设置CP状态
	TogglePlayerDynamicCP(playerid,BurglaryGarageCP[0],false);
	TogglePlayerDynamicCP(playerid,BurglaryGarageCP[1],false);
	TogglePlayerDynamicCP(playerid,BurglaryGarageCP[2],false);
}