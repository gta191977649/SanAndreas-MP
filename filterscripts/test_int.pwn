/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*\
||                                                                                            ||
||						Created 3th December 2009 By Garsino.                                 ||
||	               	   Last Edited: 07/02/10 by Oggle McFoggle
||                                                                                            ||
\*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/

#include <a_samp>
#define FILTERSCRIPT
#define RED 0xF60000AA
#define INTERIORMENU 1500
public OnFilterScriptInit()
{
	print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
	print("											  ");
	print("=> Interior Menu by Garsino | Edited by Oggle <=");
	print("==============汉化:[Fly_O_o]CHY=================");
	print("											  ");
	print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");

	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}


public OnPlayerConnect(playerid)
{
	return 1;
}


public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext,"/i",true) || !strcmp(cmdtext,"/interiors",true))
	{
/* if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, RED, "Only Admins Can Use This Command!");
	else */ // Uncomment for RCON admins to use only ...
	ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "[室内空间]By:Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category（未分类）\nBurglary(入室盗窃）\nBurglary(入室盗窃2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
    return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == INTERIORMENU)
	{
		if(response)
		{
   			if(listitem == 0) // 24/7
   			{
			ShowPlayerDialog(playerid, INTERIORMENU+1, DIALOG_STYLE_LIST, "24/7's", "24/7总店\n24/7二号连锁店\n24/7三号连锁店\n24/7四号连锁店\n24/7五号连锁店\n24/7六号连锁店\nBack(返回)", "选择", "取消");
			}
			if(listitem == 1) // Airports
			{
			ShowPlayerDialog(playerid, INTERIORMENU+2, DIALOG_STYLE_LIST, "Airport Interiors", "游戏开头动画机场\n游戏开头动画机场旁边...\n可以跳伞的运输机\n飞机客舱\n游戏开头动画机场下面的机场...虚空的.\n还是开头动画的机场..\n沙漠机场的房子\nBack(返回)", "选择", "取消");
			}
			if(listitem == 2) // Ammunations
			{
			ShowPlayerDialog(playerid, INTERIORMENU+3, DIALOG_STYLE_LIST, "Ammunation Interiors", "FLY暴力军火商店1\nFLY暴力军火商店2\nFLY暴力军火商店3\nFLY暴力军火商店4\nFLY暴力军火商店5\n武器店射击位置\n武器店靶子位置..暴力.\nBack(返回)", "选择", "取消");
   			}
			if(listitem == 3) // Houses
			{
			ShowPlayerDialog(playerid, INTERIORMENU+4, DIALOG_STYLE_LIST, "Houses", "B Dup的卧室\nB Dup的娱乐室\nOG Loc的家\nRyder的家\nSweet的家\n疯狗的别墅\nBig Smoke的工厂\nBack(返回)", "选择", "取消");
   			}
			if(listitem == 4) // Houses 2
			{
			ShowPlayerDialog(playerid, INTERIORMENU+5, DIALOG_STYLE_LIST, "Houses 2", "Johnson家族的家（CJ家）\nAngel Pine Trailer这是哪..\n民房\n民房2\n小号别墅\nS很多高跟鞋的房子.\nLV郊区的房子\n精致的小房子\n很像宾馆的房子\nBack(返回)", "选择", "取消");
   			}
			if(listitem == 5) // Missions
			{
			ShowPlayerDialog(playerid, INTERIORMENU+6, DIALOG_STYLE_LIST, "Missions", "雕塑大厅\n火中救女孩的房子\n军事爱好者的房子\nC帅酒吧~（音乐不错哦~~~）\n老吴的赛马场\nJizzy酒吧\n乡下的加油站商店\nJefferson旅馆\n自由城（挺冷的..）\n水坝发电机\nBack(返回)", "选择", "取消");
   			}
			if(listitem == 6) // Missions 2
			{
			ShowPlayerDialog(playerid, INTERIORMENU+7, DIALOG_STYLE_LIST, "Stadiums", "玩具大战\n赛车场1\n赛车场2\n暴力血腥竞技场\n摩托特技场地\nBack(返回)", "选择", "取消");
   			}
			if(listitem == 7) // Casino Interiors
			{
			ShowPlayerDialog(playerid, INTERIORMENU+8, DIALOG_STYLE_LIST, "Casino Interiors", "Caligulas赌场\n四龙赌场\n小型赌场\n可以进四龙赌场的虚空环境\n赌马场\nCaligulas内部\nRosenberg's Caligulas办公室（虚空~要摔死）\n四龙赌场的杂物存放点\nBack(返回)", "选择", "取消");
			}
			if(listitem == 8) // Shops
			{
			ShowPlayerDialog(playerid, INTERIORMENU+9, DIALOG_STYLE_LIST, "Shop Interiors", "纹身店\n汉堡店\n好味道披萨店\n肯德基\n小吃店\n模型玩具店\nX用品店（不好不好..）\nBack(返回)", "选择", "取消");
			}
			if(listitem == 9) // Garages
			{
			ShowPlayerDialog(playerid, INTERIORMENU+10, DIALOG_STYLE_LIST, "Mod Shops/Garages","改车行1\n改车行2\n改车行3\n改车行4\nBack(返回)", "选择", "取消");
   			}
			if(listitem == 10) // Girl Friends
			{
			ShowPlayerDialog(playerid, INTERIORMENU+11, DIALOG_STYLE_LIST, "CJ's Girlfriends Interiors","Denises家\nHelena家\nBarbara家\nKatie家\nMichelle家\nMillie卧室\nBack(返回)", "选择", "取消");
   			}
			if(listitem == 11) // Clothing & Barber Store
			{
			ShowPlayerDialog(playerid, INTERIORMENU+12, DIALOG_STYLE_LIST, "Clothing & Barber Store","理发店 \nPro-Laps服装店\nVictim服装店\nSubUrban服装店\nReece的理发店\nZip服装店\nDidier Sachs服装店\nBinco服装店\nBarber理发店\n换衣服的地方\nBack(返回)", "选择", "取消");
   			}
   			if(listitem == 12) // Resturants & Clubs
			{
			ShowPlayerDialog(playerid, INTERIORMENU+13, DIALOG_STYLE_LIST, "Resturants & Clubs","娱乐场所\n娱乐场所2\nBig Spread娱乐会所\n酒吧（虚空的..）\n世界茶坊..\n艳舞厅（很邪恶..）\n喝酒跳舞俱乐部\nJay的快餐店\nSecret Valley快餐店（虚空的..）\nFanny Batter的淫荡房子（有裸照和大镜子）\nBack(返回)", "选择", "取消");
   			}
   			if(listitem == 13) // No Specific Group
			{
			ShowPlayerDialog(playerid, INTERIORMENU+14, DIALOG_STYLE_LIST, "No Specific Category","虚空的走廊\n战争房子\n战争房子2\n有大镜子的卧室\nUFO酒吧\n吸毒者之家\n肉加工厂\n摩托驾校\n汽车驾校\nBack(返回)", "选择", "取消");
   			}
   			if(listitem == 14) // Burglary Houses
			{
			ShowPlayerDialog(playerid, INTERIORMENU+15, DIALOG_STYLE_LIST, "Burglary Houses","民居1\n民居2 \n民居3\n民居4\n民居5\n民居6\n民居7\n民居8\n民居9\n民居10\nBack(返回)", "选择", "取消");
   			}
			if(listitem == 15) // Burglary Houses 2
			{
			ShowPlayerDialog(playerid, INTERIORMENU+16, DIALOG_STYLE_LIST, "Burglary Houses 2","民居11\n民居12\n民居13\n民居14\n民居15\n民居16\nBack(返回)", "选择", "取消");
   			}
   			if(listitem == 16) // Gyms
			{
			ShowPlayerDialog(playerid, INTERIORMENU+17, DIALOG_STYLE_LIST, "Gyms","小别墅（放错位置了吧..）\nSF锻炼房\nLV锻炼房\nBack(返回)", "选择", "取消");
   			}
   			if(listitem == 17) // Departements
			{
			ShowPlayerDialog(playerid, INTERIORMENU+18, DIALOG_STYLE_LIST, "Departments","SF警察局\nLS警察局\nLV警察局\n政府大厅\nBack(返回)", "选择", "取消");
   			}
   			if(listitem == 18) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
   			}
		}
		return 1;
	}
