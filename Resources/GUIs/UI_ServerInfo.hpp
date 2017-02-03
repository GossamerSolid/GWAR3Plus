/* #Moxihy
$[
	1.063,
	["SquadMenu",[["0","0","1","1"],"0.025","0.04","GUI_GRID"],0,0,0],
	[2200,"MainBack",[1,"",["0.381249 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.242664 * safezoneW","0.165 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"",[1,"Server Information",["0.381249 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.242664 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,1,1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"BtnExit",[1,"X",["0.613587 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.0103261 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"BtnBack",[1,"B",["0.598098 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.0103261 * safezoneW","0.022 * safezoneH"],[1,1,1,1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"FramePerformance",[1,"Server Performance",["0.386413 * safezoneW + safezoneX","0.3504 * safezoneH + safezoneY","0.232338 * safezoneW","0.077 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"",[1,"Server Uptime",["0.386413 * safezoneW + safezoneX","0.434 * safezoneH + safezoneY","0.232338 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"",[1,"Server Uptime: 00:00:00",["0.391576 * safezoneW + safezoneX","0.456 * safezoneH + safezoneY","0.216849 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]],
	[1102,"TextFPS",[1,"Min: 50FPS   Avg: 50FPS   Current: 50FPS",["0.391576 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.216849 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]]
]
*/


class UI_ServerInfo
{
	movingEnable = 1;
	enableSimulation = 1;
	enableDisplay = 1;
	idd = 60009;
	onLoad = "_this Spawn GUI_ServerInfo";
	
	class controlsBackground
	{
		class MainBack: IGUIBack
		{
			idc = 2200;
			x = 0.381249 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.242664 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0.2196,0.2196,0.2196,0.8};
		};
		class FramePerformance: RscFrame
		{
			idc = 1800;
			text = "Server Uptime"; //--- ToDo: Localize;
			x = 0.386413 * safezoneW + safezoneX;
			y = 0.3504 * safezoneH + safezoneY;
			w = 0.232338 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RscFrame_1801: RscFrame
		{
			idc = 1801;
			text = "Server Performance"; //--- ToDo: Localize;
			x = 0.386413 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.232338 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class HeaderBG : IGUIBack
		{
			idc = 1189;
			x = 0.381249 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.242664 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
		};
		class Header : RscStructuredText
		{
			idc = 1100;
			x = 0.381249 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.242664 * safezoneW;
			h = 0.022 * safezoneH;
			text = "Server Information"; //--- ToDo: Localize;
			colorBackground[] = {0,0,0,0};
		};
	};
	
	class controls 
	{
		class BtnExit: RscClickableText
		{
			idc = 1200;
			text = "resources\images\exit_button.paa";
			x = 0.613587 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0103261 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "closeDialog 60009";
		};
		/*
		class BtnBack: RscClickableText
		{
			idc = 1201;
			text = "resources\images\back_button.paa";
			x = 0.598098 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0103261 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			onButtonClick = "closeDialog 60009; [] Spawn {sleep 0.05; createDialog 'UI_Menu'}";
		};
		*/
		class RscStructuredText_1101: RscStructuredText
		{
			idc = 1101;
			text = "Server Uptime: 00:00:00"; //--- ToDo: Localize;
			x = 0.391576 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.216849 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
		class TextFPS: RscStructuredText
		{
			idc = 1102;
			text = "Min: 50FPS   Avg: 50FPS   Current: 50FPS"; //--- ToDo: Localize;
			x = 0.391576 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.216849 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
	};
};

