/*
	交通工具类
	CarShop支线任务
	By Episodes
	

	车辆种类
	VEHICLE_FAST,
	VEHICLE_SLOW
*/

#define VEHICLE_FAST 0 
#define VEHICLE_SLOW 1

//速度
#define VMIN_FAST 50
#define VMAX_SLOW 30
#define VMIN_SLOW 10

new VehicleIDs[][] = 
{
	{411,VEHICLE_FAST},
	{506,VEHICLE_FAST},
	{533,VEHICLE_FAST},
	{535,VEHICLE_FAST},
	{541,VEHICLE_FAST},
	{500,VEHICLE_SLOW},
	{517,VEHICLE_SLOW},
	{526,VEHICLE_SLOW},
	{527,VEHICLE_SLOW},
	{542,VEHICLE_SLOW}
	
};

new Float:VehicleSpawn[][] = 
{
	{-1958.8414, 259.7624, 35.6943,90.0}
};

stock CarShop_VehicleCreate(playerid)
{
	//随机选择种类
	new idx = random(sizeof(VehicleIDs));
	CarShop_PlayerSetVehType(playerid,VehicleIDs[idx][1]);
	
	CarShop_PlayerVehCreate(playerid,VehicleIDs[idx][0],VehicleSpawn[0][0],VehicleSpawn[0][1],VehicleSpawn[0][2],VehicleSpawn[0][3]);
	//CarShop_PlayerVehCreate(playerid,VehicleIDs[idx][0],-1958.8414, 259.7624, 35.6943,90.0);
}

stock CarShop_VehicleIsVaild(playerid)
{
	new vehicle = GetPlayerVehicleID(playerid);
	return vehicle == CarShop_PlayerVehGet(playerid);
	
}