//计算相对位置
stock GYM_CAM_setRelatePos(playerid,Float:x1,Float:y1,Float:z1,Float:angle,Float:len)
{
	SetPlayerCameraPos( playerid,x1 - (len * floatsin(angle,degrees)),y1 + (len * floatcos(angle,degrees)),z1 + 0.5 );
}

forward GYM_CAM_TooglePlayerCamera(playerid,toogle,machinetype,machineID);
public GYM_CAM_TooglePlayerCamera(playerid,toogle,machinetype,machineID)
{
	if(toogle)
	{
		TogglePlayerControllable(playerid,0);
		switch(machinetype)
		{
			case GYM_RunningMachine:
			{
				SetPlayerCameraPos( playerid, GYM_RM_POS[machineID][0] +2, GYM_RM_POS[machineID][1] -2, GYM_RM_POS[machineID][2] + 0.5);
				SetPlayerCameraLookAt( playerid, GYM_RM_POS[machineID][0], GYM_RM_POS[machineID][1], GYM_RM_POS[machineID][2]);
			}
			case GYM_BikeMachine:
			{
				SetPlayerCameraPos( playerid, GYM_BIKE_POS[machineID][0] +2, GYM_BIKE_POS[machineID][1] -2, GYM_BIKE_POS[machineID][2] + 0.5 );
				SetPlayerCameraLookAt( playerid, GYM_BIKE_POS[machineID][0], GYM_BIKE_POS[machineID][1], GYM_BIKE_POS[machineID][2]+0.5);
			}
			case GYM_Bench:
			{
				//SetPlayerCameraPos( playerid, GYM_BENCH_POS[machineID][ 0 ]-1.5, GYM_BENCH_POS[machineID][ 1 ]+1.5, GYM_BENCH_POS[machineID][ 2 ] + 0.5 );
				GYM_CAM_setRelatePos(playerid,GYM_BENCH_POS[machineID][0],GYM_BENCH_POS[machineID][1],GYM_BENCH_POS[machineID][2],GYM_BENCH_POS[machineID][3]-180,2);
				SetPlayerCameraLookAt(playerid,GYM_BENCH_POS[machineID][0],GYM_BENCH_POS[machineID][1],GYM_BENCH_POS[machineID][2]);
			}
		}

	}
	else
	{
		TogglePlayerControllable(playerid,1);
		SetCameraBehindPlayer(playerid );
	}
}