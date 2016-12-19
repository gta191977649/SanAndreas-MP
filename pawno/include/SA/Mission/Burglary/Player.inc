#define PLAYER_ATTACH_INDEX 9
#define PLAYER_ANIM_DELAY 1500

new PlayerBurglaryRoom[MAX_PLAYERS];

stock BurglaryPlayerLiftFuniture(playerid,funitureidx)
{
	
	new PlayerGameID = Burglary_PlayerRoomGet(playerid); 
	//��OBJ�����
	new ObjectModel = BurglaryFunitureGetModel(PlayerGameID,funitureidx);
	SetPlayerAttachedObject(playerid,PLAYER_ATTACH_INDEX,ObjectModel,1,0,0.6,0,0,90,0,1.000000, 1.000000, 1.000000);
	
	BurglaryAnimationPick(playerid);
	//���ö����ӳ�
	SetTimerEx("BurglaryPickUp",PLAYER_ANIM_DELAY, false, "iii",playerid,PlayerGameID,funitureidx);
	
}


forward BurglaryPickUp(playerid,GameID,funitureidx);
public BurglaryPickUp(playerid,GameID,funitureidx)
{
	BurglaryFunitureDestory(GameID,funitureidx);
	//���ö���
	BurglaryAnimationPrtial(playerid);
}
stock PlayerBurglaryRoomReset()
{
	for(new i=0; i < MAX_PLAYERS;i++)
		PlayerBurglaryRoom[MAX_PLAYERS] = NULL;
}
stock Burglary_IsPlayerInMission(playerid)
{
	if(GetPlayerMissionID(playerid) == MISSION_BURGLARY && IsPlayerInMission(playerid)) return true;
	else return false;
}
stock Burglary_SetPlayerMissionStatus(playerid,bool:toogle)
{
	if(toogle)
	{
		SetPlayerMissionStatus(playerid,MISSION_BURGLARY,true);
		
	}
	else
	{
		SetPlayerMissionStatus(playerid,MISSION_BURGLARY,false);
		Burglary_PLAYER_reset(playerid);
	}
}

stock Burglary_PlayerStart(playerid)
{
	//��ȡ����ID
	new roomid = Burglary_GetAvaiableRoomID();
	if(roomid == NULL)
	{
		ShowInfoBox(playerid,INFO_BoxBG,5,BURGLARY_NOROOM);
		return 1;
	}
	
	Burglary_PlayerRoomSet(playerid,roomid);
	
	//���뷿��
	Burglary_PlayerJoin(roomid,playerid);
	
	//��������״̬
	Burglary_SetVehicle(roomid,GetPlayerVehicleID(playerid));
	
	//������Է���
	new houseid = Burglary_GenRobbryHouseID();
	
	
	//�������ڼҾ�
	Burglary_CreateFuniture(roomid,houseid);
	//����PickUp
	Burglary_CreatePickUp(roomid,houseid);
	//������ͼͼ��
	Burglary_CreateMarker(roomid,houseid);
	//����������ʾ
	Burglary_UpdateMissionObj(roomid,houseid);
	
	printf("��������ʼ");
	
	return 1;
}
stock Burglary_PLAYER_reset(playerid)
{
	/*
	Burglary_PlayerExit(playerid);
	
	
	Burglary_PlayerRoomReset(playerid);
	*/
	
}
stock Burglary_PlayerJoin(roomid,playerid)
{
	printf("pre Burglary_PlayerJoin");
	new playerSlot = Burglary_GetAvaiablePlayerSlot(roomid);
	
	printf("Burglary_GetAvaiablePlayerSlot");
	Burglary_SetPlayerSlot(roomid,playerSlot,playerid);
	printf("Burglary_SetPlayerSlot");
	//��������״̬
	Burglary_SetPlayerMissionStatus(playerid,true);
	printf("Burglary_PlayerJoin Out");
}
stock Burglary_PlayerExit(playerid)
{
	Burglary_SetPlayerSlot(PlayerBurglaryRoom[playerid],slot,playerid)
}
stock Burglary_PlayerRoomSet(playerid,roomid)
{
	PlayerBurglaryRoom[playerid] = roomid;
}
stock Burglary_PlayerRoomReset(playerid)
{
	PlayerBurglaryRoom[playerid] = NULL;
}

stock Burglary_PlayerRoomGet(playerid)
{
	return PlayerBurglaryRoom[playerid];
}