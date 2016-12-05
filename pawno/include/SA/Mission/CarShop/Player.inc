
enum CP_INFO
{
	Vehicleid,
	PlayerBar:Bar,
	VehType,
	bool:Finished
}
new CarShop_Player[MAX_PLAYERS][CP_INFO];

//开始任务...
stock CarShop_PlayerStart(playerid)
{
	//创建交通工具
	CarShop_VehicleCreate(playerid);
	//销毁红点
	CarShop_PlayerDestoryCP(playerid);
	//设置任务状态以及UI
	CarShop_SetPlayerMissionStatus(playerid,true);
	CarShop_PlayerSetFininsh(playerid,false);
	//Objective
	SetTimerEx("CarShopCreateVehObjecitve",3000, false, "i", playerid);
}
forward CarShopCreateVehObjecitve(playerid);
public CarShopCreateVehObjecitve(playerid)
{
	SetPlayerObjective(playerid,CarShop_PlayerVehGet(playerid),true);
}
CarShop_PlayerFaild(playerid)
{
	CarShop_SetPlayerMissionStatus(playerid,false);
	//GameTextForPlayer(playerid, "~r~mission faild!", 5000, 0);
}
stock CarShop_SetPlayerProg(playerid,Float:value)
{
	SetPlayerProgressBarValue(playerid, CarShop_Player[playerid][Bar], value);
}
stock Float:CarShop_GetPlayerProg(playerid)
{
	return GetPlayerProgressBarValue(playerid,CarShop_Player[playerid][Bar]);
}

//功能函数...
stock CarShop_PlayerCreateCP(playerid)
{
	TogglePlayerDynamicCP(playerid,CarShopCP[0],true);
	TogglePlayerDynamicCP(playerid,CarShopCP[1],false);
	//printf("CarShop_PlayerCreateCP called ");
}
stock CarShop_PlayerSetCPBack(playerid)
{
	TogglePlayerDynamicCP(playerid,CarShopCP[0],false);
	TogglePlayerDynamicCP(playerid,CarShopCP[1],true);
	//显示小地图
	//CreateDynamicMapIcon(Float:x, Float:y, Float:z)
	//printf("CarShop_PlayerCreateCP called ");
}

stock CarShop_PlayerDestoryCP(playerid)
{
	TogglePlayerDynamicCP(playerid,CarShopCP[0],false);
	TogglePlayerDynamicCP(playerid,CarShopCP[1],false);
}

stock CarShop_PlayerCreateUI(playerid)
{
	CarShop_Player[playerid][Bar] = CreatePlayerProgressBar(playerid, 540.0, 245.0, 60, 3.5, C_SABLUE, 100.0, BAR_DIRECTION_RIGHT);
	SG_RightSub(playerid,"SALES:",true);
	//设置BAR值
	SetPlayerProgressBarValue(playerid, CarShop_Player[playerid][Bar], 0.0);
	//显示UI
	ShowPlayerProgressBar(playerid, CarShop_Player[playerid][Bar]);
}
stock CarShop_PlayerDestoryUI(playerid)
{
	DestroyPlayerProgressBar(playerid,CarShop_Player[playerid][Bar]);
	SG_RightSub(playerid," ",false);
}

stock CarShop_PlayerSetVehType(playerid,type)
{
	CarShop_Player[playerid][VehType] = type;
}

stock CarShop_PlayerGetVehType(playerid)
{
	return CarShop_Player[playerid][VehType];
}
stock CarShop_PlayerSetFininsh(playerid,bool:toogle)
{
	CarShop_Player[playerid][Finished] = toogle;
}
stock CarShop_PlayerIsFinished(playerid)
{
	return CarShop_Player[playerid][Finished];
}

stock CarShop_PlayerVehCreate(playerid,modelid,Float:VX,Float:VY,Float:VZ,Float:VA)
{
	CarShop_Player[playerid][Vehicleid] = CreateVehicle(modelid, VX, VY, VZ, VA, -1, -1, -1);
	//丢进垃圾回收系统
	CARSHOP_REC_ADD(CarShop_Player[playerid][Vehicleid]);
	//printf("Debug %d,%f,%f,%f,%f",modelid,Float:VX,Float:VY,Float:VZ,Float:VA);
}
stock CarShop_PlayerVehDesotry(playerid)
{
	//DestroyVehicle(CarShop_Player[playerid][Vehicleid]);
	//让玩家下车(如果玩家在车上的话)
    if(IsPlayerInAnyVehicle(playerid) && CarShop_VehicleIsVaild(playerid)) RemovePlayerFromVehicle(playerid);
	//锁车门
	SA_Veh_ToogleDoorLock(playerid,CarShop_Player[playerid][Vehicleid],true);
	//执行垃圾回收
	CARSHOP_REC_FREE(CarShop_Player[playerid][Vehicleid]);

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
		SetPlayerMissionStatus(playerid,MISSION_CARSHOP,false);
		CarShop_PLAYER_reset(playerid);
	}
}

stock CarShop_PLAYER_reset(playerid)
{
	SetPlayerObjective(playerid,CarShop_PlayerVehGet(playerid),false);	
	CarShop_PlayerDestoryUI(playerid);
	CarShop_PlayerVehDesotry(playerid);
	CarShop_PlayerCreateCP(playerid);
	CarShop_Player[playerid][Vehicleid] = INVALID_VEHICLE_ID;
}

stock CarShop_IsPlayerInMission(playerid)
{
	if(GetPlayerMissionID(playerid) == MISSION_CARSHOP && IsPlayerInMission(playerid)) return true;
	else return false;
}