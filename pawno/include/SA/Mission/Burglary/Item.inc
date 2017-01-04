/*
	盗窃物品类
	在这里添加可偷窃的物品模型ID以及它的价值等

*/

// #格式 {模型ID,价值}
new BurlagryItems[][] =
{
	{2648,2000},
	{1839,4000},
	{2028,4000},
	{2149,800},
	{1786,5000},
	{1840,3000},
	{1841,3000}
};

stock Burglary_GetItemCash(modelid)
{
	for(new i = 0; i < sizeof(BurlagryItems);i++)
	{
		if(BurlagryItems[i][0] == modelid) return BurlagryItems[i][1];
	}
	return NULL;
}