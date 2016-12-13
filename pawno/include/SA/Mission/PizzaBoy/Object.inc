#define MAX_PIZZA 5 //一次能带的PIZZA
#define VECTOR_LEFT 0
#define VECTOR_RIGHT 1
#define PIZZA_OBJECT 19571
enum Pizza_obj
{
	p_object, // 指针指向PIZZA对象
	bool:p_throwed //模型是否创建了
}
new PizzaObject[MAX_PLAYERS][MAX_PIZZA][Pizza_obj];

//获取可用的位置
stock PIZZA_GetFreeSlot(playerid)
{
	for(new i =0;i < MAX_PIZZA;i++)
		if(!PizzaObject[playerid][i][p_throwed]) return i;
	return NULL;
}
stock PIZZA_LunchObject(playerid,vectordir)
{
	#define SPEED (5.0)
	#define CONS (0.5)
	#define Z_SPEED (4.0)
	
	#define mass (5.0)
    new modelid = PIZZA_OBJECT ;
	new Float:x, Float:y, Float:z, Float:ang;
	GetPlayerPos(playerid, x, y, z);
	new currentveh;
	currentveh = GetPlayerVehicleID(playerid);

	GetVehicleZAngle(currentveh,ang);
	new Sot = PIZZA_GetFreeSlot(playerid);
	//printf("Slot = %d",Sot);
	if(Sot == NULL)
	{
		SendClientMessage(playerid,-1,"[小任务]: 没Pizza了,请回到餐厅去在拿一些~.");
		SG_Sub(playerid,"Return to the ~r~restaurant ~w~for more pizzas.",5);
	}	
	
	
	switch (vectordir)
	{
		case VECTOR_LEFT:
		{
			PizzaObject[playerid][Sot][p_object] = CreateObject(modelid, x- CONS * floatcos(ang, degrees), y- CONS *  floatsin(ang, degrees) , z+1, 90, 0, 0);
			PizzaObject[playerid][Sot][p_throwed] = true;
			//PHY_InitObject(Pizza[playerid][Sot][Taken], modelid, mass, _, PHY_MODE_3D);
			PHY_InitObject(PizzaObject[playerid][Sot][p_object], modelid, 2.0, 0.1,PHY_MODE_3D);
			PHY_SetObjectVelocity(PizzaObject[playerid][Sot][p_object], -SPEED * floatcos(ang, degrees), -SPEED * floatsin(ang, degrees), Z_SPEED);
			//print("VECTOR_LEFT");
		}
		case VECTOR_RIGHT:
		{
			PizzaObject[playerid][Sot][p_object]  = CreateObject(modelid, x+ CONS * floatcos(ang, degrees), y+ CONS *  floatsin(ang, degrees) , z+1, 90, 0, 0);
			PizzaObject[playerid][Sot][p_throwed] = true;
			//PHY_InitObject(Pizza[playerid][Sot][Taken], modelid, mass, _, PHY_MODE_3D);
			PHY_InitObject(PizzaObject[playerid][Sot][p_object], modelid, 2.0, 0.1,PHY_MODE_3D);
			PHY_SetObjectVelocity(PizzaObject[playerid][Sot][p_object] , SPEED * floatcos(ang, degrees), SPEED * floatsin(ang, degrees), Z_SPEED);
			//print("VECTOR_RIGHT");
		}
		
		
	}
	
	//物理属性赋值
	PHY_SetObjectFriction(PizzaObject[playerid][Sot][p_object], 10.0);
	PHY_SetObjectAirResistance(PizzaObject[playerid][Sot][p_object], 0.1);
	PHY_SetObjectGravity(PizzaObject[playerid][Sot][p_object], 10.0);
	PHY_SetObjectZBound(PizzaObject[playerid][Sot][p_object], _, _,0.0);
	PHY_UseColAndreas(PizzaObject[playerid][Sot][p_object],3);

		
	//更新UI绘制
	PIZZA_PLAYER_UIUpdate(playerid);
			

}
PIZZA_Fill(playerid)
{
	//清空创建的Pizza
	PIZZA_ObjectsRecycle(playerid);
	PIZZA_PLAYER_UIUpdate(playerid);
}

//垃圾回收
stock PIZZA_ObjectsRecycle(playerid)
{
	
	for(new i = 0; i < MAX_PIZZA;i++)
	{
		if(PizzaObject[playerid][i][p_throwed])
		{
			DestroyObject(PizzaObject[playerid][i][p_object]);
			PizzaObject[playerid][i][p_throwed] = false;
		}
	}
}

stock PIZZA_GetRemain(playerid)
{
	new idx;
	for(new i = 0; i < MAX_PIZZA;i++)
		if(!PizzaObject[playerid][i][p_throwed]) idx++;
	return idx;
}
stock PIZZA_OnPizzaHitMarker(playerid)
{
	//当玩家丢中了
	PIZZA_DestoryPlayerCheckPoints(playerid);
	PIZZA_CreatePlayerCheckPoints(playerid);

}
stock PIZZA_IsAVaildObject(playerid,objectid)
{
	for(new i =0;i<MAX_PIZZA;i++)
	{
		if(PizzaObject[playerid][i][p_object] == objectid ) return true;
	
	}
	return false;
}
stock PIZZA_GetObjectIDX(playerid,objectid)
{
	for(new i =0;i<MAX_PIZZA;i++)
	{
		if(PizzaObject[playerid][i][p_object] == objectid ) return i;
	
	}
	return false;
}


stock PIZZA_OnObjectUpdate(objectid)
{
	//printf("PHY_OnObjectUpdate(%d)",objectid);
	
	//Loop All Players
	for(new i = 0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i))
		{
			//如果OBJ是我们要的
			if(PIZZA_IsAVaildObject(i,objectid))
			{
			
				//SendClientMessage(i,-1,"[小任务]:OBJ IS VAILD.");
				new Float:Tem[3];
				GetObjectPos(objectid,Tem[0],Tem[1],Tem[2]);
				//判断物体是否丢中
				
				if(IsPointInRangeOfPoint(Tem[0],Tem[1],Tem[2],PlayerCP[i][cp_x],PlayerCP[i][cp_y],PlayerCP[i][cp_z],3))
				{
					
					//Pizza_CPTemObject[i] = objectid;
					PIZZA_OnPizzaHitMarker(i);
					//GivenPlayerMoneyByRange(i,900,1000);
					
				}

			}
		
		}
	
	}
}

