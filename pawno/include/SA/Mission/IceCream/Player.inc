new bool:IsPlayerSellIceCream[MAX_PLAYERS];

stock IceCream_PLAYER_startSelling(playerid)
{
	IsPlayerSellIceCream[playerid] = true;
	SetPlayerMissionStatus(playerid,MISSION_ICECREAM,true);
}
stock IceCream_PLAYER_stopSelling(playerid)
{
	IsPlayerSellIceCream[playerid] = false;
	SetPlayerMissionStatus(playerid,MISSION_ICECREAM,false);
}

stock IceCream_PLAYER_getNearSeller(playerid)
{
	for (new i =0 ; i < MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && IsPlayerSellIceCream[i])
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

stock IceCream_PLAYER_isNeart(playerid)
{
	for (new i =0 ; i < MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && IsPlayerSellIceCream[i])
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
stock IceCream_PLAYER_isSell(playerid)
{
	return IsPlayerSellIceCream[playerid] ? true : false;
}
stock IceCream_PLAYER_buy(playerid,sellerid)
{
	//玩家扣钱和加血...
	SetPlayerHealth(playerid,100);
	
	//卖家给钱
	GivePlayerMoney(sellerid,900);
	GameTextForPlayer(sellerid, "Payout:~w~$900", 2000, 6);
	//动作
	IceCream_ANIM_applyAnim(playerid);
	
}

stock IceCream_PLAYER_reset(playerid)
{
	IsPlayerSellIceCream[playerid] = false;
	IceCream_SetAllObjectiveOff(playerid);
}