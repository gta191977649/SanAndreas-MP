/* SA:MP PAWN Debug -
*  Debugging Filterscript used
*  for creation of gamemode.
*
*  Simon Campbell
*  10/03/2007, 6:31pm
* EDITED FOR MOVIEMAKERMOD BY LJ
*/

//==============================================================================

#include <a_samp>

#undef KEY_UP
#undef KEY_DOWN
#undef KEY_LEFT
#undef KEY_RIGHT

new limit[200];
forward reset(playerid);

#define KEY_UP  	65408
#define KEY_DOWN	128
#define KEY_LEFT    65408
#define KEY_RIGHT   128

#define DEBUG_VERSION   "0.5c"

#define SKIN_SELECT   	true
#define	VEHI_SELECT   	true
#define WORL_SELECT     true
#define CAME_SELECT     true
#define OBJE_SELECT		true

#define MISCEL_CMDS     true
#define ADMINS_ONLY     false

#define SKIN_SEL_STAT   1
#define VEHI_SEL_STAT   2
#define WORL_SEL_STAT   3
#define CAME_SEL_STAT   4
#define OBJE_SEL_STAT	5

#define COLOR_RED   	0xFF4040FF
#define COLOR_GREEN 	0x40FF40FF
#define COLOR_BLUE  	0x4040FFFF
#define COLOR_PURPLE    0xC2A2DAAA

#define COLOR_CYAN  	0x40FFFFFF
#define COLOR_PINK  	0xFF40FFFF
#define COLOR_YELLOW    0xFFFF40FF

#define COLOR_WHITE		0xFFFFFFFF
#define COLOR_BLACK		0x000000FF
#define COLOR_NONE      0x00000000

#define MIN_SKIN_ID		0
#define MAX_SKIN_ID		299

#define MIN_VEHI_ID		400
#define MAX_VEHI_ID		611

#define MIN_TIME_ID		0
#define MAX_TIME_ID		23

#define MIN_WEAT_ID     0
#define MAX_WEAT_ID		45

#define MIN_OBJE_ID		615
#define MAX_OBJE_ID		13563

#define DEFAULT_GRA     0.008

#define VEHI_DIS        5.0
#define OBJE_DIS		10.0

#define CMODE_A			0
#define CMODE_B			1

#define O_MODE_SELECTOR	0
#define O_MODE_MOVER	1
#define O_MODE_ROTATOR	2

#define PI				3.14159265

#define CAMERA_TIME     40

#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

//==============================================================================

new gPlayerStatus[MAX_PLAYERS]; // Player Status
new gPlayerTimers[MAX_PLAYERS]; // Player TimerID's for keypresses
new gWorldStatus[3] =  {12, 4}; // Time, Weather

new curPlayerSkin[MAX_PLAYERS]				= {MIN_SKIN_ID, ...}; // Current Player Skin ID
new curPlayerVehM[MAX_PLAYERS]				= {MIN_VEHI_ID, ...}; // Current Player Vehicle ID
new curPlayerVehI[MAX_PLAYERS]				= {-1, ...};

new VLimit[MAX_PLAYERS] = 5;
new World[MAX_PLAYERS] = 0;
new v1[MAX_PLAYERS] = 0;
new v2[MAX_PLAYERS] = 0;
new v3[MAX_PLAYERS] = 0;
new v4[MAX_PLAYERS] = 0;
new v5[MAX_PLAYERS] = 0;
new vi1[MAX_PLAYERS] = 0;
new vi2[MAX_PLAYERS] = 0;
new vi3[MAX_PLAYERS] = 0;
new vi4[MAX_PLAYERS] = 0;
new vi5[MAX_PLAYERS] = 0;
new newskin[MAX_PLAYERS] = 0;
new skinchange[MAX_PLAYERS] = 0;

enum E_OBJECT
{
	OBJ_MOD,
	OBJ_MDL,
	Float:OBJ_X,
	Float:OBJ_Y,
	Float:OBJ_Z,
	Float:OBJ_RX,
	Float:OBJ_RY,
	Float:OBJ_RZ
}

enum E_OBJ_RATE
{
	Float:OBJ_RATE_ROT,
	Float:OBJ_RATE_MOVE
}

new pObjectRate[ MAX_PLAYERS ][ E_OBJ_RATE ];
new curPlayerObjM[ MAX_PLAYERS ][ E_OBJECT ];
new curPlayerObjI[ MAX_PLAYERS ]				= {-1, ...};

enum P_CAMERA_D {
	CMODE,
	Float:RATE,
	Float:CPOS_X,
	Float:CPOS_Y,
	Float:CPOS_Z,
	Float:CLOO_X,
	Float:CLOO_Y,
	Float:CLOO_Z
};

new curPlayerCamD[MAX_PLAYERS][P_CAMERA_D];

enum CURVEHICLE {
	bool:spawn,
	vmodel,
	vInt
};

new curServerVehP[MAX_VEHICLES][CURVEHICLE];

new aSelNames[5][] = {			// Menu selection names
	{"SkinSelect"},
	{"VehicleSelect"},
	{"WeatherSelect"},
	{"CameraSelect"},
	{"ObjectSelect"}
};

new aWeaponNames[][32] = {
	{"Unarmed (Fist)"}, // 0
	{"Brass Knuckles"}, // 1
	{"Golf Club"}, // 2
	{"Night Stick"}, // 3
	{"Knife"}, // 4
	{"Baseball Bat"}, // 5
	{"Shovel"}, // 6
	{"Pool Cue"}, // 7
	{"Katana"}, // 8
	{"Chainsaw"}, // 9
	{"Purple Dildo"}, // 10
	{"Big White Vibrator"}, // 11
	{"Medium White Vibrator"}, // 12
	{"Small White Vibrator"}, // 13
	{"Flowers"}, // 14
	{"Cane"}, // 15
	{"Grenade"}, // 16
	{"Teargas"}, // 17
	{"Molotov"}, // 18
	{" "}, // 19
	{" "}, // 20
	{" "}, // 21
	{"Colt 45"}, // 22
	{"Colt 45 (Silenced)"}, // 23
	{"Desert Eagle"}, // 24
	{"Normal Shotgun"}, // 25
	{"Sawnoff Shotgun"}, // 26
	{"Combat Shotgun"}, // 27
	{"Micro Uzi (Mac 10)"}, // 28
	{"MP5"}, // 29
	{"AK47"}, // 30
	{"M4"}, // 31
	{"Tec9"}, // 32
	{"Country Rifle"}, // 33
	{"Sniper Rifle"}, // 34
	{"Rocket Launcher"}, // 35
	{"Heat-Seeking Rocket Launcher"}, // 36
	{"Flamethrower"}, // 37
	{"Minigun"}, // 38
	{"Satchel Charge"}, // 39
	{"Detonator"}, // 40
	{"Spray Can"}, // 41
	{"Fire Extinguisher"}, // 42
	{"Camera"}, // 43
	{"Night Vision Goggles"}, // 44
	{"Infrared Vision Goggles"}, // 45
	{"Parachute"}, // 46
	{"Fake Pistol"} // 47
};


new aVehicleNames[212][] = {	// Vehicle Names - Betamaster
	{"Landstalker"},
	{"Bravura"},
	{"Buffalo"},
	{"Linerunner"},
	{"Perrenial"},
	{"Sentinel"},
	{"Dumper"},
	{"Firetruck"},
	{"Trashmaster"},
	{"Stretch"},
	{"Manana"},
	{"Infernus"},
	{"Voodoo"},
	{"Pony"},
	{"Mule"},
	{"Cheetah"},
	{"Ambulance"},
	{"Leviathan"},
	{"Moonbeam"},
	{"Esperanto"},
	{"Taxi"},
	{"Washington"},
	{"Bobcat"},
	{"Mr Whoopee"},
	{"BF Injection"},
	{"Hunter"},
	{"Premier"},
	{"Enforcer"},
	{"Securicar"},
	{"Banshee"},
	{"Predator"},
	{"Bus"},
	{"Rhino"},
	{"Barracks"},
	{"Hotknife"},
	{"Trailer 1"}, //artict1
	{"Previon"},
	{"Coach"},
	{"Cabbie"},
	{"Stallion"},
	{"Rumpo"},
	{"RC Bandit"},
	{"Romero"},
	{"Packer"},
	{"Monster"},
	{"Admiral"},
	{"Squalo"},
	{"Seasparrow"},
	{"Pizzaboy"},
	{"Tram"},
	{"Trailer 2"}, //artict2
	{"Turismo"},
	{"Speeder"},
	{"Reefer"},
	{"Tropic"},
	{"Flatbed"},
	{"Yankee"},
	{"Caddy"},
	{"Solair"},
	{"Berkley's RC Van"},
	{"Skimmer"},
	{"PCJ-600"},
	{"Faggio"},
	{"Freeway"},
	{"RC Baron"},
	{"RC Raider"},
	{"Glendale"},
	{"Oceanic"},
	{"Sanchez"},
	{"Sparrow"},
	{"Patriot"},
	{"Quad"},
	{"Coastguard"},
	{"Dinghy"},
	{"Hermes"},
	{"Sabre"},
	{"Rustler"},
	{"ZR-350"},
	{"Walton"},
	{"Regina"},
	{"Comet"},
	{"BMX"},
	{"Burrito"},
	{"Camper"},
	{"Marquis"},
	{"Baggage"},
	{"Dozer"},
	{"Maverick"},
	{"News Chopper"},
	{"Rancher"},
	{"FBI Rancher"},
	{"Virgo"},
	{"Greenwood"},
	{"Jetmax"},
	{"Hotring"},
	{"Sandking"},
	{"Blista Compact"},
	{"Police Maverick"},
	{"Boxville"},
	{"Benson"},
	{"Mesa"},
	{"RC Goblin"},
	{"Hotring Racer A"}, //hotrina
	{"Hotring Racer B"}, //hotrinb
	{"Bloodring Banger"},
	{"Rancher"},
	{"Super GT"},
	{"Elegant"},
	{"Journey"},
	{"Bike"},
	{"Mountain Bike"},
	{"Beagle"},
	{"Cropdust"},
	{"Stunt"},
	{"Tanker"}, //petro
	{"Roadtrain"},
	{"Nebula"},
	{"Majestic"},
	{"Buccaneer"},
	{"Shamal"},
	{"Hydra"},
	{"FCR-900"},
	{"NRG-500"},
	{"HPV1000"},
	{"Cement Truck"},
	{"Tow Truck"},
	{"Fortune"},
	{"Cadrona"},
	{"FBI Truck"},
	{"Willard"},
	{"Forklift"},
	{"Tractor"},
	{"Combine"},
	{"Feltzer"},
	{"Remington"},
	{"Slamvan"},
	{"Blade"},
	{"Freight"},
	{"Streak"},
	{"Vortex"},
	{"Vincent"},
	{"Bullet"},
	{"Clover"},
	{"Sadler"},
	{"Firetruck LA"}, //firela
	{"Hustler"},
	{"Intruder"},
	{"Primo"},
	{"Cargobob"},
	{"Tampa"},
	{"Sunrise"},
	{"Merit"},
	{"Utility"},
	{"Nevada"},
	{"Yosemite"},
	{"Windsor"},
	{"Monster A"}, //monstera
	{"Monster B"}, //monsterb
	{"Uranus"},
	{"Jester"},
	{"Sultan"},
	{"Stratum"},
	{"Elegy"},
	{"Raindance"},
	{"RC Tiger"},
	{"Flash"},
	{"Tahoma"},
	{"Savanna"},
	{"Bandito"},
	{"Freight Flat"}, //freiflat
	{"Streak Carriage"}, //streakc
	{"Kart"},
	{"Mower"},
	{"Duneride"},
	{"Sweeper"},
	{"Broadway"},
	{"Tornado"},
	{"AT-400"},
	{"DFT-30"},
	{"Huntley"},
	{"Stafford"},
	{"BF-400"},
	{"Newsvan"},
	{"Tug"},
	{"Trailer 3"}, //petrotr
	{"Emperor"},
	{"Wayfarer"},
	{"Euros"},
	{"Hotdog"},
	{"Club"},
	{"Freight Carriage"}, //freibox
	{"Trailer 3"}, //artict3
	{"Andromada"},
	{"Dodo"},
	{"RC Cam"},
	{"Launch"},
	{"Police Car (LSPD)"},
	{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},
	{"Police Ranger"},
	{"Picador"},
	{"S.W.A.T. Van"},
	{"Alpha"},
	{"Phoenix"},
	{"Glendale"},
	{"Sadler"},
	{"Luggage Trailer A"}, //bagboxa
	{"Luggage Trailer B"}, //bagboxb
	{"Stair Trailer"}, //tugstair
	{"Boxville"},
	{"Farm Plow"}, //farmtr1
	{"Utility Trailer"} //utiltr1
};

