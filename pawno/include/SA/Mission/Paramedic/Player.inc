/*
	救护车任务
	玩家类
	By Episodes
*/

enum AMB_INFO
{
	Vehicleid,
}

new PlayerParamedic[MAX_PLAYERS][AMB_INFO];

stock AMB_SetVehicleID(playerid,vehicleid)
{
	PlayerParamedic[playerid][Vehicleid] = vehicleid;
}
stock AMB_GetPlayerVehicleID(playerid)
{
	return PlayerParamedic[playerid][Vehicleid];
}
stock AMB_SetPlayerMissionStatus(playerid,bool:toogle)
{
	if(toogle)
	{
		SetPlayerMissionStatus(playerid,MISSION_PARAMEDIT,true);
	}
	else
	{
		SetPlayerMissionStatus(playerid,MISSION_PARAMEDIT,false);
		ResetMapIndicator(playerid);
	}
}
stock AMB_IsPlayerInMission(playerid)
{
	if(GetPlayerMissionID(playerid) == MISSION_PARAMEDIT && IsPlayerInMission(playerid)) return true;
	else return false;
}
stock AMB_GetNearstPatient(playerid)
{
	for(new i = 0; i < MAX_PLAYERS; i ++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			new Float:health;
			GetPlayerHealth(i,health);
			if (health < 100)
			{
				new Float:T_POS[3];
				GetPlayerPos(i,T_POS[0],T_POS[1],T_POS[2]);
			
				if (IsPlayerInRangeOfPoint(playerid, 5.0, T_POS[0],T_POS[1],T_POS[2])) 
				{
					return i;
				}
			}
		}
	}
	return -1;
}

stock AMB_TreatPlayer(playerid,treaterid)
{
	SetPlayerHealth(treaterid,100.0);
	AMB_ApplyAnimation(playerid);
	GivePlayerMoney(playerid,900);
	GameTextForPlayer(playerid, "Payout:~w~$900", 2000, 6);
}
stock UpdateMapIndicator(playerid)
{
	for(new i = 0; i < MAX_PLAYERS; i ++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			new Float:health;
			GetPlayerHealth(i,health);
			if (health < 100)
			{
				SetPlayerMarkerForPlayer( playerid, i, C_RED );
			}
			else
			{
				SetPlayerMarkerForPlayer( playerid, i, GetPlayerColor(i) );
			}
		}
	}
}
stock ResetMapIndicator(playerid)
{
	for(new i = 0; i < MAX_PLAYERS; i ++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			SetPlayerMarkerForPlayer(playerid,i,GetPlayerColor(i));
		}
	}
}
