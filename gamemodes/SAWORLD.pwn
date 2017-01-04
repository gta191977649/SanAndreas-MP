//----------------------------------------------------------
//
//  SA WORLD 0.1 beta
//  A freeroam gamemode for SA-MP 
//	Developer: Liberty_Episodes
//	QQ: 191977649
//	(C) JavaSparrow Project 2010 - 2017
//
//----------------------------------------------------------

#include <a_samp>
#include <streamer>
#include <sscanf>
#include <zcmd>

//System
#include <SA/System/SA_Zone>
//UI

#include <SA/UI/UI_Color>
#include <SA/UI/UI_Sound>
#include <SA/UI/InfoBox>
#include <SA/UI/UI_Subtitle>
#include <SA/UI/UI_Progress>

//Libs
#include <SA/Lib/SA_Func>
//Core

#include <SA/SA_Main>
#include <SA/SA_MapIcons>
#include <SA/SA_MapIcons>
#include <SA/SA_Spawn>
#include <SA/SA_GlCommon>
//Libs
#include <SA/Lib/SA_Vehs>
//任务库
#include <SA/Mission/PlayerObjective>
#include <SA/Mission/PlayerObjectiveMain>
//物理库
#define COLANDREAS
#include <physics>

#include <SA/Mission/MissionConfig>
#include <SA/Mission/PlayerMission>
//任务列表
#include <SA/Mission/HotDog/Main>
#include <SA/Mission/IceCream/Main>
#include <SA/Mission/Paramedic/Main>

#include <SA/Mission/PizzaBoy/Main>
#include <SA/Mission/Burglary/Main>
#include <SA/Mission/CarShop/Main>



//----------------------------------------------------------

//----------------------------------------------------------

main()                                            
{
	print("\n---------------------------------------");
	print(" SA WORLD Main Frame Work\n");
	print(" By Liberty_Episodes\n");
	print("---------------------------------------\n");
}

//----------------------------------------------------------

public OnPlayerConnect(playerid)
{
  	//SendClientMessage(playerid,-1,"Welcome to {88AA88}G{FFFFFF}rand {88AA88}L{FFFFFF}arceny");
  	
 	return 1;
}

//----------------------------------------------------------

public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	ShowInfoBox(playerid,INFO_BoxBG,5,"欢迎来到圣安地列斯!");
    SetPlayerSkin(playerid, 2);

	return 1;
}

//----------------------------------------------------------
//Debug
CMD:cpdebug(playerid,params[])
{
	new Float:getPos[3];
	GetXYZInBackOfVehicle(GetPlayerVehicleID(playerid),getPos[0],getPos[1],getPos[2],5);
	//debug
	//CreateDynamicCP(getPos[0],getPos[1],getPos[2],5, -1,-1, -1,STREAMER_CP_SD);
	CreateObject(19607,getPos[0],getPos[1],getPos[2],0.0, 0.0, 0.0);
	
	printf("[Fomula] %f,%f,%f",getPos[0],getPos[1],getPos[2]);
	GetPlayerPos(playerid,getPos[0],getPos[1],getPos[2]);
	printf("[PLAYER] %f,%f,%f",getPos[0],getPos[1],getPos[2]);
	ShowInfoBox(playerid,INFO_BoxBG,5,"Debug Has excecuted.");
	return 1;
}
  
  
  
