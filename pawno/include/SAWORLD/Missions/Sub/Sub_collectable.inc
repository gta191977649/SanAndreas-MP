#define     COLLECTIBLE_REWARD      (250)   	// $250 for each collectible collected
#define     COMPLETION_REWARD       (15000) 	// $15000 reward if somebody collects all collectibles of one type

enum    _:E_COLLECTIBLE_DIALOG
{
	DIALOG_COLLECTIBLES_MENU = 24555,
	DIALOG_COLLECTIBLES_PROGRESS,
	DIALOG_COLLECTIBLES_PROGRESS_2,
	DIALOG_COLLECTIBLES_RESET,
	DIALOG_COLLECTIBLES_RESET_2
}

enum    E_COLLECTIBLE_TYPE
{
	typeName[16],
	typeModel
}

enum    E_COLLECTIBLE
{
	colType,
	Float: colX,
	Float: colY,
	Float: colZ,
	colPickup
}

enum    _:E_COLLECTIBLE_TYPE_REF
{
	TYPE_OYSTER,    // reference to CollectibleTypes index 0
	TYPE_HORSESHOE  // reference to CollectibleTypes index 1
}

new
	CollectibleTypes[][E_COLLECTIBLE_TYPE] = {
	//  {name, model id}
	    {"Oyster", 953},    // index 0
		{"Horseshoe", 954}  // index 1
	};

