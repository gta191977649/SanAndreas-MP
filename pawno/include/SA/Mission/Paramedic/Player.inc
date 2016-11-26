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
	}
}
stock AMB_IsPlayerInMission(playerid)
{
	if(GetPlayerMissionID(playerid) == MISSION_PARAMEDIT && IsPlayerInMission(playerid)) return true;
	else return false;
}