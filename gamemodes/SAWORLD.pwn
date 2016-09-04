//----------------------------------------------------------
//
//  SA WORLD 0.1 beta
//  A freeroam gamemode for SA-MP 
//
//----------------------------------------------------------

#include <a_samp>
#include <SAWORLD/SA_Main>
#include <SAWORLD/SA_MapIcons>

//UI类
#include <SAWORLD/UI/InfoBox>


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
	GameTextForPlayer(playerid,"~w~Grand Larceny",3000,4);
	ShowInfoBox(playerid,0xFFFFFF,10,"Welcome To SanAndreas MultiPlayer!");
  	SendClientMessage(playerid,-1,"Welcome to {88AA88}G{FFFFFF}rand {88AA88}L{FFFFFF}arceny");
  	
 	return 1;
}

//----------------------------------------------------------

public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	
    

	return 1;
}

//----------------------------------------------------------

  