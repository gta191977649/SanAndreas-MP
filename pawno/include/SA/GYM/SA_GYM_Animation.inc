/*
	GYM 动作类
	Dev: Episodes
	(C) 2016 JavaSparrow Project
	QQ: 191977649
*/

//#define GYM_ANIM_RunningMachine 0

new GYM_IsPlayerInAnimation[MAX_PLAYERS];
//------------------------------上运动器材动作----------------------------------
stock GYM_ANIM_applyAnimationON(playerid,mahcinetype)
{
	
	GYM_IsPlayerInAnimation[playerid] = true;
	switch(mahcinetype)
	{
		case GYM_RunningMachine://跑步机
		{
			ApplyAnimation( playerid, "GYMNASIUM", "gym_tread_geton", 1, 0, 0, 0, 1, 0, 1 );
			SetTimerEx( "GYM_ANIM_RUN", 2000, false, "ii", playerid,mahcinetype);
		}
		case GYM_BikeMachine://单车
		{
			ApplyAnimation( playerid, "GYMNASIUM", "gym_bike_geton", 1, 0, 0, 0, 1, 0, 1 );
			SetTimerEx( "GYM_ANIM_RUN", 2000, false, "ii", playerid,mahcinetype);
		}
		case GYM_Bench:
		{
			ApplyAnimation( playerid, "benchpress", "gym_bp_geton", 1, 0, 0, 0, 1, 0, 1 );
			SetTimerEx( "GYM_ANIM_RUN", 4000, false, "ii", playerid,mahcinetype);
		}
	}
	
	
	
}
//------------------------------下运动器材动作----------------------------------
stock GYM_ANIM_applyAnimationOFF(playerid,mahcinetype)
{
	switch(mahcinetype)
	{
		case GYM_RunningMachine://跑步机
		{
			GYM_RM_makeNoise(playerid,PlayerGym[playerid][MachineID],false);
			ApplyAnimation( playerid, "GYMNASIUM", "gym_tread_getoff", 1, 0, 0, 0, 1, 0, 1 );
		}
		case GYM_BikeMachine://单车
		{
			GYM_BIKE_makeNoise(playerid,PlayerGym[playerid][MachineID],false);
			ApplyAnimation( playerid, "GYMNASIUM", "gym_bike_getoff", 1, 0, 0, 0, 1, 0, 1 );
		}
		case GYM_Bench://
		{
			GYM_BENCH_makeNoise(playerid,PlayerGym[playerid][MachineID],false);
			ApplyAnimation( playerid, "benchpress", "gym_bp_getoff", 1, 0, 0, 0, 1, 0, 1 );
		}
		
	}
}

stock GYM_ANIM_reset(playerid,machinetype)
{
	
	//ApplyAnimation( playerid, "GYMNASIUM", "gym_free_celebrate", 1, 0, 0, 0, 0, 0, 1 );
	switch(machinetype)
	{
		case GYM_RunningMachine:ApplyAnimation( playerid, "GYMNASIUM", "gym_tread_celebrate", 1, 0, 0, 0, 0, 0, 1 );
		case GYM_BikeMachine:ApplyAnimation( playerid, "Freeweights", "gym_free_celebrate", 1, 0, 0, 0, 0, 0, 1 );
		case GYM_Bench:
		{
			//声音效果
			GYM_BENCH_makeNoise(playerid,PlayerGym[playerid][MachineID],true);
			//重新创建OBJ
			GYM_BENCH_RESTOREOBJ(PlayerGym[playerid][MachineID]);
			//移除玩家绑定OBJ
			RemovePlayerAttachedObject(playerid,1);
			ApplyAnimation( playerid, "benchpress", "gym_bp_celebrate", 1, 0, 0, 0, 0, 0, 1 );
		}
		
	}
}

forward GYM_ANIM_RUN(playerid,mahcinetype);
public GYM_ANIM_RUN(playerid,mahcinetype)
{
	GYM_IsPlayerInAnimation[playerid] = false;
	switch(mahcinetype)
	{
		case GYM_RunningMachine://跑步机
		{
			GYM_RM_makeNoise(playerid,PlayerGym[playerid][MachineID],true);
			ApplyAnimation( playerid, "GYMNASIUM", "gym_tread_sprint", 1, 1, 0, 0, 1, 0, 1);
			
		}
		case GYM_BikeMachine://单车
		{
			GYM_BIKE_makeNoise(playerid,PlayerGym[playerid][MachineID],true);
			ApplyAnimation( playerid, "GYMNASIUM", "gym_bike_fast", 1, 1, 0, 0, 1, 0, 1);
		}
		case GYM_Bench://
		{
			//声音效果
			GYM_BENCH_makeNoise(playerid,PlayerGym[playerid][MachineID],true);
			//绑定OBJ到玩家手上
			SetPlayerAttachedObject(playerid, 1, 2913, 6);
			//移除静态OBJ
			GYM_BENCH_HIDEOBJ(PlayerGym[playerid][MachineID]);
			
			ApplyAnimation( playerid, "benchpress", "gym_bp_down", 1, 0, 0, 0, 1, 0, 1 );
		}
		
		
	}
	
}

stock PreloadAnimLib(playerid, animlib[])
{
    ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
}