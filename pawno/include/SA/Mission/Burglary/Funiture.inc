#define FINIUTRE_NEARDIS 2.0
#define FUNIUTRE_FONTDIS 2.0
#define FUNIUTRE_FLOOROFFSET 0.9

enum FunitureInfo
{
	b_object,
	b_model,
	bool:b_ispicked,
	bool:b_used //可用么
};
new BurglaryFuniture[MAX_BURGLARY][MAX_FUNITURE][FunitureInfo];

stock BurglaryFunitureGetHandle(gameid,idx)
{
	return BurglaryFuniture[gameid][idx][b_object];
}

stock BurglaryFunitureGetModel(gameid,idx)
{
	return BurglaryFuniture[gameid][idx][b_model];
}

stock BurglaryFunitureCreate(gameid,idx,modelid,Float:fx,Float:fy,Float:fz,Float:frx,Float:fry,Float:frz)
{
	printf("Created Funiture %d %d",idx,modelid);
	BurglaryFuniture[gameid][idx][b_object] = CreateDynamicObject(modelid,fx,fy,fz,frx,fry,frz,0,-1,-1); //记得修改世界线
	BurglaryFuniture[gameid][idx][b_model] = modelid;
	BurglaryFuniture[gameid][idx][b_used] = true;
}

stock BurglaryFunitureDelete(gameid,idx)
{
	if(IsValidDynamicObject(BurglaryFuniture[gameid][idx][b_object]))
	{
		DestroyDynamicObject(BurglaryFuniture[gameid][idx][b_object]);
	}
}
stock BurglaryFunitureShow(playerid,gameid,idx)
{
	if(BurglaryFuniture[gameid][idx][b_used])
	{
		new Float:c_pos[3];
		GetXYZInFrontOfPlayer(playerid,c_pos[0],c_pos[1],c_pos[2],FUNIUTRE_FONTDIS);
		CA_FindZ_For2DCoord(c_pos[0],c_pos[1], c_pos[2]);//获取地面Z
		new Float:modelSize = GetColSphereRadius(BurglaryFuniture[gameid][idx][b_model]);//获取模型大小
		BurglaryFuniture[gameid][idx][b_object] = CreateDynamicObject(BurglaryFuniture[gameid][idx][b_model],c_pos[0],c_pos[1],c_pos[2]-modelSize-0.2,0.0,0.0,0.0,0,-1,-1); //记得修改世界线
	}
	
}
stock BurglaryFunitureHide(gameid,idx)
{
	if(BurglaryFuniture[gameid][idx][b_used])
	{
		DestroyDynamicObject(BurglaryFuniture[gameid][idx][b_object]);
	}
	else
	{
		printf("[入室盗窃] 家具隐藏失败,因为 id %d 并没用使用",idx);
	}
}


stock BurglaryFunitureDestory(gameid,idx)
{
	if(BurglaryFuniture[gameid][idx][b_used])
	{
		DestroyDynamicObject(BurglaryFuniture[gameid][idx][b_object]);
		BurglaryFuniture[gameid][idx][b_used] = false;
	}
	else
	{
		printf("[入室盗窃] 家具回收失败,因为 id %d 并没用使用",idx);
	}
	
}

stock BurglaryFunitureLift(gameid,index) //..
{
	
}
//返回最近的家具ID
stock BurglaryGetClostFuniture(playerid,gameid)
{
	new Float:playerPos[3];
	GetPlayerPos(playerid,playerPos[0],playerPos[1],playerPos[2]);
	
	//循环遍历全部家具
	for(new i = 0; i < MAX_FUNITURE; i++)
	{
		new Float:funiturePos[3];
		GetDynamicObjectPos(BurglaryFuniture[gameid][i][b_object],funiturePos[0],funiturePos[1],funiturePos[2]);
		if(IsPointInRangeOfPoint(playerPos[0],playerPos[1],playerPos[2], funiturePos[0],funiturePos[1],funiturePos[2], FINIUTRE_NEARDIS) && BurglaryFuniture[gameid][i][b_used])
		{
			return i;
		}
	}
	return NULL;
	
}