new
	CollectibleData[][E_COLLECTIBLE] = {
	//  {type, pos x, pos y, pos z}
	    {TYPE_HORSESHOE, 1224.0, 2617.0, 11.0},
		{TYPE_HORSESHOE, 2323.0, 1284.0, 97.0},
		{TYPE_HORSESHOE, 2035.0, 2305.0, 18.0},
		{TYPE_HORSESHOE, 2491.0, 2263.0, 15.0},
		{TYPE_HORSESHOE, 1433.0, 2796.0, 20.0},
		{TYPE_HORSESHOE, 2071.0, 712.0, 11.0},
		{TYPE_HORSESHOE, 2239.0, 1839.0, 18.0},
		{TYPE_HORSESHOE, 2583.0, 2387.0, 16.0},
		{TYPE_HORSESHOE, 2864.0, 857.0, 13.0},
		{TYPE_HORSESHOE, 2612.0, 2200.0, -1.0},
		{TYPE_HORSESHOE, 2274.0, 1507.0, 24.0},
		{TYPE_HORSESHOE, 2184.0, 2529.0, 11.0},
		{TYPE_HORSESHOE, 1863.0, 2314.0, 15.0},
		{TYPE_HORSESHOE, 2054.0, 2434.0, 166.0},
		{TYPE_HORSESHOE, 1603.0, 1435.0, 11.0},
		{TYPE_HORSESHOE, 1362.92, 1015.24, 11.0},
		{TYPE_HORSESHOE, 2058.7, 2159.1, 16.0},
		{TYPE_HORSESHOE, 2003.0, 1672.0, 12.0},
		{TYPE_HORSESHOE, 2238.0, 1135.0, 49.0},
		{TYPE_HORSESHOE, 1934.06, 988.79, 22.0},
		{TYPE_HORSESHOE, 1768.0, 2847.0, 9.0},
		{TYPE_HORSESHOE, 1084.0, 1076.0, 11.0},
		{TYPE_HORSESHOE, 2879.0, 2522.0, 11.0},
		{TYPE_HORSESHOE, 2371.0, 2009.0, 15.0},
		{TYPE_HORSESHOE, 1521.0, 1690.0, 10.6},
		{TYPE_HORSESHOE, 2417.0, 1281.0, 21.0},
		{TYPE_HORSESHOE, 1376.0, 2304.0, 15.0},
		{TYPE_HORSESHOE, 1393.0, 1832.0, 12.34},
		{TYPE_HORSESHOE, 984.0, 2563.0, 12.0},
		{TYPE_HORSESHOE, 1767.0, 601.0, 13.0},
		{TYPE_HORSESHOE, 2108.0, 1003.0, 46.0},
		{TYPE_HORSESHOE, 2705.98, 1862.52, 24.41},
		{TYPE_HORSESHOE, 2493.0, 922.0, 16.0},
		{TYPE_HORSESHOE, 1881.0, 2846.0, 11.0},
		{TYPE_HORSESHOE, 2020.0, 2352.0, 11.0},
		{TYPE_HORSESHOE, 1680.3, 2226.86, 16.11},
		{TYPE_HORSESHOE, 1462.0, 936.0, 10.0},
		{TYPE_HORSESHOE, 2125.5, 789.23, 11.45},
		{TYPE_HORSESHOE, 2588.0, 1902.0, 15.0},
		{TYPE_HORSESHOE, 919.0, 2070.0, 11.0},
		{TYPE_HORSESHOE, 2173.0, 2465.0, 11.0},
		{TYPE_HORSESHOE, 2031.25, 2207.33, 11.0},
		{TYPE_HORSESHOE, 2509.0, 1144.0, 19.0},
		{TYPE_HORSESHOE, 2215.0, 1968.0, 11.0},
		{TYPE_HORSESHOE, 2626.0, 2841.0, 11.0},
		{TYPE_HORSESHOE, 2440.08, 2161.07, 20.0},
		{TYPE_HORSESHOE, 1582.0, 2401.0, 19.0},
		{TYPE_HORSESHOE, 2077.0, 1912.0, 14.0},
		{TYPE_HORSESHOE, 970.0, 1787.0, 11.0},
		{TYPE_HORSESHOE, 1526.22, 751.0, 29.04},
		{TYPE_OYSTER, 979.0, -2210.0, -3.0},
		{TYPE_OYSTER, 2750.0, -2584.0, -5.0},
		{TYPE_OYSTER, 1279.0, -806.0, 85.0},
		{TYPE_OYSTER, 2945.13, -2051.93, -3.0},
		{TYPE_OYSTER, 67.0, -1018.0, -5.0},
		{TYPE_OYSTER, 2327.0, -2662.0, -5.0},
		{TYPE_OYSTER, 2621.0, -2506.0, -5.0},
		{TYPE_OYSTER, 1249.0, -2687.0, -1.0},
		{TYPE_OYSTER, 725.0, -1849.0, -5.0},
		{TYPE_OYSTER, 723.0, -1586.0, -3.0},
		{TYPE_OYSTER, 155.0, -1975.0, -8.0},
		{TYPE_OYSTER, 1968.0, -1203.0, 17.0},
		{TYPE_OYSTER, -2657.0, 1564.0, -6.0},
		{TYPE_OYSTER, -1252.0, 501.0, -8.0},
		{TYPE_OYSTER, -1625.0, 4.0, -10.0},
		{TYPE_OYSTER, -1484.0, 1489.0, -10.0},
		{TYPE_OYSTER, -2505.406, 1543.724, -22.5553},
		{TYPE_OYSTER, -2727.0, -469.0, -5.0},
		{TYPE_OYSTER, -1266.0, 966.0, -10.0},
		{TYPE_OYSTER, -1013.0, 478.0, -7.0},
		{TYPE_OYSTER, -1364.0, 390.0, -5.0},
		{TYPE_OYSTER, 2578.0, 2382.0, 16.0},
		{TYPE_OYSTER, 2090.0, 1898.0, 8.0},
		{TYPE_OYSTER, 2130.0, 1152.0, 7.0},
		{TYPE_OYSTER, 2013.0, 1670.0, 7.0},
		{TYPE_OYSTER, 2531.0, 1569.0, 9.0},
		{TYPE_OYSTER, 2998.0, 2998.0, -10.0},
		{TYPE_OYSTER, -832.0, 925.0, -2.0},
		{TYPE_OYSTER, 486.0, -253.0, -4.0},
		{TYPE_OYSTER, -90.0, -910.0, -5.0},
		{TYPE_OYSTER, 26.43, -1320.94, -10.04},
		{TYPE_OYSTER, -207.0, -1682.0, -8.0},
		{TYPE_OYSTER, -1672.0, -1641.0, -2.0},
		{TYPE_OYSTER, -1175.0, -2639.0, -2.5},
		{TYPE_OYSTER, -1097.0, -2858.0, -8.0},
		{TYPE_OYSTER, -2889.0, -1042.0, -9.0},
		{TYPE_OYSTER, -659.0, 874.0, -2.0},
		{TYPE_OYSTER, -955.0, 2628.0, 35.0},
		{TYPE_OYSTER, -1066.0, 2197.0, 32.0},
		{TYPE_OYSTER, 40.0, -531.0, -8.0},
		{TYPE_OYSTER, -765.0, 247.0, -8.0},
		{TYPE_OYSTER, 2098.0, -108.0, -2.0},
		{TYPE_OYSTER, 2767.0, 470.0, -8.0},
		{TYPE_OYSTER, -783.0, 2116.0, 35.0},
		{TYPE_OYSTER, -821.0, 1374.0, -8.0},
		{TYPE_OYSTER, -2110.5, 2329.72, -7.5},
		{TYPE_OYSTER, -1538.0, 1708.0, -3.27},
		{TYPE_OYSTER, -2685.0, 2153.0, -5.0},
		{TYPE_OYSTER, 796.0, 2939.0, -5.0},
		{TYPE_OYSTER, 2179.0, 235.0, -5.0}
	};

