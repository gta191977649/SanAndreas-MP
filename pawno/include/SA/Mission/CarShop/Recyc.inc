/* 
	Recycle 
	垃圾回收
*/
#define MAX_RECS 50
#define REC_TIMER 10000

new CARSHOP_REC[MAX_RECS] = {INVALID_VEHICLE_ID,...};



stock CARSHOP_REC_ADD(pointer)
{
	new idx = CARSHOP_REC_MALLOC();
	if(idx != NULL)
	{
		CARSHOP_REC[idx] = pointer;
		SetTimerEx("CARSHOP_REC_TIMER", REC_TIMER, false, "i", idx);
	}
	else return NULL;
}

stock CARSHOP_REC_MALLOC()
{
	for(new i =0; i < MAX_RECS; i++)
		if(CARSHOP_REC[i] != INVALID_VEHICLE_ID) return i;
	return NULL;
}

forward CARSHOP_REC_TIMER(idx);
public CARSHOP_REC_TIMER(idx)
{
	DestroyVehicle(CARSHOP_REC[idx]);
	CARSHOP_REC[idx] = INVALID_VEHICLE_ID;
}
