

stock BurglaryAnimationPrtial(playerid)
{
	//ApplyAnimation(playerid,"CARRY","crry_prtial",4.0,0,0,1,1,1);
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
}

stock BurglaryAnimationPick(playerid)
{
	ApplyAnimation(playerid,"CARRY","liftup",4,0,0,1,1,1);
}