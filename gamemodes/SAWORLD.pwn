//----------------------------------------------------------
//
//  SA WORLD 0.1 beta
//  A freeroam gamemode for SA-MP 
//
//----------------------------------------------------------

#include <a_samp>
#include <SAWORLD/SA_Main>
#include <SAWORLD/SA_MapIcons>
#include <SAWORLD/SA_MapIcons>
#include <SAWORLD/SA_Spawn>
#include <SAWORLD/SA_GlCommon>

//UI
#include <SAWORLD/UI/InfoBox>
#include <SAWORLD/UI/UI_Color>

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
	ShowInfoBox(playerid,INFO_BoxBG,10,"Welcome To SanAndreas MultiPlayer!");
    

	return 1;
}

//----------------------------------------------------------

  
