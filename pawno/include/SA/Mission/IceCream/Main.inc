/*
	֧������:�������
*/

#include <SA/Mission/IceCream/Animation>
#include <SA/Mission/IceCream/Vehicle>
#include <SA/Mission/IceCream/Player>



#define KEY_MISSION (newkeys & KEY_SUBMISSION) && !(oldkeys & KEY_SUBMISSION)
#define KEY_ALT  (newkeys &  KEY_WALK ) && !(oldkeys &  KEY_WALK )

static gIceCream_HasCB[7];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//your OnGameModeInit pre code here

	//function hook checks

	gIceCream_HasCB[0] = funcidx("IceCream_OnPlayerDisconnect") != -1;
	gIceCream_HasCB[1] = funcidx("IceCream_OnPlayerEnterVehicle") != -1;
	gIceCream_HasCB[2] = funcidx("IceCream_OnPlayerExitVehicle") != -1;
	gIceCream_HasCB[3] = funcidx("IceCream_OnPlayerStateChange") != -1;
	gIceCream_HasCB[4] = funcidx("IceCream_OnPlayerKeyStateChange")  != -1;
	gIceCream_HasCB[5] = funcidx("IceCream_OnPlayerStreamIn") != -1;
	gIceCream_HasCB[6] = funcidx("IceCream_OnPlayerStreamOut") != -1;
	if (funcidx("IceCream_OnGameModeInit") != -1)
	{
		return CallLocalFunction("IceCream_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit IceCream_OnGameModeInit
forward IceCream_OnGameModeInit();



//--------------OnPlayerDisconnect Hook-------------------

public OnPlayerDisconnect(playerid,  reason)
{
	//your OnPlayerDisconnect code here
	IceCream_PLAYER_reset(playerid);
	if (gIceCream_HasCB[0])
	{
		return CallLocalFunction("IceCream_OnPlayerDisconnect", "ii",playerid,  reason);
	}
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect IceCream_OnPlayerDisconnect
forward IceCream_OnPlayerDisconnect(playerid,  reason);



//--------------OnPlayerEnterVehicle Hook-------------------

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	//print("OnPlayerEnterVehicle Called");
	//your OnPlayerEnterVehicle code here
	
	
	if (gIceCream_HasCB[1])
	{
		return CallLocalFunction("IceCream_OnPlayerEnterVehicle", "iii",playerid, vehicleid, ispassenger);
	}
	return 1;
}
#if defined _ALS_OnPlayerEnterVehicle
	#undef OnPlayerEnterVehicle
#else
	#define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle IceCream_OnPlayerEnterVehicle
forward IceCream_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);



//--------------OnPlayerExitVehicle Hook-------------------

public OnPlayerExitVehicle(playerid, vehicleid)
{
	//your OnPlayerExitVehicle code here
	//print("OnPlayerExitVehicle");
	
	if(IceCream_PLAYER_isSell(playerid)) 
	{
		SG_Sub(playerid,"~r~ You have left the vehicle.",5);
		IceCream_PLAYER_stopSelling(playerid);
		IceCream_PLAYER_reset(playerid);
	}
	
	
	if (gIceCream_HasCB[2])
	{
		return CallLocalFunction("IceCream_OnPlayerExitVehicle", "ii",playerid, vehicleid);
	}
	return 1;
}
#if defined _ALS_OnPlayerExitVehicle
	#undef OnPlayerExitVehicle
#else
	#define _ALS_OnPlayerExitVehicle
#endif
#define OnPlayerExitVehicle IceCream_OnPlayerExitVehicle
forward IceCream_OnPlayerExitVehicle(playerid, vehicleid);

//--------------OnPlayerStateChange Hook-------------------

public OnPlayerStateChange(playerid, newstate,  oldstate)
{
	//your OnPlayerStateChange code here

	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) // Player entered a vehicle as a driver
    {
		
		if(IsVaildIceCreamVehicle(playerid)) ShowInfoBox(playerid,INFO_BoxBG,3,"Press ~k~~TOGGLE_SUBMISSIONS~  to start sell IceCream.");
    }
	
	
	if (gIceCream_HasCB[3])
	{
		return CallLocalFunction("IceCream_OnPlayerStateChange", "iii",playerid, newstate,  oldstate);
	}
	return 1;
}
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange IceCream_OnPlayerStateChange
forward IceCream_OnPlayerStateChange(playerid, newstate,  oldstate);
//--------------OnPlayerKeyStateChange Hook-------------------

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	//your OnPlayerKeyStateChange code here
	if(KEY_MISSION)
	{
		if(IceCream_PLAYER_isSell(playerid)) return 1;
		//��ʼ����
		if(IsVaildIceCreamVehicle(playerid))
		{
			IceCream_PLAYER_startSelling(playerid);
			SG_Sub(playerid,"Find a ~y~Customer~w~.",5);
			
		}
	}
	
	//���ȹ�
	if(KEY_ALT)
	{
		//����������ȹ���
		if(IceCream_PLAYER_isNeart(playerid) && !IceCream_PLAYER_isSell(playerid)) 
		{
			//��ȡ������ID
			new SellerID = IceCream_PLAYER_getNearSeller(playerid);
			IceCream_PLAYER_buy(playerid,SellerID);
			//�������
			new vehicle;
			vehicle = GetPlayerVehicleID(SellerID);
			SetPlayerObjective(playerid,vehicle,false);
		}			
	
	}
	
	if (gIceCream_HasCB[4])
	{
		return CallLocalFunction("IceCream_OnPlayerKeyStateChange", "iii",playerid, newkeys, oldkeys);
	}
	return 1;
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange IceCream_OnPlayerKeyStateChange
forward IceCream_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);

