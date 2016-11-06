//Bench

#define offsetX (0.0329)
#define offsetY (-0.8471)
#define offsetZ (0.9844)
stock Float:GYM_BENCH_POS[][] =
{
	{ 773.0491,1.4285,1000.7209, 270.00 }, // Los Santos Gym's bench.
	{ 766.3170,-47.3574,1000.5859, 180.00 }, // San Fierro Gym's bench.
	{ 764.9001,-60.5580,1000.6563, 1.9500 },// Las Venturas Gym's bench
	{ 653.9644, -1864.9324, 5.4277,0.0 } // Los Santos beach
};
stock Float:GYM_BENCH_OBJ[][] =
{
	{ 774.42907715,1.88309872,1000.48834229,0.00000000,270.00000000,87.99966431 }, // Los Santos Gym's BarBell
	{ 765.85528564,-48.86857224,1000.64093018,0.00000000,89.49993896,0.00000000 }, // San Fierro Gym's BarBell.
	{ 765.34039307,-59.18271637,1000.63793945,0.00000000,89.49993896,181.25012207 }, // Las Venturas Gym's BarBell
	{ 653.4888, -1863.5402, 5.4212,0.0000, 90.0000, 0.0000} // Los Santos beach
};
new GYM_BENCH_OBJS[sizeof(GYM_BENCH_OBJ)];

new GYM_BENCH_used[sizeof(GYM_BENCH_OBJ)];


stock GYM_BENCH_isAvaiable(machineid)
{
	return GYM_BIKE_used[machineid] ? false : true;
}
stock GYM_BENCH_setAvaiable(machineid,bool:ava)
{
	if(ava) GYM_BENCH_used[machineid]= false;
	else GYM_BENCH_used[machineid] = true;
}


stock GYM_BENCH_init()
{
	for(new i =0; i < sizeof(GYM_BENCH_OBJ);i++)
	{
		GYM_BENCH_RESTOREOBJ(i);
		//GYM_BENCH_OBJS[i]=CreateObject( 2913, GYM_BENCH_OBJ[i][0], GYM_BENCH_OBJ[i][1], GYM_BENCH_OBJ[i][2], GYM_BENCH_OBJ[i][3], GYM_BENCH_OBJ[i][4], GYM_BENCH_OBJ[i][5] );
	}
}
stock GYM_BENCH_HIDEOBJ(machineid)
{
	DestroyDynamicObject(GYM_BENCH_OBJS[machineid]);
}

stock GYM_BENCH_RESTOREOBJ(machineid)
{
	GYM_BENCH_OBJS[machineid] = CreateDynamicObject( 2913, GYM_BENCH_OBJ[machineid][0], GYM_BENCH_OBJ[machineid][1], GYM_BENCH_OBJ[machineid][2], GYM_BENCH_OBJ[machineid][3], GYM_BENCH_OBJ[machineid][4], GYM_BENCH_OBJ[machineid][5] );
}
stock GYM_BENCH_makeNoise(playerid,machineid,toggle)
{
	
	if(toggle) PlayerPlaySound(playerid, 17807, GYM_BENCH_POS[machineid][0], GYM_BENCH_POS[machineid][1], GYM_BENCH_POS[machineid][2]);
	else PlayerPlaySound(playerid, 17803 , 0.0, 0.0, 0.0);
}

stock GYM_BENCH_near(playerid)
{
	for( new o; o != sizeof GYM_BENCH_POS; o ++ )
	{
		if(IsPlayerInRangeOfPoint(playerid,2.0,GYM_BENCH_POS[o][0], GYM_BENCH_POS[o][1], GYM_BENCH_POS[o][2]))
		{
			return true;
		}
	}
	return false;
}

stock GYM_BENCH_getNearMachineID(playerid)
{
	for( new o; o != sizeof GYM_BENCH_POS; o ++ )
	{
		if( IsPlayerInRangeOfPoint(playerid,2.0,GYM_BENCH_POS[o][0], GYM_BENCH_POS[o][1], GYM_BENCH_POS[o][2]))
		{
			return o;
		}
	}
	return -1;
}