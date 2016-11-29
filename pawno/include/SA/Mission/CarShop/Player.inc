#define CP_X -1970.7388
#define CP_Y  297.4897
#define CP_Z  34.7497
#define CP_SIZE  5.0
enum CP_INFO
{
	Vehicleid,
	CP,
	PlayerBar:Bar,
	VehType
}
new CarShop_Player[MAX_PLAYERS][CP_INFO];

//开始任务...
stock CarShop_PlayerStart(playerid)
{
	//销毁红点
	CarShop_PlayerDestoryCP(playerid);
	//设置任务状态以及UI
	CarShop_SetPlayerMissionStatus(playerid,true);
	CarShop_PlayerCreateUI(playerid);
	//创建交通工具
	CarShop_VehicleCreate(playerid);
	//设置Objctive
	SetPlayerObjective(playerid,CarShop_Player[playerid][Vehicleid],true);
	
}
CarShop_PlayerFaild(playerid)
{
	CarShop_SetPlayerMissionStatus(playerid,false);

}

//功能函数...
stock CarShop_PlayerCreateCP(playerid)
{
	CarShop_Player[playerid][CP] = CreateDynamicCP(CP_X,CP_Y,CP_Z,CP_SIZE,-1,-1,-1,100.0);
}
stock CarShop_PlayerDestoryCP(playerid)
{
	DestroyDynamicCP(CarShop_Player[playerid][CP]);
}

stock CarShop_PlayerCreateUI(playerid)
{
	CarShop_Player[playerid][Bar] = CreatePlayerProgressBar(playerid, 320.0, 200.0, 50.0, 10.0, 0xcfcaf1FF, 10.0, BAR_DIRECTION_RIGHT);
	
	//设置BAR值
	SetPlayerProgressBarValue(playerid, CarShop_Player[playerid][Bar], 20.0);
	//显示UI
	ShowPlayerProgressBar(playerid, CarShop_Player[playerid][Bar]);
}
stock CarShop_PlayerDestoryUI(playerid)
{
	DestroyPlayerProgressBar(playerid,CarShop_Player[playerid][Bar]);
}

stock CarShop_PlayerSetVehType(playerid,type)
{
	CarShop_Player[playerid][VehType] = type;
}

stock CarShop_PlayerGetVehType(playerid)
{
	return CarShop_Player[playerid][VehType];
}


stock CarShop_PlayerVehCreate(playerid,modelid,Float:VX,Float:VY,Float:VZ,Float:VA)
{
	CarShop_Player[playerid][Vehicleid] = CreateVehicle(modelid, VX, VY, VZ, VA, -1, -1, -1);
	printf("Debug %d,%f,%f,%f,%f",modelid,Float:VX,Float:VY,Float:VZ,Float:VA);
}
stock CarShop_PlayerVehDesotry(playerid)
{
	DestroyVehicle(CarShop_Player[playerid][Vehicleid]);
}
stock CarShop_PlayerVehGet(playerid)
{
	return CarShop_Player[playerid][Vehicleid];
}

stock CarShop_SetPlayerMissionStatus(playerid,bool:toogle)
{
	if(toogle)
	{
		SetPlayerMissionStatus(playerid,MISSION_CARSHOP,true);
	}
	else
	{
		CarShop_PLAYER_reset(playerid);
	}
}

stock CarShop_PLAYER_reset(playerid)
{
	CarShop_PlayerDestoryUI(playerid);
	CarShop_PlayerVehDesotry(playerid);
	CarShop_PlayerCreateCP(playerid);
}

stock CarShop_IsPlayerInMission(playerid)
{
	if(GetPlayerMissionID(playerid) == MISSION_CARSHOP && IsPlayerInMission(playerid)) return true;
	else return false;
}