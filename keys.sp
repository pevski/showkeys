#include <sourcemod>
#include <sdktools>
#include <shavit>

bool g_bEnabled[MAXPLAYERS + 1]

public void OnPluginStart()
{
	RegConsoleCmd("sm_keyss", Command_CenterKeys);
}

public Action Command_CenterKeys(client, args)
{
	g_bEnabled[client] = !g_bEnabled[client];
	return Plugin_Handled;
}

public Action Shavit_OnUserCmdPre(int client, int &buttons, int &impulse, float vel[3], float angles[3], TimerStatus status, int track, int style, int mouse[2])
{
	if (g_bEnabled[client] && client != 0)
	{
		// target to show to
		
		
		// show keys
		
		char sForward[1], sBack[1], sMoveleft[2], sMoveright[2];
		char sTurnLeft[8], sTurnRight[8];
		char sOverlap[1];
		char sKeys[128];
		
		if (buttons & IN_FORWARD)
			sForward[0] = 'W';
		else
			sForward[0] = 32;
		
		if (buttons & IN_BACK)
			sBack[0] = 'S';
		else
			sBack[0] = 32;
		
		if (buttons & IN_MOVELEFT)
		{
			sMoveleft[0] = 'A';
			sMoveleft[1] = 0;
		}
		else
		{
			sMoveleft[0] = 32;
			sMoveleft[1] = 32;
		}
		
		if (buttons & IN_MOVERIGHT)
		{
			sMoveright[0] = 'D';
			sMoveright[1] = 0;
		}
		else
		{
			sMoveright[0] = 32;
			sMoveright[1] = 32;
		}
		
		if (buttons & IN_MOVERIGHT && buttons & IN_MOVELEFT)
		{
			sOverlap[0] = '+';
			sOverlap[1] = 0;
		}
		
		if (buttons & IN_LEFT)
		{
			FormatEx(sTurnLeft, sizeof(sTurnLeft), "+L ");
		}
		else if (mouse[0] < 0)
		{
			FormatEx(sTurnLeft, sizeof(sTurnLeft), "←");
		}
		else
		{
			FormatEx(sTurnLeft, sizeof(sTurnLeft), "    ");
		}
		
		if (buttons & IN_RIGHT)
		{
			FormatEx(sTurnRight, sizeof(sTurnRight), " +R");
		}
		else if (mouse[0] > 0)
		{
			FormatEx(sTurnRight, sizeof(sTurnRight), "→");
		}
		else
		{
			FormatEx(sTurnRight, sizeof(sTurnRight), "    ");
		}
		
		Format(sKeys, sizeof(sKeys), "       %s\n%s%s  %s   %s%s\n        %s", sForward, sTurnLeft, sMoveleft, sOverlap, sMoveright, sTurnRight, sBack);
		
		if (buttons & IN_JUMP)
		{
			Format(sKeys, sizeof(sKeys), "%s\n    JUMP", sKeys);
		}
		else
		{
			Format(sKeys, sizeof(sKeys), "%s\n", sKeys);
		}
		
		if (buttons & IN_DUCK)
		{
			Format(sKeys, sizeof(sKeys), "%s\n    DUCK", sKeys);
		}
		else
		{
			Format(sKeys, sizeof(sKeys), "%s\n", sKeys);
		}
		
		PrintCenterText(client, sKeys);
	}
} 
