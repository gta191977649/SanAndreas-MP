/*
	GYM Main Script
	Developer: Episodes
	(C) 2016 JavaSparrow Project
	QQ: 191977649
*/

#include <SAWORLD/GYM/SA_GYM_Machine>

#include <SAWORLD/GYM/SA_GYM_PLAYER>


#define KEY_ENTER (newkeys & KEY_SECONDARY_ATTACK) && !(oldkeys & KEY_SECONDARY_ATTACK)

static gGYM_HasCB[3];

//Callbacks
public OnGameModeInit()
{
	//your OnGameModeInit pre code here
	GYM_BENCH_init();
	//function hook checks

	gGYM_HasCB[0] = funcidx("GYM_OnPlayerDisconnect") != -1;
	gGYM_HasCB[1] = funcidx("GYM_OnPlayerKeyStateChange") != -1;
	gGYM_HasCB[2] = funcidx("GYM_OnPlayerSpawn") != -1;
	if (funcidx("GYM_OnGameModeInit") != -1)
	{
		return CallLocalFunction("GYM_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit GYM_OnGameModeInit
forward GYM_OnGameModeInit();

//--------------OnPlayerSpawn Hook-------------------

public OnPlayerSpawn(playerid)
{
	//your OnPlayerSpawn code here
	PreloadAnimLib(playerid, "GYMNASIUM");
	PreloadAnimLib(playerid, "GYMNASIUM");
	PreloadAnimLib(playerid, "benchpress");
	
	
	if (gGYM_HasCB[0])
	{
		return CallLocalFunction("GYM_OnPlayerSpawn", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn GYM_OnPlayerSpawn
forward GYM_OnPlayerSpawn(playerid);




public OnPlayerKeyStateChange(playerid, newkeys, oldkeys )
{
	//Check for key prees & near by gym machine
	
	if(KEY_ENTER)
	{
		new NearMachine = GYM_getnearMachine(playerid);
		if(NearMachine != -1)
		{
			
			/*
			new N_MachineID = GYM_RM_getNearMachineID(playerid);
			if(!PlayerGym[playerid][IsInGym]) GYM_PlayerGetOnMachine(playerid,NearMachine,N_MachineID);
			else GYM_PlayerGetOffMachine(playerid,NearMachine,N_MachineID);	
			*/

			switch(NearMachine)
			{
				//跑步机的话
				case GYM_RunningMachine:
				{
					new N_MachineID = GYM_RM_getNearMachineID(playerid);
					if(!PlayerGym[playerid][IsInGym] && !GYM_isMachineavaiable(NearMachine,N_MachineID)) return GYM_ERROR_InUsed(playerid);
			
					if(!PlayerGym[playerid][IsInGym]) GYM_PlayerGetOnMachine(playerid,NearMachine,N_MachineID);
					else GYM_PlayerGetOffMachine(playerid,NearMachine,N_MachineID);	
						
				}
				case GYM_BikeMachine: //单车
				{
					new N_MachineID = GYM_BIKE_getNearMachineID(playerid);
					if(!PlayerGym[playerid][IsInGym] && !GYM_isMachineavaiable(NearMachine,N_MachineID)) return GYM_ERROR_InUsed(playerid);
					if(!PlayerGym[playerid][IsInGym]) GYM_PlayerGetOnMachine(playerid,NearMachine,N_MachineID);
					else GYM_PlayerGetOffMachine(playerid,NearMachine,N_MachineID);	
				}
				case GYM_Bench:
				{
					new N_MachineID = GYM_BENCH_getNearMachineID(playerid);
					if(!PlayerGym[playerid][IsInGym] && !GYM_isMachineavaiable(NearMachine,N_MachineID)) return GYM_ERROR_InUsed(playerid);
					if(!PlayerGym[playerid][IsInGym]) GYM_PlayerGetOnMachine(playerid,NearMachine,N_MachineID);
					else GYM_PlayerGetOffMachine(playerid,NearMachine,N_MachineID);	
				}
			}
		
			
		}
	}
	


	if (gGYM_HasCB[1])
	{
		return CallLocalFunction("GYM_OnPlayerKeyStateChange", "iii",playerid, newkeys, oldkeys);
	}
	return 1;
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange GYM_OnPlayerKeyStateChange
forward GYM_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);


stock GYM_ERROR_InUsed(playerid)
{
	PlayerPlaySound(playerid, 1055 , 0.0, 0.0, 0.0);
	SendClientMessage(playerid, -1, "[GYM]: ��Ǹ,����������ʹ����ϸ����Ĳ�����.");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	//����
	if(PlayerGym[playerid][IsInGym]) GYM_PlayerResetStatus(playerid,PlayerGym[playerid][MachineType],PlayerGym[playerid][MachineID]);
	if (gGYM_HasCB[0])
	{
		return CallLocalFunction("GYM_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect GYM_OnPlayerDisconnect
forward GYM_OnPlayerDisconnect(playerid,  reason);