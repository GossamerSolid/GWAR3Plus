/* #Wyhamy
$[
	1.063,
	["Menu",[[0,0,1,1],0.025,0.04,"GUI_GRID"],1,0,0],
	[1108,"",[1,"",["0.334782 * safezoneW + safezoneX","0.203 * safezoneH + safezoneY","0.335599 * safezoneW","0.506 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"",[1,"",["0.334782 * safezoneW + safezoneX","0.203 * safezoneH + safezoneY","0.335599 * safezoneW","0.506 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"BtnConstruction",[1,"Construction",["0.355434 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.144566 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"BtnPurchaseUnits",[1,"Purchase Units",["0.505163 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.144566 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"BtnPurchaseEquipment",[1,"Purchase Equipment",["0.355434 * safezoneW + safezoneX","0.522 * safezoneH + safezoneY","0.144566 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"BtnCommanderVoting",[1,"Commander Voting",["0.505163 * safezoneW + safezoneX","0.522 * safezoneH + safezoneY","0.144566 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1604,"BtnServiceMenu",[1,"Service Menu",["0.355434 * safezoneW + safezoneX","0.566 * safezoneH + safezoneY","0.144566 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1605,"BtnSquad",[1,"Squad",["0.505163 * safezoneW + safezoneX","0.566 * safezoneH + safezoneY","0.144566 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1606,"BtnServerInformation",[1,"Server Information",["0.355434 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.144566 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1607,"BtnSpec",[1,"Specializations",["0.355434 * safezoneW + safezoneX","0.61 * safezoneH + safezoneY","0.144566 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1608,"BtnResearch",[1,"Research and Development",["0.505163 * safezoneW + safezoneX","0.61 * safezoneH + safezoneY","0.144566 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1609,"BtnClientSettings",[1,"Client Settings",["0.505163 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.144566 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1107,"",[1,"Created by GossamerSolid - http://www.Gwar3.com",["0.386413 * safezoneW + safezoneX","0.412 * safezoneH + safezoneY","0.232338 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"GWAR3Logo",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.386413 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.232338 * safezoneW","0.176 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class UI_Menu
{
	movingEnable = 1;
	enableSimulation = 1;
	enableDisplay = 1;
	idd = 60006;
	onLoad = "_this Spawn GUI_Menu";
	class controlsBackground
	{
		class MainBack: IGUIBack
		{
			idc = 1108;
			x = 0.334782 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.335599 * safezoneW;
			h = 0.506 * safezoneH;
			colorBackground[] = {0.2196,0.2196,0.2196,0.8};
		};
		class RscFrame_1800: RscFrame
		{
			idc = 1800;
			x = 0.334782 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.335599 * safezoneW;
			h = 0.506 * safezoneH;
		};
	};
	
	class controls
	{
		class GWAR3Logo: RscPicture
		{
			idc = 1200;
			text = "Resources\images\gwar3_logo.paa";
			x = 0.386413 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.232338 * safezoneW;
			h = 0.176 * safezoneH;
		};
		class RscStructuredText_1107: RscStructuredText
		{
			idc = 1107;
			text = "Created by GossamerSolid - http://www.Gwar3.com"; //--- ToDo: Localize;
			x = 0.386413 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.232338 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class BtnConstruction: RscButton
		{
			idc = 1600;
			text = "Construction"; //--- ToDo: Localize;
			x = 0.355434 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.144566 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "closeDialog 60006; createDialog 'UI_Construction'";
		};
		class BtnPurchaseUnits: RscButton
		{
			idc = 1601;
			text = "Purchase Units"; //--- ToDo: Localize;
			x = 0.505163 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.144566 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "closeDialog 60006; createDialog 'UI_UnitPurchasing'";
		};
		class BtnPurchaseEquipment: RscButton
		{
			idc = 1602;
			text = "Purchase Equipment"; //--- ToDo: Localize;
			x = 0.355434 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.144566 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "closeDialog 60006; createDialog 'UI_Equipment'";
		};
		class BtnCommanderVoting: RscButton
		{
			idc = 1603;
			text = "Commander Voting"; //--- ToDo: Localize;
			x = 0.505163 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.144566 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "closeDialog 60006; createDialog 'UI_CommanderVote'";
		};
		class BtnServiceMenu: RscButton
		{
			idc = 1604;
			text = "Service Menu"; //--- ToDo: Localize;
			x = 0.355434 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.144566 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "closeDialog 60006; createDialog 'UI_ServiceMenu'";
		};
		class BtnSquad: RscButton
		{
			idc = 1605;
			text = "Squad"; //--- ToDo: Localize;
			x = 0.505163 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.144566 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "closeDialog 60006; createDialog 'UI_Squad'";
		};
		class BtnSpec: RscButton
		{
			idc = 1607;
			text = "Specializations"; //--- ToDo: Localize;
			x = 0.355434 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.144566 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "closeDialog 60006; createDialog 'UI_Specializations'";
		};
		class BtnResearch: RscButton
		{
			idc = 1608;
			text = "Research and Development"; //--- ToDo: Localize;
			x = 0.505163 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.144566 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "closeDialog 60012; createDialog 'UI_Research'";
		};
		class BtnServerInformation: RscButton
		{
			idc = 1606;
			text = "Server Information"; //--- ToDo: Localize;
			x = 0.355434 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.144566 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "closeDialog 60006; createDialog 'UI_ServerInfo'";
		};
		class BtnClientSettings: RscButton
		{
			idc = 1609;
			text = "Client Settings"; //--- ToDo: Localize;
			x = 0.505163 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.144566 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "closeDialog 60006; createDialog 'UI_ClientSettings'";
		};
	};
};