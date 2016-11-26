stock ResetPlayerMission(playerid,missionid)
{
	if(missionid!= MISSION_NONE)
	{	
		switch (missionid)
		{
			case MISSION_HOTDOG: HOTDOG_PLAYER_reset(playerid);
			//case MISSION_ICECREAM: IceCream_PLAYER_reset(playerid);
			//....
		}
	}
}