//==============================================================================

forward SkinSelect(playerid);
forward VehicleSelect(playerid);
forward WorldSelect(playerid);
forward CameraSelect(playerid);
forward ObjectSelect( playerid );

//==============================================================================

dcmd_debug(playerid, params[]) {
	if(strcmp(params, "help", true, 4) == 0) {
		SendClientMessage(playerid, COLOR_BLUE, "[DEBUG]: Debug Mode 0.2 - HELP");
		SendClientMessage(playerid, COLOR_CYAN, "[DEBUG]: Debug Mode 0.2 is a filterscript which allows scripters");
		SendClientMessage(playerid, COLOR_CYAN, "[DEBUG]: or people who wish to explore SA:MP 0.2\'s features to have access");
		SendClientMessage(playerid, COLOR_CYAN, "[DEBUG]: to many commands and \"menu\'s\".");
		SendClientMessage(playerid, COLOR_YELLOW, "[DEBUG]: This filterscript was designed for SA:MP version 0.2");
		SendClientMessage(playerid, COLOR_PINK, "[DEBUG]: For the command list type \"/debug commands\"");

		return true;
	}
	if(strcmp(params, "commands", true, 8) == 0) {
		SendClientMessage(playerid, COLOR_BLUE, "[DEBUG]: Debug Mode 0.2 - COMMANDS");
		SendClientMessage(playerid, COLOR_CYAN, "[WORLD]: /wea, /weather, /t, /time");
		SendClientMessage(playerid, COLOR_CYAN, "[VEHICLES]: /v, /vehicle");
		SendClientMessage(playerid, COLOR_CYAN, "[PLAYER]: /skin, /ssel, /weapon, /w2");
		SendClientMessage(playerid, COLOR_CYAN, "[PLAYER]: /setloc");
		SendClientMessage(playerid, COLOR_CYAN, "[CAMERA]: /camera, /csel");
		
		return true;
	}
	
/*	if(strcmp(params, "dump", true, 4) == 0) {
		SendClientMessage(playerid, COLOR_GREEN, "[SUCCESS]: All current server data dumped to a file.");
		new File:F_DUMP = fopen("DEBUG-DUMP.txt", io_append);
		if(F_DUMP) {
			new h, m, s, Y, M, D, cString[256];
			
			getdate(Y, M, D);
			gettime(h, m, s);
			
			format(cString, 256, "// %d-%d-%d @ %d:%d:%d\r\n", D, M, Y, h, m, s);
			fwrite(F_DUMP, cString);
			
			for(new i = 0; i < MAX_VEHICLES; i++) {
				if(curServerVehP[i][spawn] 	== true) {
					new Float:vx, Float:vy, Float:vz, Float:va;
					GetVehiclePos(i, vx, vy, vz);
					GetVehicleZAngle(i, va);
					format(cString, 256, "CreateVehicle(%d, %f, %f, %f, %f, -1, -1, 5000); // Interior(%d), %s\r\n", curServerVehP[i][vmodel], vx, vy, vz, va, curServerVehP[i][vInt], aVehicleNames[curServerVehP[i][vmodel] - MIN_VEHI_ID]);
					fwrite(F_DUMP, cString);
				}
			}
			print("** Dumped current server information.");
			fclose(F_DUMP);
		}
		else {
			print("** Failed to create the file \"DEBUG-DUMP.txt\".\n");
		}
		return true;
	}*/
	return false;
}

#if CAME_SELECT == true

dcmd_object(playerid, params[])
{
	new cString[ 128 ], idx;
	cString = strtok( params, idx );
	
	if ( !strlen( cString ) || !strlen( params[ idx + 1 ] ) )
	{
		SendClientMessage( playerid, COLOR_WHITE, "[用法]: /object [RRATE/MRATE/CAMERA] [RATE/ID]");
		
		return 1;
	}
	
	if ( strcmp( cString, "rrate", true ) == 0 )
	{
		pObjectRate[ playerid ][ OBJ_RATE_ROT ] = floatstr( params[ idx + 1 ] );
		
		format( cString, 128, "[SUCCESS]: Object rotation rate changed to %f.", pObjectRate[ playerid ][ OBJ_RATE_ROT ] );
		SendClientMessage( playerid, COLOR_GREEN, cString );
		
		return 1;
	}
	
	if ( strcmp( cString, "mrate", true ) == 0 )
	{
		pObjectRate[ playerid ][ OBJ_RATE_MOVE ] = floatstr( params[ idx + 1 ] );
		
		format( cString, 128, "[成功]Obj 移动速度改为 %f.", pObjectRate[ playerid ][ OBJ_RATE_MOVE ] );
		SendClientMessage( playerid, COLOR_GREEN, cString );
		
		return 1;
	}
	
	if ( strcmp( cString, "mode", true ) == 0 )
	{
		new fuck = strval( params[ idx + 1 ] );
		
		if ( fuck >= O_MODE_SELECTOR || fuck <= O_MODE_ROTATOR )
		{
			curPlayerObjM[ playerid ][ OBJ_MOD ] = fuck;
			
			switch ( fuck )
			{
				case O_MODE_SELECTOR: SendClientMessage( playerid, COLOR_GREEN, "[SUCCESS]: Object mode changed to Object Selection." );
				case O_MODE_MOVER: SendClientMessage( playerid, COLOR_GREEN, "[SUCCESS]: Object mode changed to Object Mover." );
				case O_MODE_ROTATOR: SendClientMessage( playerid, COLOR_GREEN, "[SUCCESS]: Object mode changed to Object Rotator." );
			}
			
			return 1;
		}
		else
		{
			SendClientMessage( playerid, COLOR_RED, "[错误]:无效ID." );
			
			return 1;
		}
	}
	
	if ( strcmp( cString, "focus", true ) == 0 )
	{
		new objectid = strval( params[ idx + 1 ] );
		
		if ( !IsValidObject( objectid ) )
		{
			SendClientMessage( playerid, COLOR_RED, "[错误]: 请输入一个有效的OBJ的ID." );
			
			return 1;
		}
		
		else 
		{
			curPlayerObjI[ playerid ] = objectid;
			
			GetObjectPos( objectid, curPlayerObjM[ playerid ][ OBJ_X ], curPlayerObjM[ playerid ][ OBJ_Y ], curPlayerObjM[ playerid ][ OBJ_Z ] );
			GetObjectRot( objectid, curPlayerObjM[ playerid ][ OBJ_RX ], curPlayerObjM[ playerid ][ OBJ_RY ], curPlayerObjM[ playerid ][ OBJ_RZ ] );
			
			curPlayerCamD[playerid][CPOS_X] = curPlayerObjM[ playerid ][ OBJ_X ] + 5.0;
			curPlayerCamD[playerid][CPOS_Y] = curPlayerObjM[ playerid ][ OBJ_Y ] - 20.0;
			curPlayerCamD[playerid][CPOS_Z] = curPlayerObjM[ playerid ][ OBJ_Z ] + 30.0;
			
			curPlayerCamD[playerid][CLOO_X] = curPlayerObjM[ playerid ][ OBJ_X ];
			curPlayerCamD[playerid][CLOO_Y] = curPlayerObjM[ playerid ][ OBJ_Y ];
			curPlayerCamD[playerid][CLOO_Z] = curPlayerObjM[ playerid ][ OBJ_Z ];
			
			if ( gPlayerStatus[ playerid ] == OBJE_SEL_STAT )
			{
				SetPlayerCameraPos( playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z] );
				SetPlayerCameraLookAt( playerid, curPlayerObjM[ playerid ][ OBJ_X ], curPlayerObjM[ playerid ][ OBJ_Y ], curPlayerObjM[ playerid ][ OBJ_Z ] );
			}
			
			return 1;
		}
	}
	
	if ( strcmp( cString, "camera", true ) == 0 )
	{
		new cameraid = strval( params[ idx + 1 ] );
		
		if ( cameraid >= 0 && cameraid < 4 )
		{
			switch ( cameraid )
			{
				case 0:
				{
					curPlayerCamD[playerid][CPOS_X] = curPlayerObjM[ playerid ][ OBJ_X ] + 7.0;
					curPlayerCamD[playerid][CPOS_Y] = curPlayerObjM[ playerid ][ OBJ_Y ] - 20.0;
					curPlayerCamD[playerid][CPOS_Z] = curPlayerObjM[ playerid ][ OBJ_Z ] + 30.0;
				}
				
				case 1:
				{
					curPlayerCamD[playerid][CPOS_X] = curPlayerObjM[ playerid ][ OBJ_X ] + 7.0;
					curPlayerCamD[playerid][CPOS_Y] = curPlayerObjM[ playerid ][ OBJ_Y ] + 15.0;
					curPlayerCamD[playerid][CPOS_Z] = curPlayerObjM[ playerid ][ OBJ_X ] + 15.0;
				}
				
				case 2:
				{
					curPlayerCamD[playerid][CPOS_X] = curPlayerObjM[ playerid ][ OBJ_X ] - 20.0;
					curPlayerCamD[playerid][CPOS_Y] = curPlayerObjM[ playerid ][ OBJ_Y ] + 20.0;
					curPlayerCamD[playerid][CPOS_Z] = curPlayerObjM[ playerid ][ OBJ_X ] + 20.0;
				}
				
				case 3:
				{
					curPlayerCamD[playerid][CPOS_X] = curPlayerObjM[ playerid ][ OBJ_X ] - 10.0;
					curPlayerCamD[playerid][CPOS_Y] = curPlayerObjM[ playerid ][ OBJ_Y ] + 25.0;
					curPlayerCamD[playerid][CPOS_Z] = curPlayerObjM[ playerid ][ OBJ_X ] + 15.0;
				}
			}
			
			SetPlayerCameraPos( playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z] );
			SetPlayerCameraLookAt( playerid, curPlayerObjM[ playerid ][ OBJ_X ], curPlayerObjM[ playerid ][ OBJ_Y ], curPlayerObjM[ playerid ][ OBJ_Z ] );
			
			return 1;
		}
		else
		{
			SendClientMessage( playerid, COLOR_RED, "[错误]: Invalid object camera id.");
			
			return 1;
		}
	}
	return 0;
}

