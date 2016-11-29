/*
	SA WORLD
	常用函数库
	By Episodes

*/
stock GetVehicleSpeed(vehicleid)
{
	new Float:Vx, Float:Vy, Float:Vz;
	GetVehicleVelocity(vehicleid, Vx, Vy, Vz);
    new Float:rtn;
    rtn = floatsqroot(floatpower(Vx*100,2) + floatpower(Vy*100,2));
    rtn = floatsqroot(floatpower(rtn,2) + floatpower(Vz*100,2));
    return floatround(rtn);
}