new
	CollectiblePicked[MAX_PLAYERS][ sizeof(CollectibleData) ];

new
	DB: CollectibleDB,
	DBStatement: LoadProgress,
	DBStatement: SaveProgress,
	DBStatement: ResetProgress;

ReturnPlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

GetCollectedCount(playerid, type)
{
	new count = 0;
	for(new i; i < sizeof(CollectibleData); i++) if(CollectibleData[i][colType] == type && CollectiblePicked[playerid][i] > 0) count++;
	return count;
}

GetCollectibleCount(type)
{
	new count = 0;
	for(new i; i < sizeof(CollectibleData); i++) if(CollectibleData[i][colType] == type) count++;
	return count;
}

LoadPlayerProgress(playerid)
{
    for(new i; i < sizeof(CollectibleData); i++) CollectiblePicked[playerid][i] = 0;
    
    new id;
    stmt_bind_value(LoadProgress, 0, DB::TYPE_STRING, ReturnPlayerName(playerid));
    stmt_bind_result_field(LoadProgress, 0, DB::TYPE_INTEGER, id);
    
    if(stmt_execute(LoadProgress) && stmt_rows_left(LoadProgress) > 0) while(stmt_fetch_row(LoadProgress)) CollectiblePicked[playerid][id] = 1;
	return 1;
}

ShowMenu(playerid, menu_id = DIALOG_COLLECTIBLES_MENU, extra_id = -1)
{
	switch(menu_id)
	{
	    case DIALOG_COLLECTIBLES_PROGRESS:
	    {
	        new string[196];
	        format(string, sizeof(string), "Type\tCollected\tTotal\n");
	        for(new i; i < sizeof(CollectibleTypes); i++) format(string, sizeof(string), "%s%s\t%d\t%d\n", string, CollectibleTypes[i][typeName], GetCollectedCount(playerid, i), GetCollectibleCount(i));
	        ShowPlayerDialog(playerid, menu_id, DIALOG_STYLE_TABLIST_HEADERS, "Collectibles {FFFFFF}Progress", string, "Select", "Back");
		}
		
		case DIALOG_COLLECTIBLES_PROGRESS_2:
	    {
			new string[2048], col_name[16], title[36];
			format(col_name, sizeof(col_name), "%s", CollectibleTypes[extra_id][typeName]);
			format(title, sizeof(title), "Collectibles {FFFFFF}%ss", col_name);

			for(new i, idx; i < sizeof(CollectibleData); i++)
			{
			    if(CollectibleData[i][colType] != extra_id) continue;
			    format(string, sizeof(string), "%s%s %d\t%s\n", string, col_name, idx + 1, (CollectiblePicked[playerid][i]) ? ("{2ECC71}Collected") : ("{E74C3C}Not Collected"));
			    idx++;
			}
			
	        ShowPlayerDialog(playerid, menu_id, DIALOG_STYLE_TABLIST, title, string, "Back", "");
		}
		
		case DIALOG_COLLECTIBLES_RESET:
		{
		    new string[196];
  			for(new i; i < sizeof(CollectibleTypes); i++) format(string, sizeof(string), "%sReset %s Progress\n", string, CollectibleTypes[i][typeName]);
		    ShowPlayerDialog(playerid, menu_id, DIALOG_STYLE_LIST, "Collectibles {FFFFFF}Reset", string, "Continue", "Back");
		}
		
		case DIALOG_COLLECTIBLES_RESET_2:
		{
		    new string[128];
		    format(string, sizeof(string), "{FFFFFF}Do you want to reset your {F1C40F}%s {FFFFFF}progress?\n\n{E74C3C}It will be gone forever!", CollectibleTypes[extra_id][typeName]);
		    ShowPlayerDialog(playerid, menu_id, DIALOG_STYLE_MSGBOX, "Collectibles {FFFFFF}Reset", string, "Reset", "Back");
		}
		
		default:
		{
		    ShowPlayerDialog(playerid, menu_id, DIALOG_STYLE_LIST, "Collectibles", "My Progress\nReset Progress", "Select", "Close");
		}
	}
	
	return 1;
}
static gCollectable_HasCB[3];

