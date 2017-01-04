#define b_size 800


stock Burglary_ReCreateMap()
{
	//House 1
	CreateObject(1763, 220.50211, 1240.08130, 1081.07678,   0.00000, 0.00000, 90.00000);
	CreateObject(1763, 223.04080, 1238.57605, 1081.07678,   0.00000, 0.00000, 180.00000);
	CreateObject(1823, 225.69470, 1241.07019, 1081.07556,   0.00000, 0.00000, 90.00000);
	CreateObject(1817, 222.94920, 1240.38574, 1081.11536,   0.00000, 0.00000, 90.00000);
	CreateObject(1821, 218.34261, 1239.04565, 1081.13611,   0.00000, 0.00000, 90.00000);
	CreateObject(1814, 222.54329, 1244.90369, 1081.07556,   0.00000, 0.00000, 0.00000);
	CreateObject(2267, 217.49672, 1243.75977, 1083.33813,   0.00000, 0.00000, 90.00000);
	CreateObject(1799, 224.16017, 1251.61609, 1081.03564,   0.00000, 0.00000, 180.00000);
	CreateObject(1742, 227.31995, 1253.72131, 1081.13611,   0.00000, 0.00000, 270.00000);
	CreateObject(1742, 220.88739, 1253.11365, 1081.13611,   0.00000, 0.00000, 90.00000);
	CreateObject(2313, 222.85747, 1253.91028, 1081.11609,   0.00000, 0.00000, 0.00000);
	CreateObject(2708, 226.94855, 1250.25574, 1081.13623,   0.00000, 0.00000, 270.00000);
	CreateObject(2394, 226.82269, 1249.35437, 1082.92114,   0.00000, 0.00000, 90.00000);
	CreateObject(1778, 218.10742, 1245.13867, 1081.13599,   0.00000, 0.00000, 0.00000);
	CreateObject(1642, 219.64140, 1243.78711, 1081.13550,   0.00000, 0.00000, 0.00000);
	CreateObject(2314, 221.42253, 1248.53064, 1081.13647,   0.00000, 0.00000, 90.00000);
	CreateObject(1763, 221.71381, 1242.66333, 1081.07678,   0.00000, 0.00000, 0.00000);
	CreateObject(14717, 222.82809, 1245.83594, 1082.87500,   0.00000, 0.00000, 0.00000);



}
/*
//移除SA本有的OBJ
stock RemoveSABurglaryObject(playerid)
{
	
	for(new i = 0; i < sizeof(BurlagryHourses); i++)
		RemoveSABurglaryHourseObject(playerid,BurlagryHourses[i][0],BurlagryHourses[i][1],BurlagryHourses[i][2]);
	printf("Remove SA Burglary Object.");
}
stock RemoveSABurglaryHourseObject(playerid,Float:b_x,Float:b_y,Float:b_z)
{
	for(new i = 0; i < sizeof(BurlagryItems); i++)
	{
		RemoveBuildingForPlayer(playerid,BurlagryItems[i],b_x,b_y,b_z,b_size);
		printf("[入室盗窃]: 移除SAOBJ: %d 在: %f %f %f",BurlagryItems[i],b_x,b_y,b_z);
	}
}
*/
