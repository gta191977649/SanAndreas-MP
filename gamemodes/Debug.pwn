/*
===========================================
{Just Now Movie!}
Versoion:2.2 Last Edition
Last fixd Episodes 2011-07-17
===========================================
INFO:
Dev By:Episodes
The Technology Support: GTAYY,[MTS]hos_happy
The Translate By: Jeffery,Episodes
The BUG Fix By:[MTS]hos_happy
------------Testing------------
Episodes
Jeffery
[FCZ]Mr_Ghost
Liberty_Tester
GTAYY

Copyright (C) 2010 - 2011 Easy Mp Programming Dev Center ALL RECIEVED
==========About Just Now Movie==========
Just Now Moives From 2010 JUN started the first editon.v0.1 testing version.
first language it's English,we use the MOVIE-MAKER-MOD for first version downloaded in SA-MP Forums.
* 
*/

#include <a_samp>
#include <dudb>
#include <dutils>


#include <core>
#include <float>
//#pragma tabsize 0 // (Un)Mark this if you want PAWNO to ignore/recognize indentation.

// REACTION TESTpublic OnPlayerConnect(playerid)
#define time1 240000 //this is the 4 minute minimum gap time
#define time2 180000 // this is the 3 minute max addon time
#define INTERIORMENU 1500//Id Of 1500 室内空间
#define COLOUR_DEBUG 0x88AA62FF
new LightPwr[MAX_VEHICLES];
new Flasher[MAX_VEHICLES];
new FlasherState[MAX_VEHICLES];
new FlashTimer;
new reactionstr[9]; // randomly generated string
new reactioninprog; // what status the reactiontest is at
new reactionwinnerid; // id of the current reactiontest winner
new reactiongap; // timer to restart ReactionTest()
new playerworld[MAX_PLAYERS]=0;
new afk3dtext[MAX_PLAYERS];
new isplayerafk[MAX_PLAYERS]=0;//0== no , 1 = yes
new textgodmome[MAX_PLAYERS];
new isplayeringodmode[MAX_PLAYERS]=0;//0 = no 1 =yes
forward ReactionTest();
forward ReactionWin(playerid);
forward SetBack();
new GMTimer;
new sptimer[MAX_PLAYERS];
// END OF REACTION TEST

//====================================[DCMD]====================================
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

stock PlayerName(playerid) {
	new name[255];
	GetPlayerName(playerid, name, 255);
	return name;
}
//===================================[Forwards]=================================
forward IsPlayerxGAdmin(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward IsTutPasser(playerid);
forward SendClientMessageToAdmins(color,const string[]);
forward STut2(playerid);
forward STut3(playerid);
forward STut4(playerid);
forward STut5(playerid);
forward STut6(playerid);
forward STut7(playerid);
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
forward ProxDetectorS(Float:radi, playerid, targetid);
forward VehicleReset();
forward VehicleResetWarning();
forward OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);

#define SPECIAL_ACTION_PISSING      68
new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new animation[200];
new playermessage[MAX_PLAYERS]=0;
new gNameTags[MAX_PLAYERS];

//CAr



//car
new playerspawnpos[MAX_PLAYERS]=0;//1 =拍摄现场2.1 spawn pos, 2 = 拍摄现场1.0 pos,3 = GTAIP 4F Pos
new Text:lbt;
new Text:lbb;
new Text:site;
new Text:txtAnimHelper;
new gPlayerVehicles0[MAX_PLAYERS];
new gPlayerVehicles1[MAX_PLAYERS];
new gPlayerVehicles2[MAX_PLAYERS];
new gPlayerVehicles3[MAX_PLAYERS];
new gPlayerVehicles4[MAX_PLAYERS];
new gPlayerVehicles5[MAX_PLAYERS];
new times[MAX_PLAYERS];
new Text3D:label[MAX_PLAYERS];
new BigEar[MAX_PLAYERS];
new Admin[MAX_PLAYERS];
new TutorialPassed[MAX_PLAYERS];
new TunedSultan;
//pickups
new help;
//End(pickups)
forward SpawnVehicles();

forward TurnOffGod(playerid);

forward RandPlayer1();

forward SetRandomWeather();

enum weather_info
{
	wt_id,
	wt_text[255]
};
new aVehicleNames[212][] =
{
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
	{"Trailer 1"},
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
	{"Trailer 2"},
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
	{"Hotring Racer A"},
	{"Hotring Racer B"},
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
	{"Tanker"},
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
	{"Firetruck LA"},
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
	{"Monster A"},
	{"Monster B"},
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
	{"Freight Flat"},
	{"Streak Carriage"},
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
	{"Trailer 3"},
	{"Emperor"},
	{"Wayfarer"},
	{"Euros"},
	{"Hotdog"},
	{"Club"},
	{"Freight Carriage"},
	{"Trailer 3"},
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
	{"Luggage Trailer A"},
	{"Luggage Trailer B"},
	{"Stair Trailer"},
	{"Boxville"},
	{"Farm Plow"},
	{"Utility Trailer"}
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

new gRandomWeatherIDs[][weather_info] =
{
	{0,"Blue Sky"},
	{1,"Blue Sky"},
	{2,"Blue Sky"},
	{3,"Blue Sky"},
	{4,"Blue Sky"},
	{5,"Blue Sky"},
	{6,"Blue Sky"},
	{7,"Blue Sky"},
	{08,"Stormy"},
	{09,"Foggy"},
	{10,"Blue Sky"},
	{11,"Heatwave"},
	{17,"Heatwave"},
	{18,"Heatwave"},
	{12,"Dull"},
	{13,"Dull"},
	{14,"Dull"},
	{15,"Dull"},
	{16,"Dull & Rainy"},
	{19,"Sandstorm"},
	{20,"Smog"},
	{21,"Dark & Purple"},
	{22,"Black & Purple"},
	{23,"Pale Orange"},
	{24,"Pale Orange"},
	{25,"Pale Orange"},
	{26,"Pale Orange"},
	{27,"Fresh Blue"},
	{28,"Fresh Blue"},
	{29,"Fresh Blue"},
	{30,"Smog"},
	{31,"Smog"},
	{32,"Smog"},
	{33,"Dark"},
	{34,"Regular Purple"},
	{35,"Dull Brown"},
	{36,"Bright & Foggy"},
	{37,"Bright & Foggy"},
	{38,"Bright & Foggy"},
	{39,"Very Bright"},
	{40,"Blue & Cloudy"},
	{41,"Blue & Cloudy"},
	{42,"Blue & Cloudy"},
	{43,"Toxic"},
	{44,"Black Sky"},
	{700,"Weed Effect"},
	{150,"Darkest Weather Ever"}
};
new PlayerRainbowColors[200] = {
0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,
0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,
0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,
0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,0x3D0A4FFF,
0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,0x057F94FF,
0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,
0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,
0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,
0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,
0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,0xDCDE3DFF,
0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,
0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,
0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,
0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,
0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,
0x18F71FFF,0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,
0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,
0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,
0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,
0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,
0xD8C762FF,0xD8C762FF

};

#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_LIGHTBLUE 0x01FCFFC8
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_INVIS 0xAFAFAF00
#define COLOR_SPEC 0xBFC0C200
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_BRIGHTRED 0xFF0000AA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_VIOLET 0x9955DEEE
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_SEAGREEN 0x00EEADDF
#define COLOR_GRAYWHITE 0xEEEEFFC4
#define COLOR_LIGHTNEUTRALBLUE 0xabcdef66
#define COLOR_GREENISHGOLD 0xCCFFDD56
#define COLOR_LIGHTBLUEGREEN 0x0FFDD349
#define COLOR_NEUTRALBLUE 0xABCDEF01
#define COLOR_LIGHTCYAN 0xAAFFCC33
#define COLOR_LEMON 0xDDDD2357
#define COLOR_MEDIUMBLUE 0x63AFF00A
#define COLOR_NEUTRAL 0xABCDEF97
#define COLOR_BLACK 0x00000000
#define COLOR_NEUTRALGREEN 0x81CFAB00
#define COLOR_DARKGREEN 0x12900BBF
#define COLOR_DARKBLUE 0x300FFAAB
#define COLOR_BLUEGREEN 0x46BBAA00
#define COLOR_PINK 0xFF66FFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_RED1 0xFF0000AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BROWN 0x993300AA
#define COLOR_CYAN 0x99FFFFAA
#define COLOR_TAN 0xFFFFCCAA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_KHAKI 0x999900AA
#define COLOR_LIME 0x99FF00AA
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_AQUA 0x33CCFFAA
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
//Skin
#define SKIN_SELECT   	true
#define SKIN_SEL_STAT   1
#define SKIN_SELECT   	true
#define MIN_SKIN_ID		0
#define MAX_SKIN_ID		299
#define MISCEL_CMDS     true
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
new curPlayerSkin[MAX_PLAYERS]				= {MIN_SKIN_ID, ...};
new gPlayerStatus[MAX_PLAYERS];
new gPlayerTimers[MAX_PLAYERS];
forward SkinSelect(playerid);
new aSelNames[5][] = {			// Menu selection names
	{"自定义人物"},
	{"VehicleSelect"},
	{"WeatherSelect"},
	{"CameraSelect"},
	{"自定义摆放模型"}
};
#include <Dini>
#define VERSION "v0.1"
#define COLOR_WHITE	0xFFFFFFFF
#define MusicFile "MusicList.db"//播放列表储存路径
#define MAX_MUSIC_LIST 9 //对话框每页可以显示 最大音乐数量  默认为9 可设置

//响应话框 ID 若有冲突可以修改这里
#define PMusicDialogid 780
#define AddMusicDialogid 781
#define AddMusicUrlDialogid 782
new MusicPage[MAX_PLAYERS];//记录玩家当前播放页数
new MusicName[MAX_PLAYERS][128];



//MOVING CAMERA
// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>

//where the player will spawn
#define player_x 1678.8542
#define player_y 1448.2733
#define player_z 47.7780
#define player_angle 210.3500

//PLAYER CAMERA, THE ONE YOU CREATE SO YOU CAN SEE THE PLAYER
//note: for a better effect, let the camera be a few meters away from the player
#define camera_x 1679.210205
#define camera_y 1447.770752
#define camera_z 47.438412

//ATTENTION; THESE ARE MILISECONDS
//untested, but it should work in theory. The smaller the value, the faster the camera.
#define moving_speed 20

//declaring stuff
//IMPORTANT: FOR THE CODE TO WORK, YOU MUST DEFINE THE ENUM BEFORE PlayerInfo
//just copy it like It's written here
enum pInfo
{
    bool:SpawnDance,
    Float:SpawnAngle,
    SpawnTimer
};


new PlayerInfo[MAX_PLAYERS][pInfo];



main()
{
	print("\r\n=================================================|");
	print("|                                                    |");
	print("|          拍攝現場v2.4[beta3] [正體中文]             |");
	print("|             English :Just Now Movie!               |");
	print("|               The Last Edition                     |");
	print("|     --------------------------------------------   |");
	print("|          腳本開發:     By Episodes                 |");
	print("|          程序翻譯:     By Jeffery                  |");
	print("|          技術提供:     By GTAYY                    |");
	print("|    本腳本會自動載入FS,所以請在Server.cfg裏面留空!  |");
	print("|                                                    |");
	print("=====================================================\r\n");
}
//CARS
CreatePlayerVehicle( playerid, modelid )
{
new
vehicle,
Float:x,
Float:y,
Float:z,
Float:angle;
GetPlayerPos(playerid,x,y,z);
vehicle = CreateVehicle( modelid, x, y, ( z + 1 ), angle, -1, -1,0);
LinkVehicleToInterior( vehicle, GetPlayerInterior( playerid ) );
#if !defined IGNORE_VIRTUAL_WORLDS
SetVehicleVirtualWorld( vehicle, GetPlayerVirtualWorld( playerid ) );
#endif
#if !defined IGNORE_WARP_INTO_VEHICLE
PutPlayerInVehicle( playerid, vehicle, 0 );
#endif
#if !defined IGNORE_VEHICLE_DELETION
//gDialogCreated[ vehicle ] = true;
#endif
if (times[playerid]<6)
{
if (times[playerid]==5)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles5[playerid] = vehicle = GetPlayerVehicleID( playerid );
}
if (times[playerid]==4)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles4[playerid] = vehicle = GetPlayerVehicleID( playerid );
}
if (times[playerid]==3)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles3[playerid] = vehicle = GetPlayerVehicleID( playerid );
}
if (times[playerid]==2)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles2[playerid] = vehicle = GetPlayerVehicleID( playerid );
}

if (times[playerid]==1)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles1[playerid] = vehicle = GetPlayerVehicleID( playerid );
}
if (times[playerid]==0)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles0[playerid] = vehicle = GetPlayerVehicleID( playerid );
}
} else {
SendClientMessage(playerid,COLOR_YELLOW,"[车管]：你不能再刷车了，请输入/dc删除！");
return 1;
}
return 1;
}

