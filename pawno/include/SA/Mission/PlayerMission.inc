//#include <SAWORLD/Mission/PlayerMissionReset>
enum MissionInfo
{
	MissionID,
}

new PlayerMission[MAX_PLAYERS][MissionInfo];

stock SetPlayerMissionID(playerid,Missionid)
{
	PlayerMission[playerid][MissionID] = Missionid;
}

stock GetPlayerMissionID(playerid)
{
	return PlayerMission[playerid][MissionID];
}
stock IsPlayerInMission(playerid)
{
	return PlayerMission[playerid][MissionID] == MISSION_NONE ? false : true;
}
stock SetPlayerMissionStatus(playerid,Missionid,bool:start)
{
	if(start)
	{
		//垃圾回收
		ResetPlayerMission(playerid,PlayerMission[playerid][MissionID]);
		PlayerMission[playerid][MissionID] = Missionid;
	}
	else 
	{
		PlayerMission[playerid][MissionID] = MISSION_NONE;
	}
}
stock ResetPlayerMission(playerid,missionid)
{
	if(missionid!= MISSION_NONE)
	{	
		switch (missionid)
		{
			case MISSION_HOTDOG: HOTDOG_PLAYER_reset(playerid);
			case MISSION_ICECREAM: IceCream_PLAYER_reset(playerid);
			case MISSION_PARAMEDIT: AMB_PLAYER_reset(playerid);
			case MISSION_PIZZA: PIZZA_PLAYER_reset(playerid);
			case MISSION_CARSHOP: CarShop_PLAYER_reset(playerid);
		}
	}
}
