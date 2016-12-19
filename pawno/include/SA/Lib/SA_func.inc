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
stock IsPointInRangeOfPoint(Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2, Float:range)
{
	x2 -= x;
	y2 -= y;
	z2 -= z;
	return ((x2 * x2) + (y2 * y2) + (z2 * z2)) < (range * range);
}

SetPlayerPosFront(playerid,Float:x, Float:y,Float:z,Float:Angle,Float:distance)
{
	x += (distance * floatsin(-Angle, degrees));
	y += (distance * floatcos(-Angle, degrees));
	SetPlayerPos(playerid,x,y,z);
}

PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid, animlib, "null", 0.0, 0, 0, 0, 0, 0);
}