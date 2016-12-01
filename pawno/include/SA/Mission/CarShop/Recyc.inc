/* 
	Recycle 
	垃圾回收
*/
#define MAX_RECS 50
#define REC_TIMER 10000
#define NULL -1

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
	else printf("[��������]: ����! ��������ʧ��, �����ַ:%d",pointer);
}
stock CARSHOP_REC_FREE(pointer)
{
	new idx = CARSHOP_REC_GETOBJ(pointer);
	if(idx != NULL) SetTimerEx("CARSHOP_REC_TIMER", REC_TIMER, false, "i", idx);
	else printf("[��������]: ����! δ���ҵ���ָ��ָ��Ķ����ַ!�޷����л���, �����ַ:%d",pointer);
}
stock CARSHOP_REC_MALLOC()//��ѯ�Ƿ���ʣ���ַ����
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