//===================================24/7's===================================//
	if(dialogid == INTERIORMENU+1) // 24/7's
	{
		if(response)
		{
			if(listitem == 0) // 24/7 1
			{
		    SetPlayerPosEx(playerid, -25.884499,-185.868988,1003.549988, 17, 0);
			}
			if(listitem == 1) // 24/7 2
			{
		    SetPlayerPosEx(playerid, -6.091180,-29.271898,1003.549988, 10, 0);
			}
			if(listitem == 2) //  24/7 3
			{
			SetPlayerPosEx(playerid, -30.946699,-89.609596,1003.549988, 18, 0);
			}
			if(listitem == 3) //  24/7 4
			{
		    SetPlayerPosEx(playerid, -25.132599,-139.066986,1003.549988, 16, 0);
			}
			if(listitem == 4) //  24/7 5
			{
		    SetPlayerPosEx(playerid, -27.312300,-29.277599,1003.549988, 4, 0);
			}
			if(listitem == 5) // 24/7 6
			{
		    SetPlayerPosEx(playerid, -26.691599,-55.714897,1003.549988, 6, 0);
			}
			if(listitem == 6) // Back(返回)
  			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//==================================Airports==================================//
	if(dialogid == INTERIORMENU+2) // Airport Interiors
	{
		if(response)
		{
			if(listitem == 0) // Francis Ticket Sales Airport
			{
		    SetPlayerPosEx(playerid, -1827.147338,7.207418,1061.143554, 14, 0);
			}
			if(listitem == 1) // Francis Baggage Claim Airport
			{
		    SetPlayerPosEx(playerid, -1855.568725,41.263156,1061.143554, 14, 0);
			}
			if(listitem == 2) // Andromada Cargo Hold
			{
			SetPlayerPosEx(playerid, 315.856170,1024.496459,1949.797363, 9, 0);
			}
			if(listitem == 3) // Shamal Cabin
			{
		    SetPlayerPosEx(playerid, 2.384830,33.103397,1199.849976, 1, 0);
			}
			if(listitem == 4) // LS Airport Baggage Claim
			{
		    SetPlayerPosEx(playerid, -1870.80,59.81,1056.25, 14, 0);
			}
			if(listitem == 5) // Interernational Airport
			{
		    SetPlayerPosEx(playerid, -1830.81,16.83,1061.14, 14, 0);
			}
			if(listitem == 6) // Abounded AC Tower
			{
		    SetPlayerPosEx(playerid, 419.8936, 2537.1155, 10, 10, 0);
			}
			if(listitem == 7) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//=================================Ammunation=================================//
	if(dialogid == INTERIORMENU+3) // Ammunations
	{
		if(response)
		{
			if(listitem == 0) // Ammunation 1
			{
		    SetPlayerPosEx(playerid, 286.148987,-40.644398,1001.569946, 1, 0);
			}
			if(listitem == 1) // Ammunation 2
			{
		    SetPlayerPosEx(playerid, 286.800995,-82.547600,1001.539978, 4, 0);
			}
			if(listitem == 2) // Ammunation 3
			{
		    SetPlayerPosEx(playerid, 296.919983,-108.071999,1001.569946, 6, 0);
			}
			if(listitem == 3) // Ammunation 4
			{
		    SetPlayerPosEx(playerid, 314.820984,-141.431992,999.661987, 7, 0);
			}
			if(listitem == 4) // Ammunation 5
			{
		    SetPlayerPosEx(playerid, 316.524994,-167.706985,999.661987, 6, 0);
			}
			if(listitem == 5) // Booth Ammunation
			{
		    SetPlayerPosEx(playerid, 302.292877,-143.139099,1004.062500, 7, 0);
			}
			if(listitem == 6) // Range Ammunation
			{
		    SetPlayerPosEx(playerid, 280.795104,-135.203353,1004.062500, 7, 0);
			}
			if(listitem == 7) // Back
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//===================================Houses===================================//
	if(dialogid == INTERIORMENU+4) // Houses
	{
		if(response)
		{
			if(listitem == 0) // B Dup's Apartment
			{
		    SetPlayerPosEx(playerid, 1527.0468, -12.0236, 1002.0971, 3, 0);
			}
			if(listitem == 1) // B Dup's Crack Palace
			{
		    SetPlayerPosEx(playerid, 1523.5098, -47.8211, 1002.2699, 2, 0);
			}
			if(listitem == 2) // OG Loc's House
			{
		    SetPlayerPosEx(playerid, 512.9291, -11.6929, 1001.565, 3, 0);
			}
			if(listitem == 3) // Ryder's
			{
		    SetPlayerPosEx(playerid, 2447.8704, -1704.4509, 1013.5078, 2, 0);
			}
			if(listitem == 4) // Sweet's
			{
		    SetPlayerPosEx(playerid, 2527.0176, -1679.2076, 1015.4986, 1, 0);
			}
			if(listitem == 5) // Madd Dogg's Mansion
			{
		    SetPlayerPosEx(playerid, 1267.8407, -776.9587, 1091.9063, 5, 0);
			}
			if(listitem == 6) // Big Smoke's Crack Palace
			{
		    SetPlayerPosEx(playerid, 2536.5322, -1294.8425, 1044.125, 2, 0);
			}
			if(listitem == 7) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//===================================Safe Houses===================================//
	if(dialogid == INTERIORMENU+5) // Houses
	{
		if(response)
		{
			if(listitem == 0) // CJ's House
			{
		    SetPlayerPosEx(playerid, 2496.0549, -1695.1749, 1014.7422, 3, 0);
			}
			if(listitem == 1) // Angel Pine trailer
			{
		    SetPlayerPosEx(playerid, 1.1853, -3.2387, 999.4284, 2, 0);
			}
			if(listitem == 2) // Safe House
			{
		    SetPlayerPosEx(playerid, 2233.6919, -1112.8107, 1050.8828, 5, 0);
			}
			if(listitem == 3) // Safe House 2
			{
		    SetPlayerPosEx(playerid, 2194.7900, -1204.3500, 1049.0234, 6, 0);
			}
			if(listitem == 4) // Safe House 3
			{
		    SetPlayerPosEx(playerid, 2319.1272, -1023.9562, 1050.2109, 9, 0);
			}
			if(listitem == 5) // Safe House 4
			{
		    SetPlayerPosEx(playerid, 2262.4797,-1138.5591,1050.63285, 10, 0);
			}
			if(listitem == 6) // Verdant Bluff safehouse
			{
		    SetPlayerPosEx(playerid, 2365.1089, -1133.0795, 1050.875, 8, 0);
			}
			if(listitem == 7) // Willowfield Safehouse
			{
		    SetPlayerPosEx(playerid, 2282.9099, -1138.2900, 1050.8984, 11, 0);
			}
			if(listitem == 8) // The Camel's Toe Safehouse
			{
		    SetPlayerPosEx(playerid, 2216.1282, -1076.3052, 1050.4844, 1, 0);
			}
			if(listitem == 9) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//==================================Missions==================================//
	if(dialogid == INTERIORMENU+6) // Missions
	{
		if(response)
		{
			if(listitem == 0) // Atrium
			{
		    SetPlayerPosEx(playerid, 1726.18,-1641.00,20.23, 18, 0);
			}
			if(listitem == 1) // Burning Desire
			{
		    SetPlayerPosEx(playerid, 2338.32,-1180.61,1027.98, 5, 0);
			}
			if(listitem == 2) // Colonel Furhberger
			{
		    SetPlayerPosEx(playerid, 2807.63,-1170.15,1025.57, 8, 0);
			}
			if(listitem == 3) // Welcome Pump(Dillimore)
			{
		    SetPlayerPosEx(playerid, 681.66,-453.32,-25.61, 1, 0);
			}
			if(listitem == 4) // Woozies Apartment
			{
		    SetPlayerPosEx(playerid, -2158.72,641.29,1052.38, 1, 0);
			}
			if(listitem == 5) // Jizzy's
			{
		    SetPlayerPosEx(playerid, -2637.69,1404.24,906.46, 3, 0);
			}
			if(listitem == 6) // Dillimore Gas Station
			{
		    SetPlayerPosEx(playerid, 664.19,-570.73,16.34, 0, 0);
			}
			if(listitem == 7) // Jefferson Motel
			{
		    SetPlayerPosEx(playerid, 2220.26,-1148.01,1025.80, 15, 0);
			}
			if(listitem == 8) // Liberty City
			{
		    SetPlayerPosEx(playerid, -750.80,491.00,1371.70, 1, 0);
			}
			if(listitem == 9) // Sherman Dam
			{
		    SetPlayerPosEx(playerid, -944.2402, 1886.1536, 5.0051, 17, 0);
			}
			if(listitem == 10) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//=================================Missions 2=================================//
	if(dialogid == INTERIORMENU+7) //
	{
		if(response)
		{

			if(listitem == 0) // RC War Arena
			{
		    SetPlayerPosEx(playerid, -1079.99,1061.58,1343.04, 10, 0);
			}
			if(listitem == 1) // Racing Stadium
			{
		    SetPlayerPosEx(playerid, -1395.958,-208.197,1051.170, 7, 0);
			}
			if(listitem == 2) // Racing Stadium 2
			{
		    SetPlayerPosEx(playerid, -1424.9319,-664.5869,1059.8585, 4, 0);
			}
			if(listitem == 3) // Bloodbowl Stadium
			{
		    SetPlayerPosEx(playerid, -1394.20,987.62,1023.96, 15, 0);
			}
			if(listitem == 4) // Kickstart Stadium
			{
		    SetPlayerPosEx(playerid, -1410.72,1591.16,1052.53, 14, 0);
			}
			if(listitem == 5) // Back(返回)
			{
  			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//===============================Casino Interiors================================//
	if(dialogid == INTERIORMENU+8) // Casino Interiors
	{
		if(response)
		{
			if(listitem == 0) // Caligulas
			{
		    SetPlayerPosEx(playerid, 2233.8032,1712.2303,1011.7632, 1, 0);
			}
			if(listitem == 1) // 4 Dragons Casino
			{
		    SetPlayerPosEx(playerid, 2016.2699,1017.7790,996.8750, 10, 0);
			}
			if(listitem == 2) // Redsands Casino
			{
		    SetPlayerPosEx(playerid, 1132.9063,-9.7726,1000.6797, 12, 0);
			}
			if(listitem == 3) // 4 Dragons' Managerial Suite NOT SOLID
			{
		    SetPlayerPosEx(playerid, 2003.1178, 1015.1948, 33.008, 11, 0);
			}
			if(listitem == 4) // Inside Track betting
			{
		    SetPlayerPosEx(playerid, 830.6016, 5.9404, 1004.1797, 3, 0);
			}
			if(listitem == 5) // Caligulas Roof
			{
		    SetPlayerPosEx(playerid, 2268.5156, 1647.7682, 1084.2344, 1, 0);
			}
			if(listitem == 6) // Rosenberg's Caligulas Office NOT SOLID FLOOR
			{
		    SetPlayerPosEx(playerid, 2182.2017, 1628.5848, 1043.8723, 2, 0);
			}
			if(listitem == 7) // 4 Dragons Janitor's Office
			{
		    SetPlayerPosEx(playerid, 1893.0731, 1017.8958, 31.8828, 10, 0);
			}
			if(listitem == 8) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//===============================Shop Interiors================================//
	if(dialogid == INTERIORMENU+9) // Shop Interiors
	{
		if(response)
		{
			if(listitem == 0) // Tattoo
			{
		    SetPlayerPosEx(playerid, -203.0764,-24.1658,1002.2734, 16, 0);
			}
			if(listitem == 1) // Burger Shot
			{
		    SetPlayerPosEx(playerid, 365.4099,-73.6167,1001.5078, 10, 0);
			}
			if(listitem == 2) // Well Stacked Pizza
			{
		    SetPlayerPosEx(playerid, 372.3520,-131.6510,1001.4922, 5, 0);
			}
			if(listitem == 3) // Cluckin Bell
			{
		    SetPlayerPosEx(playerid, 365.7158,-9.8873,1001.8516, 9, 0);
			}
			if(listitem == 4) // Rusty Donut's
			{
		    SetPlayerPosEx(playerid, 378.026,-190.5155,1000.6328, 17, 0);
			}
			if(listitem == 5) // Zero's
			{
		    SetPlayerPosEx(playerid, -2240.1028, 136.973, 1035.4141, 6, 0);
			}
			if(listitem == 6) // Sex Shop
			{
		    SetPlayerPosEx(playerid, -100.2674, -22.9376, 1000.7188, 3, 0);
			}
			if(listitem == 7) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//===================================MOD SHOPS/GARAGES==================================//
	if(dialogid == INTERIORMENU+10) //
	{
		if(response)
		{
			if(listitem == 0) // Loco Low Co.
			{
		    SetPlayerPosEx(playerid, 616.7820,-74.8151,997.6350, 2, 0);
			}
			if(listitem == 1) // Wheel Arch Angels
			{
		    SetPlayerPosEx(playerid, 615.2851,-124.2390,997.6350, 3, 0);
			}
			if(listitem == 2) // Transfender
			{
		    SetPlayerPosEx(playerid, 617.5380,-1.9900,1000.6829, 1, 0);
			}
			if(listitem == 3) // Doherty Garage
			{
		    SetPlayerPosEx(playerid, -2041.2334, 178.3969, 28.8465, 1, 0);
			}
			if(listitem == 4) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//===================================Girlfriend Interiors==================================//
	if(dialogid == INTERIORMENU+11) //
	{
		if(response)
		{
			if(listitem == 0) // Denise's Bedroom
			{
		    SetPlayerPosEx(playerid, 245.2307, 304.7632, 999.1484, 1, 0);
			}
			if(listitem == 1) // Helena's Barn
			{
		    SetPlayerPosEx(playerid, 290.623, 309.0622, 999.1484, 3, 0);
			}
			if(listitem == 2) // Barbaras Love Nest
			{
		    SetPlayerPosEx(playerid, 322.5014, 303.6906, 999.1484, 5, 0);
			}
			if(listitem == 3) // Katie's Lovenest
			{
		    SetPlayerPosEx(playerid, 269.6405, 305.9512, 999.1484, 2, 0);
			}
			if(listitem == 4) // Michelle's Love Nest
			{
		    SetPlayerPosEx(playerid, 306.1966, 307.819, 1003.3047, 4, 0);
			}
			if(listitem == 5) // Millie's Bedroom
			{
		    SetPlayerPosEx(playerid, 344.9984, 307.1824, 999.1557, 6, 0);
			}
			if(listitem == 6) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//===================================CLOTHING/BARBER SHOP==================================//
	if(dialogid == INTERIORMENU+12) //
	{
		if(response)
		{
			if(listitem == 0) // Barber Shop
			{
		    SetPlayerPosEx(playerid, 418.4666, -80.4595, 1001.8047, 3, 0);
			}
			if(listitem == 1) // Pro Laps
			{
		    SetPlayerPosEx(playerid, 206.4627, -137.7076, 1003.0938, 3, 0);
			}
			if(listitem == 2) // Victim
			{
		    SetPlayerPosEx(playerid, 225.0306, -9.1838, 1002.218, 5, 0);
			}
			if(listitem == 3) // Suburban
			{
		    SetPlayerPosEx(playerid, 204.1174, -46.8047, 1001.8047, 1, 0);
			}
			if(listitem == 4) // Reece's Barber Shop
			{
		    SetPlayerPosEx(playerid, 414.2987, -18.8044, 1001.8047, 2, 0);
			}
			if(listitem == 5) // Zip
			{
		    SetPlayerPosEx(playerid, 161.4048, -94.2416, 1001.8047, 18, 0);
			}
			if(listitem == 6) // Didier Sachs
			{
		    SetPlayerPosEx(playerid, 204.1658, -165.7678, 1000.5234, 14, 0);
			}
			if(listitem == 7) // Binco
			{
		    SetPlayerPosEx(playerid, 207.5219, -109.7448, 1005.1328, 15, 0);
			}
			if(listitem == 8) // Barber Shop 2
			{
		    SetPlayerPosEx(playerid, 411.9707, -51.9217, 1001.8984, 12, 0);
			}
			if(listitem == 9) // Wardrobe
			{
		    SetPlayerPosEx(playerid, 256.9047, -41.6537, 1002.0234, 14, 0);
			}
			if(listitem == 10) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//===================================RESTURANTS/CLUBS==================================//
	if(dialogid == INTERIORMENU+13) //
	{
		if(response)
		{
			if(listitem == 0) // Brotel
			{
		    SetPlayerPosEx(playerid, 974.0177, -9.5937, 1001.1484, 3, 0);
			}
			if(listitem == 1) // Brotel 2
			{
		    SetPlayerPosEx(playerid, 961.9308, -51.9071, 1001.1172, 3, 0);
			}
			if(listitem == 2) // Big Spread Ranch
			{
		    SetPlayerPosEx(playerid, 1212.0762,-28.5799,1000.9531, 3, 0);
			}
			if(listitem == 3) // Dinner
			{
		    SetPlayerPosEx(playerid, 454.9853, -107.2548, 999.4376, 5, 0);
			}
			if(listitem == 4) // World Of Coq
			{
		    SetPlayerPosEx(playerid, 445.6003, -6.9823, 1000.7344, 1, 0);
			}
			if(listitem == 5) // The Pig Pen
			{
		    SetPlayerPosEx(playerid, 1204.9326,-8.1650,1000.9219, 2, 0);
			}
			if(listitem == 6) // Dance Club
			{
		    SetPlayerPosEx(playerid, 490.2701,-18.4260,1000.6797, 17, 0);
			}
			if(listitem == 7) // Jay's Dinner
			{
		    SetPlayerPosEx(playerid, 449.0172, -88.9894, 999.5547, 4, 0);
			}
			if(listitem == 8) // Secret Valley Dinner
			{
		    SetPlayerPosEx(playerid, 442.1295, -52.4782, 999.7167, 6, 0);
			}
			if(listitem == 9) // Fanny Batter's Whore House
			{
		    SetPlayerPosEx(playerid, 748.4623, 1438.2378, 1102.9531, 6, 0);
			}
			if(listitem == 10) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//===================================No Specific Group==================================//
	if(dialogid == INTERIORMENU+14) //
	{
		if(response)
		{
			if(listitem == 0) // Blastin' Fools Records
			{
		    SetPlayerPosEx(playerid, 1037.8276, 0.397, 1001.2845, 3, 0);
			}
			if(listitem == 1) // Warehouse
			{
		    SetPlayerPosEx(playerid, 1290.4106, 1.9512, 1001.0201, 18, 0);
			}
			if(listitem == 2) // Warehouse 2
			{
		    SetPlayerPosEx(playerid, 1411.4434,-2.7966,1000.9238, 1, 0);
			}
			if(listitem == 3) // Budget Inn Motel Room
			{
		    SetPlayerPosEx(playerid, 446.3247, 509.9662, 1001.4195, 12, 0);
			}
			if(listitem == 4) // Lil' Probe Inn
			{
		    SetPlayerPosEx(playerid, -227.5703, 1401.5544, 27.7656, 18, 0);
			}
			if(listitem == 5) //Crack Den
			{
		    SetPlayerPosEx(playerid, 318.5645, 1118.2079, 1083.8828, 5, 0);
			}
			if(listitem == 6) // Meat Factory
			{
		    SetPlayerPosEx(playerid, 963.0586, 2159.7563, 1011.0303, 1, 0);
			}
			if(listitem == 7) // Bike School
			{
		    SetPlayerPosEx(playerid, 1494.8589, 1306.48, 1093.2953, 3, 0);
			}
			if(listitem == 8) // Driving School
			{
		    SetPlayerPosEx(playerid, -2031.1196, -115.8287, 1035.1719, 3, 0);
			}
			if(listitem == 9) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
/*==============================Burglary Houses================================*/
	if(dialogid == INTERIORMENU+15) //
	{
		if(response)
		{
			if(listitem == 0) // Burglary House #1
			{
		    SetPlayerPosEx(playerid, 234.6087, 1187.8195, 1080.2578, 3, 0);
			}
			if(listitem == 1) // Burglary House #2
			{
		    SetPlayerPosEx(playerid, 225.5707, 1240.0643, 1082.1406, 2, 0);
			}
			if(listitem == 2) // Burglary House #3
			{
		    SetPlayerPosEx(playerid, 224.288, 1289.1907, 1082.1406, 1, 0);
			}
			if(listitem == 3) // Burglary House #4
			{
		    SetPlayerPosEx(playerid, 239.2819, 1114.1991, 1080.9922, 5, 0);
			}
			if(listitem == 4) // Burglary House #5
			{
		    SetPlayerPosEx(playerid, 295.1391, 1473.3719, 1080.2578, 15, 0);
			}
			if(listitem == 5) // Burglary House #6
			{
		    SetPlayerPosEx(playerid, 261.1165, 1287.2197, 1080.2578, 4, 0);
			}
			if(listitem == 6) // Burglary House #7
			{
		    SetPlayerPosEx(playerid, 24.3769, 1341.1829, 1084.375, 10, 0);
			}
			if(listitem == 7) // Burglary House #8
			{
		    SetPlayerPosEx(playerid, -262.1759, 1456.6158, 1084.36728, 4, 0);
			}
			if(listitem == 8) // Burglary House #9
			{
		    SetPlayerPosEx(playerid, 22.861, 1404.9165, 1084.4297, 5, 0);
			}
			if(listitem == 9) // Burglary House #10
			{
		    SetPlayerPosEx(playerid, 140.3679, 1367.8837, 1083.8621, 5, 0);
			}
			if(listitem == 10) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//===============================Burglary Houses 2================================//
	if(dialogid == INTERIORMENU+16) //
	{
		if(response)
		{
			if(listitem == 0) // Burglary House #11
			{
		    SetPlayerPosEx(playerid, 234.2826, 1065.229, 1084.2101, 6, 0);
			}
			if(listitem == 1) // Burglary House #12
			{
		    SetPlayerPosEx(playerid, -68.5145, 1353.8485, 1080.2109, 6, 0);
			}
			if(listitem == 2) // Burglary House #13
			{
		    SetPlayerPosEx(playerid, -285.2511, 1471.197, 1084.375, 15, 0);
			}
			if(listitem == 3) // Burglary House #14
			{
		    SetPlayerPosEx(playerid, -42.5267, 1408.23, 1084.4297, 8, 0);
			}
			if(listitem == 4) // Burglary House #15
			{
		    SetPlayerPosEx(playerid, 84.9244, 1324.2983, 1083.8594, 9, 0);
			}
			if(listitem == 5) // Burglary House #16
			{
		    SetPlayerPosEx(playerid, 260.7421, 1238.2261, 1084.2578, 9, 0);
			}
			if(listitem == 6) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//===============================Gyms================================//
	if(dialogid == INTERIORMENU+17) //
	{
		if(response)
		{
			if(listitem == 0) // LS Gym
			{
		    SetPlayerPosEx(playerid, 234.2826, 1065.229, 1084.2101, 6, 0);
			}
			if(listitem == 1) // SF Gym
			{
		    SetPlayerPosEx(playerid, 771.8632,-40.5659,1000.6865, 6, 0);
			}
			if(listitem == 2) // LV Gym
			{
		    SetPlayerPosEx(playerid, 774.0681,-71.8559,1000.6484, 7, 0);
			}
			if(listitem == 3) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
//===============================Departments================================//
	if(dialogid == INTERIORMENU+18) //
	{
		if(response)
		{
			if(listitem == 0) // SFPD
			{
		    SetPlayerPosEx(playerid, 246.40,110.84,1003.22, 10, 0);
			}
			if(listitem == 1) // LSPD
			{
		    SetPlayerPosEx(playerid, 246.6695, 65.8039, 1003.6406, 6, 0);
			}
			if(listitem == 2) // LVPD
			{
		    SetPlayerPosEx(playerid, 288.4723, 170.0647, 1007.1794, 3, 0);
			}
			if(listitem == 3) // Planning Department(CITY HALL)
			{
		    SetPlayerPosEx(playerid, 386.5259, 173.6381, 1008.382, 3, 0);
			}
			if(listitem == 4) // Back(返回)
			{
			ShowPlayerDialog(playerid, INTERIORMENU, DIALOG_STYLE_LIST, "Interior Menu By [03]Garsino","24/7's(超级市场)\nAirports(飞机场)\nAmmunations(武器店)\nHouses(民房)\nHouses 2(民房2)\nMissions(单机任务房)\nStadiums（室内赛车场）\nCasinos(赌场)\nShops(商店)\nGarages（改车行）\nGirlfriends(CJ女朋友住处)\nClothing(服装店)/Barber Store(理发店)\nResturants(餐馆)/Clubs(俱乐部)\nNo Category(未分类)\nBurglary（民居）\nBurglary(民居2）\nGym(强身健体~锻炼房)\nDepartment(政府部门)\nBack(返回)", "选择", "取消");
			}
		}
		return 1;
	}
	return 0;
}

stock SetPlayerPosEx(playerid, Float:X, Float:Y, Float:Z, interior, world)
{
	SetPlayerPos(playerid, X, Y, Z);
	SetPlayerInterior(playerid,interior);
	SetPlayerVirtualWorld(playerid,world);
	return 1;
}
