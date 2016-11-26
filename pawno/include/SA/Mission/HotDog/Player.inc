new bool:IsPlayerSellHotDog[MAX_PLAYERS];


stock HOTDOG_PLAYER_startSelling(playerid)
{
	IsPlayerSellHotDog[playerid] = true;
	SetPlayerMissionStatus(playerid,MISSION_HOTDOG,true);
}
stock HOTDOG_PLAYER_stopSelling(playerid)
{
	IsPlayerSellHotDog[playerid] = false;
	SetPlayerMissionStatus(playerid,MISSION_HOTDOG,false);
}

stock HOTDOG_PLAYER_getNearSeller(playerid)
{
	for (new i =0 ; i < MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && IsPlayerSellHotDog[i])
		{
			new Float:T_POS[3];
			GetPlayerPos(i,T_POS[0],T_POS[1],T_POS[2]);
			
			if (IsPlayerInRangeOfPoint(playerid, 7.0, T_POS[0],T_POS[1],T_POS[2])) 
			{
				return i;
			}
		}
	}
	return -1;
}

stock HOTDOG_PLAYER_isNeart(playerid)
{
	for (new i =0 ; i < MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && IsPlayerSellHotDog[i])
		{
			new Float:T_POS[3];
			GetPlayerPos(i,T_POS[0],T_POS[1],T_POS[2]);
			
			if (IsPlayerInRangeOfPoint(playerid, 7.0, T_POS[0],T_POS[1],T_POS[2])) 
			{
				return true;
			}
		}
	}
	return false;
}
stock HOTDOG_PLAYER_isSell(playerid)
{
	return IsPlayerSellHotDog[playerid] ? true : false;
}
stock HOTDOG_PLAYER_buy(playerid,sellerid)
{
	//玩家扣钱和加血...
	SetPlayerHealth(playerid,100);
	
	//卖家给钱
	GivePlayerMoney(sellerid,900);
	GameTextForPlayer(sellerid, "Payout:~w~$900", 2000, 6);
	//动作
	HOTDOG_ANIM_applyAnim(playerid);
	
}

stock HOTDOG_PLAYER_reset(playerid)
{
	IsPlayerSellHotDog[playerid] = false;
	HOTDOG_SetAllObjectiveOff(playerid);
	
}