//--------------OnGameModeInit Hook-------------------

public OnGameModeInit()
{
	//your OnGameModeInit pre code here
	
	for(new i; i < sizeof(CollectibleData); i++) CollectibleData[i][colPickup] = CreatePickup(CollectibleTypes[ CollectibleData[i][colType] ][typeModel], 1, CollectibleData[i][colX], CollectibleData[i][colY], CollectibleData[i][colZ], -1);

	/*
	// db
	
	CollectibleDB = db_open("collectibles.db");
	db_query(CollectibleDB, "CREATE TABLE IF NOT EXISTS player_data (Player TEXT, CollectibleID INTEGER, CollectibleType INTEGER)");
	*/
	
	
	
	// prepare queries
	LoadProgress = db_prepare(CollectibleDB, "SELECT CollectibleID FROM player_data WHERE Player=?");
	SaveProgress = db_prepare(CollectibleDB, "INSERT INTO player_data (Player, CollectibleID, CollectibleType) VALUES (?, ?, ?)");
	ResetProgress = db_prepare(CollectibleDB, "DELETE FROM player_data WHERE Player=? AND CollectibleType=?");
	
	// load data for connected players
	for(new i, maxp = GetPlayerPoolSize(); i <= maxp; i++) if(IsPlayerConnected(i)) LoadPlayerProgress(i);
	//function hook checks

	gCollectable_HasCB[0] = funcidx("Collectable_OnDialogResponse") != -1;
	gCollectable_HasCB[1] = funcidx("Collectable_OnPlayerConnect") != -1;
	gCollectable_HasCB[2] = funcidx("Collectable_OnPlayerPickUpPickup") != -1;
	if (funcidx("Collectable_OnGameModeInit") != -1)
	{
		return CallLocalFunction("Collectable_OnGameModeInit", "");
	}
	//your OnGameModeInit post code here

	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Collectable_OnGameModeInit
forward Collectable_OnGameModeInit();



//--------------OnDialogResponse Hook-------------------

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	//your OnDialogResponse code here
	switch(dialogid)
	{
	    case DIALOG_COLLECTIBLES_MENU:
	    {
	        if(!response) return 1;
			if(listitem == 0) return ShowMenu(playerid, DIALOG_COLLECTIBLES_PROGRESS);
			if(listitem == 1) return ShowMenu(playerid, DIALOG_COLLECTIBLES_RESET);
	    }
	    
	    case DIALOG_COLLECTIBLES_PROGRESS:
	    {
	        if(!response) return ShowMenu(playerid);
	        ShowMenu(playerid, DIALOG_COLLECTIBLES_PROGRESS_2, listitem);
	        return 1;
	    }
	    
	    case DIALOG_COLLECTIBLES_PROGRESS_2:
	    {
	        ShowMenu(playerid, DIALOG_COLLECTIBLES_PROGRESS);
	        return 1;
	    }
	    
	    case DIALOG_COLLECTIBLES_RESET:
	    {
	        if(!response) return ShowMenu(playerid);
	        SetPVarInt(playerid, "progResetType", listitem);
			ShowMenu(playerid, DIALOG_COLLECTIBLES_RESET_2, listitem);
	        return 1;
	    }
	    
	    case DIALOG_COLLECTIBLES_RESET_2:
	    {
	        if(!response) return ShowMenu(playerid, DIALOG_COLLECTIBLES_RESET);
	        new res_type = GetPVarInt(playerid, "progResetType");
	        
	        stmt_bind_value(ResetProgress, 0, DB::TYPE_STRING, ReturnPlayerName(playerid));
	        stmt_bind_value(ResetProgress, 1, DB::TYPE_INTEGER, res_type);
	        
	        if(stmt_execute(ResetProgress)) {
	            for(new i; i < sizeof(CollectibleData); i++) if(CollectibleData[i][colType] == res_type) CollectiblePicked[playerid][i] = 0;
	            
				new string[64];
				format(string, sizeof(string), "%s {FFFFFF}progress reset.", CollectibleTypes[res_type][typeName]);
		        SendClientMessage(playerid, 0xF1C40FFF, string);
	        }else{
	            SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Couldn't reset progress.");
	        }
	        
	        return 1;
	    }
	}
	
	if (gCollectable_HasCB[0])
	{
		return CallLocalFunction("Collectable_OnDialogResponse", "iiiis",playerid, dialogid, response, listitem, inputtext[0] ? inputtext : "\1\0");
	}
	return 1;
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif
#define OnDialogResponse Collectable_OnDialogResponse
forward Collectable_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);



