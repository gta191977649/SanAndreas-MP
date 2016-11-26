/*
	GYM Running Machine Class
	Dev: Episodes
	(C) 2016 JavaSparrow Project
	QQ: 191977649
*/

stock Float:GYM_RM_POS[][] =
{
	{ 773.4922, -2.6016,1000.7209 ,180.00000 },
	{ 759.6328, -48.1250, 1000.7209,180.00000},
	{ 758.3828, -65.5078, 1000.7209,180.00000} 
};

new bool:GYM_RM_used[sizeof(GYM_RM_POS)];


//方法
stock GYM_RM_isAvaiable(machineid)
{
	return GYM_RM_used[machineid] ? false : true;
}

stock GYM_RM_setAvaiable(machineid,bool:ava)
{
	if(ava) GYM_RM_used[machineid]= false;
	else GYM_RM_used[machineid] = true;
}

stock GYM_RM_makeNoise(playerid,machineid,toggle)
{
	
	if(toggle) PlayerPlaySound(playerid, 17801, GYM_RM_POS[machineid][0], GYM_RM_POS[machineid][1], GYM_RM_POS[machineid][2]);
	else PlayerPlaySound(playerid, 17803 , 0.0, 0.0, 0.0);
}


stock GYM_RM_near(playerid)
{
	for( new o; o != sizeof GYM_RM_POS; o ++ )
	{
		if( IsPlayerInRangeOfPoint(playerid,2.0,GYM_RM_POS[o][0], GYM_RM_POS[o][1], GYM_RM_POS[o][2]))
		{
			return true;
		}
	}
	return false;
}

stock GYM_RM_getNearMachineID(playerid)
{
	for( new o; o != sizeof GYM_RM_POS; o ++ )
	{
		if( IsPlayerInRangeOfPoint(playerid,2.0,GYM_RM_POS[o][0], GYM_RM_POS[o][1], GYM_RM_POS[o][2]))
		{
			return o;
		}
	}
	return -1;
}