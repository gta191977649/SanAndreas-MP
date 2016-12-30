#define BURGLARY_VEH 498

stock BurglaryIsVaildVeh(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
    new vehid = GetVehicleModel(vehicleid);
	return vehid == BURGLARY_VEH ? true : false;
}

//玩家是否在车后面(卸货用)
stock BurglaryIsVaildLoadPos(playerid)
{
	new Float:loadPos[3],Float:playerPos[3];
	new vehicleid = Burglary_GetVehicle(Burglary_PlayerRoomGet(playerid));
	GetXYZInBackOfVehicle(vehicleid,loadPos[0],loadPos[1],loadPos[2],2.0);
	GetPlayerPos(playerid,playerPos[0],playerPos[1],playerPos[2]);
	if(IsPointInRangeOfPoint(loadPos[0],loadPos[1],loadPos[2], playerPos[0],playerPos[1],playerPos[2],2.0))
	{
		return true;
	}
	return false;
}