dcmd_osel(playerid, params[])
{
	#pragma unused params
	
	new cString[ 128 ];
	
	if ( gPlayerStatus[ playerid ] != 0 )
	{
		format( cString, 128, "[错误]你已经在使用指令 \"%s\".", aSelNames[ gPlayerStatus[ playerid ] - 1 ] );
		SendClientMessage(playerid, COLOR_RED, cString);
		
		return 1;
	}
	
	new Float:a;
	
	gPlayerStatus[playerid] = OBJE_SEL_STAT;
	
	GetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
	curPlayerCamD[playerid][CPOS_Z] += 5.0;
	SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
	
	GetXYInFrontOfPlayer(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], OBJE_DIS);
	
	curPlayerCamD[playerid][CLOO_Z] = curPlayerCamD[playerid][CPOS_Z] - 5.0;
	
	SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
	
	TogglePlayerControllable(playerid, 0);
	
	GetPlayerFacingAngle(playerid, a);
	
	curPlayerObjM[ playerid ][ OBJ_X ] = curPlayerCamD[playerid][CLOO_X];
	curPlayerObjM[ playerid ][ OBJ_Y ] = curPlayerCamD[playerid][CLOO_Y];
	curPlayerObjM[ playerid ][ OBJ_Z ] = curPlayerCamD[playerid][CLOO_Z];
	curPlayerObjM[ playerid ][ OBJ_RX ] = 0.0;
	curPlayerObjM[ playerid ][ OBJ_RY ] = 0.0;
	curPlayerObjM[ playerid ][ OBJ_RZ ] = 0.0;
	
	curPlayerObjI[ playerid ] = CreateObject( curPlayerObjM[ playerid ][ OBJ_MDL ], curPlayerObjM[ playerid ][ OBJ_X ],
	curPlayerObjM[ playerid ][ OBJ_Y ], curPlayerObjM[ playerid ][ OBJ_Z ],
	curPlayerObjM[ playerid ][ OBJ_RX ], curPlayerObjM[ playerid ][ OBJ_RY ], curPlayerObjM[ playerid ][ OBJ_RZ ]
	);
	
	gPlayerTimers[ playerid ] = SetTimerEx("ObjectSelect", 200, 1, "i", playerid);
	
	return 1;
}

dcmd_camera(playerid, params[]) {
	new idx; new cString[128];
	
	cString = strtok(params, idx);
	
	if (!strlen(cString)) {
		SendClientMessage(playerid, COLOR_RED, "[用法]: /camera [RATE/MODE] [RATE/MODEID]");
		
		return true;
	}
	
	if (strcmp(cString, "rate", true, 4) == 0) {
		curPlayerCamD[playerid][RATE] = floatstr(params[idx+1]);
		
		return true;
	}
	
	if (strcmp(cString, "mode", true, 4) == 0) {
		curPlayerCamD[playerid][CMODE] = strval(params[idx+1]);
		
		return true;
	}
	
	return true;
}

dcmd_csel(playerid, params[]) {
	#pragma unused params
	
	new cString[128];
	
	if (gPlayerStatus[playerid] != 0) {
		format(cString, 128, "[错误]你已经在使用指令 \"%s\".", aSelNames[gPlayerStatus[playerid] - 1]);
		SendClientMessage(playerid, COLOR_RED, cString);
		
		return true;
	}
	
	gPlayerStatus[playerid] = CAME_SEL_STAT;
	
	TogglePlayerControllable(playerid, 0);
	
	GetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
	GetXYInFrontOfPlayer(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], 5.0);
	
	curPlayerCamD[playerid][CLOO_Z] = curPlayerCamD[playerid][CPOS_Z];
	
	gPlayerTimers[playerid] = SetTimerEx("CameraSelect", 200, 1, "i", playerid);
	
	return true;
}

#endif

dcmd_wea(playerid, params[]) {
	new idx, iString[128];
	iString = strtok(params, idx);
	
	if (!strlen(iString)) {
		SendClientMessage(playerid, COLOR_RED, "[用法]: /weather(/wea) [天气ID]");
		return true;
	}
	
	idx = strval(iString);
	
	if (idx < MIN_WEAT_ID || idx > MAX_WEAT_ID) {
		SendClientMessage(playerid, COLOR_RED, "[错误]:无效的天气ID.");
		return true;
	}
	
	gWorldStatus[1] = idx;
	
	if(limit[playerid] >= 5)
	{
		SendClientMessage(playerid, COLOR_RED, "[错误]:请等待20秒再尝试.");
		return 1;
	}
	else
	{
	limit[playerid]++;
	SetTimerEx("reset", 20000, 0, "i", playerid);
	}
	
	SetPlayerWeather(playerid,idx);
	
	new pname[24];
	GetPlayerName(playerid, pname, 256);
	
	format(iString, 128, "[天气]: %s 将ta的天气改为ID为 %d 的天气.", pname, idx);
	SendClientMessageToAll(COLOR_PURPLE, iString);
	
	return true;
}

dcmd_weather(playerid, params[])
return dcmd_wea(playerid, params);

dcmd_t(playerid, params[]) {
	new idx, iString[128];
	iString = strtok(params, idx);
	
	if (!strlen(iString)) {
		SendClientMessage(playerid, COLOR_RED, "[用法]: /time(/t) [小时]");
		return true;
	}
	
	idx = strval(iString);
	
	if (idx < MIN_TIME_ID || idx > MAX_TIME_ID) {
		SendClientMessage(playerid, COLOR_RED, "[错误]:无效的时间");
		return true;
	}
	
	gWorldStatus[0] = idx;
	
	if(limit[playerid] >= 5)
	{
		SendClientMessage(playerid, COLOR_RED, "[错误]:请等待20秒再尝试.");
		return 1;
	}
	else
	{
	limit[playerid]++;
	SetTimerEx("reset", 20000, 0, "i", playerid);
	}
	
	SetPlayerTime(playerid,idx,0);
	
	new pname[24];
	GetPlayerName(playerid, pname, 256);
	
	format(iString, 128, "[时间]: %s 将ta的时间改为 %d 点.", pname, idx);
	SendClientMessageToAll(COLOR_PURPLE, iString);
	
	return true;
}

dcmd_time(playerid, params[])
return dcmd_t(playerid, params);

#if VEHI_SELECT == true

dcmd_vname(playerid, params[])
{
	if (VLimit[playerid] <= 0) return SendClientMessage(playerid,COLOR_RED,"[错误]你的可刷车数量已经达到上限5,请使用/dcar指令."),true;
	new
	idx,
	iString[ 128 ];
	new pname[24];
	GetPlayerName(playerid, pname, 256);
	if ( gPlayerStatus[ playerid ] != 0 )
		{
			format				( iString, 128, "[错误]: 你已经在使用 \"%s\".", aSelNames[ gPlayerStatus[ playerid ] - 1 ] );
			SendClientMessage	( playerid, COLOR_RED, iString );
			
			return true;
		}
		
    if ( params[ 0 ] == '\0' )	// Same effect as a !strlen check.
			return SendClientMessage( playerid, COLOR_RED, "[用法]: /vname [车辆名称]" );
		
		//***************
		// Fix by Mike! *
		//***************
		
	idx = GetVehicleModelIDFromName( params );
		
	if( idx == -1 )
		{
			idx = strval(iString);
			
			if ( idx < MIN_VEHI_ID || idx > MAX_VEHI_ID )
				return SendClientMessage(playerid, COLOR_RED, "[错误]:无效的车辆名称.");
		}
	if(limit[playerid] >= 4)
		{
			SendClientMessage(playerid, COLOR_RED, "[错误]:请等待20秒再尝试.");
			return 1;
		}
	else
		{
		limit[playerid]++;
		SetTimerEx("reset", 20000, 0, "i", playerid);
		new
		Float:x,
		Float:y,
		Float:z,
		Float:a;
		
		GetPlayerPos(playerid, x, y, z);
		GetXYInFrontOfPlayer(playerid, x, y, VEHI_DIS);
		GetPlayerFacingAngle(playerid, a);
		
		curPlayerVehM[playerid] = idx;
		

		curPlayerVehI[playerid] = CreateVehicle(idx, x, y, z + 2.0, a, -1, -1, 5000);
		LinkVehicleToInterior(curPlayerVehI[playerid], GetPlayerInterior(playerid));
    	SetVehicleVirtualWorld(curPlayerVehI[playerid],GetPlayerVirtualWorld(playerid));
		PutPlayerInVehicle(playerid,curPlayerVehI[playerid],0);
		curServerVehP[curPlayerVehI[playerid]][spawn] 	= true;
		curServerVehP[curPlayerVehI[playerid]][vmodel]	= idx;
		curServerVehP[curPlayerVehI[playerid]][vInt]    = GetPlayerInterior(playerid);
		format(iString, 128, "[车辆]: %s 召唤了一辆 \"%s\" (模型ID: %d, 车辆顺序ID: %d)", pname, aVehicleNames[idx - MIN_VEHI_ID], idx, curPlayerVehI[playerid]);
		VLimit[playerid]--;
		if(VLimit[playerid] == 4) 
		{
            v1[playerid] = GetPlayerVehicleID(playerid);
			vi1[playerid] = idx;
		}
		if(VLimit[playerid] == 3)
		{
            v2[playerid] = GetPlayerVehicleID(playerid);
			vi2[playerid] = idx;
		}
		if(VLimit[playerid] == 2)
		{
            v3[playerid] = GetPlayerVehicleID(playerid);
			vi3[playerid] = idx;
		}
        if(VLimit[playerid] == 1)
		{
            v4[playerid] = GetPlayerVehicleID(playerid);
			vi4[playerid] = idx;
		}
		if(VLimit[playerid] == 0)
		{
            v5[playerid] = GetPlayerVehicleID(playerid);
			vi5[playerid] = idx;
		}
		SendClientMessageToAll(COLOR_PURPLE, iString);
		
		return true;
	}
}

