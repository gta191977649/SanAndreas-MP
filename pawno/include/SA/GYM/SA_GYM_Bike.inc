/*
	GYM Running Machine Class
	Dev: Episodes
	(C) 2016 JavaSparrow Project
	QQ: 191977649
*/

stock Float:GYM_BIKE_POS[][] =
{
	{772.172,9.41406,1000.0,90.0}, // Los Santos Gym's Bake
	{769.242,-47.8984,1000.0,90.0}, // San Fierro Gym's Bake
	{774.625,-68.6406,1000.0,90.0}, // Las Venturas Gym's Bake
	{659.273,-1864.2,4.44531,0.0} // Los Santos Gym's Bake 海滩
};

new bool:GYM_BIKE_used[sizeof(GYM_BIKE_POS)] = { false, ... };


stock GYM_BIKE_isAvaiable(machineid)
{
	return GYM_BIKE_used[machineid] ? false : true;
}

stock GYM_BIKE_setAvaiable(machineid,bool:ava)
{
	if(ava) GYM_BIKE_used[machineid]= false;
	else GYM_BIKE_used[machineid] = true;
}
stock GYM_BIKE_makeNoise(playerid,machineid,toggle)
{
	
	if(toggle) PlayerPlaySound(playerid, 17800, GYM_BIKE_POS[machineid][0], GYM_BIKE_POS[machineid][1], GYM_BIKE_POS[machineid][2]);
	else PlayerPlaySound(playerid, 17803 , 0.0, 0.0, 0.0);
}


stock GYM_BIKE_near(playerid)
{
	for( new o; o != sizeof GYM_BIKE_POS; o ++ )
	{
		if(IsPlayerInRangeOfPoint(playerid,2.0,GYM_BIKE_POS[o][0], GYM_BIKE_POS[o][1], GYM_BIKE_POS[o][2]))
		{
			return true;
		}
	}
	return false;
}

stock GYM_BIKE_getNearMachineID(playerid)
{
	for( new o; o != sizeof GYM_BIKE_POS; o ++ )
	{
		if( IsPlayerInRangeOfPoint(playerid,2.0,GYM_BIKE_POS[o][0], GYM_BIKE_POS[o][1], GYM_BIKE_POS[o][2]))
		{
			return o;
		}
	}
	return -1;
}