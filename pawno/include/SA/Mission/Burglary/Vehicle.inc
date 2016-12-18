#define BURGLARY_VEH 498

stock BurglaryIsVaildVeh(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
    new vehid = GetVehicleModel(vehicleid);
	return vehid == BURGLARY_VEH ? true : false;
}