dcmd_vn(playerid, params[])
return dcmd_vname(playerid, params);

dcmd_vehicle(playerid, params[])
return dcmd_v(playerid, params);

dcmd_v(playerid, params[])
{
	#pragma unused params
	ShowPlayerDialog(playerid,100,DIALOG_STYLE_LIST,"/v","刷车方法:\n通过ID刷车,指令:/vid [车辆ID],\n如/vid 411,则刷出id为411的车辆.\n \n通过车名刷车,指令/vn(vname) [车名]\n如/vname sul,则刷出一辆Sultan\n \n通过浏览车模型刷车(暂不开放)\n \n通过车辆选单召车(暂不开放)\n \n[提示]每人限刷5辆交通工具.相关指令:/dc(/dcar) - 反召 || /cc(/ccar) - 唤车","确认","取消");
    return true;
}

dcmd_vid(playerid, params[])
{
	if (VLimit[playerid] <= 0) return SendClientMessage(playerid,COLOR_RED,"[错误]你的可刷车数量已经达到上限5,请使用/dcar指令."),true;
    new idx, iString[128];
    iString = strtok(params, idx);

	if (!strlen(iString)) {
	    SendClientMessage(playerid, COLOR_RED, "[用法]: /vid [车辆ID]");
		return true;
	}

    idx = strval(iString);

	if (idx > 611 || idx < 400) {
		SendClientMessage(playerid, COLOR_RED, "[错误]:无效的车辆ID.");
		return true;
	}
    new Float:x,Float:y,Float:z,Float:a;

    GetPlayerPos(playerid, x, y, z);
    GetXYInFrontOfPlayer(playerid, x, y, VEHI_DIS);
    GetPlayerFacingAngle(playerid, a);

    curPlayerVehM[playerid] = idx;

    new pname[24];
    GetPlayerName(playerid,pname,sizeof(pname));

    curPlayerVehI[playerid] = CreateVehicle(idx, x, y, z + 2.0, a, -1, -1, 5000);
    LinkVehicleToInterior(curPlayerVehI[playerid], GetPlayerInterior(playerid));
    SetVehicleVirtualWorld(curPlayerVehI[playerid],GetPlayerVirtualWorld(playerid));
    PutPlayerInVehicle(playerid,curPlayerVehI[playerid],0);
    curServerVehP[curPlayerVehI[playerid]][spawn] 	= true;
    curServerVehP[curPlayerVehI[playerid]][vmodel]	= idx;
    curServerVehP[curPlayerVehI[playerid]][vInt]    = GetPlayerInterior(playerid);
    format(iString, 128, "[成功] %s 的新车ID为 %d,是一辆 %s,顺序ID %i .", pname, idx, aVehicleNames[idx - MIN_VEHI_ID],curPlayerVehI[playerid]);
    VLimit[playerid]--;
    if(VLimit[playerid] == 4)
    {
	    v1[playerid] = GetPlayerVehicleID(playerid);
	    vi1[playerid] = idx;
    }
    if(VLimit[playerid] == 3)
    {
	    v2[playerid] = GetPlayerVehicleID(playerid);
	    vi2[playerid] = idx;
    }
    if(VLimit[playerid] == 2)
    {
	    v3[playerid] = GetPlayerVehicleID(playerid);
	    vi3[playerid] = idx;
    }
    if(VLimit[playerid] == 1)
    {
	    v4[playerid] = GetPlayerVehicleID(playerid);
	    vi4[playerid] = idx;
    }
    if(VLimit[playerid] == 0)
    {
	    v5[playerid] = GetPlayerVehicleID(playerid);
	    vi5[playerid] = idx;
    }
    SendClientMessage(playerid, COLOR_GREEN, iString);
    return true;
}

/*
dcmd_vsel(playerid, params[])
{
	// /vsel allows players to select a car using playerkeys.
	#pragma unused params

	new cString[128];

	if (gPlayerStatus[playerid] != 0) {
		format(cString, 128, "[错误]:你已经在使用 \"%s\".", aSelNames[gPlayerStatus[playerid] - 1]);
		SendClientMessage(playerid, COLOR_RED, cString);
		return true;
	}

	new Float:x, Float:y, Float:z;

	gPlayerStatus[playerid] = VEHI_SEL_STAT;

	GetPlayerPos(playerid, x, y, z);
	SetPlayerCameraLookAt(playerid, x, y, z);

	GetXYInFrontOfPlayer(playerid, x, y, 3.5);
	SetPlayerCameraPos(playerid, x+3, y+3, z+0.5);

	TogglePlayerControllable(playerid, 0);
	SendClientMessage(playerid,COLOR_CYAN,"[提示]按左右键浏览,按TAB键选取.");
	SendClientMessage(playerid,COLOR_CYAN,"[提示]你也可以用/vid [ID] 或/vname [车名]选取特定的车辆.");
	gPlayerTimers[playerid] = SetTimerEx("VehicleSelect", 200, 1, "i", playerid);

	return true;
}*/

dcmd_dcar(playerid, params[])
{
    if(VLimit[playerid] > 4) return SendClientMessage(playerid,COLOR_RED,"[错误]你还没刷任何车,请使用/v查看说明."),true;
	SendClientMessage(playerid,COLOR_YELLOW,"[成功]所刷车辆复位,现在可以用/v重新刷车了,最多5辆.");

    if(VLimit[playerid] == 4)
    {
    DestroyVehicle(v1[playerid]);
	}
    if(VLimit[playerid] == 3)
	{
    DestroyVehicle(v1[playerid]);
    DestroyVehicle(v2[playerid]);
	}
    if(VLimit[playerid] == 2)
	{
    DestroyVehicle(v1[playerid]);
    DestroyVehicle(v2[playerid]);
    DestroyVehicle(v3[playerid]);
	}
    if(VLimit[playerid] == 1)
	{
    DestroyVehicle(v1[playerid]);
    DestroyVehicle(v2[playerid]);
    DestroyVehicle(v3[playerid]);
    DestroyVehicle(v4[playerid]);
	}
    if(VLimit[playerid] == 0)
    {
    DestroyVehicle(v1[playerid]);
    DestroyVehicle(v2[playerid]);
    DestroyVehicle(v3[playerid]);
    DestroyVehicle(v4[playerid]);
    DestroyVehicle(v5[playerid]);
    }
	VLimit[playerid] = 5;
	curPlayerVehI[playerid] = -1;
	v1[playerid] = 0;
	v2[playerid] = 0;
	v3[playerid] = 0;
	v4[playerid] = 0;
	v5[playerid] = 0;
	vi1[playerid] = 0;
	vi2[playerid] = 0;
	vi3[playerid] = 0;
	vi4[playerid] = 0;
	vi5[playerid] = 0;
    #pragma unused params
    return true;
}

dcmd_ccar(playerid, params[])
{
	new s[999],pname[256];
	GetPlayerName(playerid,pname,sizeof(pname));
	if(VLimit[playerid] == 5) return SendClientMessage(playerid,COLOR_RED,"[错误]你还没有刷任何车辆,请查看车辆系统说明/v."),true;
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_RED,"[错误]你在一辆交通工具里,请先离开."),true;
	if(VLimit[playerid] == 4)
		format(s,sizeof(s),"*** %s 的专用座驾,数量 : 1\n \n[一号车] %s ,模型ID: %d, 顺序ID: %d",pname,aVehicleNames[vi1[playerid] - MIN_VEHI_ID],vi1[playerid],v1[playerid]);
	if(VLimit[playerid] == 3)
		format(s,sizeof(s),"*** %s 的专用座驾,数量 : 2\n \n[一号车] %s ,模型ID: %d, 顺序ID: %d\n \n[二号车] %s ,模型ID: %d, 顺序ID: %d",pname,aVehicleNames[vi1[playerid] - MIN_VEHI_ID],vi1[playerid],v1[playerid],aVehicleNames[vi2[playerid] - MIN_VEHI_ID],vi2[playerid],v2[playerid]);
	if(VLimit[playerid] == 2)
		format(s,sizeof(s),"*** %s 的专用座驾,数量 : 3\n \n[一号车] %s ,模型ID: %d, 顺序ID: %d\n \n[二号车] %s ,模型ID: %d, 顺序ID: %d\n \n[三号车] %s ,模型ID: %d, 顺序ID: %d",pname,aVehicleNames[vi1[playerid] - MIN_VEHI_ID],vi1[playerid],v1[playerid],aVehicleNames[vi2[playerid] - MIN_VEHI_ID],vi2[playerid],v2[playerid],aVehicleNames[vi3[playerid] - MIN_VEHI_ID],vi3[playerid],v3[playerid]);
	if(VLimit[playerid] == 1)
		format(s,sizeof(s),"*** %s 的专用座驾,数量 : 4\n \n[一号车] %s ,模型ID: %d, 顺序ID: %d\n \n[二号车] %s ,模型ID: %d, 顺序ID: %d\n \n[三号车] %s ,模型ID: %d, 顺序ID: %d\n \n[四号车] %s ,模型ID: %d, 顺序ID: %d",pname,aVehicleNames[vi1[playerid] - MIN_VEHI_ID],vi1[playerid],v1[playerid],aVehicleNames[vi2[playerid] - MIN_VEHI_ID],vi2[playerid],v2[playerid],aVehicleNames[vi3[playerid] - MIN_VEHI_ID],vi3[playerid],v3[playerid],aVehicleNames[vi4[playerid] - MIN_VEHI_ID],vi4[playerid],v4[playerid]);
	if(VLimit[playerid] == 0)
		format(s,sizeof(s),"*** %s 的专用座驾,数量 : 5\n \n[一号车] %s, 模型ID: %d\n \n[二号车] %s ,模型ID: %d\n \n[三号车] %s ,模型ID: %d\n \n[四号车] %s ,模型ID: %d\n \n[五号车] %s ,模型ID: %d ,顺序ID:%d",pname,aVehicleNames[vi1[playerid] - MIN_VEHI_ID],vi1[playerid],aVehicleNames[vi2[playerid] - MIN_VEHI_ID],vi2[playerid],aVehicleNames[vi3[playerid] - MIN_VEHI_ID],vi3[playerid],aVehicleNames[vi4[playerid] - MIN_VEHI_ID],vi4[playerid],aVehicleNames[vi5[playerid] - MIN_VEHI_ID],vi5[playerid],v5[playerid]);
	ShowPlayerDialog(playerid,77,DIALOG_STYLE_LIST,"/ccar",s,"召唤","取消");
	#pragma unused params
	return true;
}
dcmd_cc(playerid, params[])
return dcmd_ccar(playerid, params);
dcmd_dc(playerid, params[])
return dcmd_dcar(playerid, params);
#endif

