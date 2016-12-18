#define MAX_FUNITURE 10 一个房子里面最多有多少家具

enum FunitureInfo
{
	b_object,
	b_model,
	bool:b_ispicked,
	bool:b_used //可用么
};
new BurglaryFuniture[MAX_BURGLARY][MAX_FUNITURE];


stock BurglaryFunitureCreate(hourseid,modelid,Float:fx,Float:fy,Float:fz,Float:frx,Float:fry,Float:frz)
{
	
}