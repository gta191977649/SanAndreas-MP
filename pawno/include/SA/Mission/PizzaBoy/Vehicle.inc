

#define PIZZA_VEH 448

stock PIZZA_IsInVaildVeh(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(vehicleid) == PIZZA_VEH) return true;
	else return false;
}
