#define AMB_VEHICLE 416

stock AMB_IsVaildVehicle(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
    new vehid = GetVehicleModel(vehicleid);
	return vehid == AMB_VEHICLE ? true : false;
}