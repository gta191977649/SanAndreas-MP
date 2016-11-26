/*
	Objective 标记系统
	By:Episodes
*/
enum Objective_Info {
	ObjectiveVehicle,
	bool:Objective,
	
}

new PlayerObjective[MAX_PLAYERS][Objective_Info];

stock SetPlayerObjective(playerid,vehicleid,bool:toggle)
{
	new
	iEngine, iLights, iAlarm,
	iDoors, iBonnet, iBoot,
	iObjective;
	GetVehicleParamsEx(vehicleid, iEngine, iLights, iAlarm, iDoors, iBonnet, iBoot, iObjective);
	
	if(toggle)
	{
		
		SetVehicleParamsForPlayer(vehicleid, playerid, 1, iDoors);
		PlayerObjective[playerid][Objective] = true;
		PlayerObjective[playerid][ObjectiveVehicle] = vehicleid;
	}
	else
	{
		
		SetVehicleParamsEx(vehicleid, iEngine, iLights, iAlarm, iDoors, iBonnet, iBoot, 0);
		ResetPlayerObjecitve(playerid);
		//Trick部分修复其他玩家标记显示
		UpdatePlayerObjective(playerid);
	}
}


stock UpdatePlayerObjective(playerid)
{
	for(new i = 0 ; i < MAX_PLAYERS ; i ++)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerObjective(i)) SetPlayerObjective(i,PlayerObjective[playerid][ObjectiveVehicle],true);
		}
	}
}


stock IsPlayerObjective(playerid)
{
	return (PlayerObjective[playerid][Objective]);
}

stock ResetPlayerObjecitve(playerid)
{
	PlayerObjective[playerid][Objective] = false;
	PlayerObjective[playerid][ObjectiveVehicle] = INVALID_VEHICLE_ID;
}

stock GetPlayerObjectiveVehicle(playerid)
{
	return PlayerObjective[playerid][ObjectiveVehicle];
}