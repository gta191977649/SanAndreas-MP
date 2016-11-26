//For more info on ALS Hooking check
//http://forum.sa-mp.com/showthread.php?t=85907

static gNPC_HasCB[3];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//your OnGameModeInit pre code here
	
	ConnectNPC("TrainDriverLV","train_lv");
	ConnectNPC("TrainDriverLS","train_ls");
	ConnectNPC("TrainDriverSF","train_sf");
	ConnectNPC("PilotLV","at400_lv");
	ConnectNPC("PilotSF","at400_sf");
	ConnectNPC("PilotLS","at400_ls");
	
	print("[模块]:世界NPC已经加载");
	// Testing
	//ConnectNPC("OnfootTest","onfoot_test");
	//ConnectNPC("DriverTest","mat_test2");
	//ConnectNPC("DriverTest2","driver_test2");
	//function hook checks

	gNPC_HasCB[0] = funcidx("NPC_OnPlayerConnect") != -1;
	gNPC_HasCB[1] = funcidx("NPC_OnPlayerRequestClass") != -1;
	gNPC_HasCB[2] = funcidx("NPC_OnPlayerSpawn") != -1;
	if (funcidx("NPC_OnGameModeInit") != -1)
	{
		return CallLocalFunction("NPC_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit NPC_OnGameModeInit
forward NPC_OnGameModeInit();



//--------------OnPlayerConnect Hook-------------------

public OnPlayerConnect(playerid)
{
	//your OnPlayerConnect code here
	if(IsPlayerNPC(playerid)) {
	    new ip_addr_npc[64+1];
	    new ip_addr_server[64+1];
	    GetServerVarAsString("bind",ip_addr_server,64);
	    GetPlayerIp(playerid,ip_addr_npc,64);
	    
		if(!strlen(ip_addr_server)) {
		    ip_addr_server = "127.0.0.1";
		}
		
		if(strcmp(ip_addr_npc,ip_addr_server,true) != 0) {
		    // this bot is remote connecting
		    printf("NPC: Got a remote NPC connecting from %s and I'm kicking it.",ip_addr_npc);
		    Kick(playerid);
		    return 0;
		}
        printf("NPC: Connection from %s is allowed.",ip_addr_npc);
	}
	
	if (gNPC_HasCB[0])
	{
		return CallLocalFunction("NPC_OnPlayerConnect", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect NPC_OnPlayerConnect
forward NPC_OnPlayerConnect(playerid);



//--------------OnPlayerRequestClass Hook-------------------

public OnPlayerRequestClass(playerid,  classid)
{
	//your OnPlayerRequestClass code here
	// We only deal with NPC players in this script
	if(IsPlayerNPC(playerid)) 
	{
		new playername[64];
		GetPlayerName(playerid,playername,64);

		if(!strcmp(playername,"TrainDriverLV",true)) {
			SetSpawnInfo(playerid,69,255,1462.0745,2630.8787,10.8203,0.0,-1,-1,-1,-1,-1,-1);
		}
		else if(!strcmp(playername,"TrainDriverSF",true)) {
			SetSpawnInfo(playerid,69,255,-1942.7950,168.4164,27.0006,0.0,-1,-1,-1,-1,-1,-1);
		}
		else if(!strcmp(playername,"TrainDriverLS",true)) {
			SetSpawnInfo(playerid,69,255,1700.7551,-1953.6531,14.8756,0.0,-1,-1,-1,-1,-1,-1);
		}
		else if(!strcmp(playername,"PilotLV",true)) {
			SetSpawnInfo(playerid,69,61,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
		}
		else if(!strcmp(playername,"PilotSF",true)) {
			SetSpawnInfo(playerid,69,61,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
		}
		else if(!strcmp(playername,"PilotLS",true)) {
			SetSpawnInfo(playerid,69,61,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
		}
		else if(!strcmp(playername,"OnfootTest",true)) {
			SetSpawnInfo(playerid,69,61,2388.1003,-1279.8933,25.1291,94.3321,-1,-1,-1,-1,-1,-1);
		}
		else if(!strcmp(playername,"DriverTest",true)) {
			SetSpawnInfo(playerid,69,61,2388.1003,-1279.8933,25.1291,94.3321,-1,-1,-1,-1,-1,-1);
		}
		else if(!strcmp(playername,"DriverTest2",true)) {
			SetSpawnInfo(playerid,69,61,2388.1003,-1279.8933,25.1291,94.3321,-1,-1,-1,-1,-1,-1);
		}
	}
	if (gNPC_HasCB[1])
	{
		return CallLocalFunction("NPC_OnPlayerRequestClass", "ii",playerid,  classid);
	}
	return 1;
}
#if defined _ALS_OnPlayerRequestClass
	#undef OnPlayerRequestClass
#else
	#define _ALS_OnPlayerRequestClass
#endif
#define OnPlayerRequestClass NPC_OnPlayerRequestClass
forward NPC_OnPlayerRequestClass(playerid,  classid);



//--------------OnPlayerSpawn Hook-------------------

public OnPlayerSpawn(playerid)
{

	if(IsPlayerNPC(playerid))
	{	
		new playername[64];
		GetPlayerName(playerid,playername,64);

		if(!strcmp(playername,"TrainDriverLV",true)) {
			PutPlayerInVehicle(playerid,1,0);
			SetPlayerColor(playerid,0xFFFFFFFF);
		}
		else if(!strcmp(playername,"TrainDriverSF",true)) {
			PutPlayerInVehicle(playerid,5,0);
			SetPlayerColor(playerid,0xFFFFFFFF);
		}
		else if(!strcmp(playername,"TrainDriverLS",true)) {
			PutPlayerInVehicle(playerid,9,0);
			SetPlayerColor(playerid,0xFFFFFFFF);
		}
		else if(!strcmp(playername,"PilotLV",true)) {
			PutPlayerInVehicle(playerid,13,0);
			SetPlayerColor(playerid,0xFFFFFFFF);
		}
		else if(!strcmp(playername,"PilotSF",true)) {
			PutPlayerInVehicle(playerid,14,0);
			SetPlayerColor(playerid,0xFFFFFFFF);
		}
		else if(!strcmp(playername,"PilotLS",true)) {
			PutPlayerInVehicle(playerid,15,0);
			SetPlayerColor(playerid,0xFFFFFFFF);
		}
		else if(!strcmp(playername,"OnfootTest",true)) {
			//PutPlayerInVehicle(playerid,876,0);
			SetPlayerColor(playerid,0xFFFFFFFF);
		}
		else if(!strcmp(playername,"DriverTest",true)) {
			PutPlayerInVehicle(playerid,376,0);
			SetPlayerColor(playerid,0xFFFFFFFF);
		}
		else if(!strcmp(playername,"DriverTest2",true)) {
			//SetVehicleTireStatus(876,0xFF);
			PutPlayerInVehicle(playerid,875,0);
			SetPlayerColor(playerid,0xFFFFFFFF);
		}
	}
	if (gNPC_HasCB[2])
	{
		return CallLocalFunction("NPC_OnPlayerSpawn", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn NPC_OnPlayerSpawn
forward NPC_OnPlayerSpawn(playerid);

stock SetVehicleTireStatus(vehicleid, tirestatus)
{
    new panels, doors, lights, tires;
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tirestatus);
}

