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
	printf("[���ҵ���] �Ҿߴ��� ��ȡ�ļ�·�� %s",str_path);
	new File:file = fopen(str_path, io_read), line[128],idx=0;
    while(fread(file, line))
    {	
		if(idx >= MAX_FUNITURE) break; //���ӳ������޵�����
		if(strfind(line, "#", true) != -1) continue; //����ע����
		
        new MODELID,Float:POSX,Float:POSY,Float:POSZ,Float:POSRX,Float:POSRY,Float:POSRZ;

		if (!sscanf(line, "iffffff",MODELID,POSX,POSY,POSZ,POSRX,POSRY,POSRZ)) //�����ȡ������ȷ����
		{
			
			BurglaryFunitureCreate(gameid,idx,MODELID,POSX,POSY,POSZ,POSRX,POSRY,POSRZ);
		}
		idx++;
    }
	
}