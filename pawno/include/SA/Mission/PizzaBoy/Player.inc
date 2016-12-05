enum Player_CP
{
	Float:cp_x,
	Float:cp_y,
	Float:cp_z,
	cp
}

new PlayerCP[MAX_PLAYERS][Player_CP];
new PlayerPizzaVeh[MAX_PLAYERS] = {INVALID_VEHICLE_ID,...};

stock PIZZA_IsPlayerInMission(playerid)
{
	if(GetPlayerMissionID(playerid) == MISSION_PIZZA && IsPlayerInMission(playerid)) return true;
	else return false;
}
stock PIZZA_PLAYER_start(playerid)
{
	PIZZA_SetPlayerMissionStatus(playerid,true);
	//UI
	PIZZA_PLAYER_CreateUI(playerid);
	//创建CP
	PIZZA_CreatePlayerCheckPoints(playerid);
}
stock PIZZA_PLAYER_Failed(playerid)
{
	PIZZA_PLAYER_reset(playerid);
}
stock PIZZA_PLAYER_CreateUI(playerid)
{
	SG_Sub(playerid,PIZZA_OBJTIVE,5);
	SG_Textbox(playerid,PIZZA_TUT,5);
	new tem[125];
	format(tem,sizeof(tem),"PIZZAS:			%d",PIZZA_GetRemain(playerid));
	SG_RightSub(playerid,tem,true);
}
stock PIZZA_PLAYER_UIUpdate(playerid)
{
	new tem[125],amount = PIZZA_GetRemain(playerid);
	format(tem,sizeof(tem),"PIZZAS:			%d",amount);
	SG_RightSub(playerid,tem,true);
	if(amount == 0) PIZZA_CreatePizzaShopCP(playerid);//没Pizza提示回去拿
}
stock PIZZA_PLAYER_DestoryUI(playerid)
{

	SG_RightSub(playerid," ",false);
}



stock PIZZA_PLAYER_reset(playerid)
{
	PIZZA_PLAYER_DestoryUI(playerid);
	PIZZA_ObjectsRecycle(playerid);
}



stock PIZZA_SetPlayerMissionStatus(playerid,bool:toogle)
{
	if(toogle)
	{
		SetPlayerMissionStatus(playerid,MISSION_PIZZA,true);
		
	}
	else
	{
		SetPlayerMissionStatus(playerid,MISSION_PIZZA,false);
		PIZZA_PLAYER_reset(playerid);
	}
}
stock PIZZA_CreatePizzaShopCP(playerid)
{
	PIZZA_DestoryPlayerCheckPoints(playerid);//删除之前的CP点
	PlayerCP[playerid][cp] = CreateDynamicCP(pizzaShop_LS[0][0],pizzaShop_LS[0][1],pizzaShop_LS[0][2],3,-1,-1,-1,-1);
}
stock PIZZA_DestoryPizzaShopCP(playerid)
{
	DestroyDynamicCP(PlayerCP[playerid][cp]);
}

stock PIZZA_CreatePlayerCheckPoints(playerid)
{
	PIZZA_DestoryPizzaShopCP(playerid);
	#define CONS (0.5)
	new randSpawn = 0;
	randSpawn = random(sizeof(gRandomSpawns_LosSantos));
	
	
	//CreateDynamicRaceCP(type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_RACE_CP_SD);
	PlayerCP[playerid][cp_x] = gRandomSpawns_LosSantos[randSpawn][0];
	PlayerCP[playerid][cp_y] = gRandomSpawns_LosSantos[randSpawn][1];
	PlayerCP[playerid][cp_z] = gRandomSpawns_LosSantos[randSpawn][2]+1;
	
	PlayerCP[playerid][cp] = CreateDynamicRaceCP(4,
	PlayerCP[playerid][cp_x],
	PlayerCP[playerid][cp_y],
	PlayerCP[playerid][cp_z],
    PlayerCP[playerid][cp_x]+ CONS * floatsin(gRandomSpawns_LosSantos[randSpawn][3], degrees),
	PlayerCP[playerid][cp_y] + CONS *  floatcos(gRandomSpawns_LosSantos[randSpawn][3], degrees),
	PlayerCP[playerid][cp_z],2,-1,-1,playerid,-1);
}

stock PIZZA_DestoryPlayerCheckPoints(playerid)
{
	DestroyDynamicRaceCP(PlayerCP[playerid][cp]);
}
