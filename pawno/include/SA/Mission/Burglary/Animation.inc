

stock BurglaryAnimationPrtial(playerid)
{
	//ApplyAnimation(playerid,"CARRY","crry_prtial",4.0,0,0,1,1,1);
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
}

stock BurglaryAnimationClear(playerid)
{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
}
stock BurglaryAnimationPick(playerid)
{
	ApplyAnimation(playerid,"CARRY","liftup",1, 0, 0, 0, 0, 0, 1 );
}

stock BurglaryAnimationDown(playerid)
{
	ApplyAnimation(playerid,"CARRY","putdwn",1, 0, 0, 0, 0, 0, 1  );
}
