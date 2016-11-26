enum Player_Info
{
	Color,
}

new PlayerInfo[MAX_PLAYERS][Player_Info];

stock SetPlayerColorInfo(playerid,color)
{
	PlayerInfo[playerid][Color] = color;
}

stock GetPlayerColorInfo(playerid)
{
	return PlayerInfo[playerid][Color];
}