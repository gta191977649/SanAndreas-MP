#define FINIUTRE_NEARDIS 2

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
		if(IsPointInRangeOfPoint(playerPos[0],playerPos[1],playerPos[2], funiturePos[0],funiturePos[1],funiturePos[2], FINIUTRE_NEARDIS))
		{
			return i;
		}
	}
	return NULL;
	
}
