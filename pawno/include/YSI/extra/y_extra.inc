// Include pretty much 90% of YSI in one fell swoop!

#tryinclude <sscanf2>
#tryinclude <whirlpool>

#if !defined _inc_sscanf2 || !defined _inc_whirlpool
	#error y_extra requires plugins - please install sscanf and whirlpool.
#endif

#include <YSI\y_commands>
#include <YSI\y_text>
#include <YSI\y_users>

text core[ysi_players], core[ysi_extras], core[ysi_dialog];

YCMD:login(playerid, params[], help)
{
	if (help)
	{
		Text_Send(playerid, YSI_LOGIN_HELP_1);
	}
	else
	{
		inline Response(pid, response, listitem, string:text[])
		{
			#pragma unused listitem
			if (response)
			{
				Player_TryLogin(pid, text);
			}
		}
		Text_InputBox(playerid, using inline Response, YSI_EXTRA_LOGIN_TITLE, YSI_EXTRA_LOGIN_PROMPT, DIALOG_OK, DIALOG_CANCEL);
	}
	return 1;
}

YCMD:register(playerid, params[], help)
{
	if (help)
	{
		Text_Send(playerid, YSI_REGISTER_HELP_1);
	}
	else
	{
		inline Response1(pid1, response1, listitem1, string:text1[])
		{
			#pragma unused listitem1
			if (response)
			{
				inline Response2(pid2, response2, listitem2, string:text2[])
				{
					#pragma unused listitem2
					if (response)
					{
						if (strcmp(text1, text2))
						{
							Text_Send(playerid, YSI_EXTRA_REGISTER_MISMATCH);
						}
						else
						{
							Player_TryRegister(playerid, text2);
						}
					}
				}
				Text_InputBox(playerid, using inline Response2, YSI_EXTRA_REGISTER_TITLE, YSI_EXTRA_CONFIRM_PROMPT, DIALOG_OK, DIALOG_CANCEL);
			}
		}
		Text_InputBox(playerid, using inline Response1, YSI_EXTRA_REGISTER_TITLE, YSI_EXTRA_REGISTER_PROMPT, DIALOG_OK, DIALOG_CANCEL);
	}
	return 1;
}


