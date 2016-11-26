/*
	ÔË¶¯Æ÷²Ä Àà
	Developer: Episodes
	(C) 2016 JavaSparrow Project
	QQ: 191977649
*/

#include <fun/JM_GYM_RunningMachine>
#include <fun/JM_GYM_Bike>
#include <fun/JM_GYM_Bench>

#define GYM_RunningMachine 1
#define GYM_BikeMachine 2
#define GYM_Bench 3
#define GYM_DumbBell 4


stock GYM_getnearMachine(playerid)
{
	if(GYM_RM_near(playerid)) return GYM_RunningMachine;
	if(GYM_BIKE_near(playerid)) return GYM_BikeMachine;
	if(GYM_BENCH_near(playerid)) return GYM_Bench;
	
	return 0;
}

stock GYM_isMachineavaiable(machinetype,machineid)
{
	switch(machinetype)
	{
		case GYM_RunningMachine: return GYM_RM_isAvaiable(machineid) ? true : false;
		case GYM_BikeMachine: return GYM_BIKE_isAvaiable(machineid) ? true : false;
		case GYM_Bench: return GYM_BENCH_isAvaiable(machineid) ? true : false;
	}
	return false;
}

stock GYM_setMachineavaiable(machinetype,machineid,bool:avaiable)
{
	switch(machinetype)
	{
		case GYM_RunningMachine: GYM_RM_setAvaiable(machineid,avaiable);
		case GYM_BikeMachine: GYM_BIKE_setAvaiable(machineid,avaiable);
		case GYM_Bench: GYM_BENCH_setAvaiable(machineid,avaiable);
		
	}
}