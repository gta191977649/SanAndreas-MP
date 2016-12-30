#include <a_samp>
#include <zcmd>
#include <sscanf>

new PlayerVeh[MAX_PLAYERS];


CMD:vid(playerid, params[]){

	new vid,Float:distance;

	if(sscanf(params,"d",vid)) return SendClientMessage(playerid,0xFFFFFFFF,"用法: /vid  [汽车id]");
	if(vid < 400 || vid > 611) return SendClientMessage(playerid,0xFF0000FF, "[车管]：错误！你输入的名称不正确！");
	
	
	new Float:facing;
	
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	//Spawn in font of player
	
	new Float:size_x,Float:size_y,Float:size_z;
	GetVehicleModelInfo(vid, VEHICLE_MODEL_INFO_SIZE, size_x, size_y, size_z);
	distance = size_x + 0.5;
	
	GetPlayerFacingAngle(playerid, facing);
  	x += (distance * floatsin(-facing, degrees));
    y += (distance * floatcos(-facing, degrees));

	//Create the model and given the values
	PlayerVeh[playerid]=CreateVehicle(vid, x,y,z, 0, -1, -1,-1);

	
	SetVehicleVirtualWorld(PlayerVeh[playerid], GetPlayerVirtualWorld( playerid ) );
	LinkVehicleToInterior(PlayerVeh[playerid], GetPlayerInterior( playerid ) );
	PutPlayerInVehicle(playerid,PlayerVeh[playerid], 0);

					
	return 1;
}