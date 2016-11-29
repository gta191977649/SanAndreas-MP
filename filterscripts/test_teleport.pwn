// Teleport menu by CaptainJohn
 
#include <a_samp>
 
// Defines
#define FILTERSCRIPT
#define DIALOGID 3300
#define MAX 13 // Change this to the max players in your server.cfg
 
// Sniper Death Match
new Info[255];
new Float:RandomSpawn[][6] =
{
  // Positions, (X, Y, Z and Facing Angle)
    {-973.6733,1061.2589,1345.6721,85.6553},
    {-1027.8649,1081.1333,1343.2194,282.9058},
    {-1025.7057,1082.3707,1343.3472,67.0405},
    {-1039.5646,1085.4370,1343.3317,154.3409},
    {-1062.0338,1070.1962,1343.4124,121.8743},
    {-1069.0345,1092.3414,1343.1663,116.1298}
};
 
// BikeRace/CarRace
new iSpawnedCar[MAX]=-1;
 
// Skydive
new OnSkyDiving[MAX];
 
public OnPlayerCommandText(playerid, cmdtext[])
{
                if (strcmp("/Teleport", cmdtext, true, 10) == 0)
                {
                        ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Teleport Categories", "Los Santos\nSan Fierro\nLas Venturas\nOther", "Select", "Cancel");
                        return 1;
                }
                return 1;
        }
 
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
        if(dialogid == DIALOGID) // Teleport Dialog
        {
                if(response)
                {
                        if(listitem == 0) // Los Santos
                        {
                                ShowPlayerDialog(playerid, DIALOGID+1, DIALOG_STYLE_LIST, "Los Santos", "Los Santos Airport \nSanta Marina \nGrove Street \nCity Hall \nPolice Station \nBank \nOcean Docks \nCrazybob's House \nJefferson Motel \nAbove Los Santos \nBack", "Select", "Cancel");
                        }
                        if(listitem == 1) // San Fierro
                        {
                                ShowPlayerDialog(playerid, DIALOGID+2, DIALOG_STYLE_LIST, "San Fierro", "San Fierro Airport \nCity Hall \nBank \nOcean Flats \nMissionary Hill \nJizzys Pleasure Dome \nPolice Station  \nBack", "Select", "Cancel");
                        }
                        if(listitem == 2) // Las Venturas
                        {
                                ShowPlayerDialog(playerid, DIALOGID+3, DIALOG_STYLE_LIST, "Las Venturas", "Las Venturas Airport \nArea69 \nCity Hall \nPolice Station \nCaligulas Casino \nStarfish Casino \nBank \nPrickle Pine \nBandit Stadium \nLast Dime Motel \nAbove Las Venturas \nBack", "Select", "Cancel");
                        }
                        if(listitem == 3) // Other
                        {
                                ShowPlayerDialog(playerid, DIALOGID+4, DIALOG_STYLE_LIST, "Other", "Verdant Meadows \nBayside \nPalominmo Creek \nMontgomery \nBlueberry \nDrylake \nSniper Death Match \nBike Race \nCar Race \nMount Chilliad Cabin \nTop of Mount Chilliad \nMount Chilliad \nBack", "Select", "Cancel");
                        }
                }
                return 1;
        }
 
        if(dialogid == DIALOGID+1) // Los Santos
        {
                if(response)
                {
                        if(listitem == 0) // Airport
                        {
                        SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 1934.8811,-2305.5283,13.5469);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Los Santos Airport.");
                        }
                        if(listitem == 1) //Santa Marina
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 433.1179,-1796.5649,5.5469);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Santa Marina Beach.");
                        }
                        if(listitem == 2) // Grove Street
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 2499.8733,-1667.6309,13.3512);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Grove Street.");
                        }
                        if(listitem == 3) // City Hall
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 1461.0043,-1019.4626,24.6975);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Los Santos City Hall.");
                        }
                        if(listitem == 4) // Police Station
                        {
                                SetPlayerPos(playerid, 1544.8700,-1675.8081,13.5593);
                                SetPlayerFacingAngle(playerid, 90);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Los Santos Police Department.");
                        }
                        if(listitem == 5) // Bank
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 595.1895,-1243.1205,18.0844);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Los Santos Bank.");
                        }
                        if(listitem == 6) // Ocean Docks
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 2791.1782,-2534.6309,13.6303);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Ocean Docks.");
                        }
                        if(listitem == 7) // Crazybob's House
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 1255.2925,-778.2413,92.0302);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Crazybob's House.");
                        }
                        if(listitem == 8) // Jefferson Motel
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 2229.0200,-1159.8000,25.7981);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Jefferson Motel.");
                        }
                        if(listitem == 9) // Above Los Santos
                        {
                                SetPlayerPos(playerid, 1744.1571,-1426.3916,1513.2897);
                                SetPlayerFacingAngle(playerid, 0);
 
                                GivePlayerWeapon(playerid, 46, 1);
                                SendClientMessage(playerid, 0x00FFFFAA, "You got a parachute.");
                                OnSkyDiving[playerid]=1;
                        }
                        if(listitem == 10) // Back
                        {
                ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Teleport Categories", "Los Santos\nSan Fierro\nLas Venturas\nOther", "Select", "Cancel");
                        }
                }
                return 1;
        }
 
        if(dialogid == DIALOGID+2) // San Fierro
        {
                if(response)
                {
                        if(listitem == 0) // Airport
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, -1315.9419,-223.8595,14.1484);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to San Fierro Airport.");
                        }
                        if(listitem == 1) // City Hall
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, -2672.6116,1268.4943,55.9456);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to San Fierro City Hall.");
                        }
                        if(listitem == 2) // Bank
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, -2050.6089,459.3649,35.1719);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to San Fierro Bank.");
                        }
                        if(listitem == 3) // Ocen Flats
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, -2670.1101,-4.9832,6.1328);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Ocean Flats.");
                        }
                        if(listitem == 4) // Missionary Hill
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, -2515.6768,-611.6651,132.5625);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Missionary Hill.");
                        }
                        if(listitem == 5) // Jizzy's Pleasure Dome
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, -2621.0244,1403.7534,7.0938);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Jizzy's Pleasure Dome.");
                        }
                        if(listitem == 6) // Police Station
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, -1608.1376,718.9722,12.4356);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to San Fierro Police Station.");
                        }
                        if(listitem == 7) // Back
                        {
                ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Teleport Categories", "Los Santos\nSan Fierro\nLas Venturas\nOther", "Select", "Cancel");
                        }
                }
                return 1;
        }
 
        if(dialogid == DIALOGID+3) // Las Venturas
        {
                if(response)
                {
                        if(listitem == 0) // Airport
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 1487.9703,1736.9537,10.8125);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Las Venturas Airport.");
                        }
                        if(listitem == 1) // Area69
                        {
                                SetPlayerPos(playerid, 129.3000, 1920.3000, 20.0);
                        GameTextForPlayer(playerid,"~W~Welcome to ~G~Area 69~W~!",1000,0);
                        SetPlayerInterior(playerid,0);
                        }
                        if(listitem == 2) // City Hall
                        {
                                SetPlayerPos(playerid, 2421.7185,1121.9866,10.8125);
                        SetPlayerFacingAngle(playerid, 90);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Las Venturas City Hall.");
                        }
                        if(listitem == 3) // Police Station
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 2287.2561,2426.2576,10.8203);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Las Venturas Police Station.");
                        }
                        if(listitem == 4) // Caligulas Casino
                        {
                                SetPlayerPos(playerid, 2187.8350,1678.5358,11.1094);
                        SetPlayerFacingAngle(playerid, 90);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Caligulas Casino.");
                        }
                        if(listitem == 5) // Starfish Casino
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 2227.3596,1894.3228,10.6719);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Starfish Casino.");
                        }
                        if(listitem == 6) // Bank
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 2463.6680,2240.7524,10.8203);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Las Venturas Bank.");
                        }
                        if(listitem == 7) // Prickle Pine
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 1434.6989,2654.4026,11.3926);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Prickle Pine.");
                        }
                        if(listitem == 8) // Bandit Stadium
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 1493.2443,2238.1526,11.0291);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Bandit Stadium.");
                        }
                        if(listitem == 9) // Last Dime Motel
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 1929.0522,707.8507,10.8203);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Last Dime Motel.");
                        }
                        if(listitem == 10) // Above Las Venturas
                        {
                                SetPlayerPos(playerid, 2201.6697,1997.7933,1500.1992);
                                SetPlayerFacingAngle(playerid, 0);
 
                                GivePlayerWeapon(playerid, 46, 1);
                                SendClientMessage(playerid, 0x00FFFFAA, "You got a parachute.");
                                OnSkyDiving[playerid]=1;
                        }
                        if(listitem == 11) // Back
                        {
                ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Teleport Categories", "Los Santos\nSan Fierro\nLas Venturas\nOther", "Select", "Cancel");
                        }
                }
                return 1;
        }
       
        if(dialogid == DIALOGID+4) // Other
        {
                if(response)
                {
                        if(listitem == 0) // Verdant Meadows
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 414.9159,2532.9700,19.1484);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Verdant Meadows.");
                        }
                        if(listitem == 1) // Bayside
                        {
                                SetPlayerPos(playerid, -2271.0764, 2317.8457, 4.8202);
                        SetPlayerFacingAngle(playerid, 180);
                                SendClientMessage(playerid, 0x00FFFFAA, "Aye there fisherman, your at Bayside.");
                        }
                        if(listitem == 2) // Palomino Creek
                        {
                                SetPlayerPos(playerid, 2259.5532, -85.0334, 26.5107);
                        SetPlayerFacingAngle(playerid, 180);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Palomino Creek.");
                        }
                        if(listitem == 3) // Montgomery
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 1377.4314,271.4077,19.5669);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Montgomery.");
                        }
                        if(listitem == 4) // Blueberry
                        {
                                SetPlayerInterior(playerid, 0);
                                SetPlayerPos(playerid, 183.9907,-108.5440,2.0234);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Blueberry.");
                        }
                        if(listitem == 5) // Drylake
                        {
                                SetPlayerPos(playerid, -12.7000, 1481.7000, 14.00);
                        GameTextForPlayer(playerid,"~W~Welcome to ~B~Dry lake~W~!", 1000, 0);
                        SetPlayerInterior(playerid,0);
                        }
                        if(listitem == 6) // Sniper Death Match
                        {
                                new PlayerName[MAX_PLAYER_NAME];
                                new iRandom=random(sizeof(RandomSpawn));
 
                                GetPlayerName(playerid, PlayerName ,sizeof(PlayerName));
                                // SetPlayerPos to the random spawn information
                        SetPlayerPos(playerid, RandomSpawn[iRandom][0], RandomSpawn[iRandom][1],RandomSpawn[iRandom][2]);
                                // SetPlayerFacingAngle to the random facing angle information
                        SetPlayerFacingAngle(playerid, RandomSpawn[iRandom][3]);
                        SetPlayerInterior(playerid, 10);
                        format(Info, sizeof(Info), "%s (%i) has joined the Sniper Stadium. Join it too with /sniper!", PlayerName, playerid);
                        SendClientMessageToAll(0x00FFFFFF, Info);
                        ResetPlayerWeapons(playerid);
                        GivePlayerWeapon(playerid, 34, 5000);
                        GivePlayerWeapon(playerid, 24, 5000);
                        }
                        if(listitem == 7) // Bike Race
                        {
                                if(iSpawnedCar[playerid] != -1) DestroyVehicle(iSpawnedCar[playerid]);
                                SetPlayerInterior(playerid,4);
                        SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Bike Race. Use /exit to exit.");
                                iSpawnedCar[playerid] = CreateVehicle(468,-1424.93,-664.58,1059.85, 180.0, -1, -1, -1);
                        LinkVehicleToInterior(iSpawnedCar[playerid], 4);
                        PutPlayerInVehicle(playerid,iSpawnedCar[playerid], 0);
                        }
                        if(listitem == 8) // Car Race
                        {
                                if(iSpawnedCar[playerid] != -1) DestroyVehicle(iSpawnedCar[playerid]);
                        SetPlayerInterior(playerid,7);
                        SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Car Race. Use /exit to exit.");
                        iSpawnedCar[playerid] = CreateVehicle(415,-1394.54,-243.56,1043.20, 180.0, -1, -1, -1);
                        LinkVehicleToInterior(iSpawnedCar[playerid],7);
                        PutPlayerInVehicle(playerid,iSpawnedCar[playerid], 0);
                        }
                        if(listitem == 9) // Mount Chilliad Cabin
                        {
                            SetPlayerPos(playerid, -2809.0000, -1516.5000, 142.0000);
                            SetPlayerFacingAngle(playerid, 270);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to the cabin at Mount Chilliad.");
                                GameTextForPlayer(playerid,"~W~Welcome to~N~~R~~H~Mount Chilliad Cabin~W~!",1000,0);
                        }
                        if(listitem == 10) // Top of Mount Chilliad
                        {
                            SetPlayerPos(playerid, -2238.0000, -1712.2700, 482.0000);
                            SetPlayerFacingAngle(playerid, 90);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported on top of Mount Chilliad.");
                                GameTextForPlayer(playerid,"~W~Welcome to~N~~R~~H~Top of Mount Chilliad~W~!",1000,0);
                        }
                        if(listitem == 11) // Mount Chilliad
                        {
                            SetPlayerPos(playerid, -2409.5000, -2190.0000, 35.0000);
                            SetPlayerFacingAngle(playerid, 270);
                                SendClientMessage(playerid, 0x00FFFFAA, "You've been teleported to Mount Chilliad. Type /mccabin or /mctop for more places.");
                                GameTextForPlayer(playerid,"~W~Welcome to~N~~R~Mount Chilliad~W~!",1000,0);
                        }
                        if(listitem == 12) // Back
                        {
                ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Teleport Categories", "Los Santos\nSan Fierro\nLas Venturas\nOther", "Select", "Cancel");
                        }
                }
                return 1;
        }
        return 0;
 }