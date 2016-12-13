//#define TYPE_HORSESHOE (954)
//#define TYPE_OYSTER (953)
enum E_COLLECTIBLE_DIALOG
{
    DIALOG_COLLECTIBLES_MENU = 24555,
    DIALOG_COLLECTIBLES_PROGRESS,
    DIALOG_COLLECTIBLES_PROGRESS_2,
    DIALOG_COLLECTIBLES_RESET,
    DIALOG_COLLECTIBLES_RESET_2
};
 
enum E_COLLECTIBLE_TYPE
{
    typeName[16],
    typeModel
};
 
enum E_COLLECTIBLE
{
    colType,
    Float: colX,
    Float: colY,
    Float: colZ,
    colPickup
};
 
enum E_COLLECTIBLE_TYPE_REF
{
    TYPE_OYSTER,    // reference to CollectibleTypes index 0
    TYPE_HORSESHOE  // reference to CollectibleTypes index 1
};
 
new
    CollectibleTypes[][E_COLLECTIBLE_TYPE] = {
    //  {name, model id}
        {"Oyster", 953},    // index 0
        {"Horseshoe", 954}  // index 1
    };
 
new
    CollectibleData[][E_COLLECTIBLE] = {
    //  {type, pos x, pos y, pos z}
        {TYPE_HORSESHOE, 1224.0, 2617.0, 11.0},
        {TYPE_HORSESHOE, 2323.0, 1284.0, 97.0},
        {TYPE_HORSESHOE, 2035.0, 2305.0, 18.0},
        {TYPE_HORSESHOE, 2491.0, 2263.0, 15.0},
        {TYPE_HORSESHOE, 1433.0, 2796.0, 20.0},
        {TYPE_HORSESHOE, 2071.0, 712.0, 11.0},
        {TYPE_HORSESHOE, 2239.0, 1839.0, 18.0},
        {TYPE_HORSESHOE, 2583.0, 2387.0, 16.0},
        {TYPE_HORSESHOE, 2864.0, 857.0, 13.0},
        {TYPE_HORSESHOE, 2612.0, 2200.0, -1.0},
        {TYPE_HORSESHOE, 2274.0, 1507.0, 24.0},
        {TYPE_HORSESHOE, 2184.0, 2529.0, 11.0},
        {TYPE_HORSESHOE, 1863.0, 2314.0, 15.0},
        {TYPE_HORSESHOE, 2054.0, 2434.0, 166.0},
        {TYPE_HORSESHOE, 1603.0, 1435.0, 11.0},
        {TYPE_HORSESHOE, 1362.92, 1015.24, 11.0},
        {TYPE_HORSESHOE, 2058.7, 2159.1, 16.0},
        {TYPE_HORSESHOE, 2003.0, 1672.0, 12.0},
        {TYPE_HORSESHOE, 2238.0, 1135.0, 49.0},
        {TYPE_HORSESHOE, 1934.06, 988.79, 22.0},
        {TYPE_HORSESHOE, 1768.0, 2847.0, 9.0},
        {TYPE_HORSESHOE, 1084.0, 1076.0, 11.0},
        {TYPE_HORSESHOE, 2879.0, 2522.0, 11.0},
        {TYPE_HORSESHOE, 2371.0, 2009.0, 15.0},
        {TYPE_HORSESHOE, 1521.0, 1690.0, 10.6},
        {TYPE_HORSESHOE, 2417.0, 1281.0, 21.0},
        {TYPE_HORSESHOE, 1376.0, 2304.0, 15.0},
        {TYPE_HORSESHOE, 1393.0, 1832.0, 12.34},
        {TYPE_HORSESHOE, 984.0, 2563.0, 12.0},
        {TYPE_HORSESHOE, 1767.0, 601.0, 13.0},
        {TYPE_HORSESHOE, 2108.0, 1003.0, 46.0},
        {TYPE_HORSESHOE, 2705.98, 1862.52, 24.41},
        {TYPE_HORSESHOE, 2493.0, 922.0, 16.0},
        {TYPE_HORSESHOE, 1881.0, 2846.0, 11.0},
        {TYPE_HORSESHOE, 2020.0, 2352.0, 11.0},
        {TYPE_HORSESHOE, 1680.3, 2226.86, 16.11},
        {TYPE_HORSESHOE, 1462.0, 936.0, 10.0},
        {TYPE_HORSESHOE, 2125.5, 789.23, 11.45},
        {TYPE_HORSESHOE, 2588.0, 1902.0, 15.0},
        {TYPE_HORSESHOE, 919.0, 2070.0, 11.0},
        {TYPE_HORSESHOE, 2173.0, 2465.0, 11.0},
        {TYPE_HORSESHOE, 2031.25, 2207.33, 11.0},
        {TYPE_HORSESHOE, 2509.0, 1144.0, 19.0},
        {TYPE_HORSESHOE, 2215.0, 1968.0, 11.0},
        {TYPE_HORSESHOE, 2626.0, 2841.0, 11.0},
        {TYPE_HORSESHOE, 2440.08, 2161.07, 20.0},
        {TYPE_HORSESHOE, 1582.0, 2401.0, 19.0},
        {TYPE_HORSESHOE, 2077.0, 1912.0, 14.0},
        {TYPE_HORSESHOE, 970.0, 1787.0, 11.0},
        {TYPE_HORSESHOE, 1526.22, 751.0, 29.04},
        {TYPE_OYSTER, 979.0, -2210.0, -3.0},
        {TYPE_OYSTER, 2750.0, -2584.0, -5.0},
        {TYPE_OYSTER, 1279.0, -806.0, 85.0},
        {TYPE_OYSTER, 2945.13, -2051.93, -3.0},
        {TYPE_OYSTER, 67.0, -1018.0, -5.0},
        {TYPE_OYSTER, 2327.0, -2662.0, -5.0},
        {TYPE_OYSTER, 2621.0, -2506.0, -5.0},
        {TYPE_OYSTER, 1249.0, -2687.0, -1.0},
        {TYPE_OYSTER, 725.0, -1849.0, -5.0},
        {TYPE_OYSTER, 723.0, -1586.0, -3.0},
        {TYPE_OYSTER, 155.0, -1975.0, -8.0},
        {TYPE_OYSTER, 1968.0, -1203.0, 17.0},
        {TYPE_OYSTER, -2657.0, 1564.0, -6.0},
        {TYPE_OYSTER, -1252.0, 501.0, -8.0},
        {TYPE_OYSTER, -1625.0, 4.0, -10.0},
        {TYPE_OYSTER, -1484.0, 1489.0, -10.0},
        {TYPE_OYSTER, -2505.406, 1543.724, -22.5553},
        {TYPE_OYSTER, -2727.0, -469.0, -5.0},
        {TYPE_OYSTER, -1266.0, 966.0, -10.0},
        {TYPE_OYSTER, -1013.0, 478.0, -7.0},
        {TYPE_OYSTER, -1364.0, 390.0, -5.0},
        {TYPE_OYSTER, 2578.0, 2382.0, 16.0},
        {TYPE_OYSTER, 2090.0, 1898.0, 8.0},
        {TYPE_OYSTER, 2130.0, 1152.0, 7.0},
        {TYPE_OYSTER, 2013.0, 1670.0, 7.0},
        {TYPE_OYSTER, 2531.0, 1569.0, 9.0},
        {TYPE_OYSTER, 2998.0, 2998.0, -10.0},
        {TYPE_OYSTER, -832.0, 925.0, -2.0},
        {TYPE_OYSTER, 486.0, -253.0, -4.0},
        {TYPE_OYSTER, -90.0, -910.0, -5.0},
        {TYPE_OYSTER, 26.43, -1320.94, -10.04},
        {TYPE_OYSTER, -207.0, -1682.0, -8.0},
        {TYPE_OYSTER, -1672.0, -1641.0, -2.0},
        {TYPE_OYSTER, -1175.0, -2639.0, -2.5},
        {TYPE_OYSTER, -1097.0, -2858.0, -8.0},
        {TYPE_OYSTER, -2889.0, -1042.0, -9.0},
        {TYPE_OYSTER, -659.0, 874.0, -2.0},
        {TYPE_OYSTER, -955.0, 2628.0, 35.0},
        {TYPE_OYSTER, -1066.0, 2197.0, 32.0},
        {TYPE_OYSTER, 40.0, -531.0, -8.0},
        {TYPE_OYSTER, -765.0, 247.0, -8.0},
        {TYPE_OYSTER, 2098.0, -108.0, -2.0},
        {TYPE_OYSTER, 2767.0, 470.0, -8.0},
        {TYPE_OYSTER, -783.0, 2116.0, 35.0},
        {TYPE_OYSTER, -821.0, 1374.0, -8.0},
        {TYPE_OYSTER, -2110.5, 2329.72, -7.5},
        {TYPE_OYSTER, -1538.0, 1708.0, -3.27},
        {TYPE_OYSTER, -2685.0, 2153.0, -5.0},
        {TYPE_OYSTER, 796.0, 2939.0, -5.0},
        {TYPE_OYSTER, 2179.0, 235.0, -5.0}
    };
 
new
    CollectiblePicked[MAX_PLAYERS][ sizeof(CollectibleData) ];

new CollectiblePickUp[sizeof(Collect_HorseshoeData)];
 
//new bool:p_CollectiblePicked[MAX_PLAYERS][ sizeof(CollectibleData) ];
/*

stock COLLECT_CreatePickUp()
{
	//马蹄铁
	for(new i; i < sizeof(Collect_HorseshoeData); i++) CollectiblePickUp[i] = CreatePickup(TYPE_HORSESHOE, 1, Collect_HorseshoeData[i][0], Collect_HorseshoeData[i][1], Collect_HorseshoeData[i][2], -1);
}*/