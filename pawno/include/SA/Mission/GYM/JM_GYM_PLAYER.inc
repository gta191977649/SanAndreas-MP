/*
	GYM 玩家类

*/

#include <fun/JM_GYM_Camera>

#define GYM_MACHINE_NONE -1
enum PlayerGym_Info
{
	NumberOfMeter,
	bool:IsInGym,
	MachineID,
	MachineType,
}

new PlayerGym[MAX_PLAYERS][PlayerGym_Info];


#include <fun/JM_GYM_Animation>



stock GYM_PlayerGetOnMachine(playerid,machinetype,machineid)
{
	print("GYM_PlayerGetOnMachine");
	PlayerGym[playerid][IsInGym] = true;
	CallRemoteFunction("TooglePlayerCMD","iis",playerid,true,"ExitGym");
	
	//设置状态
	PlayerGym[playerid][MachineID] = machineid;
	PlayerGym[playerid][MachineType] = machinetype;
	//设置可用
	GYM_setMachineavaiable(machinetype,machineid,false);
	
	switch (machinetype)
	{
		case GYM_RunningMachine: // 跑步机
		{
			//设置位置&角度
			SetPlayerPos( playerid, GYM_RM_POS[machineid][0], GYM_RM_POS[machineid][1]+1.5, GYM_RM_POS[machineid][2]);
			SetPlayerFacingAngle( playerid, GYM_RM_POS[machineid][3]);
			//镜头
			GYM_CAM_TooglePlayerCamera(playerid,true,machinetype,machineid);
			//动作
			GYM_ANIM_applyAnimationON(playerid,machinetype);
			
			
		}
		case GYM_BikeMachine: //单车
		{
			//设置位置&角度
			SetPlayerPos( playerid, GYM_BIKE_POS[machineid][0]+0.5, GYM_BIKE_POS[machineid][1]-0.5, GYM_BIKE_POS[machineid][2]);
			SetPlayerFacingAngle( playerid, GYM_BIKE_POS[machineid][3]);
			
			//镜头
			GYM_CAM_TooglePlayerCamera(playerid,true,machinetype,machineid);
			//动作
			GYM_ANIM_applyAnimationON(playerid,machinetype);
		}
		case GYM_Bench:
		{
			//设置位置&角度
			SetPlayerPos( playerid, GYM_BENCH_POS[machineid][0], GYM_BENCH_POS[machineid][1], GYM_BENCH_POS[machineid][ 2 ] );
			SetPlayerFacingAngle( playerid, GYM_BENCH_POS[machineid][3]);
			
			//镜头
			GYM_CAM_TooglePlayerCamera(playerid,true,machinetype,machineid);
			//动作
			GYM_ANIM_applyAnimationON(playerid,machinetype);
		}
		
	}
	
	
}
stock GYM_PlayerGetOffMachine(playerid,machinetype,machineid)
{
	if(!GYM_IsPlayerInAnimation[playerid])
	{
		print("GYM_PlayerGetOffMachine");
					
		GYM_IsPlayerInAnimation[playerid] = true;
		//动作
		GYM_ANIM_applyAnimationOFF(playerid,machinetype);
		switch (machinetype)
		{
			case GYM_RunningMachine: // 跑步机
			{
				SetTimerEx( "GYM_PlayerResetStatus", 3000, false, "iii",playerid,machinetype,machineid);
			}
			case GYM_BikeMachine: // 单车
			{
				
				SetTimerEx( "GYM_PlayerResetStatus", 2000, false, "iii",playerid,machinetype,machineid);
			}
			case GYM_Bench:
			{
				SetTimerEx( "GYM_PlayerResetStatus", 3000, false, "iii",playerid,machinetype,machineid);
			}
				
		}
	}
	
}
//设置状态
forward GYM_PlayerResetStatus(playerid,machinetype,machineid);
public GYM_PlayerResetStatus(playerid,machinetype,machineid)
{
	GYM_CAM_TooglePlayerCamera(playerid,false,machinetype,machineid);
	GYM_ANIM_reset(playerid,machinetype);
	
	PlayerGym[playerid][MachineID] = GYM_MACHINE_NONE;
	PlayerGym[playerid][MachineType] = GYM_MACHINE_NONE;
	PlayerGym[playerid][IsInGym] = false;
	GYM_IsPlayerInAnimation[playerid] = false;
	GYM_setMachineavaiable(machinetype,machineid,true);
	
	Streamer_Update(playerid);
	CallRemoteFunction("TooglePlayerCMD","iis",playerid,false,"ExitGym");
	print("GYM_PlayerResetStatus");
}
