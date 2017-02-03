/* #Lykajo
$[
	1.063,
	["ResearchAndDevelopment",[[0,0,1,1],0.025,0.04,"GUI_GRID"],1,0,0],
	[1100,"Header",[1,"Research and Development",["0.293477 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.413045 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,1,1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"MainBack",[1,"",["0.293477 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.413045 * safezoneW","0.473 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"BGFrame",[1,"Research List",["0.29864 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.154892 * safezoneW","0.451 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"ListResearch",[1,"",["0.303803 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.144566 * safezoneW","0.418 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"",[1,"Research Description",["0.458695 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.242664 * safezoneW","0.396 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"BtnBack",[1,"B",["0.680707 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.0103261 * safezoneW","0.022 * safezoneH"],[1,1,1,1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"BtnExit",[1,"X",["0.696197 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.0103261 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1802,"FrameButton",[1,"",["0.458695 * safezoneW + safezoneX","0.665 * safezoneH + safezoneY","0.242664 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2403,"BtnResearch",[1,"Research (Sxxxxx)",["0.572284 * safezoneW + safezoneX","0.670074 * safezoneH + safezoneY","0.123914 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1102,"TextCommOnly",[1,"Commander Only",["0.460941 * safezoneW + safezoneX","0.669443 * safezoneH + safezoneY","0.103261 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]],
	[1103,"TextDescription",[1,"",["0.463859 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.232338 * safezoneW","0.363 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class UI_Research
{
	movingEnable = 1;
	enableSimulation = 1;
	enableDisplay = 1;
	idd = 60012;
	onLoad = "_this Spawn GUI_Research";

	class controlsBackground
	{
		class HeaderBG : IGUIBack
		{
			idc = 1189;
			x = 0.293477 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.413045 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
		};
		
		class Header: RscStructuredText
		{
			idc = 1100;
			text = "Research and Development"; //--- ToDo: Localize;
			x = 0.293477 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.413045 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		
		class MainBack: IGUIBack
		{
			idc = 1101;
			x = 0.293477 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.413045 * safezoneW;
			h = 0.473 * safezoneH;
			colorBackground[] = {0.2196,0.2196,0.2196,0.8};
		};
		
		class BGFrame: RscFrame
		{
			idc = 1800;
			text = "Research List"; //--- ToDo: Localize;
			x = 0.29864 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.154892 * safezoneW;
			h = 0.451 * safezoneH;
		};
		class FrameDescrip: RscFrame
		{
			idc = 1801;
			text = "Research Description"; //--- ToDo: Localize;
			x = 0.458695 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.242664 * safezoneW;
			h = 0.396 * safezoneH;
		};
		class FrameButton: RscFrame
		{
			idc = 1802;
			x = 0.458695 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.242664 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
	
	class controls 
	{
		class ListResearch: RscListbox
		{
			idc = 1500;
			x = 0.303803 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.144566 * safezoneW;
			h = 0.418 * safezoneH;
			onLBSelChanged = "GW_RESEARCH_CURRTECH_CHANGED = true";
		};
		
		class BtnResearch : RscButton
		{
			idc = 2403;
			text = "Research"; //--- ToDo: Localize;
			x = 0.572284 * safezoneW + safezoneX;
			y = 0.670074 * safezoneH + safezoneY;
			w = 0.123914 * safezoneW;
			h = 0.033 * safezoneH;
			action = "GW_RESEARCH_SELECTED = true";
		};
		/*
		class BtnBack : RscClickableText
		{
			idc = 1201;
			text = "resources\images\back_button.paa";
			x = 0.680707 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0103261 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			onButtonClick = "closeDialog 60012; [] Spawn {sleep 0.05; createDialog 'UI_Menu'}";
		};
		*/
		class BtnExit : RscClickableText
		{
			idc = 1200;
			text = "resources\images\exit_button.paa";
			x = 0.696197 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0103261 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "closeDialog 60012";
		};
		class TextCommOnly: RscStructuredText
		{
			idc = 1102;
			text = "Commander Only"; //--- ToDo: Localize;
			x = 0.460941 * safezoneW + safezoneX;
			y = 0.669443 * safezoneH + safezoneY;
			w = 0.103261 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
		class TextDescription: RscStructuredText
		{
			idc = 1103;
			x = 0.463859 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.232338 * safezoneW;
			h = 0.363 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
	};
};
