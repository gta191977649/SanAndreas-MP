//----------------------------------------------------------
//
//  SA WORLD 0.1 beta
//  A freeroam gamemode for SA-MP 
//
//----------------------------------------------------------

#include <a_samp>
#include <streamer>
#include <sscanf>

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
#include <SA/Mission/CarShop/Main>
#include <SA/Mission/PizzaBoy/Main>
#include <SA/Mission/Burglary/Main>


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
	ShowInfoBox(playerid,INFO_BoxBG,5,"Welcome To SanAndreas MultiPlayer CN!");
    SetPlayerSkin(playerid, 2);

	return 1;
}

//----------------------------------------------------------

  