ShowPlayerDefaultDialog( playerid )
{
if (times[playerid]<6)
{
	ShowPlayerDialog( playerid, 3434, DIALOG_STYLE_LIST, "交通工具：Vehicle Types：", "飞机，Airplanes\n直升机，Helicopters\n摩托车，Bikes\n敞篷车，Convertibles\n农业用车Industrial\n低底盘车Lowriders\n越野车Off Road\nPublic 服务性交通工具Public Service Vehicles\n可改装Saloons\n跑车Sport Vehicles\n面包车Station Wagons\n船Boats\n火车Trailers\n未分类Unique Vehicles\n遥控车RC Vehicles","确定OK", "取消Cancel" );
	return 1;
} else {
SendClientMessage(playerid,COLOR_YELLOW,"[车管]：你不能再刷车了，请输入/dc删除！");
}
return 1;
}
public OnGameModeInit()
{

    //UsePlayerPedAnims(); If we use this function some of the players may not happy.
	SetGameModeText("拍攝現場2.4[beta]");
    SetWeather(17);
    SetWorldTime(04);
    AddPlayerClass(0,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //0 -
	AddPlayerClass(280,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //0 -
	AddPlayerClass(281,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //1 -
	AddPlayerClass(282,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //2 -
	AddPlayerClass(283,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //3 -
	AddPlayerClass(284,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //4 -
	AddPlayerClass(285,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //5 -
	AddPlayerClass(286,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //6 -
	AddPlayerClass(287,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //7 -
	
	AddPlayerClass(254,1958.3783,1343.1572,15.3746,0.0,0,0,24,300,-1,-1);      //8
	AddPlayerClass(255,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //9 -
	AddPlayerClass(256,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //10 -
	AddPlayerClass(257,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //11 -
	AddPlayerClass(258,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //12 -
	AddPlayerClass(259,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //13 -
	AddPlayerClass(260,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //14 -
	AddPlayerClass(261,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //15
	AddPlayerClass(262,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //16
	AddPlayerClass(263,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //17
	AddPlayerClass(264,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //18 -
	AddPlayerClass(274,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //19 -
	AddPlayerClass(275,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //20 -
	AddPlayerClass(276,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //21 -
	
	AddPlayerClass(1,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //22 -
	AddPlayerClass(2,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //23
	AddPlayerClass(290,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //24
	AddPlayerClass(291,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //25
	AddPlayerClass(292,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //26
	AddPlayerClass(293,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //27
	AddPlayerClass(294,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //28
	AddPlayerClass(295,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //29
	AddPlayerClass(296,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //30 -
	AddPlayerClass(297,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //31
	AddPlayerClass(298,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //32
	AddPlayerClass(299,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //33
	
	AddPlayerClass(277,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //34 -
	AddPlayerClass(278,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //35 -
	AddPlayerClass(279,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //36 -
	AddPlayerClass(288,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //37
	AddPlayerClass(47,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //38
	AddPlayerClass(48,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //39
	AddPlayerClass(49,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //40
	AddPlayerClass(50,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //41
	AddPlayerClass(51,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //42
	AddPlayerClass(52,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //43
	AddPlayerClass(53,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //44
	AddPlayerClass(54,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //45
	AddPlayerClass(55,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //46
	AddPlayerClass(56,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //47
	AddPlayerClass(57,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //48
	AddPlayerClass(58,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //49
	AddPlayerClass(59,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //50
	AddPlayerClass(60,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //51
	AddPlayerClass(61,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //52 -
	AddPlayerClass(62,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //53
	AddPlayerClass(63,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //54 -
	AddPlayerClass(64,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //55 -
	AddPlayerClass(66,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //56
	AddPlayerClass(67,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //57
	AddPlayerClass(68,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //58
	AddPlayerClass(69,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //59
	AddPlayerClass(70,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //60
	AddPlayerClass(71,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //61
	AddPlayerClass(72,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //62
	AddPlayerClass(73,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //63
	AddPlayerClass(75,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //64 -
	AddPlayerClass(76,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //65
	AddPlayerClass(78,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //66 -
	AddPlayerClass(79,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //67 -
	AddPlayerClass(80,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //68 -
	AddPlayerClass(81,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //69 -
	AddPlayerClass(82,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //70 -
	AddPlayerClass(83,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //71 -
	AddPlayerClass(84,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //72 -
	AddPlayerClass(85,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //73 -
	AddPlayerClass(87,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //74 -
	AddPlayerClass(88,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //75
	AddPlayerClass(89,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //76
	AddPlayerClass(91,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //77
	AddPlayerClass(92,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //78 -
	AddPlayerClass(93,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //79 -
	AddPlayerClass(95,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //80
	AddPlayerClass(96,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //81
	AddPlayerClass(97,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //82 -
	AddPlayerClass(98,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //83
	AddPlayerClass(99,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //84
	AddPlayerClass(100,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //85
	AddPlayerClass(101,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //86
	AddPlayerClass(102,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //87 -
	AddPlayerClass(103,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //88 -
	AddPlayerClass(104,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //89 -
	AddPlayerClass(105,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //90 -
	AddPlayerClass(106,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //91 -
	AddPlayerClass(107,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //92 -
	AddPlayerClass(108,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //93 -
	AddPlayerClass(109,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //94 -
	AddPlayerClass(110,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //95 -
	AddPlayerClass(111,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //96
	AddPlayerClass(112,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //97
	AddPlayerClass(113,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //98
	AddPlayerClass(114,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //99 -
	AddPlayerClass(115,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //100 -
	AddPlayerClass(116,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //101 -
	AddPlayerClass(117,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //102
	AddPlayerClass(118,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //103
	AddPlayerClass(120,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //104
	AddPlayerClass(121,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //105
	AddPlayerClass(122,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //106 -
	AddPlayerClass(123,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //107
	AddPlayerClass(124,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //108
	AddPlayerClass(125,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //109
	AddPlayerClass(126,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //110
	AddPlayerClass(127,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //111
	AddPlayerClass(128,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //112
	AddPlayerClass(129,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //113
	AddPlayerClass(131,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //114
	AddPlayerClass(133,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //115
	AddPlayerClass(134,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //116
	AddPlayerClass(135,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //117
	AddPlayerClass(136,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //118
	AddPlayerClass(137,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //119 -
	AddPlayerClass(138,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //120 -
	AddPlayerClass(139,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //121 -
	AddPlayerClass(140,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //122 -
	AddPlayerClass(141,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //123
	AddPlayerClass(142,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //124
	AddPlayerClass(143,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //125
	AddPlayerClass(144,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //126 -
	AddPlayerClass(145,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //127 -
	AddPlayerClass(146,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //128 -
	AddPlayerClass(147,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //129
	AddPlayerClass(148,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //130
	AddPlayerClass(150,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //131
	AddPlayerClass(151,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //132
	AddPlayerClass(152,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //133 -
	AddPlayerClass(153,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //134
	AddPlayerClass(154,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //135 -
	AddPlayerClass(155,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //136
	AddPlayerClass(156,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //137
	AddPlayerClass(157,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //138 -
	AddPlayerClass(158,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //139 -
	AddPlayerClass(159,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //140 -
	AddPlayerClass(160,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //141 -
	AddPlayerClass(161,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //142 -
	AddPlayerClass(162,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //143 -
	AddPlayerClass(163,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //144 -
	AddPlayerClass(164,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //145 -
	AddPlayerClass(165,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //146 -
	AddPlayerClass(166,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //147 -
	AddPlayerClass(167,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //148 -
	AddPlayerClass(168,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //149
	AddPlayerClass(169,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //150
	AddPlayerClass(170,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //151
	AddPlayerClass(171,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //152
	AddPlayerClass(172,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //153
	AddPlayerClass(173,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //154 -
	AddPlayerClass(174,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //155 -
	AddPlayerClass(175,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //156 -
	AddPlayerClass(176,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //157
	AddPlayerClass(177,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //158
	AddPlayerClass(178,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //159 -
	AddPlayerClass(179,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //160 -
	AddPlayerClass(180,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //161
	AddPlayerClass(181,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //162
	AddPlayerClass(182,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //163
	AddPlayerClass(183,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //164
	AddPlayerClass(184,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //165
	AddPlayerClass(185,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //166
	AddPlayerClass(186,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //167
	AddPlayerClass(187,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //168
	AddPlayerClass(188,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //169
	AddPlayerClass(189,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //170
	AddPlayerClass(190,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //171
	AddPlayerClass(191,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //172
	AddPlayerClass(192,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //173
	AddPlayerClass(193,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //174
	AddPlayerClass(194,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //175
	AddPlayerClass(195,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //176
	AddPlayerClass(196,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //177
	AddPlayerClass(197,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //178
	AddPlayerClass(198,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //179
	AddPlayerClass(199,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //180
	AddPlayerClass(200,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //181
	AddPlayerClass(201,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //182
	AddPlayerClass(202,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //183
	AddPlayerClass(203,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //184 -
	AddPlayerClass(204,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //185 -
	AddPlayerClass(205,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //186 -
	AddPlayerClass(206,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //187
	AddPlayerClass(207,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //188
	AddPlayerClass(209,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //189
	AddPlayerClass(210,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //190
	AddPlayerClass(211,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //191
	AddPlayerClass(212,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //192
	AddPlayerClass(213,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //193 -
	AddPlayerClass(214,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //194
	AddPlayerClass(215,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //195
	AddPlayerClass(216,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //196
	AddPlayerClass(217,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //197
	AddPlayerClass(218,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //198
	AddPlayerClass(219,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //199
	AddPlayerClass(220,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //200
	AddPlayerClass(221,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //201
	AddPlayerClass(222,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //202
	AddPlayerClass(223,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //203
	AddPlayerClass(224,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //204
	AddPlayerClass(225,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //205
	AddPlayerClass(226,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //206
	AddPlayerClass(227,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //207
	AddPlayerClass(228,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //208
	AddPlayerClass(229,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //209 -
	AddPlayerClass(230,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //210 -
	AddPlayerClass(231,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //211
	AddPlayerClass(232,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //212
	AddPlayerClass(233,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //213
	AddPlayerClass(234,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //214
	AddPlayerClass(235,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //215
	AddPlayerClass(236,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //216
	AddPlayerClass(237,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //217
	AddPlayerClass(238,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //218
	AddPlayerClass(239,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //219
	AddPlayerClass(240,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //220
	AddPlayerClass(241,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //221 -
	AddPlayerClass(242,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //222 -
	AddPlayerClass(243,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //223
	AddPlayerClass(244,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //224
	AddPlayerClass(245,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //225
	AddPlayerClass(246,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //226 -
	AddPlayerClass(247,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //227
	AddPlayerClass(248,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //228
	AddPlayerClass(249,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //229 -
	AddPlayerClass(250,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //230
	AddPlayerClass(251,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //231
	AddPlayerClass(253,1690.4220,1439.8679,10.7663,270.3860,0,0,0,0,0,0);      //232 -
	//SpawnVehicles();
	//腳本載入
	SendRconCommand("loadfs 宠物选择");
    SendRconCommand("loadfs others");
    SendRconCommand("loadfs tele");
    SendRconCommand("loadfs animlistbywoozie");
	SendRconCommand("loadfs Spectate");
	SendRconCommand("loadfs map");
    SendRconCommand("loadfs close_shop");
    SendRconCommand("loadfs vactions");
    SendRconCommand("loadfs new_map");
    SendRconCommand("loadfs swear");
    SendRconCommand("loadfs FS");
    SendRconCommand("loadfs Bs_loader");

	print("=================加載完成！=================\n如果有錯誤請確認你的FS文件夾.\n我會把所有的腳本在下面列出來\n請看下");
	print("所有腳本有:\n宠物选择\nothers\ntele\nanimlistbywoozie\nSpectate\nmap\nclose_shop\nvactions\nnew_map\nswear\nFS\nBs_loader\n請再次確認你是否都有這些腳本\n=======================================");
	Create3DTextLabel("欢迎来到拍摄现场",0xFFFFFFFF,1699.5048,1431.4244,16.00,40,0);
	Create3DTextLabel("程序开发:Episodes",0xFFFF00FF,1699.5048,1431.4244,15.5029,40,0);
	Create3DTextLabel("技术支持:GTAYY",0xFFFF00FF,1699.5048,1431.4244,15.00,40,0);
	Create3DTextLabel("网站:www.easy-mp.co.cc",0xFFFF00FF,1699.5048,1431.4244,14.50,40,0);
	Create3DTextLabel("请输入/help 查看基本的命令",0xFF0000FF,1699.5048,1431.4244,14.00,40,0);
	//-------------------------------------------------------------------------------------
    Create3DTextLabel("GTAIP-电影拍摄世界",0x00FF00FF,1477.8623,-1668.2054,23.00,40,0);
    Create3DTextLabel("[出生地]",0xFFFF00FF,1477.8623,-1668.2054,22.50,40,0);
    Create3DTextLabel("需要帮助请输入/help",0xFF0000FF,1477.8623,-1668.2054,22.00,40,0);
    //-------------------------------------------------------------------------------------
    Create3DTextLabel("拍摄现场1.0[经典出生地]",0xFFFF00AA,917.5461,-1221.1047,25.63,20,0,1);
    Create3DTextLabel("服务器汉化者:Jeffery",0xFFFFFFAA,917.5461,-1221.1047,25.3,20,0,1);
    Create3DTextLabel("服务器制作者Episodes",0xFFFFFFAA,917.5461,-1221.1047,24.83,20,0,1);
    Create3DTextLabel("技术提供：GTA-YY",0xFFFFFFAA,917.5461,-1221.1047,24.63,20,0,1);
    Create3DTextLabel("---------------------",0xAA3333AA,917.5461,-1221.1047,24.43,20,0,1);
    Create3DTextLabel("输入/help查看帮助",0xFF6347AA,917.5461,-1221.1047,24.23,20,0,1);
	//-------------------------------------------------------------------------------------
	Create3DTextLabel("私人机场",0x00FF00FF,178.0179,-4200.6860,7.00,40,0);
    Create3DTextLabel("[出生地]",0xFFFF00FF,178.0179,-4200.6860,6.50,40,0);
    Create3DTextLabel("需要帮助请输入/help",0xFF0000FF,178.0179,-4200.6860,6.00,40,0);
   	//AddStaticPickup(370, 2,1702.3940,1441.3772,10.7982,0);
	/*help=CreatePickup(1239,1,1702.5867,1445.3911,10.8188,0);
	help=CreatePickup(1239,1,1478.4033,-1681.7511,14.0469,0);
    help=CreatePickup(1239,1,912.3426,-1229.8248,16.9766,0);
	*//*site = TextDrawCreate(397.000000,433.000000,"Www.Sa-Mp.Com");
	TextDrawAlignment(site,0);
	TextDrawBackgroundColor(site,0x000000ff);
	TextDrawFont(site,3);
	TextDrawLetterSize(site,0.499999,1.300000);
	TextDrawColor(site,0xff0000ff);
	TextDrawSetOutline(site,1);
	TextDrawSetProportional(site,1);
	TextDrawSetShadow(site,10);
	
	txtAnimHelper = TextDrawCreate(610.0, 400.0,"~b~~k~~PED_LOCK_TARGET~ ~w~to stop the animation");
	TextDrawUseBox(txtAnimHelper, 0);
	TextDrawFont(txtAnimHelper, 2);
	TextDrawSetShadow(txtAnimHelper,0);
	TextDrawSetOutline(txtAnimHelper,1);
	TextDrawBackgroundColor(txtAnimHelper,0x000000FF);
	TextDrawColor(txtAnimHelper,0xFFFFFFFF);
	TextDrawAlignment(txtAnimHelper,3);*/
	return 1;
}



public SpawnVehicles()
{

	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
GivePlayerMoney(playerid,99999999);
SetPlayerHealth(playerid,100);

return;
}


public OnPlayerRequestClass(playerid, classid)
{
 SetPlayerPos(playerid, player_x,player_y,player_z);
    SetPlayerFacingAngle(playerid, player_angle);
    SetPlayerCameraPos(playerid, camera_x,camera_y,camera_z);
    SetPlayerCameraLookAt(playerid, player_x,player_y,player_z);
    ApplyAnimation(playerid,"DANCING","DNCE_M_B",4.0,1,0,0,0,-1); //smooth dancing. It's most fitting to the music
    PlayerPlaySound(playerid, 1097,-119.9460,23.1096,12.2238); //music, duh
    //making sure the timer gets executed only once, so the camera doesn't go to fast
    if (PlayerInfo[playerid][SpawnDance]) PlayerInfo[playerid][SpawnTimer] = SetTimerEx("MoveCamera", moving_speed, true, "i", playerid);
    PlayerInfo[playerid][SpawnDance] = false; //preventing the timer to execute again
	return 1;
}
PreloadAnimLib(playerid, animlib[]) ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);

public OnPlayerRequestSpawn(playerid)
{
SetPlayerCheckpoint(playerid,923.1230,-1209.6195,16.9766,4.0);
Create3DTextLabel("碰我金钱满",0xFFFF00AA,923.1230,-1209.6195,16.9766,20,0,1);
    if(playerspawnpos[playerid]==2)//old pos
    {
    SetPlayerTime(playerid,12,0);
    SetPlayerWeather(playerid,1);
   	return 1;
    }
    if(playerspawnpos[playerid]==3)//4f pos
    {
    SetPlayerTime(playerid,12,0);
    SetPlayerWeather(playerid,0);
    return 1;
   	}
    if(playerspawnpos[playerid]==4)//LS Private Airport Island
    {
    SetPlayerTime(playerid,12,0);
    SetPlayerWeather(playerid,0);
    return 1;
   	}
return 1;
}
public OnPlayerText(playerid, text[])
{
new string[128];
new name[24];
GetPlayerName(playerid,name,sizeof(name));
format(string,sizeof(string),"[ID:%d]: %s: %s",playerid,name,text);
SendClientMessageToAll(GetPlayerColor(playerid),string);
return 0;
}
public OnPlayerConnect(playerid)
{

    PreloadAnimLib(playerid,"BOMBER");
    PreloadAnimLib(playerid,"RAPPING");
    PreloadAnimLib(playerid,"SHOP");
    PreloadAnimLib(playerid,"BEACH");
    PreloadAnimLib(playerid,"SMOKING");
    PreloadAnimLib(playerid,"FOOD");
    PreloadAnimLib(playerid,"ON_LOOKERS");
    PreloadAnimLib(playerid,"DEALER");
    PreloadAnimLib(playerid,"CRACK");
    PreloadAnimLib(playerid,"CARRY");
    PreloadAnimLib(playerid,"COP_AMBIENT");
    PreloadAnimLib(playerid,"PARK");
    PreloadAnimLib(playerid,"INT_HOUSE");
    PreloadAnimLib(playerid,"FOOD");
    PreloadAnimLib(playerid,"PED");
    //so the timer can be executed again
    PlayerInfo[playerid][SpawnDance] = true;
    ApplyAnimation(playerid,"DANCING","DNCE_M_B",4.0,1,0,0,0,-1); //preventing a bug for the animation not being applied the first time OnPlayerRequestClass is called
    SetPlayerColor(playerid, PlayerRainbowColors[playerid]);
 //IsLoggedIn[playerid]=false;
	//gPlayerUsingLoopingAnim[playerid] = 0;
	//gPlayerAnimLibsPreloaded[playerid] = 0;
	SendDeathMessage(INVALID_PLAYER_ID,playerid,200);
	new Player[24];
	GetPlayerName(playerid, Player, sizeof(Player));
	new string[128];
	format(string, sizeof(string), "**[服务器] %s [ID:%d] 进入了片场", Player, playerid);
	label[playerid] = Create3DTextLabel("", 0x008080FF, 30.0, 40.0, 50.0, 40.0, 0);
    Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.7);
	SendClientMessageToAll(0x9ACD32AA, string);
	gNameTags[playerid] = 1;
	TutorialPassed[playerid] = 1;
    PlayerPlaySound(playerid,1068,0.0,0.0,0.0);
    
    
    ShowPlayerDialog(playerid,911,DIALOG_STYLE_LIST,"选择出生点","欢迎您，请选择个你喜欢的出生点\n1.拍摄现场2.0[默认出生点]\n2.拍摄现场1.0出生点\n3.电影服(GTAIP - 4F)的出生点\n4.私人机场","OK","关闭");
	return 0;
}




public OnPlayerDisconnect(playerid,reason)
{
KillTimer( PlayerInfo[playerid][SpawnTimer] );
playerworld[playerid]=0;
if (times[playerid]>0)
{
DestroyVehicle(gPlayerVehicles0[playerid]);
DestroyVehicle(gPlayerVehicles1[playerid]);
DestroyVehicle(gPlayerVehicles2[playerid]);
DestroyVehicle(gPlayerVehicles3[playerid]);
DestroyVehicle(gPlayerVehicles4[playerid]);
DestroyVehicle(gPlayerVehicles5[playerid]);
gPlayerVehicles1[playerid] = 0;
gPlayerVehicles2[playerid] = 0;
gPlayerVehicles3[playerid] = 0;
gPlayerVehicles4[playerid] = 0;
gPlayerVehicles5[playerid] = 0;
times[playerid]=0;
}
Delete3DTextLabel(label[playerid]);

DestroyObject(GetPVarInt(playerid, "blue"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "blue1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "undercover"));
DestroyObject(GetPVarInt(playerid, "undercover1"));
DeletePVar(playerid, "Status");
//============NEW TESTING=======================
/*DestroyObject(GetPVarInt(playerid, "blue"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "blue1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld2"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld3"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld4"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld5"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld6"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld7"));
DeletePVar(playerid, "neon");
//==============================================*/
SendDeathMessage(INVALID_PLAYER_ID,playerid,201);
new PlayerN[24];
new string[128];
GetPlayerName(playerid, PlayerN, sizeof(PlayerN));
gNameTags[playerid] = 0;
playermessage[playerid]=0;
isplayerafk[playerid]=0;
isplayeringodmode[playerid]=0;
Delete3DTextLabel(textgodmome[playerid]);
Delete3DTextLabel(label[playerid]);
Delete3DTextLabel(afk3dtext[playerid]);
switch (reason)
{
		case 0:
		{
			format(string, sizeof(string), "**[服务器] %s 离开了片场 [非正常退出]", PlayerN);
			SendClientMessageToAll(0x9ACD32AA, string);
		}
		case 1:
		{
			format(string, sizeof(string), "**[服务器] %s 离开了片场 [正常退出]", PlayerN);
			SendClientMessageToAll(0x9ACD32AA, string);
		}
		case 2:
		{
			format(string, sizeof(string), "**[服务器] %s 离开了片场. [封了或被管理员T了]", PlayerN);
			SendClientMessageToAll(0x9ACD32AA, string);
		}
	}






return false;
}

public OnPlayerSpawn(playerid)
{
//PICKUP
	//help
	//jecpac
	
    //UsePlayerPedAnims();
	//end(help)
	//textdraw
	//Forhelp
	/*Create3DTextLabel("帮助中心",0x33AA33AA,1702.5867,1445.3911,10.8188,20,0,0);
	Create3DTextLabel("帮助中心",0x33AA33AA,1478.4033,-1681.7511,14.0469,20,0,0);
	Create3DTextLabel("帮助中心",0x33AA33AA,912.3426,-1229.8248,16.9766,20,0,0);
	//Forjectpack
	Create3DTextLabel("飞行器",0x33AA33AA,1702.3940,1441.3772,10.7982,20,0,1);*/

	//PICKUP

	PlayerPlaySound(playerid,1077,0.0,0.0,0.0);

    PlayerInfo[playerid][SpawnAngle] = 0.0; //so when you leave and another player comes, the camera will start from start
    PlayerInfo[playerid][SpawnDance] = true; //to not execute to much timers
    KillTimer( PlayerInfo[playerid][SpawnTimer] ); //to kill it, since its useless now
    PlayerPlaySound(playerid, 1186, 0.0, 0.0, 0.0); // (blank sound) to shut the music up
    SetCameraBehindPlayer(playerid); //to prevent some bugs
	//new rand = random(sizeof(gRandomPlayerSpawns));
	//GivePlayerMoney(playerid,dUserINT(PlayerName(playerid)).("Cash")-GetPlayerMoney(playerid));

	/*if(!gPlayerAnimLibsPreloaded[playerid])
	{
		PreloadAnimLib(playerid,"BOMBER");
		PreloadAnimLib(playerid,"RAPPING");
		PreloadAnimLib(playerid,"SHOP");
		PreloadAnimLib(playerid,"BEACH");
		PreloadAnimLib(playerid,"SMOKING");
		PreloadAnimLib(playerid,"FOOD");
		PreloadAnimLib(playerid,"ON_LOOKERS");
		PreloadAnimLib(playerid,"DEALER");
		PreloadAnimLib(playerid,"CRACK");
		PreloadAnimLib(playerid,"CARRY");
		PreloadAnimLib(playerid,"COP_AMBIENT");
		PreloadAnimLib(playerid,"PARK");
		PreloadAnimLib(playerid,"INT_HOUSE");
		PreloadAnimLib(playerid,"FOOD");
		PreloadAnimLib(playerid,"PED");
		gPlayerAnimLibsPreloaded[playerid] = 1;
	}*/
    SendClientMessage(playerid,0xFFFFFFFF, "需要帮助请输入{FF0000}/help");
    SendClientMessage(playerid,0xFFFFFFFF,"查看新版功能{FF0000}/whatnew");
    SetPlayerVirtualWorld(playerid,playerworld[playerid]);
   	new name [600];
    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	if(playermessage[playerid]==0)
	{
	format(name,256,"{FFFFFF}欢迎你，本服为{EEEE88}完全自由{FFFFFF}的模式，所以你可以随心所欲的做你喜欢的事，但是还是请你不要去影响其他玩家，尽量做个合格的玩家!!\n-----开发者致所以玩家的一条信息\n{FF1400}注:2.4版本以后加了一些管理功能.\n注:本服为怀旧纪念意义而开,想体验更多请去最新版本->7777");
    ShowPlayerDialog(playerid,DIALOG_STYLE_MSGBOX,0,"欢迎中心",name,"开始游戏","");
	playermessage[playerid]=1;
	}
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
    SendClientMessage(playerid, 0xFFFFFFAA, "[系统]:你出身了");
	if(playerspawnpos[playerid]==0)//now
	{
	}
    if(playerspawnpos[playerid]==1)//now
    {

    }
    if(playerspawnpos[playerid]==2)//old pos
    {
    SetPlayerPos(playerid,904.3836,-1219.7582,16.9766);
   	PlayerPlaySound(playerid,1077,0.0,0.0,0.0);
   	return 1;
    }
    if(playerspawnpos[playerid]==3)//4f pos
    {
    SetPlayerPos(playerid,1477.8623,-1668.2054,14.5532);
   	PlayerPlaySound(playerid,1077,0.0,0.0,0.0);
   	return 1;
    }
    if(playerspawnpos[playerid]==4)//4f pos
    {
    new string[100];
    SetPlayerPos(playerid,178.0179,-4200.6860,5.3910);
	TogglePlayerControllable(playerid,0);
    format(string, sizeof(string), "Please Wait 3 Seconds  Thank You");
    GameTextForPlayer(playerid, string, 3000, 4);
    sptimer[playerid] = SetTimerEx("spwait", 2000, true, "i", playerid);
   	PlayerPlaySound(playerid,1077,0.0,0.0,0.0);
   	return 1;
    }
	return 1;
}

forward MoveCamera(playerid);
public MoveCamera(playerid)
{
    //this is called trigonometry. It makes the camera spin
    //you can experiment with this line. Just change the values 2, 10 and 3 to make different effects
  SetPlayerCameraPos(playerid, player_x - 2 * floatsin(-PlayerInfo[playerid][SpawnAngle], degrees), player_y - 10 * floatcos(-PlayerInfo[playerid][SpawnAngle], degrees), player_z + 3);
  SetPlayerCameraLookAt(playerid, player_x, player_y, player_z + 0.5);

    //changing the angle a little
  PlayerInfo[playerid][SpawnAngle] += 0.5;

  if (PlayerInfo[playerid][SpawnAngle] >= 360.0)
    PlayerInfo[playerid][SpawnAngle] = 0.0;

}


public OnPlayerDeath(playerid, killerid, reason)
{
    PlayerPlaySound(playerid,1068,0.0,0.0,0.0);
	new pname[256];
	new string[256];
	new name[256];
	new killername[65];
	GetPlayerName(killerid,killername,65);
    GetPlayerName(playerid,pname,128);
    format(string, sizeof(string), "[系统]:玩家{FF0000} %s {AAAAAA}挂了",pname);
    SendClientMessageToAll(0xFFFFFFFF,string);
    format(name,256,"[你挂了]\n杀你的人: %s",killername);
    ShowPlayerDialog(playerid,DIALOG_STYLE_MSGBOX,0,"[系统]",name,"重生","关闭");
	return 1;
}


public OnPlayerStateChange(playerid,newstate,oldstate)
{


if (newstate == PLAYER_STATE_DRIVER)
{
SendClientMessage(playerid,0x33CCFFAA," [________汽车信息________]：");
new carid;
new string[256];
new mess[123];
carid= GetPlayerVehicleID(playerid);
format(mess, sizeof(mess),"你刷了第{00C300} %d {FFFFFF}辆车，你最多可以刷{00C300}6{FFFFFF}辆车.",times[playerid]);
format(string, sizeof(string), "这辆车的顺序ID是:{FF0000}%d",carid);
SendClientMessage(playerid,0xFFFFFFFF,mess);
SendClientMessage(playerid,0x33CCFFAA,string);
SendClientMessage(playerid,0xFFFFFFFF,"输入{FF0000} /tun {FFFFFF}进行车辆改装.");
SendClientMessage(playerid,0xFFFFFFFF,"车坏了了可以使用{FF0000}/fix {FFFFFF}修复.");
SendClientMessage(playerid,0xFFFFFFFF,"输入{FF0000}/dc{FFFFFF}把车删掉.");
}
return 1;
}
//----------------------------------SSEL
dcmd_s(playerid)
{

	// /ssel allows players to select a skin using playerkeys.

    SendClientMessage(playerid, COLOR_GREEN, "人物更换系统帮助:");
    SendClientMessage(playerid, COLOR_RED, "<1>左右(←→)*按键*选择人物类型");
    SendClientMessage(playerid, COLOR_RED, "<2>TAB*按键*保存并退出选择模式");
	new cString[128];
	if (gPlayerStatus[playerid] != 0) {
	format(cString, 128, "错误<!>: 你已经在使用 \"%s\".", aSelNames[gPlayerStatus[playerid] - 1]);
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

	gPlayerTimers[playerid] = SetTimerEx("SkinSelect", 200, 1, "i", playerid);

	return true;
}
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

  		format(cString, 128, "SkinID: %d", curPlayerSkin[playerid]);
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

		format(cString, 128, "SkinID: %d", curPlayerSkin[playerid]);
  		GameTextForPlayer(playerid, cString, 1500, 3);
  		SetPlayerSkin(playerid, curPlayerSkin[playerid]);
	}

	// Action key exits skin selection
	if(keys & KEY_ACTION)
	{
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, 1);

		format(cString, 128, "[人物更换]: 你选择了ID %d的人物", curPlayerSkin[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, cString);

		gPlayerStatus[playerid] = 0;
		KillTimer(gPlayerTimers[playerid]);
	}
}
IsInvalidSkin(skinid)
{
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
//------------------------------SSEL-------------------------


public OnPlayerCommandText(playerid,cmdtext[])
{
new tmp[256];
new idx;
new cmd[256];
#if MISCEL_CMDS == true
dcmd(s,1,cmdtext);
#endif
cmd = strtok(cmdtext, idx);

if(strcmp(cmd, "/carcolor", true) == 0)
{
new color1, color2;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_YELLOW, "[用法]: /carcolor [color1] [color2]");
color1 = strval(tmp);
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_YELLOW, "[用法] /carcolor [color1] [color2]");
color2 = strval(tmp);
ChangeVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
return 1;
}
//Vn Cars Spawn
//givecash
if(strcmp(cmd, "/givecash", true) == 0)
	 {
	  	new tmp[256];
		new string[256];
		new playermoney;
		new sendername[MAX_PLAYER_NAME];
		new giveplayer[MAX_PLAYER_NAME];
 		new giveplayerid, moneys;
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFFFFFFFF, "[用法]:{FF0000} /givecash {FFFFFF}[玩家id] [数量]");
			return 1;
		}
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFFFFFFFF, "[用法]:{FF0000} /givecash {FFFFFF}[玩家id] [数量]");
			return 1;
		}
			if(strval(tmp)==playerid)
		{
			SendClientMessage(playerid, COLOR_YELLOW, "错误，不能自己给自己钱");
			return 1;
		}
		moneys = strval(tmp);

		//printf("givecash_command: %d %d",giveplayerid,moneys);

		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetPlayerMoney(playerid);

			if (moneys > 0 && playermoney >= moneys)
			{
				GivePlayerMoney(playerid, (0 - moneys));
				GivePlayerMoney(giveplayerid, moneys);
				format(string, sizeof(string), "{FFFFFF}你给了玩家{FF0000} %s(id: %d),{00C3FF}$%d {FFFFFF}多钱", giveplayer,giveplayerid, moneys);
				SendClientMessage(playerid, COLOR_WHITE, string);
				format(string, sizeof(string), "{FFFFFF}你得到了{00C3FF} $%d {FFFFFF}钱来自玩家{FF0000} %s(id:%d).", moneys, sendername, playerid);
				SendClientMessage(giveplayerid, COLOR_GREEN, string);
				PlayerPlaySound(playerid,1084,0.0,0.0,0.0);
				format(string, sizeof(string),"{FFFFFF}[给钱]: 玩家{00C3FF} %s {FFFFFF}给玩家{00C3FF} %s{00C3FF} %d {FFFFFF}钱,{FFFFFF}命令:{FF0000} /givecash [玩家id] [数量]",sendername,giveplayer,moneys);
                SendClientMessageToAll(0xc6A2E7FF,string);
                }

			else
			{
				SendClientMessage(playerid, COLOR_RED, "Jou dont have so much ;)");
			}
		}
		else
		{
			format(string, sizeof(string), "%d not found.", giveplayerid);
			SendClientMessage(playerid, COLOR_RED, string);
		}
		return 1;
	}
//---------

if(strcmp(cmd, "/vn", true, 10) == 0)
	{

		new String[200];
		new tmp[256];
		tmp = strtok(cmdtext, idx);
		new Float:x, Float:y, Float:z;

		new vehicle = GetVehicleModelIDFromName(tmp);

		if(vehicle < 400 || vehicle > 611) return SendClientMessage(playerid,COLOR_YELLOW, "[车管]：错误！你输入的名称不正确！");

		new Float:a;
		GetPlayerFacingAngle(playerid, a);
		GetPlayerPos(playerid, x, y, z);

		if(IsPlayerInAnyVehicle(playerid) == 1)
		{
			GetXYInFrontOfPlayer(playerid, x, y, 8);
		}
		else
		{
		    GetXYInFrontOfPlayer(playerid, x, y, 5);
		}
if (times[playerid]<6)
{
if (times[playerid]==5)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles5[playerid] =CreateVehicle(vehicle, x, y, z, a+90, -1, -1, -1);
SetVehicleVirtualWorld(gPlayerVehicles5[playerid], GetPlayerVirtualWorld( playerid ) );
LinkVehicleToInterior(gPlayerVehicles5[playerid], GetPlayerInterior( playerid ) );
format(String, sizeof(String), "[车管]：刷出车辆 %s 成功！", aVehicleNames[vehicle - 400]);
SendClientMessage(playerid,0x05FF00FF, String);
}
if (times[playerid]==4)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles4[playerid] =CreateVehicle(vehicle, x, y, z, a+90, -1, -1, -1);
SetVehicleVirtualWorld(gPlayerVehicles4[playerid], GetPlayerVirtualWorld( playerid ) );
LinkVehicleToInterior(gPlayerVehicles4[playerid], GetPlayerInterior( playerid ) );
format(String, sizeof(String), "[车管]：刷出车辆 %s 成功！", aVehicleNames[vehicle - 400]);
SendClientMessage(playerid,0x05FF00FF, String);
}
if (times[playerid]==3)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles3[playerid] =CreateVehicle(vehicle, x, y, z, a+90, -1, -1, -1);
SetVehicleVirtualWorld(gPlayerVehicles3[playerid], GetPlayerVirtualWorld( playerid ) );
LinkVehicleToInterior(gPlayerVehicles3[playerid], GetPlayerInterior( playerid ) );
format(String, sizeof(String), "[车管]：刷出车辆 %s 成功！", aVehicleNames[vehicle - 400]);
SendClientMessage(playerid,0x05FF00FF, String);
}
if (times[playerid]==2)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles2[playerid] =CreateVehicle(vehicle, x, y, z, a+90, -1, -1, -1);
SetVehicleVirtualWorld(gPlayerVehicles2[playerid], GetPlayerVirtualWorld( playerid ) );
LinkVehicleToInterior(gPlayerVehicles2[playerid], GetPlayerInterior( playerid ) );
format(String, sizeof(String), "[车管]：刷出车辆 %s 成功！", aVehicleNames[vehicle - 400]);
SendClientMessage(playerid,0x05FF00FF, String);
}

if (times[playerid]==1)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles1[playerid] =CreateVehicle(vehicle, x, y, z, a+90, -1, -1, -1);
SetVehicleVirtualWorld(gPlayerVehicles1[playerid], GetPlayerVirtualWorld( playerid ) );
LinkVehicleToInterior(gPlayerVehicles1[playerid], GetPlayerInterior( playerid ) );
format(String, sizeof(String), "[车管]：刷出车辆 %s 成功！", aVehicleNames[vehicle - 400]);
SendClientMessage(playerid,0x05FF00FF, String);
}


if (times[playerid]==0)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles0[playerid] =CreateVehicle(vehicle, x, y, z, a+90, -1, -1, -1);
SetVehicleVirtualWorld(gPlayerVehicles0[playerid], GetPlayerVirtualWorld( playerid ) );
LinkVehicleToInterior(gPlayerVehicles0[playerid], GetPlayerInterior( playerid ) );
format(String, sizeof(String), "[车管]：刷出车辆 %s 成功！", aVehicleNames[vehicle - 400]);
SendClientMessage(playerid,0x05FF00FF, String);
}
new string[256];
new mess[256];
new pname[256];
GetPlayerName(playerid,pname,256);
format(string, sizeof(string),"{FFFFFF}[车辆]: 玩家{00C3FF} %s {FFFFFF}的新车为:{00C3FF} %s {FFFFFF},{FFFFFF}想要弄车，试试看{FF0000} /vn [车辆名称]",pname,aVehicleNames[vehicle - 400]);
SendClientMessageToAll(0xc6A2E7FF,string);

} else {
SendClientMessage(playerid,COLOR_YELLOW,"[车管]：你不能再刷车了，请输入/dc删除！");
return 1;
}
return 1;
}

//------Weapon/--------------------------------------------------------------------------
if(strcmp(cmd, "/w2n", true, 10) == 0)
{

		new tmp[256];
		tmp = strtok(cmdtext, idx);
		new Float:x, Float:y, Float:z;

	new weaponid = GetWeaponModelIDFromName(tmp);

	if (weaponid == -1) {
		weaponid = strval(tmp);
		if (weaponid <= 0 || weaponid > 47) {
	    	SendClientMessage(playerid, COLOR_RED, "[错误]: 错误的武器id/名字");
	    	return true;
		}
	}
	new iString[256];
new pname[65];
GetPlayerName(playerid,pname,65);
    GivePlayerWeapon(playerid, weaponid, 999999);
    format(iString, 256, "{FFFFFF}[武器]: 玩家{00C3FF} %s  {FFFFFF}刷出武器:{00C3FF} %s (ID: %d),想要弄武器，试试看{FF0000} /w2n [武器名称] ",pname, aWeaponNames[weaponid], weaponid);
    SendClientMessageToAll( COLOR_GREEN, iString);
return 1;
}
//OBJ--------------------------------------------------------------------------------------
//Jetpack
if (!strcmp(cmdtext, "/jetpack", true) || !strcmp(cmdtext,"/fxq", true))
{
SetPlayerSpecialAction(playerid, 2);
SendClientMessage(playerid, COLOR_GREEN, "[成功]: 成功刷出飞行器- -");
return 1;
}
//------------------------------------------------------------------------------------------
	if (strcmp("/npchelp", cmdtext, true, 10) == 0)
	{
	    ShowPlayerDialog(playerid, 1082, DIALOG_STYLE_LIST, "NPC制作系统","这个专为无聊之人打造:\n1./knpc [ID]创建一个NPC并开始录制\n/krecordend 停止录制开始播放NPC录像\n/knpclist 查看全服所有创建的NPC\n/kremove [Id]删掉NPCOk","Exit");
    	return 1;
	}
	
if(strcmp(cmd,\"/hp",true)==0)
{
tmp = strtok( cmdtext, idx );
if(!strval(tmp))
{
SendClientMessage(playerid,0xc6A2E7FF,\"[血量]方法：/hp [血量]。");
return 1;
}
new sid = strval(tmp);
if(sid < 0)
{
SendClientMessage(playerid,0xc6A2E7FF,\"[血量]编号无效。");
return 1;
}
sid = SetPlayerHealth(playerid,strval(tmp));
new string[256];
new pname[256];
GetPlayerName(playerid,pname,256);
format(string, sizeof(string),"{FFFFFF}[健康]: 玩家{00C3FF} %s {FFFFFF}把他自己的血量设置成了:{00C3FF} %d {FFFFFF},想要改血量，试试看{FF0000} /hp",pname,strval(tmp));
SendClientMessageToAll(0xFFFFFFFF,string);
return 1;
}
//--------------------------------------------------------------------------------
if(strcmp(cmd,\"/afk",true)==0)
{
if(isplayerafk[playerid]==0)
{
ShowPlayerDialog(playerid,1247,DIALOG_STYLE_INPUT,"[AFK挂机]","请输入你离开的原因:","完成","取消");
} else {
SendClientMessage(playerid,COLOR_YELLOW,"[AFK挂机]：你已经在挂机模式！");
return 1;
}
return 1;
}
//***************************************************
if(strcmp(cmd,\"/back",true)==0)
{
if(isplayerafk[playerid]==1)
{
Delete3DTextLabel(afk3dtext[playerid]);
SetPlayerHealth(playerid,100);
TogglePlayerControllable(playerid,1);
SendClientMessage(playerid,COLOR_YELLOW,"[AFK挂机]：欢迎回来，血量已经恢复正常!");
new string[256];
new pname[256];
GetPlayerName(playerid,pname,256);
format(string, sizeof(string),"{FFFFFF}[AFK挂机]:欢迎玩家{00C3FF} %s {FFFFFF}回来！",pname);
SendClientMessageToAll(0xFFFFFFFF,string);
isplayerafk[playerid]=0;
} else {
SendClientMessage(playerid,COLOR_YELLOW,"[AFK挂机]：你不在挂机模式！");
return 1;
}
return 1;
}


//OBJ-----------------------------------------------------------------------------
if(strcmp(cmd,\"/vid",true)==0)
{
new Float:X, Float:Y, Float:Z;
tmp = strtok( cmdtext, idx );
if(!strval(tmp))
{
SendClientMessage(playerid,0x33CCFFAA,\"[车辆系统]刷车方法：/vid [车辆编号]。");
return 1;
}
new shuache = strval(tmp);
if(shuache < 400 || shuache > 611)
{
SendClientMessage(playerid,0x33CCFFAA,\"[车辆系统]车辆编号无效。");
return 1;
}


if (times[playerid]<6)
{
GetPlayerPos( playerid, X, Y, Z );
X=X+3;
Y=Y+1;
if (times[playerid]==5)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles5[playerid] = AddStaticVehicle(strval(tmp), X, Y, Z, 0, 0, 1);
SetVehicleVirtualWorld(gPlayerVehicles5[playerid], GetPlayerVirtualWorld( playerid ) );
LinkVehicleToInterior(gPlayerVehicles5[playerid], GetPlayerInterior( playerid ) );
}
if (times[playerid]==4)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles4[playerid] = AddStaticVehicle(strval(tmp), X, Y, Z, 0, 0, 1);
SetVehicleVirtualWorld(gPlayerVehicles4[playerid], GetPlayerVirtualWorld( playerid ) );
LinkVehicleToInterior(gPlayerVehicles4[playerid], GetPlayerInterior( playerid ) );
}
if (times[playerid]==3)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles3[playerid] = AddStaticVehicle(strval(tmp), X, Y, Z, 0, 0, 1);
SetVehicleVirtualWorld(gPlayerVehicles3[playerid], GetPlayerVirtualWorld( playerid ) );
LinkVehicleToInterior(gPlayerVehicles3[playerid], GetPlayerInterior( playerid ) );
}
if (times[playerid]==2)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles2[playerid] = AddStaticVehicle(strval(tmp), X, Y, Z, 0, 0, 1);
SetVehicleVirtualWorld(gPlayerVehicles2[playerid], GetPlayerVirtualWorld( playerid ) );
LinkVehicleToInterior(gPlayerVehicles2[playerid], GetPlayerInterior( playerid ) );
}

if (times[playerid]==1)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles1[playerid] = AddStaticVehicle(strval(tmp), X, Y, Z, 0, 0, 1);
SetVehicleVirtualWorld(gPlayerVehicles1[playerid], GetPlayerVirtualWorld( playerid ) );
LinkVehicleToInterior(gPlayerVehicles1[playerid], GetPlayerInterior( playerid ) );
}


if (times[playerid]==0)
{
times[playerid]=times[playerid]+1;
gPlayerVehicles0[playerid] = AddStaticVehicle(strval(tmp), X, Y, Z, 0, 0, 1);
SetVehicleVirtualWorld(gPlayerVehicles0[playerid], GetPlayerVirtualWorld( playerid ) );
LinkVehicleToInterior(gPlayerVehicles0[playerid], GetPlayerInterior( playerid ) );
}
} else {
SendClientMessage(playerid,COLOR_YELLOW,"[车管]：你不能再刷车了，请输入/dc删除！");
return 1;
}



new string[256];
new mess[256];
new pname[256];
GetPlayerName(playerid,pname,256);
format(string, sizeof(string),"{FFFFFF}[车辆]: 玩家{00C3FF} %s {FFFFFF}的新车为ID:{00C3FF} %d {FFFFFF},想要弄车，试试看{FF0000} /vid",pname,strval(tmp));
SendClientMessageToAll(0xc6A2E7FF,string);
//test
format(mess, sizeof(mess),"你刷了第 %d 辆车，你最多可以刷6辆车.",times[playerid]);
SendClientMessage(playerid,0xc6A2E7FF,mess);
return 1;
}

//test cmd


	//test cmd
if(strcmp(cmd,\"/sid",true)==0)
{
tmp = strtok( cmdtext, idx );
if(!strval(tmp))
{
SendClientMessage(playerid,0xc6A2E7FF,\"[皮肤]方法：/sid [皮肤id]。");
return 1;
}
new sid = strval(tmp);
if(sid < 0 || sid > 299)
{
SendClientMessage(playerid,0xc6A2E7FF,\"[皮肤]皮肤编号无效。");
return 1;
}
sid = SetPlayerSkin(playerid,strval(tmp));
new string[256];
new pname[256];
GetPlayerName(playerid,pname,256);
format(string, sizeof(string),"{FFFFFF}[皮肤]: 玩家{00C3FF} %s {FFFFFF}把他自己的皮肤改成了ID:{00C3FF} %d {FFFFFF},想要改皮肤，试试看{FF0000} /sid",pname,strval(tmp));
SendClientMessageToAll(0xc6A2E7FF,string);

return 1;
}

if(strcmp(cmd,\"/w2",true)==0)
{
tmp = strtok( cmdtext, idx );
if(!strval(tmp))
{
SendClientMessage(playerid,0xc6A2E7FF,\"[武器]方法：/w2 [id]。");
return 1;
}
new w2 = strval(tmp);
if(w2 < 0 || w2 > 59)
{
SendClientMessage(playerid,0xc6A2E7FF,\"[武器]武器编号无效。");
return 1;
}
w2=GivePlayerWeapon(playerid,strval(tmp),999999);
new string[256];
new pname[256];
GetPlayerName(playerid,pname,256);
format(string, sizeof(string),"{FFFFFF}[武器]: 玩家{00C3FF} %s {FFFFFF}召唤出武器ID:{00C3FF} %d {FFFFFF},想要弄武器，试试看{FF0000} /w2",pname,strval(tmp));
SendClientMessageToAll(0xc6A2E7FF,string);
return 1;
}
if(strcmp(cmd,\"/skill",true)==0)
{
ShowPlayerDialog(playerid,544,DIALOG_STYLE_LIST,"武器熟练度设置(Dev GTAIP-4F)","1.手枪熟练度\n2.消音手枪熟练度\n3.沙漠之鹰熟练度\n4.警用霰弹熟练度\n5.Sawn-off熟练度\n6.SPAZ霰弹熟练度\n7.UZI熟练度\n8.MP5熟练度\n9.AK47熟练度\n10.M4熟练度\n11.狙击枪熟练度\n[用处]增加拍摄效果,持枪方式不同.","选择","取消");
return 1;
}

if(strcmp(cmd,\"/time",true)==0)
{
tmp = strtok( cmdtext, idx );
if(!strval(tmp))
{
SendClientMessage(playerid,0x33CCFFAA,\"[时间]方法：/time [id]。");
return 1;
}
new w2 = strval(tmp);
if(w2 < 0 || w2 > 23)
{
SendClientMessage(playerid,0x33CCFFAA,\"[时间]时间编号无效。");
return 1;
}
w2=SetPlayerTime(playerid,strval(tmp),0);
new string[256];
new pname[256];
GetPlayerName(playerid,pname,256);
format(string, sizeof(string),"{FFFFFF}[时间]: 玩家{00C3FF} %s {FFFFFF}把他自己的时间换成了{00C3FF} %d {FFFFFF}点,想要换时间，试试看{FF0000} /time",pname,strval(tmp));
SendClientMessageToAll(0xc6A2E7FF,string);
return 1;
}

if(strcmp(cmd,\"/wea",true)==0)
{
tmp = strtok( cmdtext, idx );
if(!strval(tmp))
{
SendClientMessage(playerid,0x33CCFFAA,\"[天气]方法：/wea [id]。");
return 1;
}
new w2 = strval(tmp);
if(w2 < 0 || w2 > 45)
{
SendClientMessage(playerid,0x33CCFFAA,\"[天气]天气编号无效。");
return 1;
}
w2=SetPlayerWeather(playerid,strval(tmp));
new string[256];
new pname[256];
GetPlayerName(playerid,pname,256);
format(string, sizeof(string),"{FFFFFF}[天气]: 玩家{00C3FF} %s {FFFFFF}把他自己的天气换成了id:{00C3FF} %d {FFFFFF},想要换天气，试试看{FF0000} /wea",pname,strval(tmp));
SendClientMessageToAll(0xc6A2E7FF,string);
return 1;
}

if(strcmp(cmd,\"/wid",true)==0)
{
tmp = strtok( cmdtext, idx );
if(!strval(tmp))
{
SendClientMessage(playerid,0x33CCFFAA,\"[世界]方法：/wid [id]。");
return 1;
}
new message[128];
GetPlayerName(playerid,message,128);
SetPlayerVirtualWorld(playerid,strval(tmp));
playerworld[playerid]=strval(tmp);
format(message,256,"[世界]你进入了世界(ID): %d",strval(tmp));
SendClientMessage(playerid,COLOR_GRAD2,"如果想回大世界,请输入ID:/wn");
SendClientMessage(playerid, COLOR_GRAD2, message,strval(tmp));
return 1;
}

if (strcmp(cmdtext, "/gxqm", true)==0)
{
Delete3DTextLabel(label[playerid]);
ShowPlayerDialog(playerid,889,DIALOG_STYLE_INPUT,"[个性签名]","请输入你的签名：","完成","取消");
return 1;
}
if (strcmp(cmdtext, "/huojian", true)==0)
{
SetPlayerPos(playerid,830.7491,-2053.1228,12.8672);
SendClientMessage(playerid,COLOR_YELLOW,"[传送]：你被传送到：火箭发射基地");
return 1;
}


//cars


if (strcmp(cmdtext, "/lbon", true)==0)
{
TextDrawShowForPlayer(playerid,lbt);
TextDrawShowForPlayer(playerid,lbb);
PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
SendClientMessage(playerid, 0xFFFFFFAA, "黑色上下布幕=开");
return 1;
}


if (strcmp(cmdtext, "/lboff", true)==0)
{
TextDrawHideForPlayer(playerid,lbt);
TextDrawHideForPlayer(playerid,lbb);
PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
SendClientMessage(playerid, 0xFFFFFFAA, "黑色上下布幕=关");
return 1;
}
if (strcmp ( cmdtext , "/f", true)==0)
	{
	new State=GetPlayerState(playerid);
	if (IsPlayerInAnyVehicle(playerid) && State == PLAYER_STATE_DRIVER)
	{
	new VehicleID, Float:Angle, Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	VehicleID = GetPlayerVehicleID(playerid);
	GetVehicleZAngle(VehicleID, Angle);
	SetVehiclePos(VehicleID, X, Y, Z);
	SetVehicleZAngle(VehicleID, Angle);
	SendClientMessage(playerid,COLOR_YELLOW, "[车管]:车辆已被放正！请你下次小心开车！");
	} else {
    SendClientMessage(playerid,COLOR_YELLOW,"[车管]：你不在车上！");
}
    return 1;
}
if(strcmp(cmdtext,"/cls",true)==0)
{
SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,COLOR_WHITE," ");
PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
return 1;
}

if (strcmp("/drunkon", cmdtext, true, 8) == 0)
    {
    SetPlayerDrunkLevel (playerid, 50000);
    ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
    GameTextForPlayer(playerid,"~W~Drunk Mode Is ~g~On!",3000,5);
    ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
    return 1;
    }
if (strcmp("/drunkoff", cmdtext, true, 9) == 0)
    {
    if (GetPlayerDrunkLevel(playerid) < 2000)
    SendClientMessage(playerid,0xFFFFFFFF,"You are not Drunk!");
    else
    SetPlayerDrunkLevel (playerid,0);
    GameTextForPlayer(playerid,"~W~Drunk Mode Is ~R~Off!",3000,5);
    ClearAnimations(playerid);
    return 1;
    }




if (strcmp(cmdtext, "/wn", true) == 0) {
SetPlayerVirtualWorld(playerid, 0);
playerworld[playerid]=0;
SendClientMessage(playerid,0xFFFF00AA, "[世界]你成功回到大世界!", 0);
return 1;
}


if(strcmp(cmdtext,"/help",true) == 0)
{
ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "帮助中心", "1.我的信息\n2.规则\n3.车辆\n4.武器\n5.玩家\n6.环境\n7.娱乐\n8.防捣乱帮助\n9.拍摄工具\n10.{FF000A}高级权限\n11.关于","选择", "退出" );
return 1;
}
//Word change------------------------------------------------------------------------



//Word change------------------------------------------------------------------------

	//CAR
if( strcmp( cmdtext, "/car", true, 8 ) == 0 )
	{

 if ( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
	    {
			#if !defined IGNORE_VEHICLE_ACTIVATION
	    		ShowPlayerDefaultDialog( playerid );
	    		return 1;
			#endif
		}
		ShowPlayerDefaultDialog( playerid );
		return 1;
	}

if (strcmp(cmdtext, "/dc", true) == 0)
{

if(times[playerid]==0)
{
SendClientMessage(playerid,COLOR_YELLOW,"你还没有刷车呢!");
} else {
 // Make sure their vehicle is destroyed when they leave.
DestroyVehicle(gPlayerVehicles0[playerid]);
DestroyVehicle(gPlayerVehicles1[playerid]);
DestroyVehicle(gPlayerVehicles2[playerid]);
DestroyVehicle(gPlayerVehicles3[playerid]);
DestroyVehicle(gPlayerVehicles4[playerid]);
DestroyVehicle(gPlayerVehicles5[playerid]);
gPlayerVehicles1[playerid] = 0;
gPlayerVehicles2[playerid] = 0;
gPlayerVehicles3[playerid] = 0;
gPlayerVehicles4[playerid] = 0;
gPlayerVehicles5[playerid] = 0;
DestroyObject(GetPVarInt(playerid, "blue"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "blue1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "undercover"));
DestroyObject(GetPVarInt(playerid, "undercover1"));
DeletePVar(playerid, "Status");
/*DestroyObject(GetPVarInt(playerid, "blue"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "blue1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld2"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld3"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld4"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld5"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld6"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "ld7"));
DeletePVar(playerid, "neon");*/
SendClientMessage(playerid,COLOR_YELLOW," [车管]：所以车辆删除成功！，你可以在刷车了.");
times[playerid]=0;
}
return 1;
}
//CAR有问题
new giveplayer[MAX_PLAYER_NAME];
new sendername[MAX_PLAYER_NAME];
cmd = strtok(cmdtext, idx);
new giveplayerid;
new string[MAX_STRING];
new cars[MAX_PLAYERS];
if (strcmp("/tun", cmdtext, true, 8) == 0)
{
if(IsPlayerInAnyVehicle(playerid))
{
if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
{                                                              //0                   1           2         3       4               5       6         7     8
ShowPlayerDialog(playerid,3131,DIALOG_STYLE_LIST,"车辆设置","1.加速器/液压装置\n2.轮胎/轮圈\n3.车辆颜色\n4.修车\n5车辆改装\n6.关闭车灯\n7.打开车灯\n8.锁车门\n9.解锁车门","确定","取消");
SendClientMessage(playerid,0xFF00AA,"你现在可以改装你的车了");
} else {
SendClientMessage(playerid,0xFF00AA,"[错误]：虽然你在车上了，但你不是司机！");
}
} else {
SendClientMessage(playerid,0xFF00AA,"[错误]：你不在车上！");
}
return 1;
}

    if (strcmp("/MP3", cmdtext, true, 10) == 0)
	{
		ShowPlayerDialog(playerid,PMusicDialogid,DIALOG_STYLE_LIST,"{EEEE88}音乐列表:[By GTAYY]",DrawMusicList(MusicPage[playerid]),"播放","关闭列表");
		return 1;
	}
	if (strcmp("/ADDMP3", cmdtext, true, 10) == 0)
	{
		ShowPlayerDialog(playerid, AddMusicDialogid,DIALOG_STYLE_INPUT, "添加音乐[By:GTAYY]","请在下方输入你要添加的音乐名称\n(如:甩葱歌)","下一步","取消");
		return 1;
	}
	if (strcmp("/whatnew", cmdtext, true, 10) == 0)
	{
	    ShowPlayerDialog(playerid, 1080, DIALOG_STYLE_LIST, "What's New?","在2.4版本中，我们开设了新功能。\n我们会陆续增加，详细如下\n1.在线音乐播放器/mp3help\n2.[激光剑]/light\n3.在线NPPC制作[BUG取消]\n感谢你对我们的支持！\nEasy-Mp(C)2011 All Reserved","Ok","Exit");
    	return 1;
	}
    if (strcmp("/MP3help", cmdtext, true, 10) == 0)
	{
	 ShowPlayerDialog(playerid, 1080, DIALOG_STYLE_LIST, "What's New?","====[在线音乐播放器帮助]====\n1.查看所有音乐/mp3\n2.添加自己的音乐/addmp3","关闭","");
	return 1;
	}
	
	
if (strcmp(cmdtext, "/godon", true)==0)
{
if(isplayeringodmode[playerid]==0)
{
new string[256];
new pname[256];
GetPlayerName(playerid,pname,256);
format(string, sizeof(string),"{FFFFFF}[系统]: 玩家{00C3FF} %s {FFFFFF}开启了无敌模式,想要无敌？试试看{FF0000} /godon",pname);
SendClientMessageToAll(COLOR_WHITE,string);
textgodmome[playerid]=Create3DTextLabel("此人无敌中...",0xFF8200FF,30.0,40.0,50.0,40.0,0);
Attach3DTextLabelToPlayer(textgodmome[playerid],playerid, 0.0, 0.0, -0.5);
isplayeringodmode[playerid]=1;
//--------------------
GMTimer = SetTimerEx("GodMod", 1000, true, "i", playerid);
SetPlayerHealth(playerid, 10000);
} else {
SendClientMessage(playerid,0xFF00AA,"[错误}：你已经开启无敌模式了！.");
return 1;
}
return 1;
}
if (strcmp(cmdtext, "/godoff", true)==0)
{
if(isplayeringodmode[playerid]==1)
{
new string[256];
new pname[256];
new vehicleid;
isplayeringodmode[playerid]=0;
Delete3DTextLabel(textgodmome[playerid]);
SetPlayerHealth(playerid,100);
SetPlayerArmour(playerid,0);
GivePlayerMoney(playerid,100);
if(IsPlayerInAnyVehicle(playerid))
{
vehicleid=GetPlayerVehicleID(playerid);
SetVehicleHealth(vehicleid, 1000);
}
KillTimer(GMTimer);
GetPlayerName(playerid,pname,256);
format(string, sizeof(string),"{FFFFFF}[系统]: 玩家{00C3FF} %s {FFFFFF}关闭了无敌模式,命令{FF0000} /godoff",pname);
SendClientMessageToAll(COLOR_WHITE,string);
} else {
SendClientMessage(playerid,0xFF00AA,"[错误]：你没有开启无敌模式.");
return 1;
}
return 1;
}

if (strcmp(cmdtext, "/spawn", true)==0)
{
ShowPlayerDialog(playerid,911,DIALOG_STYLE_LIST,"选择出生点","欢迎您，请选择个你喜欢的出生点\n1.拍摄现场2.0[默认出生点]\n2.拍摄现场1.0出生点\n3.电影服(GTAIP - 4F)的出生点\n4.私人机场","OK","关闭");
return 1;
}

if (strcmp(cmdtext, "/cc", true)==0)
{
ShowPlayerDialog(playerid,6315,DIALOG_STYLE_LIST,"{FFFFFF}CC呼车{228B22} By Episodes","第一辆车\n第二辆车\n第三辆车\n第四辆车\n第五辆车\n第六辆车","确定","取消");
return 1;
}

if (strcmp(cmdtext, "/nameon", true) == 0)
	{
		for(new i; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				ShowPlayerNameTagForPlayer(playerid, i, 1);
			}
		}
		SendClientMessage(playerid, COLOR_YELLOW, "Nametags are now on.");
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		gNameTags[playerid] = 1;
		return 1;
	}

if (strcmp(cmdtext, "/nameoff", true) == 0)
	{
		for(new i; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				ShowPlayerNameTagForPlayer(playerid, i, 0);
			}
		}
		SendClientMessage(playerid, COLOR_YELLOW, "Nametags are now off.");
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		gNameTags[playerid] = 0;
		return 1;
	}

if (strcmp(cmdtext, "/film", true) == 0)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "____-Special filming functions-____");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /letterbox(on/off)***");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /names(on/off) ***");
		SendClientMessage(playerid, COLOR_YELLOW,"*** /animhelp***");
		return 1;
	}
if (strcmp(cmdtext, "/fix", true)==0)
	{
		new VehicleID;
		VehicleID = GetPlayerVehicleID(playerid);
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
		SetVehicleHealth(VehicleID, 1000.0 );
		}else{
		SendClientMessage(playerid, COLOR_GRAD2, "You must be in a vehicle.");
		}
		return 1;
	}

if( strcmp( cmdtext, "/kill", true, 8 ) == 0 )
    {
    SetPlayerHealth(playerid,0);
    SendClientMessage(playerid, COLOR_YELLOW,"[自杀]：自杀成功！");
    return 1;
    }
if( strcmp( cmdtext, "/yansei", true, 8 ) == 0 )
    {
    ShowPlayerDialog(playerid, 100, DIALOG_STYLE_LIST, "{FFAF00}Colors List", "1\t{00C0FF}Light Blue\n2\t{0049FF}Blue\n3\t{FF00EA}Pink\n4\t{F81414}Dark Red\n5\t{6EF83C}Green\n6\t{FFAF00}Orange\n7\t{F3FF02}Yellow\n8\tBack", "选择", "取消");
    return 1;
    }
if( strcmp( cmdtext, "/wuqi", true, 8 ) == 0 )
    {
    ShowPlayerDialog(playerid, 110, DIALOG_STYLE_LIST, "武器菜单", "Knife\nBaseball Bat\nPistol\nSilenced Pistol\nDesert Eagle\nShotgun\nSawn-off Shotgun\nCombat Shotgun\nTec-9\nMicro-MP5\nMP5\nAK-47\nM4 Carbine\nCountry Rifle\nSniper Rifle\nRocket Launcher\nHeat Seeker\nFlamethrower\nGrenade\nTear Gas-Grenade\nMolotov Cocktail\nRemote Satchel with Detonator\nSpray Can\nFire Extinguisher", "选择", "取消");
    return 1;
    }
if( strcmp( cmdtext, "/i", true, 8 ) == 0 )
    {
	ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu 1.4 翻译by Jeffery Lie","24/7's(便利店)\nAirports(機場)\nAmmunations(武器店)\nHouses(房子1)\nHouses(房子2)\nMissions(任務中的地點)\nStadiums(體育場)\nCasinos(賭場)\nShops(商店)\nGarages(改裝店)\nGirlfriends(CJ女朋友家)\nClothing/Barber Store(服裝店和酒吧)\nResturants/Clubs(餐廳和俱樂部)\nNo Category(未分類)\nBurglary(入室盜竊房子1)\nBurglary(入室盜竊房子2)\nGym(健身房)\nDepartment(辦公室)\nWorld Locations(世界地點)", "选择", "取消");
    return 1;
    }
return 0;
}
forward GodMod(playerid);
forward spwait(playerid);
public GodMod(playerid)
{
if(isplayeringodmode[playerid]==1)
{
new vehicleid;
SetPlayerHealth(playerid,1000000);
SetPlayerArmour(playerid,1000000);
SetPlayerMoney(playerid,99999999);
if(IsPlayerInAnyVehicle(playerid))
{
vehicleid=GetPlayerVehicleID(playerid);
RepairVehicle(vehicleid);
SetVehicleHealth(vehicleid, 10000);
}
return 1;
}
return 1;
}
public spwait(playerid)
{
TogglePlayerControllable(playerid,1);
KillTimer(sptimer[playerid]);
return 1;
}
//vn刷车自定义函数
GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if(strfind(aVehicleNames[i], vname, true) != -1)
		return i + 400;
	}
	return -1;
}


//结束
//武器自定义函数
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
//End
public OnPlayerHackMoney(playerid,money)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(Admin[i] > 0)
			{
				new string[259];
				new playerName[23];
				GetPlayerName(playerid,playerName,23);
				format(string,sizeof(string),"[AdmWarning:  %s  spawned with, or spawned $2000 at once.]",playerName);
				SendClientMessage(i, COLOR_YELLOW2, string);
			}
		}
	}
	return 1;
}

public IsPlayerxGAdmin(playerid)
{
	if(Admin[playerid] == 1)
	{
		return 1;
	}
	if(Admin[playerid] == 2)
	{
		return 2;
	}
	if(Admin[playerid] == 3)
	{
		return 3;
	}
	if(Admin[playerid] == 4)
	{
		return 4;
	}
	if(Admin[playerid] == 5)
	{
		return 5;
	}
	else return 0;
}


public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(!BigEar[i])
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}
	return 1;
}

public ProxDetectorS(Float:radi, playerid, targetid)
{
	if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

public SendClientMessageToAdmins(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(Admin[i] > 0)
			{
				SendClientMessage(i, color, string);
			}
		}
	}
	return 1;
}

public TurnOffGod(playerid)
{
	SetPlayerHealth(playerid,100);
	return 1;
}

public SetRandomWeather()
{
	new rand = random(sizeof(gRandomWeatherIDs));
	new strout[256];
	format(strout, sizeof(strout), "xGBot: Weather Changed To:  %s ", gRandomWeatherIDs[rand][wt_text]);
	SetWeather(gRandomWeatherIDs[rand][wt_id]);
	SendClientMessageToAll(COLOR_YELLOW2,strout);
	print(strout);
}

stock GetRandomID()
{
	new randn = random(MAX_PLAYERS);
	
	if(IsPlayerConnected(randn)) return randn;
	
	else
	{
		return GetRandomID();
	}
}

public RandPlayer1()
{
	GivePlayerWeapon(GetRandomID(), 16, 5);
	SetPlayerArmour(GetRandomID(), 100);
	SendClientMessageToAll(COLOR_YELLOW2, "[Random: A Random Player has been given ''5 Grenades'' and ''Full Armor'']");
	return 1;
}

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

stock TelePlayer(playerid, Float:x, Float:y, Float:z, Float:angle, interior)
{
	SetPlayerInterior(playerid, interior);
	SetPlayerPos(playerid, x, y, z);
	SetPlayerFacingAngle(playerid, angle);
	SetCameraBehindPlayer(playerid);
	return 1;
}

public VehicleReset(){
	new bool:inVeh;
	SendClientMessageToAll(COLOR_PURPLE, "[Vehicle Clear]: All previously used empty vehicles have been cleared.");
	/*TextDrawHideForAll(site);*/
	SetTimer("SpawnVehicles",2000,0);
	for( new i = 0; i < MAX_VEHICLES; i++ ){
		inVeh = false;
		for( new j = 0; j < MAX_PLAYERS; j++ ){
			if(IsPlayerInVehicle( j, i )){
				inVeh = true;
				break;
			}
		}
		
		if(!inVeh){
			SetVehicleToRespawn(i);
			DestroyVehicle(i);
		}
	}
}

public VehicleResetWarning()
{
    SendClientMessageToAll(COLOR_PURPLE, "[Vehicle Clear]: All previously used empty vehicles will reset automaticly in 1 minute.");
    return 1;
}


stock IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

stock OnePlayAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	if (gPlayerUsingLoopingAnim[playerid] == 1) TextDrawHideForPlayer(playerid,txtAnimHelper);
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
	animation[playerid]++;
}

stock LoopingAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	if (gPlayerUsingLoopingAnim[playerid] == 1) TextDrawHideForPlayer(playerid,txtAnimHelper);
	gPlayerUsingLoopingAnim[playerid] = 1;
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
	TextDrawShowForPlayer(playerid,txtAnimHelper);
	animation[playerid]++;
}

stock StopLoopingAnim(playerid)
{
	gPlayerUsingLoopingAnim[playerid] = 0;
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
}
/*
stock PreloadAnimLib(playerid, animlib[])
{
//	ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
}
*/
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!gPlayerUsingLoopingAnim[playerid]) return;
	if(IsKeyJustDown(KEY_HANDBRAKE,newkeys,oldkeys)) {
		StopLoopingAnim(playerid);
		TextDrawHideForPlayer(playerid,txtAnimHelper);
		animation[playerid] = 0;
	}
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), newinteriorid);
	}
	return 1;
}

public ReactionTest()
{
	reactionstr = "";
	KillTimer(reactiongap);
	new str[256];
	new random_set[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	for (new i = 0; i < 8; i++)
	{
		reactionstr[i] = random_set[random(sizeof(random_set))];
	}
	reactioninprog = 2;
	format(str, sizeof(str), "[Reaction Test]: First person to type  %s  wins a tuned Sultan!", reactionstr);
	SendClientMessageToAll(COLOR_PURPLE,str);
}

public ReactionWin(playerid)
{
    new Float:X,Float:Y,Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    TunedSultan = CreateVehicle(560, X, Y+2, Z, 126, 0, 0, -1);
    ChangeVehiclePaintjob(TunedSultan, 1);
    AddVehicleComponent(TunedSultan, 1083); // Dollar Wheels
	AddVehicleComponent(TunedSultan, 1010); // NOS 10x
	AddVehicleComponent(TunedSultan, 1035); // Roof
	AddVehicleComponent(TunedSultan, 1058); // Spoiler
	AddVehicleComponent(TunedSultan, 1166); // Bumper
	SetTimer("SetBack",30,0);
	new reactionwinner[256];
	reactionwinnerid = playerid;
	new tempstring[256];
	GetPlayerName(playerid,reactionwinner,sizeof(reactionwinner));
	format(tempstring, sizeof(tempstring), "[Reaction Test]:  %s  has won the Reaction Test!", reactionwinner);
	SendClientMessageToAll(COLOR_PURPLE, tempstring);
	OnePlayAnim(playerid,"GRENADE","WEAPON_throw",4.0,0,0,0,0,0);
	reactiongap = SetTimer("ReactionTest",time1+random(time2),0);
}


//CARS MENU RETURN
public OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
#define objmess "===[OBJ系统帮助中心]\n一些OBJ的ID:\n===[几个房子]===\n3249,6869,14399\n16326,16409,3172\n===[箱子]===\n1220,1224,1299\n===[SF标牌]===\n10838\n===[树木]===\n620,669\n===[加特林]===\n2985\n===[爆炸物===\n1370\n更多OBJid去Google找\n诺要刷自定义OBJ\n请输入:/obj [OBJ的ID或指定名称]\n例如:/obj 3249,则刷出一栋小房子。输入错误的id则不显示OBJ,每个玩家限制刷出4个OBJ,下线自动删除。\n请不要刷出一些导致大部分玩家死机的OBJ,谢谢"

	if ( response )
	{
		switch ( dialogid )
		{
			case 3434 :
			{
		    	switch ( listitem )
				{
					case 0 : ShowPlayerDialog( playerid, 3435, DIALOG_STYLE_LIST, "Airplanes", "Andromada\nAT-400\nBeagle\nCropduster\nDodo\nHydra\nNevada\nRustler\nShamal\nSkimmer\nStuntplane\nBack", "Select", "Cancel" );
					case 1 : ShowPlayerDialog( playerid, 3436, DIALOG_STYLE_LIST, "Helicopters", "Cargobob\nHunter\nLeviathan\nMaverick\nNews Maverick\nPolice Maverick\nRaindance\nSeasparrow\nSparrow\nBack", "Select", "Cancel" );
					case 2 : ShowPlayerDialog( playerid, 3437, DIALOG_STYLE_LIST, "Bikes", "BF-400\nBike\nBMX\nFaggio\nFCR-900\nFreeway\nMountain Bike\nNRG-500\nPCJ-600\nPizzaboy\nQuad\nSanchez\nWayfarer\nBack", "Select", "Cancel" );
					case 3 : ShowPlayerDialog( playerid, 3438, DIALOG_STYLE_LIST, "Convertibles", "Comet\nFeltzer\nStallion\nWindsor\nBack", "Select", "Cancel" );
					case 4 : ShowPlayerDialog( playerid, 3439, DIALOG_STYLE_LIST, "Industrial", "Benson\nBobcat\nBurrito\nBoxville\nBoxburg\nCement Truck\nDFT-30\nFlatbed\nLinerunner\nMule\nNewsvan\nPacker\nPetrol Tanker\nPony\nRoadtrain\nRumpo\nSadler\nSadler Shit\nTopfun\nTractor\nTrashmaster\nUtility Van\nWalton\nYankee\nYosemite\nBack", "Select", "Cancel" );
					case 5 : ShowPlayerDialog( playerid, 3440, DIALOG_STYLE_LIST, "Lowriders", "Blade\nBroadway\nRemington\nSavanna\nSlamvan\nTahoma\nTornado\nVoodoo\nBack", "Select", "Cancel" );
					case 6 : ShowPlayerDialog( playerid, 3441, DIALOG_STYLE_LIST, "Off Road", "Bandito\nBF Injection\nDune\nHuntley\nLandstalker\nMesa\nMonster\nMonster A\nMonster B\nPatriot\nRancher A\nRancher B\nSandking\nBack", "Select", "Cancel" );
					case 7 : ShowPlayerDialog( playerid, 3442, DIALOG_STYLE_LIST, "Public Service Vehicles", "Ambulance\nBarracks\nBus\nCabbie\nCoach\nCop Bike (HPV-1000)\nEnforcer\nFBI Rancher\nFBI Truck\nFiretruck\nFiretruck LA\nPolice Car (LSPD)\nPolice Car (LVPD)\nPolice Car (SFPD)\nRanger\nRhino\nS.W.A.T\nTaxi\nBack", "Select", "Cancel" );
					case 8 : ShowPlayerDialog( playerid, 3443, DIALOG_STYLE_LIST, "Saloons", "Admiral\nBloodring Banger\nBravura\nBuccaneer\nCadrona\nClover\nElegant\nElegy\nEmperor\nEsperanto\nFortune\nGlendale Shit\nGlendale\nGreenwood\nHermes\nIntruder\nMajestic\nManana\nMerit\nNebula\nOceanic\nPicador\nPremier\nPrevion\nPrimo\nSentinel\nStafford\nSultan\nSunrise\nTampa\nVincent\nVirgo\nWillard\nWashington\nBack", "Select", "Cancel" );
					case 9 : ShowPlayerDialog( playerid, 3444, DIALOG_STYLE_LIST, "Sport Vehicles", "Alpha\nBanshee\nBlista Compact\nBuffalo\nBullet\nCheetah\nClub\nEuros\nFlash\nHotring Racer\nHotring Racer A\nHotring Racer B\nInfernus\nJester\nPhoenix\nSabre\nSuper GT\nTurismo\nUranus\nZR-350\nBack", "Select", "Cancel" );
					case 10 : ShowPlayerDialog( playerid, 3445, DIALOG_STYLE_LIST, "Station Wagons", "Moonbeam\nPerenniel\nRegina\nSolair\nStratum\nBack", "Select", "Cancel" );
					case 11 : ShowPlayerDialog( playerid, 3446, DIALOG_STYLE_LIST, "Boats", "Coastguard\nDinghy\nJetmax\nLaunch\nMarquis\nPredator\nReefer\nSpeeder\nSquallo\nTropic\nBack", "Select", "Cancel" );
					case 12 : ShowPlayerDialog( playerid, 3447, DIALOG_STYLE_LIST, "Trailers", "Article Trailer\nArticle Trailer 2\nArticle Trailer 3\nBaggage Trailer A\nBaggage Trailer B\nFarm Trailer\nFreight Flat Trailer (Train)\nFreight Box Trailer (Train)\nPetrol Trailer\nStreak Trailer (Train)\nStairs Trailer\nUtility Trailer\nBack", "Select", "Cancel" );
					case 13 : ShowPlayerDialog( playerid, 3448, DIALOG_STYLE_LIST, "Unique Vehicles", "Baggage\nBrownstreak (Train)\nCaddy\nCamper\nCamper A\nCombine Harvester\nDozer\nDumper\nForklift\nFreight (Train)\nHotknife\nHustler\nHotdog\nKart\nMower\nMr Whoopee\nRomero\nSecuricar\nStretch\nSweeper\nTram\nTowtruck\nTug\nVortex\nBack", "Select", "Cancel" );
					case 14 : ShowPlayerDialog( playerid, 3449, DIALOG_STYLE_LIST, "RC Vehicles", "RC Bandit\nRC Baron\nRC Raider\nRC Goblin\nRC Tiger\nRC Cam\nBack", "Select", "Cancel" );
				}
			}
			case 3435 :
			{
				if ( listitem > 10 ) return ShowPlayerDefaultDialog( playerid );

   				new
      				model_array[] = { 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3436 :
			{
				if ( listitem > 8 ) return ShowPlayerDefaultDialog( playerid );

		        new
	    	        model_array[] = { 548, 425, 417, 487, 488, 497, 563, 447, 469 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3437 :
			{
				if ( listitem > 12 ) return ShowPlayerDefaultDialog( playerid );

				new
   					model_array[] = { 581, 509, 481, 462, 521, 463, 510, 522, 461, 448, 471, 468, 586 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3438 :
			{
				if ( listitem > 3 ) return ShowPlayerDefaultDialog( playerid );

   				new
					model_array[] = { 480, 533, 439, 555 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3439 :
			{
				if ( listitem > 24 ) return ShowPlayerDefaultDialog( playerid );

				new
			        model_array[] = { 499, 422, 482, 498, 609, 524, 578, 455, 403, 414, 582, 443, 514, 413, 515, 440, 543, 605, 459, 531, 408, 552, 478, 456, 554 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3440 :
			{
				if ( listitem > 7 ) return ShowPlayerDefaultDialog( playerid );

		        new
		            model_array[] = { 536, 575, 534, 567, 535, 566, 576, 412 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3441 :
			{
				if ( listitem > 12 ) return ShowPlayerDefaultDialog( playerid );

    			new
		    	    model_array[] = { 568, 424, 573, 579, 400, 500, 444, 556, 557, 470, 489, 505, 495 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3442 :
			{
				if ( listitem > 17 ) return ShowPlayerDefaultDialog( playerid );

				new
			        model_array[] = { 416, 433, 431, 438, 437, 523, 427, 490, 528, 407, 544, 596, 598, 597, 599, 432, 601, 420 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3443 :
			{
				if ( listitem > 33 ) return ShowPlayerDefaultDialog( playerid );

			    new
	        	    model_array[] = { 445, 504, 401, 518, 527, 542, 507, 562, 585, 419, 526, 604, 466, 492, 474, 546, 517, 410, 551, 516, 467, 600, 426, 436, 547, 405, 580, 560, 550, 549, 540, 491, 529, 421 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3444 :
			{
				if ( listitem > 19 ) return ShowPlayerDefaultDialog( playerid );

    			new
	        	    model_array[] = { 602, 429, 496, 402, 541, 415, 589, 587, 565, 494, 502, 503, 411, 559, 603, 475, 506, 451, 558, 477 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3445 :
			{
				if ( listitem > 4 ) return ShowPlayerDefaultDialog( playerid );

				new
			        model_array[] = { 418, 404, 479, 458, 561 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3446 :
			{
				if ( listitem > 9 ) return ShowPlayerDefaultDialog( playerid );

	    	    new
	        	    model_array[] = { 472, 473, 493, 595, 484, 430, 453, 452, 446, 454 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3447 :
			{
				if ( listitem > 11 ) return ShowPlayerDefaultDialog( playerid );

		        new
		            model_array[] = { 435, 450, 591, 606, 607, 610, 569, 590, 584, 570, 608, 611 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3448 :
			{
				if ( listitem > 23 ) return ShowPlayerDefaultDialog( playerid );

	    	    new
	        	    model_array[] = { 485, 537, 457, 483, 508, 532, 486, 406, 530, 538, 434, 545, 588, 571, 572, 423, 442, 428, 409, 574, 449, 525, 583, 539 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3449 :
			{
				if ( listitem > 5 ) return ShowPlayerDefaultDialog( playerid );

	    	    new
	        	    model_array[] = { 441, 464, 465, 501, 564, 594 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
		}
 }
//help
/*
备注，下列帮助子菜单id为500到

*/
	if (dialogid == 1)
	 {

	    if (response)
	    {

     		    if (listitem == 0)
		   	    {
                new name[128];//定义变量name,随后将用作名字
                new ip[128];
				GetPlayerName(playerid,name,128);//获取玩家的名字,并把其值赋给变量name
				GetPlayerIp(playerid,ip,128);
                format(name,256,"{EEEE88}我的昵称\t{FFFFFF} %s \n\n{EEEE88}我的IP:{FFFFFF} %s \n %s  ,祝你游戏愉快！",name,ip,name);
                ShowPlayerDialog(playerid, 500, DIALOG_STYLE_LIST, "{EE7777}个人资料",name,"确定","退出",name,name);
	            }
                //我的信息菜单（有问题= =）
			    if (listitem == 1)
			    {
		    	 ShowPlayerDialog(playerid, 501, DIALOG_STYLE_LIST, "{EE7777}规则","[说明]\n这是个自由的服务器，可以使用任何工具包括外挂。\n但是还是请你文明游戏，不要去打扰别人。\n最后祝你游戏愉快！\n \n[返回]","确定","退出");
                }
			    //车辆(没有写刷车菜单)
			    if (listitem == 2)
			    {
                 ShowPlayerDialog(playerid, 502, DIALOG_STYLE_LIST, "{EE7777}车辆","[车辆]\n输入/car进入刷车菜单\n输入/vid [汽车ID]刷车\n输入/vn [车辆名称]\n[CC呼车]\n你可以输入/cc 叫你的车辆过来\n[返回]","确定","退出");
                }
			    //武器(没有写/w2刷武器还有武器菜单。
                if (listitem == 3)
			    {
                ShowPlayerDialog(playerid, 503, DIALOG_STYLE_LIST, "{EE7777}武器","[武器]\n输入/wuqi进入武器菜单\n输入/w2n [武器名称] 刷武器\n输入/w2 [武器名称或id]刷武器 \n输入/skill 调整你武器的武器熟练度\n[返回]","确定","退出");
                }
                //玩家(ssel没有写，/afk系统没有写吗，动作也没有写)
			    if (listitem == 4)
			    {
                ShowPlayerDialog(playerid, 504, DIALOG_STYLE_LIST, "{EE7777}玩家","[出生点]\n输入/spawn选择你的出生点\n[走路姿势]\n输入/cjwalk 使用CJ走路姿势\n[HP]\n输入/hp +[血量] 改变玩家的血量\n[皮肤]\n输入/s进入皮肤选择模式\n[玩家设置]\n输入/godon 开启无敌模式\n输入/godoff 关闭无敌模式\n[玩家动作]\n输入/anims 查看常用动作命令\n输入 /animhelp 查看高级动作命令\n输入:/animlist\n[颜色设定]\n输入/yansei 修改\n[格斗风格]\n输入/fight打开风格选择框\n[电影系统]\n输入/tv 进入电视系统\n[返回]","确定","退出");
                }
               //环境
                if (listitem == 5)
			    {
                ShowPlayerDialog(playerid, 505, DIALOG_STYLE_LIST, "{EE7777}环境","[世界]\n输入/w [世界id]创建自己的世界\n[天气]\n输入/wea [天气id]换天气\n[传送]\n输入// [传送地点名称]传送到常用地点\n输入/vmake [名称] 创建你自己的传送点\n[时间]\n输入/time 改时间\n输入/i 浏览SA所有的室内空间\n[返回]","确定","退出");
                }
                if (listitem == 6)
			    {
                ShowPlayerDialog(playerid, 506, DIALOG_STYLE_LIST, "{EE7777}娱乐","[遊玩]\n輸入/yw 查看\n[自杀]\n输入/kill 自杀\n[宠物]\n输入/pet 进入宠物商店\n[音乐]\n输入/music 打开音乐盒\n[跳伞]\n输入 /jump\n[个性签名]\n输入 /gxqm [内容]\n[喝酒]\n输入/drunkon 醉酒\n输入/drunkoff 停止醉酒\n[坐火箭]\n输入/huojian 到火箭发射区去。\n[下雪]\n输入 /snow 打开下雪模式\n\n[煙花]\n輸入：/pbomb 查看\n[返回]","确定","退出");
				}
				if (listitem == 7)
			    {
                ShowPlayerDialog(playerid, 507, DIALOG_STYLE_LIST, "{EE7777}免打扰帮助","如果有人打扰你的拍摄你可以输入\n/votekick [玩家id或名字] [原因] 进行投票T人\n/wid [世界id]\n创造个你自己的世界\n你可以输入/pm [玩家id] 给他发送密语[别人看不到]\n如果有玩家刷屏，你可以输入/cls 清屏\n[名字开关]\n你可以输入/nameoff 关闭显示玩家昵称\n输入/nameon 则恢复显示\n[宠物打扰]\n如果哪个玩家用宠物一直攻击你导致影响你的拍摄\n你可以输入/ppb 来屏蔽宠物攻击。\n输入/tpb 来看查看传送屏蔽的功能.\n[返回]","确定","退出");
				}
				if (listitem == 8)
			    {
                ShowPlayerDialog(playerid, 508, DIALOG_STYLE_LIST, "{EE7777}拍攝工具","1.拍攝效果\n2.OBJ 系统\n\n[返回]","确定","退出");
				}
				if (listitem == 9)
			    {
                ShowPlayerDialog(playerid, 509, DIALOG_STYLE_LIST, "{EE7777}高级权限","============\n注意:此功能需要RCON权限\n============\n若要使用，请查看/admin\n[返回]","确定","退出");
				}
				if (listitem == 10)
			    {
                ShowPlayerDialog(playerid, 509, DIALOG_STYLE_LIST, "{EE7777}关于","原作:\nEpisodes,\n現作：Kinstion\nJeffery\n脚本翻译:\nJeffery\n技术指导:[MTS]hos_happy\nGTAYY\nSA-MP Wiki\n特别感谢GTAYY和Jeffery为此脚本提供帮助！\n[脚本信息]\n版本:V2.4[beta]\n时间:2011-09-16\n\n[返回]","确定","退出");
				}

                }
                }

if(dialogid == 508)
{
if(response)
{
if (listitem == 0)
{
ShowPlayerDialog(playerid,600, DIALOG_STYLE_LIST, "{EE7777}[拍攝效果工具箱] 版本:1.0","===[火焰类]===\n/obj fire -普通的火-\n/obj fire 1 -噴射的火焰-\n===[烟雾类]===\n/obj smoke -很大的煙霧-\n/obj smoke 1 -工厂废气-\n/obj smoke 2 -白色的浓雾-\n/obj somke 3 -鬼雾-\n/obj somke 4 -求救烟雾-\n输入/dobj 把所有的OBJ删除。\n注:每个人限制刷4个，下线后自动删除个人所刷物品。\n","确定","退出");
}
if (listitem == 1)
{
ShowPlayerDialog(playerid,601, DIALOG_STYLE_LIST, "{EE7777}[OBJ系统] 版本:0.1",objmess,"确定","退出");
}
}
return 1;
}
if(dialogid == 6315)
{
if(response)
{
if (listitem == 0)
{
if(times[playerid]>0)
{
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
SetVehiclePos(gPlayerVehicles0[playerid],x+2,y+2,z);
SetVehicleVirtualWorld(gPlayerVehicles0[playerid], GetPlayerVirtualWorld( playerid ) );
SendClientMessage(playerid, COLOR_YELLOW, "[车管]：成功呼唤车辆！");
} else {
SendClientMessage(playerid,COLOR_RED,"[车管]：你没有刷第1辆车！");
}
}
if (listitem == 1)
{
if(times[playerid]>1)
{
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
SetVehiclePos(gPlayerVehicles1[playerid],x+2,y+2,z);
SetVehicleVirtualWorld(gPlayerVehicles1[playerid], GetPlayerVirtualWorld( playerid ) );
SendClientMessage(playerid, COLOR_YELLOW, "[车管]：成功呼唤车辆！");
} else {
SendClientMessage(playerid,COLOR_RED,"[车管]：你没有刷第2辆车！");
}

}
if (listitem == 2)
{
if(times[playerid]>2)
{
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
SetVehiclePos(gPlayerVehicles2[playerid],x+2,y+2,z);
SetVehicleVirtualWorld(gPlayerVehicles2[playerid], GetPlayerVirtualWorld( playerid ) );
SendClientMessage(playerid, COLOR_YELLOW, "[车管]：成功呼唤车辆！");
} else {
SendClientMessage(playerid,COLOR_RED,"[车管]：你没有刷第3辆车！");
}
}
if (listitem == 3)
{
if(times[playerid]>3)
{
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
SetVehiclePos(gPlayerVehicles3[playerid],x+2,y+2,z);
SetVehicleVirtualWorld(gPlayerVehicles3[playerid], GetPlayerVirtualWorld( playerid ) );
SendClientMessage(playerid, COLOR_YELLOW, "[车管]：成功呼唤车辆！");
} else {
SendClientMessage(playerid,COLOR_RED,"[车管]：你没有刷第4辆车！");
}
}
if (listitem == 4)
{
if(times[playerid]>4)
{
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
SetVehiclePos(gPlayerVehicles4[playerid],x+2,y+2,z);
SetVehicleVirtualWorld(gPlayerVehicles4[playerid], GetPlayerVirtualWorld( playerid ) );
SendClientMessage(playerid, COLOR_YELLOW, "[车管]：成功呼唤车辆！");
} else {
SendClientMessage(playerid,COLOR_RED,"[车管]：你没有刷第5辆车！");
}
}
if (listitem == 5)
{
if(times[playerid]>5)
{
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
SetVehiclePos(gPlayerVehicles5[playerid],x+2,y+2,z);
SetVehicleVirtualWorld(gPlayerVehicles5[playerid], GetPlayerVirtualWorld( playerid ) );
SendClientMessage(playerid, COLOR_YELLOW, "[车管]：成功呼唤车辆！");
} else {
SendClientMessage(playerid,COLOR_RED,"[车管]：你没有刷第6辆车！");
return 1;
}
}
}
}
//Skills
//ShowPlayerDialog( playerid, 544, DIALOG_STYLE_LIST, "[武器熟练度]", "1.手枪\n2.消音手枪\n3.沙漠之鹰\n3.散弹枪\n4.SAWNOFF弹枪\n5.SPAS12弹枪\n6.UZI\n7.MP5\n8.AK-47\n9.M4\n10.狙击枪","确定OK", "取消Cancel" );
//spawnpos
if(dialogid == 911)
{
if(response)
{
if (listitem == 0)
{
playerspawnpos[playerid]=1;
}
if (listitem == 1)
{
playerspawnpos[playerid]=1;
}
if (listitem == 2)
{
playerspawnpos[playerid]=2;
}
if (listitem == 3)
{
playerspawnpos[playerid]=3;
}
if (listitem == 4)
{
playerspawnpos[playerid]=4;
}
}
return 1;
}
if(dialogid == 544)
{
if(response)
{
if(listitem == 0) ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"/skill","[手枪熟练度设置]\n \n1.200\n \n2.400\n \n3.600\n \n4.800","确定","取消");
if(listitem == 1) ShowPlayerDialog(playerid,201,DIALOG_STYLE_LIST,"/skill","[消音手枪熟练度设置]\n \n1.200\n \n2.400\n \n3.600\n \n4.800","确定","取消");
if(listitem == 2) ShowPlayerDialog(playerid,202,DIALOG_STYLE_LIST,"/skill","[沙漠之鹰熟练度设置]\n \n1.200\n \n2.400\n \n3.600\n \n4.800","确定","取消");
if(listitem == 3) ShowPlayerDialog(playerid,203,DIALOG_STYLE_LIST,"/skill","[警用霰弹熟练度设置]\n \n1.200\n \n2.400\n \n3.600\n \n4.800","确定","取消");
if(listitem == 4) ShowPlayerDialog(playerid,204,DIALOG_STYLE_LIST,"/skill","[Sawn-off熟练度设置]\n \n1.200\n \n2.400\n \n3.600\n \n4.800","确定","取消");
if(listitem == 5) ShowPlayerDialog(playerid,205,DIALOG_STYLE_LIST,"/skill","[SPAZ霰弹熟练度设置]\n \n1.200\n \n2.400\n \n3.600\n \n4.800","确定","取消");
if(listitem == 6) ShowPlayerDialog(playerid,206,DIALOG_STYLE_LIST,"/skill","[UZI熟练度设置]\n \n1.200\n \n2.400\n \n3.600\n \n4.800","确定","取消");
if(listitem == 7) ShowPlayerDialog(playerid,207,DIALOG_STYLE_LIST,"/skill","[MP5熟练度设置]\n \n1.200\n \n2.400\n \n3.600\n \n4.800","确定","取消");
if(listitem == 8) ShowPlayerDialog(playerid,208,DIALOG_STYLE_LIST,"/skill","[AK47熟练度设置]\n \n1.200\n \n2.400\n \n3.600\n \n4.800","确定","取消");
if(listitem == 9) ShowPlayerDialog(playerid,209,DIALOG_STYLE_LIST,"/skill","[M4熟练度设置]\n \n1.200\n \n2.400\n \n3.600\n \n4.800","确定","取消");
if(listitem == 10) ShowPlayerDialog(playerid,210,DIALOG_STYLE_LIST,"/skill","[狙击枪熟练度设置]\n \n1.200\n \n2.400\n \n3.600\n \n4.800","确定","取消");
}
return 1;
}
if(dialogid >= 200 && dialogid <= 211)
{
if(response)
{
if(dialogid == 200)	SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL,(listitem-1)*200),SendClientMessage(playerid,COLOR_YELLOW,"[提示]手枪熟练度设置成功.");
if(dialogid == 201)	SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL_SILENCED,(listitem-1)*200),SendClientMessage(playerid,COLOR_YELLOW,"[提示]消音手枪熟练度设置成功.");
if(dialogid == 202)	SetPlayerSkillLevel(playerid,WEAPONSKILL_DESERT_EAGLE,(listitem-1)*200),SendClientMessage(playerid,COLOR_YELLOW,"[提示]沙漠之鹰熟练度设置成功.");
if(dialogid == 203)	SetPlayerSkillLevel(playerid,WEAPONSKILL_SHOTGUN,(listitem-1)*200),SendClientMessage(playerid,COLOR_YELLOW,"[提示]警用霰弹熟练度设置成功.");
if(dialogid == 204)	SetPlayerSkillLevel(playerid,WEAPONSKILL_SAWNOFF_SHOTGUN,(listitem-1)*200),SendClientMessage(playerid,COLOR_YELLOW,"[提示]Sawn-off熟练度设置成功.");
if(dialogid == 205)	SetPlayerSkillLevel(playerid,WEAPONSKILL_SPAS12_SHOTGUN,(listitem-1)*200),SendClientMessage(playerid,COLOR_YELLOW,"[提示]SPAZ霰弹熟练度设置成功.");
if(dialogid == 206)	SetPlayerSkillLevel(playerid,WEAPONSKILL_MICRO_UZI,(listitem-1)*200),SendClientMessage(playerid,COLOR_YELLOW,"[提示]UZI熟练度设置成功.");
if(dialogid == 207)	SetPlayerSkillLevel(playerid,WEAPONSKILL_MP5,(listitem-1)*200),SendClientMessage(playerid,COLOR_YELLOW,"[提示]MP5熟练度设置成功.");
if(dialogid == 208)	SetPlayerSkillLevel(playerid,WEAPONSKILL_AK47,(listitem-1)*200),SendClientMessage(playerid,COLOR_YELLOW,"[提示]AK47熟练度设置成功.");
if(dialogid == 209)	SetPlayerSkillLevel(playerid,WEAPONSKILL_M4,(listitem-1)*200),SendClientMessage(playerid,COLOR_YELLOW,"[提示]M4熟练度设置成功.");
if(dialogid == 210)	SetPlayerSkillLevel(playerid,WEAPONSKILL_SNIPERRIFLE,(listitem-1)*200),SendClientMessage(playerid,COLOR_YELLOW,"[提示]狙击枪熟练度设置成功.");
}
return 1;
}
//clour
	            if(dialogid == 100)
	            {
	            if(response)
	            {
 	            if (listitem == 0)
	            {
	            SendClientMessage(playerid, COLOR_LIGHTBLUE, "你的颜色现在为浅蓝色");
	            SetPlayerColor(playerid, COLOR_LIGHTBLUE);
		    	}
	    		if (listitem == 1)
	    		{
			    SendClientMessage(playerid, COLOR_BLUE, "你的颜色现在为蓝色");
			    SetPlayerColor(playerid, COLOR_BLUE);
	    		}
	    		if (listitem == 2)
	    		{
			    SendClientMessage(playerid, COLOR_PINK, "你的颜色现在为粉色");
			    SetPlayerColor(playerid, COLOR_PINK);
	    		}
	    		if (listitem == 3)
	    		{
 			    SendClientMessage(playerid, COLOR_RED, "你的颜色现在为暗红色");
	   		    SetPlayerColor(playerid, COLOR_RED);
	    		}
 		    	if (listitem == 4)
	    		{
 			    SendClientMessage(playerid, COLOR_GREEN, "你的颜色现在为绿色");
			    SetPlayerColor(playerid, COLOR_GREEN);
	    		}
		    	if (listitem == 5)
		     	{
			    SendClientMessage(playerid, COLOR_ORANGE, "你的颜色现在为橙色");
			    SetPlayerColor(playerid, COLOR_ORANGE);
		    	}
 		    	if (listitem == 6)
		    	{
		 	    SendClientMessage(playerid, COLOR_YELLOW, "你的颜色现在为黄色");
			    SetPlayerColor(playerid, COLOR_YELLOW);
		    	}
		    	if (listitem == 7)
		     	{
				ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "{00C0FF}Luis's Fun Things!", "颜色", "选择", "取消");
		    	}


}
}



			    //wuqi
                if(dialogid == 110)
                {
                switch(listitem)
                {
                case 0:
                {
                  GivePlayerWeapon(playerid, 4, 1);
                }
			    case 1:
                {
                  GivePlayerWeapon(playerid, 5, 1);
                }
			    case 2:
                {
                  GivePlayerWeapon(playerid, 22, 5000);
                }
                case 3:
                {
                  GivePlayerWeapon(playerid, 23, 5000);
                }
                case 4:
                {
                  GivePlayerWeapon(playerid, 24, 5000);
                }
                case 5:
                {
                  GivePlayerWeapon(playerid, 25, 5000);
                }
                case 6:
                {
                  GivePlayerWeapon(playerid, 26, 5000);
                }
                case 7:
                {
                  GivePlayerWeapon(playerid, 27, 5000);
                }
                case 8:
                {
                  GivePlayerWeapon(playerid, 32, 5000);
                }
                case 9:
                {
                  GivePlayerWeapon(playerid, 28, 5000);
                }
                case 10:
                {
                  GivePlayerWeapon(playerid, 29, 5000);
                }
                case 11:
                {
                  GivePlayerWeapon(playerid, 30, 5000);
                }
                case 12:
                {
                  GivePlayerWeapon(playerid, 31, 5000);
                }
                case 13:
                {
                  GivePlayerWeapon(playerid, 33, 5000);
                }
                case 14:
                {
                  GivePlayerWeapon(playerid, 34, 5000);
                }
                case 15:
                {
                  GivePlayerWeapon(playerid, 35, 5000);
                }
                case 16:
                {
                  GivePlayerWeapon(playerid, 36, 5000);
                }
                case 17:
                {
                  GivePlayerWeapon(playerid, 37, 5000);
                }
                case 18:
                {
                  GivePlayerWeapon(playerid, 16, 5000);
                }
                case 19:
                {
                  GivePlayerWeapon(playerid, 17, 5000);
                }
                case 20:
                {
                  GivePlayerWeapon(playerid, 18, 5000);
                }
                case 21:
                {
                  GivePlayerWeapon(playerid, 39, 5000);
                  GivePlayerWeapon(playerid, 40, 1);
				}
                case 22:
                {
                  GivePlayerWeapon(playerid, 41, 5000);
                }
                case 23:
                {
                  GivePlayerWeapon(playerid, 42, 5000);
                }
}
}
//室内空间
if(dialogid == 700)
	{
		switch(listitem)
		{
   			case 0: ShowPlayerDialog(playerid, 700+1, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - 24/7's", "24/7 Interior 1\n24/7 Interior 2\n24/7 Interior 3\n24/7 Interior 4\n24/7 Interior 5\n24/7 Interior 6\nBack", "Select", "Cancel");
			case 1: ShowPlayerDialog(playerid, 700+2, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Airport Interiors", "Francis Ticket Sales Airport\nFrancis Baggage Claim Airport\nAndromada Cargo Hold\nShamal Cabin\nLS Airport Baggage Claim\nInterernational Airport\nAbandoned AC Tower\nBack", "Select", "Cancel");
			case 2: ShowPlayerDialog(playerid, 700+3, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Ammunation Interiors", "Ammunation 1\nAmmunation 2\nAmmunation 3\nAmmunation 4\nAmmunation 5\nBooth Ammunation\nRange Ammunation\nBack", "Select", "Cancel");
			case 3: ShowPlayerDialog(playerid, 700+4, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Houses", "B Dup's Apartment\nB Dup's Crack Palace\nOG Loc's House\nRyder's house\nSweet's house\nMadd Dogg's Mansion\nBig Smoke's Crack Palace\nBack", "Select", "Cancel");
			case 4: ShowPlayerDialog(playerid, 700+5, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Houses 2", "Johnson House\nAngel Pine Trailer\nSafe House\nSafe House 2\nSafe House 3\nSafe House 4\nVerdant Bluffs Safehouse\nWillowfield Safehouse\nThe Camel's Toe Safehouse\nBack", "Select", "Cancel");
			case 5: ShowPlayerDialog(playerid, 700+6, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Missions", "Atrium\nBurning Desire Building\nColonel Furhberger\nWelcome Pump\nWu Zi Mu's Apartement\nJizzy's\nDillimore Gas Station\nJefferson Motel\nLiberty City\nSherman Dam\nBack", "Select", "Cancel");
			case 6: ShowPlayerDialog(playerid, 700+7, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Stadiums", "RC War Arena\nRacing Stadium\nRacing Stadium 2\nBloodbowl Stadium\nKickstart Stadium\nBack", "Select", "Cancel");
			case 7: ShowPlayerDialog(playerid, 700+8, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Casino Interiors", "Caligulas Casino\n4 Dragons Casino\nRedsands Casino\n4 Dragons Managerial Suite\nInside Track Betting\nCaligulas Roof\nRosenberg's Caligulas Office\n4 Dragons Janitors Office\nBack", "Select", "Cancel");
			case 8: ShowPlayerDialog(playerid, 700+9, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Shop Interiors", "Tattoo\nBurger Shot\nWell Stacked Pizza\nCluckin' Bell\nRusty Donut's\nZero's RC Shop\nSex Shop\nBack", "Select", "Cancel");
			case 9: ShowPlayerDialog(playerid, 700+10, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Mod Shops/Garages","Loco Low Co.\nWheel Arch Angels\nTransfender\nDoherty Garage\nBack", "Select", "Cancel");
			case 10: ShowPlayerDialog(playerid, 700+11, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - CJ's Girlfriends Interiors","Denises Bedroom\nHelena's Barn\nBarbara's Love Nest\nKatie's Lovenest\nMichelle's Love Nest\nMillie's Bedroom\nBack", "Select", "Cancel");
			case 11: ShowPlayerDialog(playerid, 700+12, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Clothing & Barber Store","Barber Shop\nPro-Laps\nVictim\nSubUrban\nReece's Barber Shop\nZip\nDidier Sachs\nBinco\nBarber Shop 2\nWardrobe\nBack", "Select", "Cancel");
   			case 12: ShowPlayerDialog(playerid, 700+13, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Resturants & Clubs","Brothel\nBrothel 2\nThe Big Spread Ranch\nDinner\nWorld Of Coq\nThe Pig Pen\nClub\nJay's Diner\nSecret Valley Diner\nFanny Batter's Whore House\nBack", "Select", "Cancel");
   			case 13: ShowPlayerDialog(playerid, 700+14, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - No Specific Category","Blastin' Fools Records\nWarehouse\nWarehouse 2\nBudget Inn Motel Room\nLil' Probe Inn\nCrack Den\nMeat Factory\nBike School\nDriving School\nBack", "Select", "Cancel");
   			case 14: ShowPlayerDialog(playerid, 700+15, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Burglary Houses","Burglary House 1\nBurglary House 2\nBurglary House 3\nBurglary House 4\nBurglary House 5\nBurglary House 6\nBurglary House 7\nBurglary House 8\nBurglary House 9\nBurglary House 10\nBack", "Select", "Cancel");
			case 15: ShowPlayerDialog(playerid, 700+16, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Burglary Houses 2","Burglary House 11\nBurglary House 12\nBurglary House 13\nBurglary House 14\nBurglary House 15\nBurglary House 16\nBurglary House 17\nBack", "Select", "Cancel");
   			case 16: ShowPlayerDialog(playerid, 700+17, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Gyms","Los Santos Gym\nSan Fierro Gym\nLas Venturas Gym\nBack", "Select", "Cancel");
   			case 17: ShowPlayerDialog(playerid, 700+18, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - Departments","SF Police Department\nLS Police Department\nLV Police Department\nPlanning Department\nBack", "Select", "Cancel");
   			case 18: ShowPlayerDialog(playerid, 700+19, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino - World Locations","Market Stall #1\nMarket Stall #2\nMarket Stall #3\nMarket Stall #4\nMarket Stall #5\nBack", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	24/7's
//==============================================================================
	if(dialogid == 700+1 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, -25.884499,-185.868988,1003.549988, 17, "24/7 #1");
			case 1: SetPlayerPosEx(playerid, -6.091180,-29.271898,1003.549988, 10, "24/7 #2");
			case 2: SetPlayerPosEx(playerid, -30.946699,-89.609596,1003.549988, 18, " 24/7 #3");
			case 3: SetPlayerPosEx(playerid, -25.132599,-139.066986,1003.549988, 16, " 24/7 #4");
			case 4: SetPlayerPosEx(playerid, -27.312300,-29.277599,1003.549988, 4, " 24/7 #5");
			case 5: SetPlayerPosEx(playerid, -26.691599,-55.714897,1003.549988, 6, "24/7 #6");
			case 6: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	Airports
//==============================================================================
	if(dialogid == 700+2 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, -1827.147338,7.207418,1061.143554, 14, "Francis Ticket Sales Airport");
			case 1: SetPlayerPosEx(playerid, -1855.568725,41.263156,1061.143554, 14, "Francis Baggage Claim Airport");
			case 2: SetPlayerPosEx(playerid, 315.856170,1024.496459,1949.797363, 9, "Andromada Cargo Hold");
			case 3: SetPlayerPosEx(playerid, 2.384830,33.103397,1199.849976, 1, "Shamal Cabin");
			case 4: SetPlayerPosEx(playerid, -1870.80,59.81,1056.25, 14, "LS Airport Baggage Claim");
			case 5: SetPlayerPosEx(playerid, -1830.81,16.83,1061.14, 14, "Interernational Airport");
			case 6: SetPlayerPosEx(playerid, 419.8936, 2537.1155, 10, 10, "Abounded AC Tower");
			case 7: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	Ammunation
//==============================================================================
	if(dialogid == 700+3 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 286.148987,-40.644398,1001.569946, 1, "Ammunation #1");
			case 1: SetPlayerPosEx(playerid, 286.800995,-82.547600,1001.539978, 4, "Ammunation #2");
			case 2: SetPlayerPosEx(playerid, 296.919983,-108.071999,1001.569946, 6, "Ammunation #3");
			case 3: SetPlayerPosEx(playerid, 314.820984,-141.431992,999.661987, 7, "Ammunation #4");
			case 4: SetPlayerPosEx(playerid, 316.524994,-167.706985,999.661987, 6, "Ammunation #5");
			case 5: SetPlayerPosEx(playerid, 302.292877,-143.139099,1004.062500, 7, "Booth Ammunation");
			case 6: SetPlayerPosEx(playerid, 280.795104,-135.203353,1004.062500, 7, "Range Ammunation");
			case 7: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");

		}
		return 1;
	}
//==============================================================================
//                          	Houses
//==============================================================================
	if(dialogid == 700+4 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 1527.0468, -12.0236, 1002.0971, 3, "B Dup's Apartment");
			case 1: SetPlayerPosEx(playerid, 1523.5098, -47.8211, 1002.2699, 2, "B Dup's Crack Palace");
			case 2: SetPlayerPosEx(playerid, 512.9291, -11.6929, 1001.565, 3, "OG Loc's House");
			case 3: SetPlayerPosEx(playerid, 2447.8704, -1704.4509, 1013.5078, 2, "Ryder's House");
			case 4: SetPlayerPosEx(playerid, 2527.0176, -1679.2076, 1015.4986, 1, "Sweet's House");
 			case 5: SetPlayerPosEx(playerid, 1267.8407, -776.9587, 1091.9063, 5, "Madd Dogg's Mansion");
			case 6: SetPlayerPosEx(playerid, 2536.5322, -1294.8425, 1044.125, 2, "Big Smoke's Crack Palace");
			case 7: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	Safe Houses
//==============================================================================
	if(dialogid == 700+5 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 2496.0549, -1695.1749, 1014.7422, 3, "CJ's House");
			case 1: SetPlayerPosEx(playerid, 1.1853, -3.2387, 999.4284, 2, "Angel Pine trailer");
			case 2: SetPlayerPosEx(playerid, 2233.6919, -1112.8107, 1050.8828, 5, "Safe House #1");
			case 3: SetPlayerPosEx(playerid, 2194.7900, -1204.3500, 1049.0234, 6, "Safe House #2");
			case 4: SetPlayerPosEx(playerid, 2319.1272, -1023.9562, 1050.2109, 9, "Safe House #3");
			case 5: SetPlayerPosEx(playerid, 2262.4797,-1138.5591,1050.63285, 10, "Safe House #4");
			case 6: SetPlayerPosEx(playerid, 2365.1089, -1133.0795, 1050.875, 8, "Verdant Bluff safehouse");
			case 7: SetPlayerPosEx(playerid, 2282.9099, -1138.2900, 1050.8984, 11, "Willowfield Safehouse");
			case 8: SetPlayerPosEx(playerid, 2216.1282, -1076.3052, 1050.4844, 1, "The Camel's Toe Safehouse");
			case 9: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");

		}
		return 1;
	}
//==============================================================================
//                          	Missions 1
//==============================================================================
	if(dialogid == 700+6 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 1726.18,-1641.00,20.23, 18, "Atrium");
			case 1: SetPlayerPosEx(playerid, 2338.32,-1180.61,1027.98, 5, "Burning Desire");
			case 2: SetPlayerPosEx(playerid, 2807.63,-1170.15,1025.57, 8, "Colonel Furhberger");
			case 3: SetPlayerPosEx(playerid, 681.66,-453.32,-25.61, 1, "Welcome Pump(Dillimore)");
			case 4: SetPlayerPosEx(playerid, -2158.72,641.29,1052.38, 1, "Woozies Apartment");
			case 5: SetPlayerPosEx(playerid, -2637.69,1404.24,906.46, 3, "Jizzy's");
			case 6: SetPlayerPosEx(playerid, 664.19,-570.73,16.34, 0, "Dillimore Gas Station");
			case 7: SetPlayerPosEx(playerid, 2220.26,-1148.01,1025.80, 15, "Jefferson Motel");
			case 8: SetPlayerPosEx(playerid, -750.80,491.00,1371.70, 1, "Liberty City");
			case 9: SetPlayerPosEx(playerid, -944.2402, 1886.1536, 5.0051, 17, "Sherman Dam");
			case 10: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");

		}
		return 1;
	}
//==============================================================================
//                          	Missions 2
//==============================================================================
	if(dialogid == 700+7 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, -1079.99,1061.58,1343.04, 10, "RC War Arena");
			case 1: SetPlayerPosEx(playerid, -1395.958,-208.197,1051.170, 7, "Racing Stadium");
			case 2: SetPlayerPosEx(playerid, -1424.9319,-664.5869,1059.8585, 4, "Racing Stadium 2");
			case 3: SetPlayerPosEx(playerid, -1394.20,987.62,1023.96, 15, "Bloodbowl Stadium");
			case 4: SetPlayerPosEx(playerid, -1410.72,1591.16,1052.53, 14, "Kickstart Stadium");
			case 5: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	Casino Interiors
//==============================================================================
	if(dialogid == 700+8 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 2233.8032,1712.2303,1011.7632, 1, "Caligulas Casino");
			case 1: SetPlayerPosEx(playerid, 2016.2699,1017.7790,996.8750, 10, "4 Dragons Casino");
			case 2: SetPlayerPosEx(playerid, 1132.9063,-9.7726,1000.6797, 12, "Redsands Casino");
			case 3: SetPlayerPosEx(playerid, 2003.1178, 1015.1948, 33.008, 11, "4 Dragons' Managerial Suite (Unsolid floor)");
			case 4: SetPlayerPosEx(playerid, 830.6016, 5.9404, 1004.1797, 3, "Inside Track betting");
			case 5: SetPlayerPosEx(playerid, 2268.5156, 1647.7682, 1084.2344, 1, "Caligulas Roof");
			case 6: SetPlayerPosEx(playerid, 2182.2017, 1628.5848, 1043.8723, 2, "Rosenberg's Caligulas Office (Unsolid floor)");
			case 7: SetPlayerPosEx(playerid, 1893.0731, 1017.8958, 31.8828, 10, "4 Dragons Janitor's Office");
			case 8: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	Shop Interiors
//==============================================================================
	if(dialogid == 700+9 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, -203.0764,-24.1658,1002.2734, 16, "Tattoo");
			case 1: SetPlayerPosEx(playerid, 365.4099,-73.6167,1001.5078, 10, "Burger Shot");
			case 2: SetPlayerPosEx(playerid, 372.3520,-131.6510,1001.4922, 5, "Well Stacked Pizza");
			case 3: SetPlayerPosEx(playerid, 365.7158,-9.8873,1001.8516, 9, "Cluckin Bell");
			case 4: SetPlayerPosEx(playerid, 378.026,-190.5155,1000.6328, 17, "Rusty Donut's");
			case 5: SetPlayerPosEx(playerid, -2240.1028, 136.973, 1035.4141, 6, "Zero's");
			case 6: SetPlayerPosEx(playerid, -100.2674, -22.9376, 1000.7188, 3, "Sex Shop");
			case 7: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	Mod Shops/Garages
//==============================================================================
	if(dialogid == 700+10 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 616.7820,-74.8151,997.6350, 2, "Loco Low Co.");
			case 1: SetPlayerPosEx(playerid, 615.2851,-124.2390,997.6350, 3, "Wheel Arch Angels");
			case 2: SetPlayerPosEx(playerid, 617.5380,-1.9900,1000.6829, 1, "Transfender");
			case 3: SetPlayerPosEx(playerid, -2041.2334, 178.3969, 28.8465, 1, "Doherty Garage");
			case 4: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	Girlfriend Interiors
//==============================================================================
	if(dialogid == 700+11 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 245.2307, 304.7632, 999.1484, 1, "Denise's Bedroom");
			case 1: SetPlayerPosEx(playerid, 290.623, 309.0622, 999.1484, 3, "Helena's Barn");
			case 2: SetPlayerPosEx(playerid, 322.5014, 303.6906, 999.1484, 5, "Barbaras Lovenest");
			case 3: SetPlayerPosEx(playerid, 269.6405, 305.9512, 999.1484, 2, "Katie's Lovenest");
			case 4: SetPlayerPosEx(playerid, 306.1966, 307.819, 1003.3047, 4, "Michelle's Lovenest");
			case 5: SetPlayerPosEx(playerid, 344.9984, 307.1824, 999.1557, 6, "Millie's Bedroom");
			case 6: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                              Clothing/Barber Shops
//==============================================================================
	if(dialogid == 700+12 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 418.4666, -80.4595, 1001.8047, 3, "Barber Shop");
			case 1: SetPlayerPosEx(playerid, 206.4627, -137.7076, 1003.0938, 3, "Pro Laps");
			case 2: SetPlayerPosEx(playerid, 225.0306, -9.1838, 1002.218, 5, "Victim");
			case 3: SetPlayerPosEx(playerid, 204.1174, -46.8047, 1001.8047, 1, "Suburban");
			case 4: SetPlayerPosEx(playerid, 414.2987, -18.8044, 1001.8047, 2, "Reece's Barber Shop");
			case 5: SetPlayerPosEx(playerid, 161.4048, -94.2416, 1001.8047, 18, "Zip");
			case 6: SetPlayerPosEx(playerid, 204.1658, -165.7678, 1000.5234, 14, "Didier Sachs");
			case 7: SetPlayerPosEx(playerid, 207.5219, -109.7448, 1005.1328, 15, "Binco");
			case 8: SetPlayerPosEx(playerid, 411.9707, -51.9217, 1001.8984, 12, "Barber Shop 2");
			case 9: SetPlayerPosEx(playerid, 256.9047, -41.6537, 1002.0234, 14, "Wardrobe");
			case 10: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	Resturants/Clubs
//==============================================================================
	if(dialogid == 700+13 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 974.0177, -9.5937, 1001.1484, 3, "Brotel");
			case 1: SetPlayerPosEx(playerid, 961.9308, -51.9071, 1001.1172, 3, "Brotel 2");
			case 2: SetPlayerPosEx(playerid, 1212.0762,-28.5799,1000.9531, 3, "Big Spread Ranch");
			case 3: SetPlayerPosEx(playerid, 454.9853, -107.2548, 999.4376, 5, "Dinner");
			case 4: SetPlayerPosEx(playerid, 445.6003, -6.9823, 1000.7344, 1, "World Of Coq");
			case 5: SetPlayerPosEx(playerid, 1204.9326,-8.1650,1000.9219, 2, "The Pig Pen");
			case 6: SetPlayerPosEx(playerid, 490.2701,-18.4260,1000.6797, 17, "Dance Club");
			case 7: SetPlayerPosEx(playerid, 449.0172, -88.9894, 999.5547, 4, "Jay's Dinner");
			case 8: SetPlayerPosEx(playerid, 442.1295, -52.4782, 999.7167, 6, "Secret Valley Dinner");
			case 9: SetPlayerPosEx(playerid, 748.4623, 1438.2378, 1102.9531, 6, "Fanny Batter's Whore House");
			case 10: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	No Specific Group
//==============================================================================
	if(dialogid == 700+14 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 1037.8276, 0.397, 1001.2845, 3, "Blastin' Fools Records");
			case 1: SetPlayerPosEx(playerid, 1290.4106, 1.9512, 1001.0201, 18, "Warehouse");
			case 2: SetPlayerPosEx(playerid, 1411.4434,-2.7966,1000.9238, 1, "Warehouse 2");
			case 3: SetPlayerPosEx(playerid, 446.3247, 509.9662, 1001.4195, 12, "Budget Inn Motel Room");
			case 4: SetPlayerPosEx(playerid, -227.5703, 1401.5544, 27.7656, 18, "Lil' Probe Inn");
			case 5: SetPlayerPosEx(playerid, 318.5645, 1118.2079, 1083.8828, 5, "Crack Den");
			case 6: SetPlayerPosEx(playerid, 963.0586, 2159.7563, 1011.0303, 1, "Meat Factory");
			case 7: SetPlayerPosEx(playerid, 1494.8589, 1306.48, 1093.2953, 3, "Bike School");
			case 8: SetPlayerPosEx(playerid, -2031.1196, -115.8287, 1035.1719, 3, "Driving School");
			case 9: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	Burglary Houses 1
//==============================================================================
	if(dialogid == 700+15 && response) //
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 234.6087, 1187.8195, 1080.2578, 3, "Burglary House #1");
			case 1: SetPlayerPosEx(playerid, 225.5707, 1240.0643, 1082.1406, 2, "Burglary House #2");
			case 2: SetPlayerPosEx(playerid, 224.288, 1289.1907, 1082.1406, 1, "Burglary House #3");
			case 3: SetPlayerPosEx(playerid, 239.2819, 1114.1991, 1080.9922, 5, "Burglary House #4");
			case 4: SetPlayerPosEx(playerid, 295.1391, 1473.3719, 1080.2578, 15, "Burglary House #5");
			case 5: SetPlayerPosEx(playerid, 261.1165, 1287.2197, 1080.2578, 4, "Burglary House #6");
			case 6: SetPlayerPosEx(playerid, 24.3769, 1341.1829, 1084.375, 10, "Burglary House #7");
			case 7: SetPlayerPosEx(playerid, -262.1759, 1456.6158, 1084.36728, 4, "Burglary House #8");
			case 8: SetPlayerPosEx(playerid, 22.861, 1404.9165, 1084.4297, 5, "Burglary House #9");
			case 9: SetPlayerPosEx(playerid, 140.3679, 1367.8837, 1083.8621, 5, "Burglary House #10");
			case 10: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	Burglary Houses 2
//==============================================================================
	if(dialogid == 700+16 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 234.2826, 1065.229, 1084.2101, 6, "Burglary House #11");
			case 1: SetPlayerPosEx(playerid, -68.5145, 1353.8485, 1080.2109, 6, "Burglary House #12");
			case 2: SetPlayerPosEx(playerid, -285.2511, 1471.197, 1084.375, 15, "Burglary House #13");
			case 3: SetPlayerPosEx(playerid, -42.5267, 1408.23, 1084.4297, 8, "Burglary House #14");
			case 4: SetPlayerPosEx(playerid, 84.9244, 1324.2983, 1083.8594, 9, "Burglary House #15");
			case 5: SetPlayerPosEx(playerid, 260.7421, 1238.2261, 1084.2578, 9, "Burglary House #16");
			case 6: SetPlayerPosEx(playerid, 447.0000, 1400.3000, 1084.3047, 2, "Burglary House #17");
			case 7: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          	Gyms
//==============================================================================
	if(dialogid == 700+17 && response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid, 234.2826, 1065.229, 1084.2101, 6, "Los Santos Gym");
			case 1: SetPlayerPosEx(playerid, 771.8632,-40.5659,1000.6865, 6, "San Fierro Gym");
			case 2: SetPlayerPosEx(playerid, 774.0681,-71.8559,1000.6484, 7, "Las Venturas Gym");
			case 3: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          Deparments
//==============================================================================
	if(dialogid == 700+18 && response)
	{
	    switch(listitem)
	    {
			case 0: SetPlayerPosEx(playerid, 246.40,110.84,1003.22, 10, "San Fierro Police Department");
			case 1: SetPlayerPosEx(playerid, 246.6695, 65.8039, 1003.6406, 6, "Los Santos Police Department");
			case 2: SetPlayerPosEx(playerid, 288.4723, 170.0647, 1007.1794, 3, "Las Venturas Police Department");
			case 3: SetPlayerPosEx(playerid, 386.5259, 173.6381, 1008.382, 3, "Planning Department (City Hall)");
			case 4: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
//==============================================================================
//                          World Locations
//==============================================================================
	if(dialogid == 700+19 && response)
	{
	    switch(listitem)
	    {
			case 0: SetPlayerPosEx(playerid, 390.6189, -1754.6224, 8.2057, 0, "Market Stall #1");
			case 1: SetPlayerPosEx(playerid, 398.1151, -1754.8677, 8.2150, 0, "Market Stall #2");
			case 2: SetPlayerPosEx(playerid, 380.1665, -1886.9348, 7.8359, 0, "Market Stall #3");
			case 3: SetPlayerPosEx(playerid, 383.4514, -1912.3203, 7.8359, 0, "Market Stall #4");
			case 4: SetPlayerPosEx(playerid, 380.8439, -1922.2300, 7.8359, 0, "Market Stall #4");
			case 5: ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "Interior Menu v1.4 by [03]Garsino","24/7's\nAirports\nAmmunations\nHouses\nHouses 2\nMissions\nStadiums\nCasinos\nShops\nGarages\nGirlfriends\nClothing/Barber Store\nResturants/Clubs\nNo Category\nBurglary\nBurglary 2\nGym\nDepartment\nWorld Locations", "Select", "Cancel");
		}
		return 1;
	}
///tun
if(dialogid==3131)
{
new vehicleid,panels,doors,lights,tires;
if(response)
{
if(listitem==0)//Nos/Hydro
{
ShowPlayerDialog(playerid,3132,DIALOG_STYLE_LIST,"加速器/液压装置","10X加速器\n液压装置","确定","取消");
}
if(listitem==1)//Rims
{
ShowPlayerDialog(playerid,3133,DIALOG_STYLE_LIST,"轮胎/轮圈","Dollar\nSwitch\nMega\nShadow\nVirtual\nAccess","确定","取消");
}
if(listitem==2)//Colours
{
ShowPlayerDialog(playerid,3134,DIALOG_STYLE_LIST,"车辆颜色","黑色\n白色\n红色\n橘黄色\n蓝色\n绿色","确定","取消");
}
if(listitem==3)//Repair
{
RepairVehicle(GetPlayerVehicleID(playerid));
}
if(listitem==4)//Repair
{
//ShowPlayerDialog(playerid, 4555, DIALOG_STYLE_LIST, "超级改装 {FF00D4}★〓by dts_3899〓☆ {BUG测试}","{0000FF}蓝色霓虹灯\n{00FF00}绿色霓虹灯\n{FFFF00}黄色霓虹灯\n白色霓虹灯\n{FF00D4}粉色霓虹灯\n{00FFFF}轻型改装\n{FF7F2A}重型改装\n{FF0000}删除后灯\n{FF0000}删除所有改装","选择","取消");
ShowPlayerDialog(playerid,4555, DIALOG_STYLE_LIST, "选择你汽车底盘灯的颜色","蓝色\n绿色\n黄色\n白色\n粉红色\n警灯\n移除所有","Add","Close");
}
if(listitem==5)//Repair
{
vehicleid = GetPlayerVehicleID(playerid);
GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
LightPwr[vehicleid] = 0;
Flasher[vehicleid] = 0;
return 1;
}
if(listitem==6)//Repair
{
vehicleid = GetPlayerVehicleID(playerid);
GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
LightPwr[vehicleid] = 1;
Flasher[vehicleid] = 0;
return 1;
}
if(listitem==7)//Repair
{
new matt;
for(matt=0;matt<MAX_PLAYERS;matt++)
{
if(matt != playerid)
{
SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),matt, 0, 1);
SendClientMessage(playerid, 0xFFFFFFAA, "[車管}：車門已鎖！");
}
}
return 1;
}
if(listitem==8)//Repair
{
new matt;
for(matt=0;matt<MAX_PLAYERS;matt++)
{
SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),matt, 0, 0);
SendClientMessage(playerid, 0xFFFFFFAA, "[車管}：車門解鎖！");
}
return 1;
}
}
return 1;
}
/*
if(dialogid == 4555)
	{
		if(response)
		{
		    if(listitem == 0)
		    {

				SetPVarInt(playerid, "neon", 1);
          		SetPVarInt(playerid, "blue", CreateObject(18648,0,0,0,0,0,0));
            	SetPVarInt(playerid, "blue1", CreateObject(18648,0,0,0,0,0,0));
            	AttachObjectToVehicle(GetPVarInt(playerid, "blue"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            	AttachObjectToVehicle(GetPVarInt(playerid, "blue1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            	GameTextForPlayer(playerid, "~b~ Blue ~w~lan se",3500,5);
            	GivePlayerMoney(playerid,-200000);

			}
			if(listitem == 1)
			{

   				SetPVarInt(playerid, "neon", 1);
       			SetPVarInt(playerid, "green", CreateObject(18649,0,0,0,0,0,0));
       			SetPVarInt(playerid, "green1", CreateObject(18649,0,0,0,0,0,0));
       			AttachObjectToVehicle(GetPVarInt(playerid, "green"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
          		AttachObjectToVehicle(GetPVarInt(playerid, "green1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
          		GameTextForPlayer(playerid, "~g~Green ~w~lv se",3500,5);
          		GivePlayerMoney(playerid,-200000);

			}
			if(listitem == 2)
			{

			    SetPVarInt(playerid, "neon", 1);
       			SetPVarInt(playerid, "yellow", CreateObject(18650,0,0,0,0,0,0));
          		SetPVarInt(playerid, "yellow1", CreateObject(18650,0,0,0,0,0,0));
            	AttachObjectToVehicle(GetPVarInt(playerid, "yellow"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
             	AttachObjectToVehicle(GetPVarInt(playerid, "yellow1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				GameTextForPlayer(playerid, "~y~Yellow~w~ huang se",3500,5);
				GivePlayerMoney(playerid,-200000);

			}
			if(listitem == 3)
			{

   				SetPVarInt(playerid, "neon", 1);
   				SetPVarInt(playerid, "white", CreateObject(18652,0,0,0,0,0,0));
   				SetPVarInt(playerid, "white1", CreateObject(18652,0,0,0,0,0,0));
       			AttachObjectToVehicle(GetPVarInt(playerid, "white"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
          		AttachObjectToVehicle(GetPVarInt(playerid, "white1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
                GameTextForPlayer(playerid, "~w~White~w~ bai se",3500,5);
                GivePlayerMoney(playerid,-200000);

			}
			if(listitem == 4)
			{

   				SetPVarInt(playerid, "neon", 1);
                SetPVarInt(playerid, "pink", CreateObject(18651,0,0,0,0,0,0));
        		SetPVarInt(playerid, "pink1", CreateObject(18651,0,0,0,0,0,0));
          		AttachObjectToVehicle(GetPVarInt(playerid, "pink"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            	AttachObjectToVehicle(GetPVarInt(playerid, "pink1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				GameTextForPlayer(playerid, "~p~Pink~w~ fen hou se",3500,5);
				GivePlayerMoney(playerid,-200000);

			}
			if(listitem == 5)
			{

   				SetPVarInt(playerid, "neon", 1);
     			SetPVarInt(playerid, "ld1", CreateObject(2985,0,0,0,0,0,0));
		        SetPVarInt(playerid, "ld2", CreateObject(2985,0,0,0,0,0,0));
          		AttachObjectToVehicle(GetPVarInt(playerid, "ld1"), GetPlayerVehicleID(playerid), 0.4567871094, 1.4544677735, -0.800000190735, 0, 0, 90);
            	AttachObjectToVehicle(GetPVarInt(playerid, "ld2"), GetPlayerVehicleID(playerid), -0.5654296875, 1.4544677735, -0.800000190735, 0, 0, 90);
				GameTextForPlayer(playerid, "~p~ld1~w~ qing xing gai zhuang wan cheng",3500,5);
				GivePlayerMoney(playerid,-5000000);

			}
			if(listitem == 6)
			{

   				SetPVarInt(playerid, "neon", 1);
     			SetPVarInt(playerid, "ld1", CreateObject(2985,0,0,0,0,0,0));
		        SetPVarInt(playerid, "ld2", CreateObject(2985,0,0,0,0,0,0));
		        SetPVarInt(playerid, "ld3", CreateObject(2899,0,0,0,0,0,0));
		        SetPVarInt(playerid, "ld4", CreateObject(2899,0,0,0,0,0,0));
		        SetPVarInt(playerid, "ld5", CreateObject(3786,0,0,0,0,0,0));
		        SetPVarInt(playerid, "ld6", CreateObject(354,0,0,0,0,0,0));
		        SetPVarInt(playerid, "ld7", CreateObject(3884,0,0,0,0,0,0));
          		AttachObjectToVehicle(GetPVarInt(playerid, "ld1"), GetPlayerVehicleID(playerid), 0.4567871094, 1.4544677735, -0.800000190735, 0, 0, 90);
            	AttachObjectToVehicle(GetPVarInt(playerid, "ld2"), GetPlayerVehicleID(playerid), -0.5654296875, 1.4544677735, -0.800000190735, 0, 0, 90);
            	AttachObjectToVehicle(GetPVarInt(playerid, "ld3"), GetPlayerVehicleID(playerid), 1.2995605469, 0.1013183594, 0.072827339172, 0, 90, 0);
            	AttachObjectToVehicle(GetPVarInt(playerid, "ld4"), GetPlayerVehicleID(playerid), -1.2889404297, 0.1013183594, 0.264037132263, 0, 270, 0);
            	AttachObjectToVehicle(GetPVarInt(playerid, "ld5"), GetPlayerVehicleID(playerid), 0.0339355469, -0.4896240234, 2.818711280823, 0, 33, 270);
            	AttachObjectToVehicle(GetPVarInt(playerid, "ld6"), GetPlayerVehicleID(playerid), 0.1011962891, -1.19921875, 1.530359268188, 0, 0, 0);
                AttachObjectToVehicle(GetPVarInt(playerid, "ld7"), GetPlayerVehicleID(playerid), 0.0166015625, -0.0382080078, 0.099999427795, 0, 0, 0);
				GameTextForPlayer(playerid, "~p~ld1~w~ zhon gxing xing gai zhuang wan cheng",3500,5);
				GivePlayerMoney(playerid,-1500000);
			}

        	if(listitem == 7)
			{
   				 DestroyObject(GetPVarInt(playerid, "ld6"));
	             DeletePVar(playerid, "neon");
                 GameTextForPlayer(playerid, "~g~shan guang deng bei yi chu",3500,5);
			}


			if(listitem == 8)
			{

			    DestroyObject(GetPVarInt(playerid, "blue"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "blue1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "ld1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "ld2"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "ld3"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "ld4"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "ld5"));
	            DeletePVar(playerid, "neon");
                DestroyObject(GetPVarInt(playerid, "ld6"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "ld7"));
	            DeletePVar(playerid, "neon");
			 }

		}
 	}
*/
if(dialogid==4555)
{
if(response)
{
if(listitem==0)
{
DestroyObject(GetPVarInt(playerid, "blue"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "blue1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink1"));
DeletePVar(playerid, "neon");
SetPVarInt(playerid, "neon", 1);
SetPVarInt(playerid, "blue", CreateObject(18648,0,0,0,0,0,0));
SetPVarInt(playerid, "blue1", CreateObject(18648,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "blue"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
AttachObjectToVehicle(GetPVarInt(playerid, "blue1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
GameTextForPlayer(playerid, "~b~ Blue ~w~Neon has been added to your vehicle",3500,5);
}
if(listitem==1)
{
DestroyObject(GetPVarInt(playerid, "blue"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "blue1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink1"));
DeletePVar(playerid, "neon");
SetPVarInt(playerid, "neon", 1);
SetPVarInt(playerid, "green", CreateObject(18649,0,0,0,0,0,0));
SetPVarInt(playerid, "green1", CreateObject(18649,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "green"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
AttachObjectToVehicle(GetPVarInt(playerid, "green1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
GameTextForPlayer(playerid, "~g~Green ~w~Neon has been added to your vehicle",3500,5);
}
if(listitem==2)
{
DestroyObject(GetPVarInt(playerid, "blue"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "blue1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink1"));
DeletePVar(playerid, "neon");
SetPVarInt(playerid, "neon", 1);
SetPVarInt(playerid, "yellow", CreateObject(18650,0,0,0,0,0,0));
SetPVarInt(playerid, "yellow1", CreateObject(18650,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "yellow"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
AttachObjectToVehicle(GetPVarInt(playerid, "yellow1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
GameTextForPlayer(playerid, "~y~Yellow~w~ Neon has been added to your vehicle",3500,5);
}
if(listitem==3)
{
DestroyObject(GetPVarInt(playerid, "blue"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "blue1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "undercover"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "undercover1"));
SetPVarInt(playerid, "neon", 1);
SetPVarInt(playerid, "white", CreateObject(18652,0,0,0,0,0,0));
SetPVarInt(playerid, "white1", CreateObject(18652,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "white"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
AttachObjectToVehicle(GetPVarInt(playerid, "white1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
GameTextForPlayer(playerid, "~w~White~w~ Neon has been added to your vehicle",3500,5);
}
if(listitem==4)
{
DestroyObject(GetPVarInt(playerid, "blue"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "blue1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "undercover"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "undercover1"));
SetPVarInt(playerid, "Status", 1);
SetPVarInt(playerid, "neon", 1);
SetPVarInt(playerid, "pink", CreateObject(18651,0,0,0,0,0,0));
SetPVarInt(playerid, "pink1", CreateObject(18651,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "pink"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
AttachObjectToVehicle(GetPVarInt(playerid, "pink1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
GameTextForPlayer(playerid, "~p~Pink~w~ Neon has been added to your vehicle",3500,5);
}
if(listitem == 5)
{
DestroyObject(GetPVarInt(playerid, "undercover"));
DestroyObject(GetPVarInt(playerid, "undercover1"));
DeletePVar(playerid, "Status");
SetPVarInt(playerid, "Status", 1);
SetPVarInt(playerid, "undercover", CreateObject(18646,0,0,0,0,0,0));
SetPVarInt(playerid, "undercover1", CreateObject(18646,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "undercover"), GetPlayerVehicleID(playerid), -0.5, -0.2, 0.8, 2.0, 2.0, 3.0);
AttachObjectToVehicle(GetPVarInt(playerid, "undercover1"), GetPlayerVehicleID(playerid), -0.5, -0.2, 0.8, 2.0, 2.0, 3.0);
SendClientMessage(playerid, 0xFFFFFFAA, "警灯已安装。");
}
if(listitem == 6)
{
DestroyObject(GetPVarInt(playerid, "blue"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "blue1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "green1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "yellow1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "white1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "pink1"));
DeletePVar(playerid, "neon");
DestroyObject(GetPVarInt(playerid, "undercover"));
DestroyObject(GetPVarInt(playerid, "undercover1"));
DeletePVar(playerid, "Status");
SendClientMessage(playerid, 0xFFFFFFAA, "所有已移除！");
}
}
return 1;
}
if(dialogid==3135)
{
if(response)
{
}
}
if(dialogid==3134)
{
if(response)
{
if(listitem==0)
{
ChangeVehicleColor(GetPlayerVehicleID(playerid),0,0);
}
if(listitem==1)
{
ChangeVehicleColor(GetPlayerVehicleID(playerid),1,1);
}
if(listitem==2)
{
ChangeVehicleColor(GetPlayerVehicleID(playerid),3,3);
}
if(listitem==3)
{
ChangeVehicleColor(GetPlayerVehicleID(playerid),6,6);
}
if(listitem==4)
{
ChangeVehicleColor(GetPlayerVehicleID(playerid),7,7);
}
if(listitem==5)
{
ChangeVehicleColor(GetPlayerVehicleID(playerid),16,16);
}
}
}
if(dialogid==3133)
{
if(response)
{
if(listitem==0)
{
AddVehicleComponent(GetPlayerVehicleID(playerid), 1083);
}
if(listitem==1)
{
AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
}
if(listitem==2)
{
AddVehicleComponent(GetPlayerVehicleID(playerid), 1074);
}
if(listitem==3)
{
AddVehicleComponent(GetPlayerVehicleID(playerid), 1073);
}
if(listitem==4)
{
AddVehicleComponent(GetPlayerVehicleID(playerid), 1097);
}
if(listitem==5)
{
AddVehicleComponent(GetPlayerVehicleID(playerid), 1098);
}
}
}
if(dialogid==3132)
{
if(response)
{
if(listitem==0)
{
AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
}
if(listitem==1)
{
AddVehicleComponent(GetPlayerVehicleID(playerid), 1087);
}
}
}

if(dialogid==889)
{

if(response)
{
new mes;
inputtext[mes];
Delete3DTextLabel(label[playerid]);
label[playerid] = Create3DTextLabel(inputtext[mes],0x0005FFFF, 30.0, 40.0, 50.0, 40.0, 0);
Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.7);
SendClientMessage(playerid,COLOR_YELLOW,"[个性签名]设定成功！");
return 1;
}
}
if(dialogid==1247)
{
if(response)
{
SendClientMessage(playerid, COLOUR_DEBUG,"[提示]输入/back 回来!");
isplayerafk[playerid]=1;
new mes;
new string[256];
new string1[256];
new pname[65];
GetPlayerName(playerid,pname,65);
SetPlayerHealth(playerid,99999999999);
TogglePlayerControllable(playerid,0);
inputtext[mes];
format(string, sizeof(string),"{FFFA00}挂机中...勿打扰,{FFFFFF} 原因:{00D7FF} %s",inputtext[mes]);
afk3dtext[playerid] =Create3DTextLabel(string,0x008080FF,30.0,40.0,50.0,40.0,0);
Attach3DTextLabelToPlayer(afk3dtext[playerid], playerid, 0.0, 0.0, 0.9);
format(string1, sizeof(string1),"[AFK系统提示]:玩家{FF0000} %s {FFFFFF}挂机中...，原因:{00AFFF} %s",pname,inputtext[mes]);
SendClientMessageToAll(COLOR_WHITE,string1);
//Delete3DTextLabel(afk3dtext[playerid]);
}
return 1;
}
if(response)
    {
    switch(dialogid==1079)
        {
		case 1:
    	    {
           	switch(listitem)
        	{
        	    case 0:
        	    {
                    StopAudioStreamForPlayer(playerid);
                    PlayAudioStreamForPlayer(playerid, "http://learning.sohu.com/zt/freshenglish/aug22/makingloveoutofnothingatall.mp3");

        	    }
        	    case 1:
        	    {
        	        StopAudioStreamForPlayer(playerid);
					PlayAudioStreamForPlayer(playerid, "http://audio.oktober1.com/SpaceAge.mp3");

        	    }
        	    case 2:
        	    {
        	        StopAudioStreamForPlayer(playerid);
					PlayAudioStreamForPlayer(playerid, "http://media1.webgarden.name/files/media1:4bed7e8e1a435.mp3.upl/usa%20for%20africa%20-%20we%20are%20the%20world.mp3");

        	    }
        	    case 3:
        	    {
        	        StopAudioStreamForPlayer(playerid);
					PlayAudioStreamForPlayer(playerid, "http://file2.qlteacher.com/gz2011/medias/upload/2011/07/21/Earth_Song(2011-7-21.114127.467).mp3");

        	    }
        	    case 4:
        	    {
        	       StopAudioStreamForPlayer(playerid);
        	       PlayAudioStreamForPlayer(playerid, "http://boxstr.net/files/6861708_cefzx/%E4%BB%93%E6%9C%A8%E9%BA%BB%E8%A1%A3%20-%20Summer%20Time%20Gone.mp3");

        	    }
        	    case 5:
        	    {
        	       StopAudioStreamForPlayer(playerid);
        	       PlayAudioStreamForPlayer(playerid, "http://www.gnrworld.com/bootlegs/audio/1988/July29/Paradise%20City.mp3");

        	    }
        	    case 6:
        	    {
        	       StopAudioStreamForPlayer(playerid);
        	       PlayAudioStreamForPlayer(playerid, "http://data2004.5sing.com/m/bz/2006/01/21/220616-20060121171806.mp3");
                return 1;
			    }

   	            case 7:
        	    {
        	       StopAudioStreamForPlayer(playerid);
        	       PlayAudioStreamForPlayer(playerid, "http://www.marineparade.net/mppodcast/EvilNine_March2010Mix.mp3");

        	    }
        	    case 8:
        	    {

        	       ShowPlayerDialog(playerid,1789,DIALOG_STYLE_INPUT,"[请输入歌曲URL]","要播放你喜欢的歌曲，请输入歌曲的URL[最好MP3格式的]","完成","取消");

        	    }
   	            case 9:
        	    {
        	       StopAudioStreamForPlayer(playerid);

        	    }
}
}
}
//return 1;
}

if(dialogid==1789)
{
if(response)
{
SendClientMessage(playerid,COLOR_BLUE, "[Check Points]Test");
new url;
inputtext[url];
StopAudioStreamForPlayer(playerid);
PlayAudioStreamForPlayer(playerid,inputtext[url]);
}
}
 if(dialogid == PMusicDialogid)
    {
        if(response)
        {
        	if(listitem == 0)
         	{
          		SendClientMessage(playerid,COLOR_WHITE,"你停止了播放!");
            	StopAudioStreamForPlayer(playerid);
            }else if(listitem  == MAX_MUSIC_LIST+1)
            {
            	MusicPage[playerid]++;
             	SendClientMessage(playerid,COLOR_WHITE,"下一页!");
              	ShowPlayerDialog(playerid,PMusicDialogid,DIALOG_STYLE_LIST,"{EEEE88}音乐列表:",DrawMusicList(MusicPage[playerid]),"播放","关闭列表");
			}else if(listitem  == MAX_MUSIC_LIST+2)
   			{
      			if(MusicPage[playerid] > 1)
         		{
          			MusicPage[playerid]--;
            		SendClientMessage(playerid,COLOR_WHITE,"上一页!");
					ShowPlayerDialog(playerid,PMusicDialogid,DIALOG_STYLE_LIST,"{EEEE88}音乐列表:",DrawMusicList(MusicPage[playerid]),"播放","关闭列表");
				}else
				{
    				SendClientMessage(playerid,COLOR_WHITE,"到头了,不能再上了!");
   					ShowPlayerDialog(playerid,PMusicDialogid,DIALOG_STYLE_LIST,"{EEEE88}音乐列表:",DrawMusicList(MusicPage[playerid]),"播放","关闭列表");
				}
			}else
			{
   				ShowListMusic(playerid,listitem,MusicPage[playerid]);
   				ShowPlayerDialog(playerid,PMusicDialogid,DIALOG_STYLE_LIST,"{EEEE88}音乐列表:",DrawMusicList(MusicPage[playerid]),"播放","关闭列表");
			}
        }
        else
        {
            MusicPage[playerid] = 1;
        	SendClientMessage(playerid,COLOR_WHITE,"你关闭了播放列表!");
        }
    }

    if(dialogid == AddMusicDialogid)
    {
        if(response)
        {
            if(!strlen(inputtext))
            {
                ShowPlayerDialog(playerid, AddMusicDialogid,DIALOG_STYLE_INPUT, "添加音乐","音乐名称不能为空!\n请在下方输入你要添加的音乐名称\n (如:甩葱歌)","下一步","取消");
            }else if(strlen(inputtext) > 20 || strlen(inputtext) < 6)
		    {
		        ShowPlayerDialog(playerid, AddMusicDialogid,DIALOG_STYLE_INPUT, "添加音乐","音乐名称过长或过短!\n请在下方输入你要添加的音乐名称\n (如:甩葱歌)","下一步","取消");
		    }else
		    {
                format(MusicName[playerid],sizeof(MusicName),"%s",inputtext);
                ShowPlayerDialog(playerid, AddMusicUrlDialogid,DIALOG_STYLE_INPUT, "添加音乐","请在下方输入你要添加的音乐链接地址\n (如 http://xxxx.com/music.mp3)","完成","取消");
		    }
        }
        else
        {
        	SendClientMessage(playerid,COLOR_WHITE,"你取消了添加音乐!");
        }
    }

    if(dialogid == AddMusicUrlDialogid)
    {
        if(response)
        {
            if(!strlen(inputtext))
            {
                ShowPlayerDialog(playerid, AddMusicUrlDialogid,DIALOG_STYLE_INPUT, "添加音乐","音乐链接地址不能为空!\n请在下方输入你要添加的音乐链接地址\n (如 http://xxxx.com/music.mp3)","完成","取消");
            }else if(strlen(inputtext) > 300 || strlen(inputtext) < 6)
		    {
		        ShowPlayerDialog(playerid, AddMusicUrlDialogid,DIALOG_STYLE_INPUT, "添加音乐","音乐链接地址过长或过短!\n请在下方输入你要添加的音乐链接地址\n (如 http://xxxx.com/music.mp3)","完成","取消");
		    }else
		    {
                new string[128];
                WriteMusic(MusicName[playerid],inputtext);
                format(string,sizeof(string),"加入歌曲:%s\t播放地址:%s",MusicName[playerid],inputtext);
               	SendClientMessage(playerid,COLOR_WHITE,string);
		    }
        }
        else
        {
        	SendClientMessage(playerid,COLOR_WHITE,"你取消了添加音乐!");
        }
        return 1;
    }



return 0;
}
//**********************
//MP3播放模块          *
//**********************
DrawMusicList(Page)//绘制播放列表
{
    new MusicListHead = MAX_MUSIC_LIST*(Page-1);
    if(Page >= 0) MusicListHead++;
    new tmp[512];//表格要大
    new string[256];
    strcat(tmp, "{85EE55}[停止播放]\n");
    for(new i = 0;i < MAX_MUSIC_LIST;i++)
    {
    	format(string,sizeof(string),"%d music",MusicListHead+i);
		string = dini_Get(MusicFile,string);
	    if(!strlen(string))
	    {
     		strcat(tmp, "{FFFFFF}\t<空>\n");
	    }else
	    {
        	format(string,sizeof(string),"{FFFFFF}%d\t{55EE55}%s\n",MusicListHead+i,string);
        	strcat(tmp, string);
		}
    }
    strcat(tmp, "\t\t\t{A5EE55}下一页\n");
    strcat(tmp, "\t\t\t{A5EE55}上一页\n");
    return tmp;
}
//寻址播放音乐
ShowListMusic(playerid,listitem,Page)
{
    new TotalMusic = MAX_MUSIC_LIST*(Page-1)+listitem;
    new string[128];
    new temp[256];
    format(string,sizeof(string),"%d music",TotalMusic);
	temp = dini_Get(MusicFile,string);
	if(!strlen(temp)) return 0;//读取不到音乐时
    format(string,sizeof(string),"你正在播放歌曲:%s",temp);
    SendClientMessage(playerid,COLOR_WHITE,string);
	format(string,sizeof(string),"%d url",TotalMusic);
 	temp = dini_Get(MusicFile,string);
	PlayAudioStreamForPlayer(playerid,temp);
    format(string,sizeof(string),"歌曲[URL]:%s",temp);
    SendClientMessage(playerid,COLOR_WHITE,string);
	return 1;
}
//歌曲插入文件储存
WriteMusic(music[],url[])
{
    if(!strlen(music) || !strlen(url)) return 0;
    new TotalMusic;
    new string[128];
	dini_Create(MusicFile);
 	TotalMusic = dini_Int(MusicFile,"[TotalMusic]");
    if(!TotalMusic) dini_IntSet(MusicFile,"[TotalMusic]",0);
    TotalMusic++;
    format(string,sizeof(string),"%d music",TotalMusic);
    dini_Set(MusicFile,string,music);
	format(string,sizeof(string),"%d url",TotalMusic);
    dini_Set(MusicFile,string,url);
    dini_IntSet(MusicFile,"[TotalMusic]",TotalMusic);
	return 1;
}


//End




//Pickup
/*public OnPlayerPickUpPickup(playerid, pickupid)
    {
if(pickupid == help)
	{
     ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "帮助中心", "1.我的信息\n2.规则\n3.车辆\n4.武器\n5.玩家\n6.环境\n7.娱乐\n8.防捣乱帮助\n9.收藏本服\n10.关于","选择", "退出" );
	 return 1;
    }
return 1;
}*/
///vn刷车自定义函数








//室内空间自定义的函数
stock SetPlayerPosEx(playerid, Float:X, Float:Y, Float:Z, interior, location[])
{
    new string[128];
	SetPlayerPos(playerid, X, Y, Z);
	SetPlayerInterior(playerid,interior);
	SetPlayerVirtualWorld(playerid, 0);
	format(string, 128, "You've teleported to  %s . [X: %0.2f | Y: %0.2f | Z: %0.2f | Interior: %d]. Use /saveex to save your position.", location, X, Y, Z, interior);
	SendClientMessage(playerid, COLOUR_DEBUG, string);
	return 1;
}
stock SaveLocation(playerid, comment[])
{
	new File:gFile, Float:Pos[4], string[256];
	switch(IsPlayerInAnyVehicle(playerid))
	{
		case 0:
		{
			GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);SetPlayerPosEx
			GetPlayerFacingAngle(playerid, Pos[3]);
			SendClientMessage(playerid, COLOUR_DEBUG, "-> OnFoot position saved");
		}
		case 1:
		{
			GetVehiclePos(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2]);
			GetVehicleZAngle(GetPlayerVehicleID(playerid), Pos[3]);
			SendClientMessage(playerid, COLOUR_DEBUG, "-> Vehicle position saved");
		}
	}
	if(!fexist("savedpositions.txt"))
	{
		gFile = fopen("savedpositions.txt", io_write);
		fclose(gFile);
	}
	gFile = fopen("savedpositions.txt", io_append);
	format(string, 256, "SetPlayerPos(playerid, %0.4f, %0.4f, %0.4f); // %s [Angle: %0.4f | Int: %d | VW: %d]\r\n", Pos[0], Pos[1], Pos[2], Pos[3], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), comment);
	fwrite(gFile, string);
	fclose(gFile);


//w2n



//Myinfo

