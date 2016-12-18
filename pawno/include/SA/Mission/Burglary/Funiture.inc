#define MAX_FUNITURE 10 一个房子里面最多有多少家具

enum FunitureInfo
{
	b_object,
	b_model,
	bool:b_ispicked,
	bool:b_used //可用么
};
new BurglaryFuniture[MAX_BURGLARY][MAX_FUNITURE];


stock BurglaryFunitureCreate(gameid,idx,modelid,Float:fx,Float:fy,Float:fz,Float:frx,Float:fry,Float:frz)
{
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