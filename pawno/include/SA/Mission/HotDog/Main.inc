/*
	֧������:���ȹ�
*/

#include <SA/Mission/HotDog/Animation>
#include <SA/Mission/HotDog/Vehicle>
#include <SA/Mission/HotDog/Player>



#define KEY_MISSION (newkeys & KEY_SUBMISSION) && !(oldkeys & KEY_SUBMISSION)
#define KEY_ALT  (newkeys &  KEY_WALK ) && !(oldkeys &  KEY_WALK )

static gHOTDOG_HasCB[8];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//your OnGameModeInit pre code here

	//function hook checks

	gHOTDOG_HasCB[0] = funcidx("HOTDOG_OnPlayerDisconnect") != -1;
	gHOTDOG_HasCB[1] = funcidx("HOTDOG_OnPlayerEnterVehicle") != -1;
	gHOTDOG_HasCB[2] = funcidx("HOTDOG_OnPlayerExitVehicle") != -1;
	gHOTDOG_HasCB[3] = funcidx("HOTDOG_OnPlayerStateChange") != -1;
	gHOTDOG_HasCB[4] = funcidx("HOTDOG_OnPlayerKeyStateChange")  != -1;
	gHOTDOG_HasCB[5] = funcidx("HOTDOG_OnPlayerStreamIn") != -1;
	gHOTDOG_HasCB[6] = funcidx("HOTDOG_OnPlayerStreamOut") != -1;
	gHOTDOG_HasCB[7] = funcidx("HOTDOG_OnPlayerDeath") != -1;
	if (funcidx("HOTDOG_OnGameModeInit") != -1)
	{
		return CallLocalFunction("HOTDOG_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit HOTDOG_OnGameModeInit
forward HOTDOG_OnGameModeInit();



//--------------OnPlayerDisconnect Hook-------------------

public OnPlayerDisconnect(playerid,  reason)
{
	//your OnPlayerDisconnect code here
	HOTDOG_PLAYER_reset(playerid);
	if (gHOTDOG_HasCB[0])
	{
		return CallLocalFunction("HOTDOG_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect HOTDOG_OnPlayerDisconnect
forward HOTDOG_OnPlayerDisconnect(playerid,  reason);



//--------------OnPlayerEnterVehicle Hook-------------------

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	//print("OnPlayerEnterVehicle Called");
	//your OnPlayerEnterVehicle code here
	
	
	if (gHOTDOG_HasCB[1])
	{
		return CallLocalFunction("HOTDOG_OnPlayerEnterVehicle", "iii",playerid, vehicleid, ispassenger);
	}
	return 1;
}
#if defined _ALS_OnPlayerEnterVehicle
	#undef OnPlayerEnterVehicle
#else
	#define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle HOTDOG_OnPlayerEnterVehicle
forward HOTDOG_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);



//--------------OnPlayerExitVehicle Hook-------------------

public OnPlayerExitVehicle(playerid, vehicleid)
{
	//your OnPlayerExitVehicle code here
	//print("OnPlayerExitVehicle");
	
	if(HOTDOG_PLAYER_isSell(playerid)) 
	{
		SG_Sub(playerid,"~r~ You have left the vehicle.",5);
		HOTDOG_PLAYER_stopSelling(playerid);
		HOTDOG_PLAYER_reset(playerid);
		
	}
	
	
	if (gHOTDOG_HasCB[2])
	{
		return CallLocalFunction("HOTDOG_OnPlayerExitVehicle", "ii",playerid, vehicleid);
	}
	return 1;
}
#if defined _ALS_OnPlayerExitVehicle
	#undef OnPlayerExitVehicle
#else
	#define _ALS_OnPlayerExitVehicle
#endif
#define OnPlayerExitVehicle HOTDOG_OnPlayerExitVehicle
forward HOTDOG_OnPlayerExitVehicle(playerid, vehicleid);

//--------------OnPlayerStateChange Hook-------------------

public OnPlayerStateChange(playerid, newstate,  oldstate)
{
	//your OnPlayerStateChange code here

	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) // Player entered a vehicle as a driver
    {
		
		if(IsVaildHotDogVehicle(playerid)) ShowInfoBox(playerid,INFO_BoxBG,3,"Press ~k~~TOGGLE_SUBMISSIONS~  to start sell hotdog.");
    }
	
	
	if (gHOTDOG_HasCB[3])
	{
		return CallLocalFunction("HOTDOG_OnPlayerStateChange", "iii",playerid, newstate,  oldstate);
	}
	return 1;
}
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange HOTDOG_OnPlayerStateChange
forward HOTDOG_OnPlayerStateChange(playerid, newstate,  oldstate);
//--------------OnPlayerKeyStateChange Hook-------------------

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	//your OnPlayerKeyStateChange code here
	if(KEY_MISSION)
	{
		if(HOTDOG_PLAYER_isSell(playerid)) return 1;
		//��ʼ����
		if(IsVaildHotDogVehicle(playerid))
		{
			HOTDOG_PLAYER_startSelling(playerid);
			SG_Sub(playerid,"Find a ~y~Customer~w~.",5);
			
		}
	}
	
	//���ȹ�
	if(KEY_ALT)
	{
		//����������ȹ���
		if(HOTDOG_PLAYER_isNeart(playerid) && !HOTDOG_PLAYER_isSell(playerid)) 
		{
			//��ȡ������ID
			new SellerID = HOTDOG_PLAYER_getNearSeller(playerid);
			HOTDOG_PLAYER_buy(playerid,SellerID);
			//�������
			new vehicle;
			vehicle = GetPlayerVehicleID(SellerID);
			SetPlayerObjective(playerid,vehicle,false);
		}			
	
	}
	
	if (gHOTDOG_HasCB[4])
	{
		return CallLocalFunction("HOTDOG_OnPlayerKeyStateChange", "iii",playerid, newkeys, oldkeys);
	}
	return 1;
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange HOTDOG_OnPlayerKeyStateChange
forward HOTDOG_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);

//--------------OnPlayerStreamIn Hook-------------------

public OnPlayerStreamIn(playerid, forplayerid)
{
	//��ʾ��ҿ������ȹ�
	if(HOTDOG_PLAYER_isSell(playerid))
	{
		//���ӳ��ϻ�ɫ��ͷ
		HOTDOG_SetObjective(playerid,forplayerid);
		//��ʾ�������
		SG_Sub(forplayerid,"You can buy hotdog from ~y~vendor~w~.",5);
		SendClientMessage(forplayerid,-1,"[��ʾ]: ������ڸ�����"C_OBJECTIVE"��Ӧ��"C_WHITE"�����ȹ�.");
	}

	if (gHOTDOG_HasCB[5])
	{
		return CallLocalFunction("HOTDOG_OnPlayerStreamIn", "ii",playerid, forplayerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerStreamIn
	#undef OnPlayerStreamIn
#else
	#define _ALS_OnPlayerStreamIn
#endif
#define OnPlayerStreamIn HOTDOG_OnPlayerStreamIn
forward HOTDOG_OnPlayerStreamIn(playerid, forplayerid);



//--------------OnPlayerStreamOut Hook-------------------

public OnPlayerStreamOut(playerid, forplayerid)
{
	//your OnPlayerStreamOut code here
	HOTDOG_SetObjectiveOff(playerid,forplayerid);
	if (gHOTDOG_HasCB[6])
	{
		return CallLocalFunction("HOTDOG_OnPlayerStreamOut", "ii",playerid, forplayerid);
	}
	return 1;
}
//--------------OnPlayerDeath Hook-------------------

public OnPlayerDeath(playerid, killerid,  reason)
{
	//your OnPlayerDeath code here
	if(HOTDOG_PLAYER_isSell(playerid)) 
	{
		SG_Sub(playerid,"~r~ You died.",5);
		HOTDOG_PLAYER_stopSelling(playerid);
		HOTDOG_PLAYER_reset(playerid);
		
	}
	
	if (gHOTDOG_HasCB[0])
	{
		return CallLocalFunction("HOTDOG_OnPlayerDeath", "iii",playerid, killerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath HOTDOG_OnPlayerDeath
forward HOTDOG_OnPlayerDeath(playerid, killerid,  reason);





#if defined _ALS_OnPlayerStreamOut
	#undef OnPlayerStreamOut
#else
	#define _ALS_OnPlayerStreamOut
#endif
#define OnPlayerStreamOut HOTDOG_OnPlayerStreamOut
forward HOTDOG_OnPlayerStreamOut(playerid, forplayerid);


//Function
stock HOTDOG_SetObjective(playerid,forplayerid)
{
	new vehicle;
	vehicle = GetPlayerVehicleID(playerid);
	SetPlayerObjective(forplayerid,vehicle,true);
}
stock HOTDOG_SetObjectiveOff(playerid,forplayerid)
{
	new vehicle;
	vehicle = GetPlayerVehicleID(playerid);
	SetPlayerObjective(forplayerid,vehicle,false);
}
stock HOTDOG_SetAllObjectiveOff(playerid)
{
	new vehicle = GetPlayerVehicleID(playerid);
	for(new i = 0 ; i < MAX_PLAYERS; i ++)
	{
		if (IsPlayerConnected(i))
		{
			
			if(GetPlayerObjectiveVehicle(i) == vehicle) HOTDOG_SetObjectiveOff(playerid,i);
			
		}
	}
}



