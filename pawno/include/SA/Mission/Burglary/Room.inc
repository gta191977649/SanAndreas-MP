
enum BurglaryRoomInfo
{
	bool:b_used,//表示当前房间是否可用
	b_status, //任务状态
	b_stealAmount,
	b_maxAmount,
	b_vehicle, //车辆ID
	b_map,
	b_hourseid,
	b_cash,
	b_city //哪个城市进行的任务
	
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
		ShowInfoBox(playerid,INFO_BoxBG,5,BURGLARY_NOROOM);
		return 1;
	}
		
}
*/

stock BurglaryRoomPlayersReset()
{
	for(new i =0; i < MAX_BURGLARY;i++)
		for(new j =0; j < MAX_BURGLARY_PLAYER;j++)
			BurglaryRoomPlayers[i][j] = INVALID_PLAYER_ID;
}

stock Burglary_CreateFuniture(roomid,houseid)
{
	BurglaryReadFunitureFromFile(roomid,houseid);
}

stock Burglary_DeleteFuniture(roomid)
{
	for(new i = 0; i < MAX_FUNITURE; i++)
		BurglaryFunitureDelete(roomid,i);
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

stock Burglary_UpdateUIForAllPlayer(roomid)
{
	for(new i =0; i < MAX_BURGLARY_PLAYER;i++)
	{
		if(BurglaryRoomPlayers[roomid][i] != INVALID_PLAYER_ID)
		{
			Burglary_PlayerUpdateUI(BurglaryRoomPlayers[roomid][i]);
		}
	}
	
	
	//当全部都偷完的时候
	if(Burglary_GetStealAmount(roomid) >= 1)
	{
		Burglary_ReturnLoad(roomid);
	}
}

stock Burglary_ReturnLoad(roomid)
{
	Burglary_DeleteMarker(roomid);
	Burglary_CreateReturnCP(roomid);
}

stock Burglary_CreateReturnCP(roomid)
{
	new BurglaryCity = Burglary_GetCity(roomid);
	
	for(new i =0; i < MAX_BURGLARY_PLAYER;i++)
	{
		if(BurglaryRoomPlayers[roomid][i] != INVALID_PLAYER_ID)
		{
			BuglaryPlayerCreateReturnCP(BurglaryRoomPlayers[roomid][i],BurglaryCity);
		}
	}
	
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

	for(new i =0; i < MAX_BURGLARY_PLAYER;i++)
	{
		if(BurglaryRoomPlayers[roomid][i] != INVALID_PLAYER_ID)
		{
			BurglaryPlayerPickUpCreate(BurglaryRoomPlayers[roomid][i],houseid);
		}
	}
	
}

stock Burglary_DeleteUIForAll(roomid)
{
	for(new i =0; i < MAX_BURGLARY_PLAYER;i++)
	{
		if(BurglaryRoomPlayers[roomid][i] != INVALID_PLAYER_ID)
		{
			Burglary_PlayerDeleteUI(BurglaryRoomPlayers[roomid][i]);
		}
	}	
}

stock Burglary_DeletePickUp(roomid,houseid)
{

	for(new i =0; i < MAX_BURGLARY_PLAYER;i++)
	{
		if(BurglaryRoomPlayers[roomid][i] != INVALID_PLAYER_ID)
		{
			BurglaryPlayerPickUpDelete(BurglaryRoomPlayers[roomid][i]);
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
			CreatePlayerObjectiveMarker(BurglaryRoomPlayers[roomid][i],BurlagryHoursesLS[houseid][0],BurlagryHoursesLS[houseid][1], BurlagryHoursesLS[houseid][2],C_MOBJECTIVE);
			
			//BurglaryRoom[roomid][b_map] = CreateDynamicMapIcon(BurlagryHoursesLS[houseid][0],BurlagryHoursesLS[houseid][1], BurlagryHoursesLS[houseid][2], -1, C_MOBJECTIVE, BurglaryRoomPlayers[roomid][i]);
		}
	}
}
stock Burglary_CPResetForAll(roomid)
{
	for(new i =0; i < MAX_BURGLARY_PLAYER;i++)
	{
		if(BurglaryRoomPlayers[roomid][i] != INVALID_PLAYER_ID)
		{
			Burglary_PlayerCPReset(BurglaryRoomPlayers[roomid][i]);
		}
	}
	
}
stock Burglary_DeleteMarker(roomid)
{
	//在地图上标记颜色
	for(new i =0; i < MAX_BURGLARY_PLAYER;i++)
	{
		if(BurglaryRoomPlayers[roomid][i] != INVALID_PLAYER_ID)
		{
			
			DestoryPlayerObjectiveMarker(BurglaryRoomPlayers[roomid][i]);
			//BurglaryRoom[roomid][b_map] = CreateDynamicMapIcon(BurlagryHoursesLS[houseid][0],BurlagryHoursesLS[houseid][1], BurlagryHoursesLS[houseid][2], -1, C_MOBJECTIVE, BurglaryRoomPlayers[roomid][i]);
		}
	}
}

stock Burglary_ResetMissionForAll(roomid)
{
	for(new i =0; i < MAX_BURGLARY_PLAYER;i++)
	{
		if(BurglaryRoomPlayers[roomid][i] != INVALID_PLAYER_ID)
		{
			Burglary_SetPlayerMissionStatus(BurglaryRoomPlayers[roomid][i],false);
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
stock Burglary_SetCity(roomid,city)
{
	BurglaryRoom[roomid][b_city] = city;
}
stock Burglary_GetCity(roomid)
{
	return BurglaryRoom[roomid][b_city];
}

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
stock Burglary_SetStealCash(roomid,amount)
{
	BurglaryRoom[roomid][b_status] = amount;
}
stock Burglary_GetStealCash(roomid)
{
	return BurglaryRoom[roomid][b_status];
}

stock Burglary_GetMisssionStatus(roomid)
{
	return BurglaryRoom[roomid][b_status];
}

stock Burglary_SetPlayerSlot(roomid,slot,playerid)
{
	BurglaryRoomPlayers[roomid][slot] = playerid;
}
//从房间里面移除玩家
stock Burglary_ResetPlayerSlot(roomid,playerid)
{
	for(new i = 0; i < MAX_BURGLARY_PLAYER; i++)
		if(BurglaryRoomPlayers[roomid][i] == playerid) BurglaryRoomPlayers[roomid][i] = INVALID_PLAYER_ID;
}

stock Burglary_GetPlayerSlot(roomid,slot)
{
	return BurglaryRoomPlayers[roomid][slot];
}

stock Burglary_SetRoomUse(roomid,bool:status)
{
	BurglaryRoom[roomid][b_used] = status;
	
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

stock Burglary_RoomResetAll()
{
	for(new i = 0; i < MAX_BURGLARY;i++)
	{
		BurglaryRoom[i][b_vehicle] = INVALID_VEHICLE_ID;
		BurglaryRoom[i][b_used] = false;
	}
}
stock Burglary_GetVehicleRoom(vehicleid)
{
	for(new i = 0; i < MAX_BURGLARY;i++)
		if(BurglaryRoom[i][b_used] && BurglaryRoom[i][b_vehicle] == vehicleid) return i;
	return NULL;
}
stock Burglary_StartRoom(roomid)
{	
	Burglary_SetRoomUse(roomid,true);
	//分配盗窃房子
	new houseid = Burglary_GenRobbryHouseID();
	//创建室内家具
	Burglary_CreateFuniture(roomid,houseid);
}


stock Burglary_EndRoom(roomid)
{
	Burglary_ResetMissionForAll(roomid);
	Burglary_SetRoomUse(roomid,false);
	Burglary_SetVehicle(roomid,INVALID_VEHICLE_ID);
	Burglary_SetStealCash(roomid,0);
	Burglary_SetMaxStealAmount(roomid,0);
	Burglary_SetStealCash(roomid,0);
	Burglary_DeleteFuniture(roomid);
	
}