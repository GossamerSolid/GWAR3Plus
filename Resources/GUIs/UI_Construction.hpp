/* #Qupive
$[
	1.063,
	["Construction",[["0","0","1","1"],"0.025","0.04","GUI_GRID"],1,0,0],
	[2200,"MainBack",[1,"",["0.195378 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.624731 * safezoneW","0.55 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"",[1,"Construction",["0.195379 * safezoneW + safezoneX","0.203 * safezoneH + safezoneY","0.624731 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,1,1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"CategoriesFrame",[1,"Build Structures",["0.200542 * safezoneW + safezoneX","0.236 * safezoneH + safezoneY","0.304621 * safezoneW","0.528 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"BtnExit",[1,"X",["0.809784 * safezoneW + safezoneX","0.203 * safezoneH + safezoneY","0.0103261 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"BtnBack",[1,"B",["0.794295 * safezoneW + safezoneX","0.203 * safezoneH + safezoneY","0.0103261 * safezoneW","0.022 * safezoneH"],[1,1,1,1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"ListBuyStructures",[1,"",["0.205705 * safezoneW + safezoneX","0.302 * safezoneH + safezoneY","0.294295 * safezoneW","0.407 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1802,"FrameStructure",[1,"Disband Structures",["0.510326 * safezoneW + safezoneX","0.236 * safezoneH + safezoneY","0.304621 * safezoneW","0.528 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1206,"StructureMap",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.515489 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.294295 * safezoneW","0.198 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2400,"BtnDisbandStructure",[1,"Disband Structure",["0.695586 * safezoneW + safezoneX","0.722111 * safezoneH + safezoneY","0.113587 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"ListDisbandStructures",[1,"",["0.515489 * safezoneW + safezoneX","0.467926 * safezoneH + safezoneY","0.294295 * safezoneW","0.242 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2401,"CategoryBase",[1,"Base",["0.210868 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.0877721 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2402,"CategoryDef",[1,"Defenses",["0.311571 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.0877721 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2403,"CategoryMisc",[1,"Miscellaneous",["0.412228 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.0877721 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2404,"BtnPlaceStructure",[1,"Place Structure",["0.386413 * safezoneW + safezoneX","0.72 * safezoneH + safezoneY","0.113587 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class UI_Construction
{
	movingEnable = 1;
	enableSimulation = 1;
	enableDisplay = 1;
	idd = 60001;
	onLoad = "_this Spawn GUI_Construction";
	
	class controlsBackground
	{
		class MainBack: IGUIBack
		{
			idc = 2200;
			x = 0.195378 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.624731 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0.2196,0.2196,0.2196,0.8};
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;
			text = "Construction"; //--- ToDo: Localize;
			x = 0.195379 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.624731 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
		};
		class CategoriesFrame: RscFrame
		{
			idc = 1800;
			text = "Build Structures"; //--- ToDo: Localize;
			x = 0.200542 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.304621 * safezoneW;
			h = 0.528 * safezoneH;
		};
		class FrameStructure: RscFrame
		{
			idc = 1802;
			text = "Disband Structures"; //--- ToDo: Localize;
			x = 0.510326 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.304621 * safezoneW;
			h = 0.528 * safezoneH;
		};
	};
	
	class controls
	{
		class BtnExit: RscClickableText
		{
			idc = 1200;
			text = "resources\images\exit_button.paa";
			x = 0.809784 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.0103261 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "closeDialog 60001";
		};
		/*
		class BtnBack: RscClickableText
		{
			idc = 1201;
			text = "resources\images\back_button.paa";
			x = 0.794295 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.0103261 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			onButtonClick = "closeDialog 60001; [] Spawn {sleep 0.05; createDialog 'UI_Menu'}";
		};
		*/
		class ListBuyStructures: RscListbox
		{
			idc = 1500;
			x = 0.205705 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.294295 * safezoneW;
			h = 0.407 * safezoneH;
			style = LB_TEXTURES;
			rowHeight = 0.08;
			colorText[] = {1,1,1,1};
			onLBDblClick = "GW_CONSTRUCT_BUILDINGSEL = true";
		};
		class StructureMap: RscMapControl
		{
			idc = 1206;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.515489 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.294295 * safezoneW;
			h = 0.198 * safezoneH;
		};
		class BtnDisbandStructure: RscButton
		{
			idc = 2400;
			text = "Disband Structure"; //--- ToDo: Localize;
			x = 0.695586 * safezoneW + safezoneX;
			y = 0.722111 * safezoneH + safezoneY;
			w = 0.113587 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_CONSTRUCT_BUILDINGDISBANDSEL = true";
		};
		class ListDisbandStructures: RscListbox
		{
			idc = 1501;
			x = 0.515489 * safezoneW + safezoneX;
			y = 0.467926 * safezoneH + safezoneY;
			w = 0.294295 * safezoneW;
			h = 0.242 * safezoneH;
			style = LB_TEXTURES;
			rowHeight = 0.08;
			colorText[] = {1,1,1,1};
			onLBSelChanged = "if ((lbCurSel 1501) != -1) then {GW_CONSTRUCT_DISBANDUPDATE = true};";
			onLBDblClick = "GW_CONSTRUCT_BUILDINGDISBANDSEL = true";
		};
		class CategoryBase: RscButton
		{
			idc = 2401;
			text = "Base"; //--- ToDo: Localize;
			x = 0.210868 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.0877721 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_CONSTRUCT_BUILDCAT = ""Base""";
		};
		class CategoryDef: RscButton
		{
			idc = 2402;
			text = "Defenses"; //--- ToDo: Localize;
			x = 0.311571 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.0877721 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_CONSTRUCT_BUILDCAT = ""Defenses""";
		};
		class CategoryMisc: RscButton
		{
			idc = 2403;
			text = "Miscellaneous"; //--- ToDo: Localize;
			x = 0.412228 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.0877721 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_CONSTRUCT_BUILDCAT = ""Other""";
		};
		class BtnPlaceStructure: RscButton
		{
			idc = 2404;
			text = "Place Structure"; //--- ToDo: Localize;
			x = 0.386413 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.113587 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_CONSTRUCT_BUILDINGSEL = true";
		};
	};
	
	/*
	class controls 
	{
		class BuildingList: RscListbox
		{
			idc = 1500;
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.484 * safezoneH;
			style = LB_TEXTURES;
			rowHeight = 0.08;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.2196,0.2196,0.2196,0.8};
			onLBDblClick = "GW_CONSTRUCT_BUILDINGSEL = true";
		};
		class Category_Base : RscButton
		{
			idc = 2400;
			text = "Base"; //--- ToDo: Localize;
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_CONSTRUCT_BUILDCAT = ""Base""";
		};
		class Category_Defenses : RscButton
		{
			idc = 2401;
			text = "Def"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_CONSTRUCT_BUILDCAT = ""Defenses""";
		};
		class Category_Other : RscButton
		{
			idc = 2402;
			text = "Other"; //--- ToDo: Localize;
			x = 0.948594 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_CONSTRUCT_BUILDCAT = ""Other""";
		};
		class BuildingsText: RscStructuredText
		{
			idc = 1104;
			text = "HelpText";
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.198 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {-1,-1,-1,0};
		};
	};
	*/
};

