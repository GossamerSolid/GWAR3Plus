/* #Qirula
$[
	1.063,
	["Service",[[0,0,1,1],0.025,0.04,"GUI_GRID"],1,0,0],
	[1100,"Header",[1,"Service Menu",["0.293477 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.413045 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,1,1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"MainBack",[1,"",["0.293477 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.413045 * safezoneW","0.473 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"BGFrame",[1,"Units in Range",["0.29864 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.211686 * safezoneW","0.451 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"",[1,"",["0.303803 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.20136 * safezoneW","0.418 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"",[1,"Service Origin",["0.515489 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.18587 * safezoneW","0.253 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1802,"",[1,"Actions",["0.515489 * safezoneW + safezoneX","0.522 * safezoneH + safezoneY","0.18587 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"BtnBack",[1,"B",["0.680707 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.0103261 * safezoneW","0.022 * safezoneH"],[1,1,1,1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"BtnExit",[1,"X",["0.696197 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.0103261 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"",[1,"",["0.520652 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.175544 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2400,"BtnRepair",[1,"Repair ($xxxxxx)",["0.520652 * safezoneW + safezoneX","0.533 * safezoneH + safezoneY","0.175544 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2401,"BtnRefuel",[1,"Refuel ($xxxxxx)",["0.520652 * safezoneW + safezoneX","0.577 * safezoneH + safezoneY","0.175544 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2402,"BtnRearm",[1,"Rearm ($xxxxxx)",["0.520652 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.175544 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2403,"BtnCMs",[1,"Countermeasures ($xxxxxx)",["0.520652 * safezoneW + safezoneX","0.665 * safezoneH + safezoneY","0.175544 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1202,"",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.520652 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.175544 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class UI_ServiceMenu
{
	movingEnable = 1;
	enableSimulation = 1;
	enableDisplay = 1;
	idd = 60007;
	onLoad = "_this Spawn GUI_ServiceMenu";
	
	class controlsBackground
	{
		class MainBack: IGUIBack
		{
			idc = 1101;
			x = 0.293477 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.413045 * safezoneW;
			h = 0.473 * safezoneH;
			colorBackground[] = {0.2196,0.2196,0.2196,0.8};
		};
	};
	
	class controls 
	{
		class Header: RscStructuredText
		{
			idc = 1100;
			text = "Service Menu"; //--- ToDo: Localize;
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
			w = 0.211686 * safezoneW;
			h = 0.451 * safezoneH;
		};
		class RscFrame_1801: RscFrame
		{
			idc = 1801;
			text = "Service Origin"; //--- ToDo: Localize;
			x = 0.515489 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.18587 * safezoneW;
			h = 0.253 * safezoneH;
		};
		class RscFrame_1802: RscFrame
		{
			idc = 1802;
			text = "Actions"; //--- ToDo: Localize;
			x = 0.515489 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.18587 * safezoneW;
			h = 0.187 * safezoneH;
		};
		class OriginMap : RscMapControl
		{
			idc = 1202;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.520652 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.175544 * safezoneW;
			h = 0.187 * safezoneH;
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.303803 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.20136 * safezoneW;
			h = 0.418 * safezoneH;
			sizeEx = 0.045;
			onLBSelChanged = "if ((lbCurSel 1500) != -1) then {GW_SERVICE_UNITSELECTED = true};";
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
			onButtonClick = "closeDialog 60007; [] Spawn {sleep 0.05; createDialog 'UI_Menu'}";
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
			onButtonClick = "closeDialog 60007";
		};
		class RscCombo_2100: RscCombo
		{
			idc = 2100;
			x = 0.520652 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.175544 * safezoneW;
			h = 0.022 * safezoneH;
			onLBSelChanged = "if ((lbCurSel 2100) != -1) then {GW_SERVICE_ORIGINSELECTED = true};";
		};
		class BtnRepair: RscButton
		{
			idc = 2400;
			text = "Repair"; //--- ToDo: Localize;
			x = 0.520652 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.175544 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_SERVICE_REPAIR = true";
		};
		class BtnRefuel: RscButton
		{
			idc = 2401;
			text = "Refuel"; //--- ToDo: Localize;
			x = 0.520652 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.175544 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_SERVICE_REFUEL = true";
		};
		class BtnRearm: RscButton
		{
			idc = 2402;
			text = "Rearm"; //--- ToDo: Localize;
			x = 0.520652 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.175544 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_SERVICE_REARM = true";
		};
		/*
		class BtnCMs: RscButton
		{
			idc = 2403;
			text = "Countermeasures"; //--- ToDo: Localize;
			x = 0.520652 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.175544 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "";
		};
		*/
	};
};