#if SKIN_SELECT == true

dcmd_ssel(playerid, params[])
{
	// /ssel allows players to select a skin using playerkeys.
	#pragma unused params
	
	new cString[128];
	
	if (gPlayerStatus[playerid] != 0) {
		format(cString, 128, "[错误]:你已经在使用 \"%s\".", aSelNames[gPlayerStatus[playerid] - 1]);
		SendClientMessage(playerid, COLOR_RED, cString);
		return true;
	}
	
	new Float:x, Float:y, Float:z;
	
	gPlayerStatus[playerid] = SKIN_SEL_STAT;
	
	GetPlayerPos(playerid, x, y, z);
	SetPlayerCameraLookAt(playerid, x, y, z);
	
	GetXYInFrontOfPlayer(playerid, x, y, 3.5);
	SetPlayerCameraPos(playerid, x, y, z);
	
	TogglePlayerControllable(playerid, 0);
	SendClientMessage(playerid,COLOR_CYAN,"[提示]按左右键浏览,按TAB键选取.");
	SendClientMessage(playerid,COLOR_CYAN,"[提示]你也可以用/sid [ID] 选取特定ID的皮肤.");
	gPlayerTimers[playerid] = SetTimerEx("SkinSelect", 200, 1, "i", playerid);
	
	return true;
}

dcmd_sid(playerid, params[])
{
	// /s SKINID allows players to directly select a skin using it's ID.
	new idx, iString[128];
	iString = strtok(params, idx);
	
	if (!strlen(iString)) {
		SendClientMessage(playerid, COLOR_RED, "[用法]: /sid [皮肤ID]");
		return true;
	}
	
	idx = strval(iString);
	
	if (IsInvalidSkin(idx) || idx < MIN_SKIN_ID || idx > MAX_SKIN_ID) {
		SendClientMessage(playerid, COLOR_RED, "[错误]:无效的皮肤ID.");
		return true;
	}
	
	SetPlayerSkin(playerid, idx);
	curPlayerSkin[playerid] = idx;
	format(iString, 128, "[成功]新皮肤的ID为 %d", idx);
	newskin[playerid] = idx;
	skinchange[playerid]++;
	SendClientMessage(playerid, COLOR_GREEN, iString);
	
	return true;
}
dcmd_skin(playerid, params[])
{
    #pragma unused params
    ShowPlayerDialog(playerid,102,DIALOG_STYLE_LIST,"/skin","皮肤更换方法:(两种)\n \n \n通过输入皮肤ID更换\n指令:/sid [皮肤ID],如要更换为ID为100的皮肤,则输入/sid 100\n \n通过浏览皮肤更换\n指令:/ssel,按左右键浏览,按'tab'键选择.","知道了","确定");
	return true;
}

#endif

#if MISCEL_CMDS == true

dcmd_nick(playerid, params[])
{
	new string[256];
	new pname[MAX_PLAYER_NAME];
 	if(!strlen(params))
	{
		SendClientMessage(playerid, COLOR_RED, "[用法]: /nick [新名字]");
		return 1;
	}
	if(limit[playerid] >= 2)
	{
		SendClientMessage(playerid, COLOR_RED, "[错误]:请等待20秒再尝试.");
		return 1;
	}
	else
	{
	limit[playerid]++;
	SetTimerEx("reset", 20000, 0, "i", playerid);
	GetPlayerName(playerid,pname,sizeof(pname));
	format(string, sizeof(string), "[名字]: %s 更名为: %s" ,pname,params);
	SendClientMessageToAll(COLOR_PURPLE, string);
 	SetPlayerName(playerid, params);
 	}
  	return true;
}

dcmd_setloc(playerid, params[])
{
	new idx, iString[128];
	iString = strtok(params, idx);
	
	if (!strlen(iString)) {
		SendClientMessage(playerid, COLOR_RED, "[用法]: /setloc X Y Z INTERIOR");
		return true;
	}
	
	new Float:X, Float:Y, Float:Z;
	new Interior;
	
	X = floatstr(iString);
	Y = floatstr(strtok(params,idx));
	Z = floatstr(strtok(params,idx));
	Interior = strval(strtok(params,idx));
	
	new pVID = GetPlayerVehicleID( playerid );
	
	if ( pVID )
	{
		SetVehiclePos( pVID, X, Y, Z );
		LinkVehicleToInterior( pVID, Interior );
	}
	else
	{
		SetPlayerPos( playerid, X, Y, Z );
	}
	
	SetPlayerInterior(playerid, Interior);
	
	return true;
	
	
}

dcmd_weapon(playerid, params[])
{
	dcmd_w2(playerid, params);
	return true;
}

dcmd_w2(playerid, params[])
{
	new idx, iString[128];
	iString = strtok(params, idx);
	if (!strlen(iString)) {
		SendClientMessage(playerid, COLOR_RED, "[用法]: /weapon(/w2) [武器ID或名称]");
		return true;
	}
	
	new weaponid = GetWeaponModelIDFromName(iString);
	if (weaponid == -1) {
		weaponid = strval(iString);
		if (weaponid < 0 || weaponid > 47) {
			SendClientMessage(playerid, COLOR_RED, "[错误]:无效的武器ID或名称.");
			return true;
		}
	}
	if(limit[playerid] >= 3)
	{
		SendClientMessage(playerid, COLOR_RED, "[错误]:请等待20秒再尝试.");
		return 1;
	}
	else
	{
		limit[playerid]++;
		SetTimerEx("reset", 20000, 0, "i", playerid);
	}
    if (!strlen(params[idx+1])) {
		GivePlayerWeapon(playerid, weaponid, 500);
		new pname[24];
    	GetPlayerName(playerid, pname, 256);
		format(iString, 128, "[武器]: %s 召唤了 %s (ID: %d)", pname, aWeaponNames[weaponid], weaponid);
		SendClientMessageToAll(COLOR_PURPLE, iString);
		return true;
	}

 	idx = strval(params[idx+1]);

	GivePlayerWeapon(playerid, weaponid, idx);

	return true;
}
#endif

dcmd_w(playerid, params[])
{

	new idx,iString[256],s1[256],s2[256],pname[MAX_PLAYER_NAME];
	iString = strtok(params, idx);
	idx = strval(iString);
	GetPlayerName(playerid,pname,sizeof(pname));
	if (!strlen(iString)) return SendClientMessage(playerid,COLOR_RED,"[用法]: /w [平行世界ID]");
	if (idx < 0 || idx > 255)
	return SendClientMessage(playerid,COLOR_RED,"[错误]无效的平行世界ID.请在0~255之间选择."),true;
	if(curPlayerVehI[playerid] > 0 && IsPlayerInVehicle(playerid,curPlayerVehI[playerid]))
	{
	    SetVehicleVirtualWorld(curPlayerVehI[playerid],idx);
		SetPlayerVirtualWorld(playerid,idx);
		PutPlayerInVehicle(playerid,curPlayerVehI[playerid],0);
	}

	else SetPlayerVirtualWorld(playerid,idx);
	format(s1,sizeof(s1),"[时空]你已成功来到第 %i 平行世界...",idx);
	SendClientMessage(playerid,COLOR_GREEN,s1);
	format(s2,sizeof(s2),"[时空] %s 运用指令/w 进入了某个平行空间,想找到他吗?问他本人吧:D",pname);
	SendClientMessageToAll(COLOR_CYAN,s2);
	World[playerid] = idx;
    return 1;
}
dcmd_fight(playerid,params[])
{
	#pragma unused params
	ShowPlayerDialog(playerid,41,DIALOG_STYLE_LIST,"[Super DM World]格斗风格","[Super DM World]格斗风格选择\n \n1.一般风格\n2.拳击风格\n3.功夫风格(荐)\n4.帮战风格1\n5.帮战风格2\n6.帮战风格3\n \n[提示]选择一项,双击或选定后按切换按钮.\n[提示]使用方法:跑动或静止时按住鼠标右键+F或回车.","切换","取消");
	return 1;
}
public OnFilterScriptInit()
{
	print("\n  *********************\n  * 电影制作辅助脚本   *");
	print("  * By Simon Campbell *\n  *********************");
	printf("  * 修改: [Fly_CoOl]_luck      *\n  *********************");
	print("  * -- 载入成功         *\n  *********************\n");
	
	for ( new i = 0; i < MAX_PLAYERS; i++ )
	{
		curPlayerObjM[ i ][ OBJ_MDL ] = MIN_OBJE_ID;
		pObjectRate[ i ][ OBJ_RATE_ROT ] = 1.0;
		pObjectRate[ i ][ OBJ_RATE_MOVE ] = 1.0;
	}
	
	AllowAdminTeleport(1);
}

public OnFilterScriptExit()
{
	print("\n  *********************\n  * SA:MP DEBUG 0.2   *");
	print("  * -- SHUTDOWN       *\n  *********************\n");
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 41)
		{
		if(response)
			{
			if(listitem == 2) SetPlayerFightingStyle(playerid,FIGHT_STYLE_NORMAL),SendClientMessage(playerid,COLOR_CYAN,"[格斗]你成功将格斗风格切换为正常.");
			if(listitem == 3) SetPlayerFightingStyle(playerid,FIGHT_STYLE_BOXING),SendClientMessage(playerid,COLOR_CYAN,"[格斗]你成功将格斗风格切换为拳击.");
			if(listitem == 4) SetPlayerFightingStyle(playerid,FIGHT_STYLE_KUNGFU),SendClientMessage(playerid,COLOR_CYAN,"[格斗]你成功将格斗风格切换为功夫.");
			if(listitem == 5) SetPlayerFightingStyle(playerid,FIGHT_STYLE_KNEEHEAD),SendClientMessage(playerid,COLOR_CYAN,"[格斗]你成功将格斗风格切换为帮战1.");
			if(listitem == 6) SetPlayerFightingStyle(playerid,FIGHT_STYLE_GRABKICK),SendClientMessage(playerid,COLOR_CYAN,"[格斗]你成功将格斗风格切换为帮战2.");
			if(listitem == 7) SetPlayerFightingStyle(playerid,FIGHT_STYLE_ELBOW),SendClientMessage(playerid,COLOR_CYAN,"[格斗]你成功将格斗风格切换为帮战3.");
			}
		return 1;
		}
/*	if(dialogid == 77 && response)
		{
			if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_RED,"[错误]你在一辆交通工具上,请先离开."),true;
			new Float:x,y,z,a;
			GetPlayerPos(playerid,x,y,z);
			GetPlayerFacingAngle(playerid,a);

			if(listitem == 2 && v1[playerid] > 0)
			{
				DestroyVehicle(v1[playerid]);
				CreateVehicle(vi1[playerid],);
				PutPlayerInVehicle(playerid,vi1[playerid],0);
			}
			if(listitem == 4 && v2[playerid] > 0)
			{
				DestroyVehicle(v2[playerid]);
			}
			if(listitem == 6 && v3[playerid] > 0)
			{
				DestroyVehicle(v3[playerid]);
			}
			if(listitem == 8 && v4[playerid] > 0)
			{
				DestroyVehicle(v4[playerid]);
			}
			if(listitem == 10 && v5[playerid] > 0)
			{
				DestroyVehicle(v5[playerid]);
			}
	}*/
    return 0;
}
//    iString = strtok(params, idx);
//    idx = strval(iString);

