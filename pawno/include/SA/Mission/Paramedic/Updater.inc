forward AMB_OnIndicatorUpdate();
public AMB_OnIndicatorUpdate()
{
	for(new i = 0 ; i < MAX_PLAYERS; i++)
	{
		if(UpdateMapIndicator(playerid))
	}
}