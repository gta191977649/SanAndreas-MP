/*
	IO Script For Burglary Mission
	By Liberty_Episodes
	Any Question Pls contact me on QQ
	191977649

*/


stock BurglaryReadFunitureFromFile(gameid,hourseid)
{
	new str_path[125];
	format(str_path,sizeof(str_path),"Mission/Burglary/%d.ini",hourseid);
	printf("[入室盗窃] 家具创建 读取文件路径 %s",str_path);
	new File:file = fopen(str_path, io_read), line[128],idx=0;
    while(fread(file, line))
    {	
		if(idx >= MAX_FUNITURE) break; //无视超过上限的数据
		if(strfind(line, "#", true) != -1) continue; //跳过注释行
		
        new MODELID,Float:POSX,Float:POSY,Float:POSZ,Float:POSRX,Float:POSRY,Float:POSRZ;

		if (!sscanf(line, "iffffff",MODELID,POSX,POSY,POSZ,POSRX,POSRY,POSRZ)) //如果读取到了正确数据
		{
			
			BurglaryFunitureCreate(gameid,idx,MODELID,POSX,POSY,POSZ,POSRX,POSRY,POSRZ);
		}
		idx++;
    }
	
}