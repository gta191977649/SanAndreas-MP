/* 
	Recycle 
	鍨冨溇鍥炴敹
*/
#define MAX_RECS 50
#define REC_TIMER 10000

new CARSHOP_REC[MAX_RECS] = {INVALID_VEHICLE_ID,...};
/*
stock CARSHOP_REC_Debug()
{
	for(new i =0; i < MAX_RECS; i++) printf("idx %d var = %d",i,CARSHOP_REC[i]);
}
*/

stock CARSHOP_REC_ADD(pointer)
{
	new idx = CARSHOP_REC_MALLOC();
	if(idx != NULL) CARSHOP_REC[idx] = pointer;
	else printf("[垃圾回收]: 警告! 添加垃圾失败, 错误地址:%d",pointer);
}
stock CARSHOP_REC_FREE(pointer)
{
	new idx = CARSHOP_REC_GETOBJ(pointer);
	if(idx != NULL) SetTimerEx("CARSHOP_REC_TIMER", REC_TIMER, false, "i", idx);
	else printf("[垃圾回收]: 警告! 未能找到该指针指向的对象地址!无法进行回收, 错误地址:%d",pointer);
}
stock CARSHOP_REC_MALLOC()//查询是否有剩余地址回收
{
	for(new i =0; i < MAX_RECS; i++)
		if(CARSHOP_REC[i] == INVALID_VEHICLE_ID) return i;
	return NULL;
}
stock CARSHOP_REC_GETOBJ(pointer)
{
	for(new i =0; i < MAX_RECS; i++)
		if(CARSHOP_REC[i] == pointer) return i;
	return NULL;
}


forward CARSHOP_REC_TIMER(idx);
public CARSHOP_REC_TIMER(idx)
{
	DestroyVehicle(CARSHOP_REC[idx]);
	CARSHOP_REC[idx] = INVALID_VEHICLE_ID;
}