public OnPlayerCommandText(playerid, cmdtext[])
{
	#if ADMINS_ONLY == true
	if(IsPlayerAdmin(playerid)) {
		#endif
		dcmd(w,1,cmdtext);
		dcmd(fight,5,cmdtext);
		#if SKIN_SELECT == true
		dcmd(ssel, 4, cmdtext);
		dcmd(skin, 4, cmdtext);
		dcmd(sid, 3, cmdtext);
		#endif
		
		#if VEHI_SELECT == true
		dcmd(v, 1, cmdtext);
		dcmd(vn, 2, cmdtext);
		dcmd(vehicle, 7, cmdtext);
		dcmd(vname, 5, cmdtext);
		dcmd(vid, 3, cmdtext);
//		dcmd(vsel, 4, cmdtext);
		dcmd(dcar, 4, cmdtext);
		dcmd(ccar, 4, cmdtext);
		dcmd(dc, 2, cmdtext);
		dcmd(cc, 2, cmdtext);
		#endif
		
		#if WORL_SELECT == true
		dcmd(wea, 3, cmdtext);
		dcmd(t, 1, cmdtext);
		dcmd(time, 4, cmdtext);
		dcmd(weather, 7, cmdtext);
		#endif
		
		#if MISCEL_CMDS == true
		dcmd(w2, 2, cmdtext);
		dcmd(weapon, 6, cmdtext);
		dcmd(setloc, 6, cmdtext);
		dcmd(nick, 4, cmdtext);
		#endif
		
		#if CAME_SELECT == true
		dcmd(csel, 4, cmdtext);
		dcmd(camera, 6, cmdtext);
		#endif
		
		dcmd(osel, 4, cmdtext);
		dcmd(object, 6, cmdtext);
		dcmd(debug, 5, cmdtext);
		
		#if ADMINS_ONLY == true
	}
	#endif
	
	return 0;
}

public OnPlayerDisconnect(playerid,reason)
{
	dcmd_dcar(playerid,"");
	KillTimer(gPlayerTimers[playerid]);
	World[playerid] = 0;
	gPlayerStatus[playerid] = 0;
	gPlayerTimers[playerid] = 0;
	skinchange[playerid] = 0;
	newskin[playerid] = 0;
	curPlayerSkin[playerid] = MIN_SKIN_ID; // Current Player Skin ID
	curPlayerVehM[playerid] = MIN_VEHI_ID; // Current Player Vehicle ID
//	curPlayerVehI[playerid] = -1;
/*	curPlayerVehI[playerid]-1 = -1;
	curPlayerVehI[playerid]-2 = -1;
	curPlayerVehI[playerid]-3 = -1;
	curPlayerVehI[playerid]-4 = -1;*/
/*	curPlayerVehII[playerid] = -1;
	curPlayerVehIII[playerid] = -1;
	curPlayerVehIV[playerid] = -1;
	curPlayerVehV[playerid] = -1;*/
/*	VLimit[playerid] = 2;
	DestroyVehicle(curPlayerVehI[playerid]);
	DestroyVehicle(curPlayerVehII[playerid]);*/
/*    DestroyVehicle(VLimit1[playerid]);
    DestroyVehicle(VLimit2[playerid]);
    DestroyVehicle(VLimit3[playerid]);*/
	return 0;
}

public OnPlayerConnect(playerid)
{
	limit[playerid] = 0;
	curPlayerCamD[playerid][CMODE] = CMODE_A;
	curPlayerCamD[playerid][RATE]  = 2.0;
	
	#if ADMINS_ONLY == false
	AllowPlayerTeleport(playerid, 1);
	#endif
	
	return 0;
}
public OnPlayerSpawn(playerid)
{
	if(World[playerid]>0)
	{
	new s[256];
	SetPlayerVirtualWorld(playerid,World[playerid]);
	format(s,sizeof(s),"[提示]你出生在第 %i 号平行宇宙...",World[playerid]);
	SendClientMessage(playerid,COLOR_RED,s);
	}
    if (skinchange[playerid] > 0) SetPlayerSkin(playerid,newskin[playerid]);
}
//==============================================================================

#if WORL_SELECT == true
public WorldSelect(playerid)
{   // Created by Simon
	/*
	// Make sure the player is not in world selection before continuing
	if (gPlayerStatus[playerid] != WORL_SEL_STAT) {
	KillTimer(skinTimerID[playerid]);
	return;
	}
	*/
	
	new keys, updown, leftright;
	
	GetPlayerKeys(playerid, keys, updown, leftright);
	
	new cString[128];
	
	// Right key increases World Time
	if (leftright == KEY_RIGHT) {
		if(gWorldStatus[0] == MAX_TIME_ID) {
			gWorldStatus[0] = MIN_TIME_ID;
		}
		else {
			gWorldStatus[0]++;
		}
		format(cString, 128, "World Time: %d~n~Weather ID: %d", gWorldStatus[0], gWorldStatus[1]);
		GameTextForPlayer(playerid, cString, 1500, 3);
		SetWorldTime(gWorldStatus[0]);
	}
	
	// Left key decreases World Time
	if (leftright == KEY_LEFT) {
		if(gWorldStatus[0] == MIN_TIME_ID) {
			gWorldStatus[0] = MAX_TIME_ID;
		}
		else {
			gWorldStatus[0]--;
		}
		format(cString, 128, "World Time: %d~n~Weather ID: %d", gWorldStatus[0], gWorldStatus[1]);
		GameTextForPlayer(playerid, cString, 1500, 3);
		SetWorldTime(gWorldStatus[0]);
	}
	
	// Up key increases Weather ID
	if(updown == KEY_UP) {
		if(gWorldStatus[1] == MAX_WEAT_ID) {
			gWorldStatus[1] = MIN_WEAT_ID;
		}
		else {
			gWorldStatus[1]++;
		}
		format(cString, 128, "World Time: %d~n~Weather ID: %d", gWorldStatus[0], gWorldStatus[1]);
		GameTextForPlayer(playerid, cString, 1500, 3);
		SetWeather(gWorldStatus[1]);
	}
	
	// Down key decreases Weather ID
	if(updown == KEY_DOWN) {
		if(gWorldStatus[1] == MIN_WEAT_ID) {
			gWorldStatus[1] = MAX_WEAT_ID;
		}
		else {
			gWorldStatus[1]--;
		}
		format(cString, 128, "World Time: %d~n~Weather ID: %d", gWorldStatus[0], gWorldStatus[1]);
		GameTextForPlayer(playerid, cString, 1500, 3);
		SetWeather(gWorldStatus[1]);
	}
	
	// Action key exits WorldSelection
	if(keys & KEY_ACTION) {
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, 1);
		
		format(cString, 128, "[成功]:时间改变为 %d 点,新天气ID为 %d", gWorldStatus[0], gWorldStatus[1]);
		SendClientMessage(playerid, COLOR_GREEN, cString);
		
		new File:F_WORLD = fopen("TIME-WEATHER.txt", io_append);
		
		if(F_WORLD) {
			new h, m, s, Y, M, D;
			
			getdate(Y, M, D);
			gettime(h, m, s);
			
			format(cString, 128, "// %d-%d-%d @ %d:%d:%d\r\nSetWeather(%d);\r\nSetWorldTime(%d);\r\n", D, M, Y, h, m, s);
			
			fwrite(F_WORLD, cString);
			fclose(F_WORLD);
			printf("\n%s\n",cString);
		}
		else {
			print("Failed to create the file \"TIME-WEATHER.txt\".\n");
		}
		
		gPlayerStatus[playerid] = 0;
		KillTimer(gPlayerTimers[playerid]);
		
		return;
	}
}

#endif

#if SKIN_SELECT == true
public SkinSelect(playerid)
{   // Created by Simon
	/*
	// Make sure the player is not in skin selection before continuing
	if (gPlayerStatus[playerid] != SKIN_SEL_STAT) {
	KillTimer(skinTimerID[playerid]);
	return;
	}
	*/
	
	new keys, updown, leftright;
	
	GetPlayerKeys(playerid, keys, updown, leftright);
	
	new cString[128];
	
	// Right key increases Skin ID
	if (leftright == KEY_RIGHT) {
		if(curPlayerSkin[playerid] == MAX_SKIN_ID) {
			curPlayerSkin[playerid] = MIN_SKIN_ID;
		}
		else {
			curPlayerSkin[playerid]++;
		}
		while(IsInvalidSkin(curPlayerSkin[playerid])) {
			curPlayerSkin[playerid]++;
		}
		
		format(cString, 128, "Skin ID: %d", curPlayerSkin[playerid]);
		GameTextForPlayer(playerid, cString, 1500, 3);
		SetPlayerSkin(playerid, curPlayerSkin[playerid]);
	}
	
	// Left key decreases Skin ID
	if(leftright == KEY_LEFT) {
		if(curPlayerSkin[playerid] == MIN_SKIN_ID) {
			curPlayerSkin[playerid] = MAX_SKIN_ID;
		}
		else {
			curPlayerSkin[playerid]--;
		}
		while(IsInvalidSkin(curPlayerSkin[playerid])) {
			curPlayerSkin[playerid]--;
		}
		
		format(cString, 128, "Skin ID: %d", curPlayerSkin[playerid]);
		GameTextForPlayer(playerid, cString, 1500, 3);
		SetPlayerSkin(playerid, curPlayerSkin[playerid]);
	}
	
	// Action key exits skin selection
	if(keys & KEY_ACTION)
	{
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, 1);
		
		format(cString, 128, "[成功]:你的新皮肤ID为 %d", curPlayerSkin[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, cString);
		
		gPlayerStatus[playerid] = 0;
		KillTimer(gPlayerTimers[playerid]);
	}
}
#endif

