
#define BULGRAY_PICKUPMODEL 19198
#define BULGRAY_PICKUPTYPE 1

enum BurglaryRoomInfo
{
	bool:b_used,//表示当前房间是否可用
	b_status, //任务状态
	b_stealAmount,
	b_maxAmount,
	b_vehicle, //车辆ID
	b_entrypickup,//进入房子的PickUp
	b_exitpickup,//离开房子的PickUp
	b_map,
	b_hourseid
	
}
new BurglaryRoom[MAX_BURGLARY][BurglaryRoomInfo]; //任务房间
new BurglaryRoomPlayers[MAX_BURGLARY][MAX_BURGLARY_PLAYER];
//开启房间

/*
stock Burglary_StartRoom(playerid)
{
	new roomid = Burglary_GetAvaiableRoomID();
	if(roomid != NULL)
	{
		ShowInfoBox(playerid,INFO_BoxBG,5,"There is no aviable room, sorry.");
		return 1;
	}
		
}
*/

stock BurglaryRoomPlayersReset()
{
	for(new i =0; i < MAX_BURGLARY;i++)
		for(new j =0; j < MAX_BURGLARY_PLAYER;j++)
			BurglaryRoomPlayers[i][j] = INVALID_PLAYER_ID;
		
	//debug
	for(new i =0; i < MAX_BURGLARY;i++)
		for(new j =0; j < MAX_BURGLARY_PLAYER;j++)
			printf("i %d, j %d Var %d",i,j,BurglaryRoomPlayers[i][j]);
}

stock Burglary_UpdateMissionObj(roomid,houseid)
{
	//更新提示所有玩家
	new str[125];
	for(new i =0; i < MAX_BURGLARY_PLAYER;i++)
	{
		if(BurglaryRoomPlayers[roomid][i] != INVALID_PLAYER_ID)
		{
			format(str,sizeof(str),BURGLARY_OBJ1,GetZoneNameFromPos(BurlagryHoursesLS[houseid][0],BurlagryHoursesLS[houseid][1]));
			SG_Sub(BurglaryRoomPlayers[roomid][i],str,5);
		}
	}
	return 1;
}
stock Burglary_SetHouse(roomid,houseid)
{
	BurglaryRoom[roomid][b_hourseid] = houseid;
	Burglary_CreatePickUp(roomid,houseid);
}

stock Burglary_GetHouseID(roomid)
{
	return BurglaryRoom[roomid][b_hourseid];
}
stock Burglary_CreatePickUp(roomid,houseid)
{
	
	printf("Burglary_CreatePickUp(%d,%d)",roomid,houseid);
	for(new i =0; i < MAX_BURGLARY_PLAYER;i++)
	{
		if(BurglaryRoomPlayers[roomid][i] != INVALID_PLAYER_ID)
		{
			//进入的Pickup
			BurglaryRoom[roomid][b_entrypickup] = CreateDynamicPickup(BULGRAY_PICKUPMODEL, BULGRAY_PICKUPTYPE, BurlagryHoursesLS[houseid][0],BurlagryHoursesLS[houseid][1], BurlagryHoursesLS[houseid][2],-1,0,BurglaryRoomPlayers[roomid][i],STREAMER_PICKUP_SD);
			//printf("CreateDynamicPickup %d %f %f %f %d",BULGRAY_PICKUPMODEL,BurlagryHoursesLS[houseid][0],BurlagryHoursesLS[houseid][1], BurlagryHoursesLS[houseid][2],BurglaryRoomPlayers[roomid][i]);
			//离开的PickUP
			BurglaryRoom[roomid][b_exitpickup] = CreateDynamicPickup(BULGRAY_PICKUPMODEL, BULGRAY_PICKUPTYPE, BurlagryHoursesLS[houseid][3],BurlagryHoursesLS[houseid][4], BurlagryHoursesLS[houseid][5],-1,0,BurglaryRoomPlayers[roomid][i],STREAMER_PICKUP_SD);
			
		
		}
	}
	
}
stock Burglary_CreateMarker(roomid,houseid)
{
	//在地图上标记颜色
	for(new i =0; i < MAX_BURGLARY_PLAYER;i++)
	{
		if(BurglaryRoomPlayers[roomid][i] != INVALID_PLAYER_ID)
		{
			BurglaryRoom[roomid][b_map] = CreateDynamicMapIcon(BurlagryHoursesLS[houseid][0],BurlagryHoursesLS[houseid][1], BurlagryHoursesLS[houseid][2], 0, C_MOBJECTIVE,0, 0,BurglaryRoomPlayers[roomid][i],  STREAMER_MAP_ICON_SD, MAPICON_GLOBAL);
			
			//BurglaryRoom[roomid][b_map] = CreateDynamicMapIcon(BurlagryHoursesLS[houseid][0],BurlagryHoursesLS[houseid][1], BurlagryHoursesLS[houseid][2], -1, C_MOBJECTIVE, BurglaryRoomPlayers[roomid][i]);
		}
	}
}

stock Burglary_GenRobbryHouseID()
{
	//随机选择房子
	new Rand = random(sizeof(BurlagryHoursesLS));
	return Rand;
}
//功能函数

stock Burglary_SetVehicle(roomid,vehicleid)
{
	BurglaryRoom[roomid][b_vehicle] = vehicleid;
}
stock Burglary_GetVehicle(roomid)
{
	return BurglaryRoom[roomid][b_vehicle];
}
stock Burglary_SetStealAmount(roomid,amount)
{
	BurglaryRoom[roomid][b_stealAmount] = amount;
}
stock Burglary_GetStealAmount(roomid)
{
	return BurglaryRoom[roomid][b_stealAmount];
}
stock Burglary_SetMaxStealAmount(roomid,amount)
{
	BurglaryRoom[roomid][b_maxAmount] = amount;
}
stock Burglary_GetMaxStealAmount(roomid)
{
	return BurglaryRoom[roomid][b_maxAmount];
}
stock Burglary_SetMisssionStatus(roomid,status)
{
	BurglaryRoom[roomid][b_status] = status;
}
stock Burglary_GetMisssionStatus(roomid)
{
	return BurglaryRoom[roomid][b_status];
}

stock Burglary_SetPlayerSlot(roomid,slot,playerid)
{
	BurglaryRoomPlayers[roomid][slot] = playerid;
}

stock Burglary_GetPlayerSlot(roomid,slot)
{
	return BurglaryRoomPlayers[roomid][slot];
}

stock Burglary_GetAvaiableRoomID()
{
	for(new i = 0; i < MAX_BURGLARY;i++)
		if(!BurglaryRoom[i][b_used]) return i;
	return NULL;
}

stock Burglary_GetAvaiablePlayerSlot(roomid)
{

	for(new i = 0; i < MAX_BURGLARY_PLAYER;i++)
		if(BurglaryRoomPlayers[roomid][i] == INVALID_PLAYER_ID) return i;

	return NULL;
}
