/* #Rakini
$[
	1.063,
	["Specializations",[["0","0","1","1"],"0.025","0.04","GUI_GRID"],0,0,0],
	[2200,"MainBack",[1,"",["0.381249 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.242664 * safezoneW","0.55 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"",[1,"Specializations",["0.381249 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.242664 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,1,1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"BtnExit",[1,"X",["0.613587 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.0103261 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"BtnBack",[1,"B",["0.598098 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.0103261 * safezoneW","0.022 * safezoneH"],[1,1,1,1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"FrameList",[1,"Specializations",["0.386413 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.232338 * safezoneW","0.231 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"FrameSpecInfo",[1,"Specialization Information",["0.386413 * safezoneW + safezoneX","0.5 * safezoneH + safezoneY","0.232338 * safezoneW","0.286 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"ListSpec",[1,"",["0.391576 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.222012 * safezoneW","0.198 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"textInformation",[1,"",["0.391576 * safezoneW + safezoneX","0.522 * safezoneH + safezoneY","0.222012 * safezoneW","0.209 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"BtnBuy",[1,"Choose Specialization ($10000)",["0.479347 * safezoneW + safezoneX","0.742 * safezoneH + safezoneY","0.13424 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class UI_Specializations
{
	movingEnable = 1;
	enableSimulation = 1;
	enableDisplay = 1;
	idd = 60010;
	onLoad = "_this Spawn GUI_Specializations";
	
	class controlsBackground
	{
		class MainBack: IGUIBack
		{
			idc = 2200;
			x = 0.381249 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.242664 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0.2196,0.2196,0.2196,0.8};
		};
		class FrameList: RscFrame
		{
			idc = 1800;
			text = "Specializations"; //--- ToDo: Localize;
			x = 0.386413 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.232338 * safezoneW;
			h = 0.231 * safezoneH;
		};
		class FrameSpecInfo: RscFrame
		{
			idc = 1801;
			text = "Specialization Information"; //--- ToDo: Localize;
			x = 0.386413 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.232338 * safezoneW;
			h = 0.286 * safezoneH;
		};
		class HeaderBG : IGUIBack
		{
			idc = 1189;
			x = 0.381249 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.242664 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
		};
		class Header : RscStructuredText
		{
			idc = 1100;
			text = "Specializations"; //--- ToDo: Localize;
			x = 0.381249 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.242664 * safezoneW;
			h = 0.022 * safezoneH;
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
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0103261 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "closeDialog 60010";
		};
		/*
		class BtnBack: RscClickableText
		{
			idc = 1201;
			text = "resources\images\back_button.paa";
			x = 0.598098 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0103261 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			onButtonClick = "closeDialog 60010; [] Spawn {sleep 0.05; createDialog 'UI_Menu'}";
		};
		*/
		class ListSpec: RscListbox
		{
			idc = 1500;
			x = 0.391576 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.222012 * safezoneW;
			h = 0.198 * safezoneH;
			onLBSelChanged = "GW_SPEC_CHANGESEL = true";
		};
		class textInformation: RscStructuredText
		{
			idc = 1101;
			text = "Select a specialization from the list above";
			x = 0.391576 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.222012 * safezoneW;
			h = 0.209 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
		class BtnBuy: RscButton
		{
			idc = 1600;
			text = "Choose Specialization ($10000)";
			x = 0.479347 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.13424 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_SPEC_CHOOSE = true;";
		};
	};
};

