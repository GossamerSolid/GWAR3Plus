/* #Qyrexa
$[
	1.063,
	["Attach",[[0,0,1,1],0.025,0.04,"GUI_GRID"],1,0,0],
	[1100,"Header",[1,"Attach",["0.293477 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.413045 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,1,1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"MainBack",[1,"",["0.293477 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.413045 * safezoneW","0.176 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"BGFrame",[1,"Units in Range",["0.29864 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.402719 * safezoneW","0.154 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"",[1,"",["0.303803 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.392393 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"BtnBack",[1,"B",["0.680707 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.0103261 * safezoneW","0.022 * safezoneH"],[1,1,1,1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"BtnExit",[1,"X",["0.696197 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.0103261 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2400,"BtnAttach",[1,"Attach %s",["0.303803 * safezoneW + safezoneX","0.3724 * safezoneH + safezoneY","0.392393 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class UI_Attach
{
	movingEnable = 1;
	enableSimulation = 1;
	enableDisplay = 1;
	idd = 60013;
	onLoad = "_this Spawn GUI_Attach";
	onUnload = "GW_ATTACH_CAMERA cameraEffect ['TERMINATE', 'BACK']; camDestroy GW_ATTACH_CAMERA";
	
	class controlsBackground
	{
		class MainBack: IGUIBack
		{
			idc = 1101;
			x = 0.293477 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.413045 * safezoneW;
			h = 0.176 * safezoneH;
			colorBackground[] = {0.2196,0.2196,0.2196,0.8};
		};
		class Header: RscStructuredText
		{
			idc = 1100;
			text = "Attach"; //--- ToDo: Localize;
			x = 0.293477 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.413045 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
		};
		class BGFrame: RscFrame
		{
			idc = 1800;
			text = "Units in Range"; //--- ToDo: Localize;
			x = 0.29864 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.402719 * safezoneW;
			h = 0.154 * safezoneH;
		};
	};
	
	class controls 
	{
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.303803 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.392393 * safezoneW;
			h = 0.088 * safezoneH;
			sizeEx = 0.045;
			onLBSelChanged = "if ((lbCurSel 1500) != -1) then {GW_ATTACH_OBJSELECTED = true};";
		};
		/*
		class BtnBack: RscClickableText
		{
			idc = 1201;
			text = "resources\images\back_button.paa";
			x = 0.680707 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0103261 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "closeDialog 60013; [] Spawn {sleep 0.05; createDialog 'UI_Menu'}";
		};
		*/
		class BtnExit: RscClickableText
		{
			idc = 1200;
			text = "resources\images\exit_button.paa";
			x = 0.696197 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0103261 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "closeDialog 60013";
		};
		class BtnAttach : RscButton
		{
			idc = 2400;
			text = "Attach"; //--- ToDo: Localize;
			x = 0.303803 * safezoneW + safezoneX;
			y = 0.3724 * safezoneH + safezoneY;
			w = 0.392393 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_ATTACH_PERFORMATTACH = true";
		};
	};
};

