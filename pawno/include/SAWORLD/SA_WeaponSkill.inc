enum PlayerWeaponInfo
{
	PISTOL,
	PISTOL_SILENCED,
	DESERT_EAGLE,
	SHOT_GUN,
	SAWNOFF_SHOTGUN,
	SPAS12_SHOTGUN,
	MICRO_UZI,
	MP5,
	AK47,
	M4,
	SNIPERRIFLE,
	COUNTRYRIFLE,
}

new PlayerWeaponSkill[MAX_PLAYERS][PlayerWeaponInfo];

//封装
forward SYSTEM_GetPlayerWeaponSkills(playerid,WeaponID);
public SYSTEM_GetPlayerWeaponSkills(playerid,WeaponID)
{
	switch(WeaponID)
	{
		case 22: return PlayerWeaponSkill[playerid][PISTOL];
		case 23: return PlayerWeaponSkill[playerid][PISTOL_SILENCED];
		case 24: return PlayerWeaponSkill[playerid][DESERT_EAGLE];
		case 25: return PlayerWeaponSkill[playerid][SHOT_GUN];
		case 26: return PlayerWeaponSkill[playerid][SAWNOFF_SHOTGUN];
		case 27: return PlayerWeaponSkill[playerid][SPAS12_SHOTGUN];
		case 28: return PlayerWeaponSkill[playerid][MICRO_UZI];
		case 29: return PlayerWeaponSkill[playerid][MP5];
		case 30: return PlayerWeaponSkill[playerid][AK47];
		case 31: return PlayerWeaponSkill[playerid][M4];
		case 32: return PlayerWeaponSkill[playerid][MP5];
		case 33: return PlayerWeaponSkill[playerid][COUNTRYRIFLE];
		case 34: return PlayerWeaponSkill[playerid][SNIPERRIFLE];
		
	}
	return -1;
}