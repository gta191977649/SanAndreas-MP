/*
	冰淇淋车辆类
*/

#define VEH_ICECREAM 423

stock IsVaildIceCreamVehicle(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
    new vehid = GetVehicleModel(vehicleid);
	return vehid == VEH_ICECREAM ? true : false;
}