//--------------OnPlayerConnect Hook-------------------

public OnPlayerConnect(playerid)
{
	//your OnPlayerConnect code here
	LoadPlayerProgress(playerid);
	
	if (gCollectable_HasCB[1])
	{
		return CallLocalFunction("Collectable_OnPlayerConnect", "i",playerid);
	}
	return 1;
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Collectable_OnPlayerConnect
forward Collectable_OnPlayerConnect(playerid);



//--------------OnPlayerPickUpPickup Hook-------------------

public OnPlayerPickUpPickup(playerid, pickupid)
{
	//your OnPlayerPickUpPickup code here
	for(new i; i < sizeof(CollectibleData); i++)
	{
	    if(pickupid == CollectibleData[i][colPickup])
	    {
	        if(!CollectiblePicked[playerid][i])
			{
			    stmt_bind_value(SaveProgress, 0, DB::TYPE_STRING, ReturnPlayerName(playerid));
				stmt_bind_value(SaveProgress, 1, DB::TYPE_INTEGER, i);
				stmt_bind_value(SaveProgress, 2, DB::TYPE_INTEGER, CollectibleData[i][colType]);
				
				if(stmt_execute(SaveProgress)) {
		            CollectiblePicked[playerid][i] = 1;

		            new string[80], type = CollectibleData[i][colType], collected = GetCollectedCount(playerid, type), max_col = GetCollectibleCount(type);
		            format(string, sizeof(string), "~w~%ss %d out of %d", CollectibleTypes[type][typeName] , collected, max_col);
	                GameTextForPlayer(playerid, string, 5000, 3);
	                GivePlayerMoney(playerid, COLLECTIBLE_REWARD);

	                if(collected == max_col)
					{
					    format(string, sizeof(string), "Congratulations! You collected every {F1C40F}%s {FFFFFF}around the map.", CollectibleTypes[type][typeName]);
					    SendClientMessage(playerid, -1, string);

					    format(string, sizeof(string), "Here's your well earned {2ECC71}$%d.", COMPLETION_REWARD);
					    SendClientMessage(playerid, -1, string);

					    GivePlayerMoney(playerid, COMPLETION_REWARD);
					}
				}else{
                    SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Couldn't collect collectible.");
    			}
			}
	        
	        break;
	    }
	}
	
	if (gCollectable_HasCB[2])
	{
		return CallLocalFunction("Collectable_OnPlayerPickUpPickup", "ii",playerid, pickupid);
	}
	return 1;
}
#if defined _ALS_OnPlayerPickUpPickup
	#undef OnPlayerPickUpPickup
#else
	#define _ALS_OnPlayerPickUpPickup
#endif
#define OnPlayerPickUpPickup Collectable_OnPlayerPickUpPickup
forward Collectable_OnPlayerPickUpPickup(playerid, pickupid);

CMD:collectibles(playerid, params[])
{
	ShowMenu(playerid);
	return 1;
}