#if CAME_SELECT == true
public CameraSelect(playerid)
{
	// CMODE_A 0	Up/Down = IncreaseZ/DecreaseZ; Left/Right = IncreaseX/DecreaseX; Num4/Num6 = IncreaseY/DecreaseY
	// CMODE_B 1	Up/Down = Rotate Up/Down; Left/Right = Rotate Left/Right; Num4/Num6 = Move Left/Right
	
	new keys, updown, leftright;
	
	GetPlayerKeys(playerid, keys, updown, leftright);
	
	printf("Player (%d) keys = %d, updown = %d, leftright = %d", playerid, keys, updown, leftright);
	
	if (curPlayerCamD[playerid][CMODE] == CMODE_A)
	{
		if (leftright == KEY_RIGHT) {
			curPlayerCamD[playerid][CPOS_X] += curPlayerCamD[playerid][RATE];
			curPlayerCamD[playerid][CLOO_X] += curPlayerCamD[playerid][RATE];
			
			SetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			
			SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
		}
		
		if (leftright == KEY_LEFT) {
			curPlayerCamD[playerid][CPOS_X] -= curPlayerCamD[playerid][RATE];
			curPlayerCamD[playerid][CLOO_X] -= curPlayerCamD[playerid][RATE];
			
			SetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			
			SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
		}
		
		if (updown == KEY_UP) {
			curPlayerCamD[playerid][CPOS_Z] += curPlayerCamD[playerid][RATE];
			curPlayerCamD[playerid][CLOO_Z] += curPlayerCamD[playerid][RATE];
			
			SetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			
			SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
		}
		
		if (updown == KEY_DOWN) {
			curPlayerCamD[playerid][CPOS_Z] -= curPlayerCamD[playerid][RATE];
			curPlayerCamD[playerid][CLOO_Z] -= curPlayerCamD[playerid][RATE];
			
			SetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			
			SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
		}
		
		if (keys & KEY_ANALOG_RIGHT) {
			curPlayerCamD[playerid][CPOS_Y] += curPlayerCamD[playerid][RATE];
			curPlayerCamD[playerid][CLOO_Y] += curPlayerCamD[playerid][RATE];
			
			SetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			
			SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
		}
		
		
		if (keys & KEY_ANALOG_LEFT) {
			curPlayerCamD[playerid][CPOS_Y] -= curPlayerCamD[playerid][RATE];
			curPlayerCamD[playerid][CLOO_Y] -= curPlayerCamD[playerid][RATE];
			
			SetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			
			SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
		}
	}
	
	
	if(curPlayerCamD[playerid][CMODE] == CMODE_B)
	{
		if (leftright == KEY_RIGHT) {
			// Rotate Y +
		}
		
		if (leftright == KEY_LEFT) {
			// Rotate Y -
		}
		
		if (updown == KEY_UP) {
			// Rotate X +
		}
		
		if (updown == KEY_DOWN) {
			// Rotate X -
		}
		
		if (keys & KEY_ANALOG_RIGHT) {
			// Rotate Z +
		}
		
		if (keys & KEY_ANALOG_LEFT) {
			// Rotate Z -
		}
	}
	
	if (keys & KEY_ACTION)
	{
		SetCameraBehindPlayer(playerid);
		
		new
		File:F_CAMERA = fopen("CAMERA.txt", io_append);
		
		if( F_CAMERA )
		{
			new
			cString[512], h, m, s, Y, M, D;
			
			getdate(Y, M, D);
			gettime(h, m, s);
			
			format(cString, sizeof( cString ), "// %d-%d-%d @ %d:%d:%d\r\nSetPlayerCameraPos(playerid, %f, %f, %f);\r\nSetPlayerCameraLookAt(playerid, %f, %f, %f);\r\n", D, M, Y, h, m, s,curPlayerCamD[playerid][CPOS_X],curPlayerCamD[playerid][CPOS_Y],curPlayerCamD[playerid][CPOS_Z],curPlayerCamD[playerid][CLOO_X],curPlayerCamD[playerid][CLOO_Y],curPlayerCamD[playerid][CLOO_Z]);
			
			fwrite(F_CAMERA, cString);
			fclose(F_CAMERA);
			
			printf("\n%s\n",cString);
			
			SendClientMessage( playerid, COLOR_GREEN, "Current camera data saved to 'CAMERA.txt'" );
		}
		else
		print("Failed to create the file \"CAMERA.txt\".\n");
		
		TogglePlayerControllable(playerid, 1);
		
		KillTimer(gPlayerTimers[playerid]);
		
		gPlayerStatus[playerid] = 0;
	}
}

#endif

#if VEHI_SELECT == true
public VehicleSelect(playerid)
{
	/*
	// Make sure the player is not in skin selection before continuing
	if (gPlayerStatus[playerid] != VEHI_SEL_STAT) {
	KillTimer(skinTimerID[playerid]);
	return;
	}
	*/
	
	new keys, updown, leftright;
	
	GetPlayerKeys(playerid, keys, updown, leftright);
	
	new cString[128];
	
	// Right key increases Vehicle MODELID
	if (leftright == KEY_RIGHT) {
		if(curPlayerVehM[playerid] == MAX_VEHI_ID) {
			curPlayerVehM[playerid] = MIN_VEHI_ID;
		}
		else {
			curPlayerVehM[playerid]++;
		}
		
		format(cString, 128, "Model ID: %d~n~Vehicle Name: %s", curPlayerVehM, aVehicleNames[curPlayerVehM[playerid] - MIN_VEHI_ID]);
		GameTextForPlayer(playerid, cString, 1500, 3);
		
		new Float:x, Float:y, Float:z, Float:a;
		
		GetPlayerPos(playerid, x, y, z);
		GetXYInFrontOfPlayer(playerid, x, y, VEHI_DIS);
		GetPlayerFacingAngle(playerid, a);
		
		DestroyVehicle(curPlayerVehI[playerid]);
		curServerVehP[curPlayerVehI[playerid]][spawn] 	= false;
		
		curPlayerVehI[playerid] = CreateVehicle(curPlayerVehM[playerid], x, y, z + 2.0, a + 90.0, -1, -1, 5000);
		LinkVehicleToInterior(curPlayerVehI[playerid], GetPlayerInterior(playerid));
		
		curServerVehP[curPlayerVehI[playerid]][spawn] 	= true;
		curServerVehP[curPlayerVehI[playerid]][vmodel]	= curPlayerVehM[playerid];
		curServerVehP[curPlayerVehI[playerid]][vInt]    = GetPlayerInterior(playerid);
	}
	
	// Left key decreases Vehicle MODELID
	if(leftright == KEY_LEFT) {
		if(curPlayerVehM[playerid] == MIN_VEHI_ID) {
			curPlayerVehM[playerid] = MAX_VEHI_ID;
		}
		else {
			curPlayerVehM[playerid]--;
		}
		
		format(cString, 128, "Model ID: %d~n~Vehicle Name: %s", curPlayerVehM, aVehicleNames[curPlayerVehM[playerid] - MIN_VEHI_ID]);
		GameTextForPlayer(playerid, cString, 1500, 3);
		
		new Float:x, Float:y, Float:z, Float:a;
		
		GetPlayerPos(playerid, x, y, z);
		GetXYInFrontOfPlayer(playerid, x, y, VEHI_DIS);
		GetPlayerFacingAngle(playerid, a);
		
		DestroyVehicle(curPlayerVehI[playerid]);
		curServerVehP[curPlayerVehI[playerid]][spawn] 	= false;
		
		curPlayerVehI[playerid] = CreateVehicle(curPlayerVehM[playerid], x, y, z + 2.0, a + 90.0, -1, -1, 5000);
		LinkVehicleToInterior(curPlayerVehI[playerid], GetPlayerInterior(playerid));
		
		curServerVehP[curPlayerVehI[playerid]][spawn] 	= true;
		curServerVehP[curPlayerVehI[playerid]][vmodel]	= curPlayerVehM[playerid];
		curServerVehP[curPlayerVehI[playerid]][vInt]    = GetPlayerInterior(playerid);
	}
	
	// Action key exits vehicle selection
	if(keys & KEY_ACTION)
	{
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, 1);
		
		format(cString, 128, "[成功]:召唤了一辆 \"%s\" (模型ID: %d, 车辆ID: %d)", aVehicleNames[curPlayerVehM[playerid] - MIN_VEHI_ID], curPlayerVehM[playerid], curPlayerVehI[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, cString);
		PutPlayerInVehicle(playerid,curPlayerVehI[playerid],0);
		gPlayerStatus[playerid] = 0;
		KillTimer(gPlayerTimers[playerid]);
	}
}
#endif

