
stock SA_Veh_ToogleDoorLock(forplayer,vehicleid,bool:toggle)
{
	new
	iEngine, iLights, iAlarm,
	iDoors, iBonnet, iBoot,
	iObjective;
	GetVehicleParamsEx(vehicleid, iEngine, iLights, iAlarm, iDoors, iBonnet, iBoot, iObjective);
	
	if(toggle)
	{
		SetVehicleParamsForPlayer(vehicleid, forplayer, iObjective, true);
	}
	else
	{
		SetVehicleParamsForPlayer(vehicleid, forplayer, iObjective, false);
	}
}