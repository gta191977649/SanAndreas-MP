forward OnCarShopDrive();
public OnCarShopDrive()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			if(CarShop_IsPlayerInMission(i) && !CarShop_PlayerIsFinished(i)) 
			{
			
				if(IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER)
				{
					if(CarShop_VehicleIsVaild(i))
					{
						new Float:Speed = GetVehicleSpeed(GetPlayerVehicleID(i));
						switch (CarShop_PlayerGetVehType(i))
						{
							case VEHICLE_FAST:
							{
								if(Speed > VMIN_FAST) CarShop_UpdaterIncreaseVal(i);
								else
								{
									CarShop_UpdaterDecreaseVal(i);
									SG_Sub(i,TEXT_MISSION_DRIVE_2SLOW,2);
								}
							}
							case VEHICLE_SLOW:
							{
								if(Speed > VMIN_SLOW && Speed < VMAX_SLOW) CarShop_UpdaterIncreaseVal(i);
								else 
								{
									CarShop_UpdaterDecreaseVal(i);
									SG_Sub(i,TEXT_MISSION_DRIVE_2FAST,2);
									if(Speed < VMIN_SLOW) SG_Sub(i,TEXT_MISSION_DRIVE_2SLOW,2);
										
								}
							}
						}
						//判断是否结束
						if(CarShop_GetPlayerProg(i) >= 100)
						{
							CarShop_UpdateSaleFinished(i);
						}
					}
				}
			}
		}
	}
}

stock CarShop_UpdateSaleFinished(playerid)
{
	CarShop_PlayerSetFininsh(playerid,true);
	CarShop_PlayerSetCPBack(playerid);
	//消除UI
	CarShop_PlayerDestoryUI(playerid);
	//提示玩家
	SG_Sub(playerid,TEXT_MISSION_DRIVE_BACK,5);
	
}

stock CarShop_UpdaterIncreaseVal(playerid)
{
	CarShop_SetPlayerProg(playerid,CarShop_GetPlayerProg(playerid)+ADD_VAL);
}
stock CarShop_UpdaterDecreaseVal(playerid)
{
	CarShop_SetPlayerProg(playerid,CarShop_GetPlayerProg(playerid)-ADD_VAL);
}