#if OBJE_SELECT == true
public ObjectSelect( playerid )
{
	new keys, updown, leftright;
	
	GetPlayerKeys( playerid, keys, updown, leftright );
	
	new cString[ 128 ];
	
	switch ( curPlayerObjM[ playerid ][ OBJ_MOD ] )
	{
		case O_MODE_SELECTOR:
		{
			if ( updown == KEY_UP)
			{
				curPlayerObjM[ playerid ][ OBJ_MDL ] += 10;
				
				if ( curPlayerObjM[ playerid ][ OBJ_MDL ] >= MAX_OBJE_ID )
				{
					curPlayerObjM[ playerid ][ OBJ_MDL ] = MIN_OBJE_ID;
				}
				
				while ( !IsValidModel( curPlayerObjM[ playerid ][ OBJ_MDL ] ) )
				{
					curPlayerObjM[ playerid ][ OBJ_MDL ]++;
				}
				
				DestroyObject( curPlayerObjI[ playerid ] );
				curPlayerObjI[ playerid ] = CreateObject( curPlayerObjM[ playerid ][ OBJ_MDL ], curPlayerObjM[ playerid ][ OBJ_X ],
				curPlayerObjM[ playerid ][ OBJ_Y ], curPlayerObjM[ playerid ][ OBJ_Z ],
				curPlayerObjM[ playerid ][ OBJ_RX ], curPlayerObjM[ playerid ][ OBJ_RY ], curPlayerObjM[ playerid ][ OBJ_RZ ]
				);
				
				format( cString, 128, "Model ID: %d", curPlayerObjM[ playerid ][ OBJ_MDL ] );
				GameTextForPlayer(playerid, cString, 1500, 3);
			}
			
			if ( updown == KEY_DOWN)
			{
				curPlayerObjM[ playerid ][ OBJ_MDL ] -= 10;
				
				if ( curPlayerObjM[ playerid ][ OBJ_MDL ] <= MIN_OBJE_ID )
				{
					curPlayerObjM[ playerid ][ OBJ_MDL ] = MAX_OBJE_ID;
				}
				
				while ( !IsValidModel( curPlayerObjM[ playerid ][ OBJ_MDL ] ) )
				{
					curPlayerObjM[ playerid ][ OBJ_MDL ]--;
				}
				
				DestroyObject( curPlayerObjI[ playerid ] );
				curPlayerObjI[ playerid ] = CreateObject( curPlayerObjM[ playerid ][ OBJ_MDL ], curPlayerObjM[ playerid ][ OBJ_X ],
				curPlayerObjM[ playerid ][ OBJ_Y ], curPlayerObjM[ playerid ][ OBJ_Z ],
				curPlayerObjM[ playerid ][ OBJ_RX ], curPlayerObjM[ playerid ][ OBJ_RY ], curPlayerObjM[ playerid ][ OBJ_RZ ]
				);
				
				format( cString, 128, "Model ID: %d", curPlayerObjM[ playerid ][ OBJ_MDL ] );
				GameTextForPlayer(playerid, cString, 1500, 3);
			}
			
			if ( leftright == KEY_LEFT)
			{
				curPlayerObjM[ playerid ][ OBJ_MDL ]--;
				
				if ( curPlayerObjM[ playerid ][ OBJ_MDL ] <= MIN_OBJE_ID )
				{
					curPlayerObjM[ playerid ][ OBJ_MDL ] = MAX_OBJE_ID;
				}
				
				while ( !IsValidModel( curPlayerObjM[ playerid ][ OBJ_MDL ] ) )
				{
					curPlayerObjM[ playerid ][ OBJ_MDL ]--;
				}
				
				DestroyObject( curPlayerObjI[ playerid ] );
				curPlayerObjI[ playerid ] = CreateObject( curPlayerObjM[ playerid ][ OBJ_MDL ], curPlayerObjM[ playerid ][ OBJ_X ],
				curPlayerObjM[ playerid ][ OBJ_Y ], curPlayerObjM[ playerid ][ OBJ_Z ],
				curPlayerObjM[ playerid ][ OBJ_RX ], curPlayerObjM[ playerid ][ OBJ_RY ], curPlayerObjM[ playerid ][ OBJ_RZ ]
				);
				
				format( cString, 128, "Model ID: %d", curPlayerObjM[ playerid ][ OBJ_MDL ] );
				GameTextForPlayer(playerid, cString, 1500, 3);
			}
			
			if ( leftright == KEY_RIGHT)
			{
				curPlayerObjM[ playerid ][ OBJ_MDL ]++;
				
				if ( curPlayerObjM[ playerid ][ OBJ_MDL ] >= MAX_OBJE_ID )
				{
					curPlayerObjM[ playerid ][ OBJ_MDL ] = MIN_OBJE_ID;
				}
				
				while ( !IsValidModel( curPlayerObjM[ playerid ][ OBJ_MDL ] ) )
				{
					curPlayerObjM[ playerid ][ OBJ_MDL ]++;
				}
				
				DestroyObject( curPlayerObjI[ playerid ] );
				curPlayerObjI[ playerid ] = CreateObject( curPlayerObjM[ playerid ][ OBJ_MDL ], curPlayerObjM[ playerid ][ OBJ_X ],
				curPlayerObjM[ playerid ][ OBJ_Y ], curPlayerObjM[ playerid ][ OBJ_Z ],
				curPlayerObjM[ playerid ][ OBJ_RX ], curPlayerObjM[ playerid ][ OBJ_RY ], curPlayerObjM[ playerid ][ OBJ_RZ ]
				);
				
				format( cString, 128, "Model ID: %d", curPlayerObjM[ playerid ][ OBJ_MDL ] );
				GameTextForPlayer(playerid, cString, 1500, 3);
			}
		}
		
		case O_MODE_MOVER:
		{
			if ( updown == KEY_UP)
			{
				curPlayerObjM[ playerid ][ OBJ_Z ] += pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
				curPlayerCamD[ playerid ][ CPOS_Z ] += pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
				curPlayerCamD[ playerid ][ CLOO_Z ] += pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
			}
			
			if ( updown == KEY_DOWN)
			{
				curPlayerObjM[ playerid ][ OBJ_Z ] -= pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
				curPlayerCamD[ playerid ][ CPOS_Z ] -= pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
				curPlayerCamD[ playerid ][ CLOO_Z ] -= pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
			}
			
			if ( leftright == KEY_LEFT)
			{
				curPlayerObjM[ playerid ][ OBJ_Y ] -= pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
				curPlayerCamD[ playerid ][ CPOS_Y ] -= pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
				curPlayerCamD[ playerid ][ CLOO_Y ] -= pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
			}
			
			if ( leftright == KEY_RIGHT)
			{
				curPlayerObjM[ playerid ][ OBJ_Y ] += pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
				curPlayerCamD[ playerid ][ CPOS_Y ] += pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
				curPlayerCamD[ playerid ][ CLOO_Y ] += pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
			}
			
			if ( keys & KEY_ANALOG_LEFT )
			{
				curPlayerObjM[ playerid ][ OBJ_Y ] -= pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
				curPlayerCamD[ playerid ][ CPOS_Y ] -= pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
				curPlayerCamD[ playerid ][ CLOO_Y ] -= pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
			}
			
			if ( keys & KEY_ANALOG_LEFT )
			{
				curPlayerObjM[ playerid ][ OBJ_X ] += pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
				curPlayerCamD[ playerid ][ CPOS_X ] += pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
				curPlayerCamD[ playerid ][ CLOO_X ] += pObjectRate[ playerid ][ OBJ_RATE_MOVE ];
			}
			
			SetPlayerPos( playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z] );
			SetObjectPos( curPlayerObjI[ playerid ], curPlayerObjM[ playerid ][ OBJ_X ], curPlayerObjM[ playerid ][ OBJ_Y ], curPlayerObjM[ playerid ][ OBJ_Z ] );
			SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
			SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
		}
		
		case O_MODE_ROTATOR:
		{
			if ( updown == KEY_UP)
			{
				curPlayerObjM[ playerid ][ OBJ_RZ ] += pObjectRate[ playerid ][ OBJ_RATE_ROT ];
			}
			
			if ( updown == KEY_DOWN)
			{
				curPlayerObjM[ playerid ][ OBJ_RZ ] -= pObjectRate[ playerid ][ OBJ_RATE_ROT ];
				
			}
			
			if ( leftright == KEY_LEFT)
			{
				curPlayerObjM[ playerid ][ OBJ_RY ] -= pObjectRate[ playerid ][ OBJ_RATE_ROT ];
			}
			
			if ( leftright == KEY_RIGHT)
			{
				curPlayerObjM[ playerid ][ OBJ_RY ] += pObjectRate[ playerid ][ OBJ_RATE_ROT ];
			}
			
			if ( keys & KEY_ANALOG_LEFT )
			{
				curPlayerObjM[ playerid ][ OBJ_RY ] -= pObjectRate[ playerid ][ OBJ_RATE_ROT ];
			}
			
			if ( keys & KEY_ANALOG_LEFT )
			{
				curPlayerObjM[ playerid ][ OBJ_RX ] += pObjectRate[ playerid ][ OBJ_RATE_ROT ];
			}
			
			SetObjectRot( curPlayerObjI[ playerid ], curPlayerObjM[ playerid ][ OBJ_RX ], curPlayerObjM[ playerid ][ OBJ_RY ], curPlayerObjM[ playerid ][ OBJ_RZ ] );
		}
	}
	
	if ( keys & KEY_ACTION )
	{
		gPlayerStatus[ playerid ] = 0;
		TogglePlayerControllable( playerid, 1 );
		SetCameraBehindPlayer( playerid );
		KillTimer( gPlayerTimers[playerid] );
	}
	
}
#endif

IsInvalidSkin(skinid)
{   // Created by Simon
	// Checks whether the skinid parsed is crashable or not.
	
	#define	MAX_BAD_SKINS   14
	
	new badSkins[MAX_BAD_SKINS] = {
		3, 4, 5, 6, 8, 42, 65, 74, 86,
		119, 149, 208, 273, 289
	};
	
	for (new i = 0; i < MAX_BAD_SKINS; i++) {
		if (skinid == badSkins[i]) return true;
	}
	
	return false;
}

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{	// Created by Y_Less
	
	new Float:a;
	
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	
	if (GetPlayerVehicleID(playerid)) {
		GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

strtok(const string[], &index)
{   // Created by Compuphase
	
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}
	
	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if ( strfind(aVehicleNames[i], vname, true) != -1 )
			return i + MIN_VEHI_ID;
	}
	return -1;
}

GetWeaponModelIDFromName(wname[])
{
	for(new i = 0; i < 48; i++) {
		if (i == 19 || i == 20 || i == 21) continue;
		if (strfind(aWeaponNames[i], wname, true) != -1) {
			return i;
		}
	}
	return -1;
}

IsValidModel(modelid)
{
	// Created by Y_Less.
	
	static modeldat[] =
	{
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -128,
		-515899393, -134217729, -1, -1, 33554431, -1, -1, -1, -14337, -1, -33,
		127, 0, 0, 0, 0, 0, -8388608, -1, -1, -1, -16385, -1, -1, -1, -1, -1,
		-1, -1, -33, -1, -771751937, -1, -9, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, 33554431, -25, -1, -1, -1, -1, -1, -1,
		-1073676289, -2147483648, 34079999, 2113536, -4825600, -5, -1, -3145729,
		-1, -16777217, -63, -1, -1, -1, -1, -201326593, -1, -1, -1, -1, -1,
		-257, -1, 1073741823, -133122, -1, -1, -65, -1, -1, -1, -1, -1, -1,
		-2146435073, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1073741823, -64, -1,
		-1, -1, -1, -2635777, 134086663, 0, -64, -1, -1, -1, -1, -1, -1, -1,
		-536870927, -131069, -1, -1, -1, -1, -1, -1, -1, -1, -16384, -1,
		-33554433, -1, -1, -1, -1, -1, -1610612737, 524285, -128, -1,
		2080309247, -1, -1, -1114113, -1, -1, -1, 66977343, -524288, -1, -1, -1,
		-1, -2031617, -1, 114687, -256, -1, -4097, -1, -4097, -1, -1,
		1010827263, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -32768, -1, -1, -1, -1, -1,
		2147483647, -33554434, -1, -1, -49153, -1148191169, 2147483647,
		-100781080, -262145, -57, 134217727, -8388608, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1048577, -1, -449, -1017, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1835009, -2049, -1, -1, -1, -1, -1, -1,
		-8193, -1, -536870913, -1, -1, -1, -1, -1, -87041, -1, -1, -1, -1, -1,
		-1, -209860, -1023, -8388609, -2096897, -1, -1048577, -1, -1, -1, -1,
		-1, -1, -897, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1610612737,
		-3073, -28673, -1, -1, -1, -1537, -1, -1, -13, -1, -1, -1, -1, -1985,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1056964609, -1, -1, -1,
		-1, -1, -1, -1, -2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-236716037, -1, -1, -1, -1, -1, -1, -1, -536870913, 3, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -2097153, -2109441, -1, 201326591, -4194304, -1, -1,
		-241, -1, -1, -1, -1, -1, -1, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, -32768, -1, -1, -1, -2, -671096835, -1, -8388609, -66323585, -13,
		-1793, -32257, -247809, -1, -1, -513, 16252911, 0, 0, 0, -131072,
		33554383, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 8356095, 0, 0, 0, 0, 0,
		0, -256, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-268435449, -1, -1, -2049, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		92274627, -65536, -2097153, -268435457, 591191935, 1, 0, -16777216, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 127
	};
	if ((modelid >= 0) && ((modelid / 32) < sizeof (modeldat)) && (modeldat[modelid / 32] & (1 << (modelid % 32))))
	{
		return 1;
	}
	return 0;
}

public reset(playerid)
{
	limit[playerid] = 0;
	return 1;
}
