enum Player_CP
{
	Float:cp_x,
	Float:cp_y,
	Float:cp_z,
	cp,
	shopcp
}

new PlayerCP[MAX_PLAYERS][Player_CP];


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
	ShowMissionFailed(playerid);
	PIZZA_SetPlayerMissionStatus(playerid,false);
}
stock PIZZA_PLAYER_CreateUI(playerid)
{
	SG_Sub(playerid,PIZZA_OBJTIVE,5);
	SG_Textbox(playerid,PIZZA_TUT,5);
	new tem[125];
	format(tem,sizeof(tem),PIZZA_INFO,PIZZA_GetRemain(playerid));
	SG_RightSub(playerid,tem,true);
}
stock PIZZA_PLAYER_UIUpdate(playerid)
{
	new tem[125],amount = PIZZA_GetRemain(playerid);
	format(tem,sizeof(tem),PIZZA_INFO,amount);
	SG_RightSub(playerid,tem,true);
	if(amount == 0) PIZZA_CreatePizzaShopCP(playerid);//没Pizza提示回去拿
}
stock PIZZA_PLAYER_DestoryUI(playerid)
{

	SG_RightSub(playerid," ",false);
}



stock PIZZA_PLAYER_reset(playerid)
{
	PIZZA_DestoryPizzaShopCP(playerid);
	PIZZA_DestoryPlayerCheckPoints(playerid);
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
	//PlayerCP[playerid][shopcp] = CreateDynamicCP(pizzaShop_LS[0][0],pizzaShop_LS[0][1],pizzaShop_LS[0][2],3,-1,-1,-1,-1);
	//判断玩家在哪个城市
	new CITY = PIZZA_GetNearCity(playerid);
	switch(CITY)
	{
		case CITY_LS: PlayerCP[playerid][shopcp] = CreateDynamicCP(pizzaShop_LS[0][0],pizzaShop_LS[0][1],pizzaShop_LS[0][2],3,-1,-1,-1,-1);
		case CITY_LV: PlayerCP[playerid][shopcp] = CreateDynamicCP(pizzaShop_LV[0][0],pizzaShop_LV[0][1],pizzaShop_LV[0][2],3,-1,-1,-1,-1);
		case CITY_SF: PlayerCP[playerid][shopcp] = CreateDynamicCP(pizzaShop_SF[0][0],pizzaShop_SF[0][1],pizzaShop_SF[0][2],3,-1,-1,-1,-1);
	}
	
}
stock PIZZA_DestoryPizzaShopCP(playerid)
{
	if(IsValidDynamicCP(PlayerCP[playerid][shopcp])) DestroyDynamicCP(PlayerCP[playerid][shopcp]);
}

stock PIZZA_CreatePlayerCheckPoints(playerid)
{
	PIZZA_DestoryPizzaShopCP(playerid);
	#define CONS (0.5)
	
	
	//判断玩家在哪个城市
	new CITY = PIZZA_GetNearCity(playerid);
	if(CITY != -1)
	{
		new Float:cp_pos[4];
		PIZZA_GetRandomPostLocation(CITY,cp_pos[0],cp_pos[1],cp_pos[2],cp_pos[3]);
			
		PlayerCP[playerid][cp_x] = cp_pos[0];
		PlayerCP[playerid][cp_y] = cp_pos[1];
		PlayerCP[playerid][cp_z] = cp_pos[2];
		
		//创建CP
		PlayerCP[playerid][cp] = CreateDynamicRaceCP(4,
		PlayerCP[playerid][cp_x],
		PlayerCP[playerid][cp_y],
		PlayerCP[playerid][cp_z],
		PlayerCP[playerid][cp_x]+ CONS * floatsin(cp_pos[3], degrees),
		PlayerCP[playerid][cp_y] + CONS *  floatcos(cp_pos[3], degrees),
		PlayerCP[playerid][cp_z],2,-1,-1,playerid,-1);
	}

	

}

stock PIZZA_DestoryPlayerCheckPoints(playerid)
{
	if(IsValidDynamicCP(PlayerCP[playerid][cp])) DestroyDynamicRaceCP(PlayerCP[playerid][cp]);
}
