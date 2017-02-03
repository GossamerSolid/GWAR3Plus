/* #Zadori
$[
	1.063,
	["CommanderDeployment",[[0,0,1,1],0.025,0.04,"GUI_GRID"],1,0,0],
	[1101,"MainBack",[1,"",["0.205705 * safezoneW + safezoneX","0.203 * safezoneH + safezoneY","0.578263 * safezoneW","0.638 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"Header",[1,"Commander Redeployment",["0.205705 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.578263 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,1,1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"FrameRespawnLoc",[1,"Deployment Selection",["0.210868 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.567937 * safezoneW","0.572 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"FrameRespawnInfo",[1,"Deployment Information",["0.210868 * safezoneW + safezoneX","0.786 * safezoneH + safezoneY","0.567937 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2400,"AcceptDeploy",[1,"Deploy (-1 Ticket)",["0.686927 * safezoneW + safezoneX","0.793407 * safezoneH + safezoneY","0.0877721 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"Map",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.216031 * safezoneW + safezoneX","0.2294 * safezoneH + safezoneY","0.557611 * safezoneW","0.55 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1102,"",[1,"Deploy to MHQ",["0.210868 * safezoneW + safezoneX","0.797 * safezoneH + safezoneY","0.361415 * safezoneW","0.022 * safezoneH"],[1,1,1,1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class UI_CommanderRedeploy
{
	movingEnable = 1;
	enableSimulation = 1;
	enableDisplay = 1;
	idd = 60011;
	onLoad = "_this Spawn GUI_CommanderRedeploy";

	class controlsBackground
	{
		class HeaderBG : IGUIBack
		{
			idc = 1189;
			x = 0.205705 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.578263 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
		};
		
		class Header: RscStructuredText
		{
			idc = 1100;
			text = "Commander Redeployment"; //--- ToDo: Localize;
			x = 0.205705 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.578263 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		
		class MainBack: IGUIBack
		{
			idc = 1101;
			x = 0.205705 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.578263 * safezoneW;
			h = 0.638 * safezoneH;
			colorBackground[] = {0.2196,0.2196,0.2196,0.8};
		};
		
		class FrameRespawnLoc: RscFrame
		{
			idc = 1800;
			text = "Deployment Selection"; //--- ToDo: Localize;
			x = 0.210868 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.567937 * safezoneW;
			h = 0.572 * safezoneH;
		};
		class FrameRespawnInfo: RscFrame
		{
			idc = 1801;
			text = "Deployment Information"; //--- ToDo: Localize;
			x = 0.210868 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.567937 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
	
	class controls 
	{
		class AcceptDeploy: RscButton
		{
			idc = 2400;
			text = "Deploy"; //--- ToDo: Localize;
			x = 0.686927 * safezoneW + safezoneX;
			y = 0.793407 * safezoneH + safezoneY;
			w = 0.0877721 * safezoneW;
			h = 0.033 * safezoneH;
			action = "GW_COMMREDEP_SELECTED = true";
		};
		class Map: RscMapControl
		{
			idc = 1200;
			ShowCountourInterval = 1;
			x = 0.216031 * safezoneW + safezoneX;
			y = 0.2294 * safezoneH + safezoneY;
			w = 0.557611 * safezoneW;
			h = 0.55 * safezoneH;
			
			onMouseMoving = "GW_MOUSEX = (_this Select 1);GW_MOUSEY = (_this Select 2)";
			onMouseButtonUp = "GW_MAPCLICK = _this Select 1";
		};
		class RscStructuredText_1102: RscStructuredText
		{
			idc = 1102;
			text = "Deploy to MHQ"; //--- ToDo: Localize;
			x = 0.210868 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.361415 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {-1,-1,-1,0};
		};
	};
};