//--------------OnPlayerStreamIn Hook-------------------

public OnPlayerStreamIn(playerid, forplayerid)
{
	//��ʾ��ҿ������ȹ�
	if(IceCream_PLAYER_isSell(playerid))
	{
		//���ӳ��ϻ�ɫ��ͷ
		IceCream_SetObjective(playerid,forplayerid);
		//��ʾ�������
		SG_Sub(forplayerid,"You can buy IceCream from ~y~vendor~w~.",5);
		SendClientMessage(forplayerid,-1,"[��ʾ]: ������ڸ�����"C_OBJECTIVE"��Ӧ��"C_WHITE"��������.");
	}

	if (gIceCream_HasCB[5])
	{
		return CallLocalFunction("IceCream_OnPlayerStreamIn", "ii",playerid, forplayerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerStreamIn
	#undef OnPlayerStreamIn
#else
	#define _ALS_OnPlayerStreamIn
#endif
#define OnPlayerStreamIn IceCream_OnPlayerStreamIn
forward IceCream_OnPlayerStreamIn(playerid, forplayerid);



//--------------OnPlayerStreamOut Hook-------------------

public OnPlayerStreamOut(playerid, forplayerid)
{
	//your OnPlayerStreamOut code here
	IceCream_SetObjectiveOff(playerid,forplayerid);
	
	if (gIceCream_HasCB[6])
	{
		return CallLocalFunction("IceCream_OnPlayerStreamOut", "ii",playerid, forplayerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerStreamOut
	#undef OnPlayerStreamOut
#else
	#define _ALS_OnPlayerStreamOut
#endif
#define OnPlayerStreamOut IceCream_OnPlayerStreamOut
forward IceCream_OnPlayerStreamOut(playerid, forplayerid);

//Function
stock IceCream_SetObjective(playerid,forplayerid)
{
	new vehicle;
	vehicle = GetPlayerVehicleID(playerid);
	SetPlayerObjective(forplayerid,vehicle,true);
}
stock IceCream_SetObjectiveOff(playerid,forplayerid)
{
	new vehicle;
	vehicle = GetPlayerVehicleID(playerid);
	SetPlayerObjective(forplayerid,vehicle,false);
}
stock IceCream_SetAllObjectiveOff(playerid)
{
	new vehicle = GetPlayerVehicleID(playerid);
	for(new i = 0 ; i < MAX_PLAYERS; i ++)
	{
		if (IsPlayerConnected(i))
		{
			
			if(GetPlayerObjectiveVehicle(i) == vehicle) IceCream_SetObjectiveOff(playerid,i);
			
		}
	}
}






