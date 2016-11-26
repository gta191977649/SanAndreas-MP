/*
	热狗车辆类
*/

#define VEH_HOTDOG 588

stock IsVaildHotDogVehicle(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
    new vehid = GetVehicleModel(vehicleid);
	return vehid == VEH_HOTDOG ? true : false;
}