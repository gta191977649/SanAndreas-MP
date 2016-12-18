/*
	IO Script For Burglary Mission
	By Liberty_Episodes
	Any Question Pls contact me on QQ
	191977649

*/


stock BurglaryReadFunitureFromFile(hourseid)
{
	new File:file = fopen("file.ini", io_read), line[128],idx=0;
    while(fread(file, line))
    {	
		if(idx >= MAX_FUNITURE) break; //无视超过上限的数据
		if(strfind(line, "#", true)) continue; //跳过注释行
		
        new MODELID,Float:POSX,Float:POSY,Float:POSZ,Float:POSRX,Float:POSRY,Float:POSRZ;
        
		if (!sscanf(line, "iffffff",MODELID,POSX,POSY,POSZ,POSRX,POSRY,POSRZ)) //如果读取到了正确数据
		{
			BurglaryFunitureCreate(hourseid,MODELID,POSX,POSY,POSZ,POSRX,POSRY,POSRZ);
		}
		idx++;
    }
	
}