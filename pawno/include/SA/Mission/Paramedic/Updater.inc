forward AMB_OnIndicatorUpdate();
public AMB_OnIndicatorUpdate()
{
	for(new i = 0 ; i < 50; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(AMB_IsPlayerInMission(i)) 
			{
				UpdateMapIndicator(i);
			}
		}
	}
}