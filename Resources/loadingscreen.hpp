/* #Wevuma
$[
	1.063,
	["LoadingScreen",[[0,0,1,1],0.025,0.04,"GUI_GRID"],1,0,0],
	[1100,"",[1,"Created By: GossamerSolid - http://Gwar3.com",["0.40086 * safezoneW + safezoneX","0.538556 * safezoneH + safezoneY","0.206523 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"GWAR3Logo",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.386413 * safezoneW + safezoneX","0.302 * safezoneH + safezoneY","0.232338 * safezoneW","0.198 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"VersionInfo",[1,"v0.02.00381",["0.406544 * safezoneW + safezoneX","0.514593 * safezoneH + safezoneY","0.191033 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]],
	[1102,"LoadingBar",[1,"",["0.407065 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.191033 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1103,"Loading Text",[1,"Waiting for Server",["0.407065 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.191033 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]],
	[1104,"FailText",[1,"",["0.293478 * safezoneW + safezoneX","0.588 * safezoneH + safezoneY","0.413045 * safezoneW","0.341 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class GW_LoadingScreen
{
	idd = 700;
	movingEnable = 0;
	objects[] = {};
	duration = 15000;
	name = "GW_LoadingScreen";
	onLoad = "[""gwar3loading"", _this Select 0] call fnc_clt_setGUI;";
	onUnload = "[""gwar3loading"", displayNull] call fnc_clt_setGUI;";
	controlsBackground[] = {};
	controls[] = 
	{
		"CreatedBy",
		"GWAR3Logo",
		"VersionInfo",
		"LoadingBar",
		"LoadingText",
		"FailText"
	};
	
	class CreatedBy : RscStructuredText
	{
		idc = 1100;
		text = ""; //--- ToDo: Localize;
		x = 0.40086 * safezoneW + safezoneX;
		y = 0.538556 * safezoneH + safezoneY;
		w = 0.206523 * safezoneW;
		h = 0.022 * safezoneH;
		colorBackground[] = {-1,-1,-1,0};
	};
	class GWAR3Logo : RscPicture
	{
		idc = 1200;
		text = "Resources\images\gwar3_logo.paa";
		x = 0.386413 * safezoneW + safezoneX;
		y = 0.302 * safezoneH + safezoneY;
		w = 0.232338 * safezoneW;
		h = 0.198 * safezoneH;
	};
	class VersionInfo : RscStructuredText
	{
		idc = 1101;
		text = ""; //--- ToDo: Localize;
		x = 0.406544 * safezoneW + safezoneX;
		y = 0.514593 * safezoneH + safezoneY;
		w = 0.191033 * safezoneW;
		h = 0.022 * safezoneH;
		colorBackground[] = {-1,-1,-1,0};
	};
	class LoadingBar : RscProgress
	{
		idc = 1102;
		x = 0.407065 * safezoneW + safezoneX;
		y = 0.621 * safezoneH + safezoneY;
		w = 0.191033 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class LoadingText : RscStructuredText
	{
		idc = 1103;
		text = ""; //--- ToDo: Localize;
		x = 0.407065 * safezoneW + safezoneX;
		y = 0.621 * safezoneH + safezoneY;
		w = 0.191033 * safezoneW;
		h = 0.022 * safezoneH;
		colorBackground[] = {-1,-1,-1,0};
	};
	class FailText : RscStructuredText
	{
		idc = 1104;
		x = 0.293478 * safezoneW + safezoneX;
		y = 0.588 * safezoneH + safezoneY;
		w = 0.413045 * safezoneW;
		h = 0.341 * safezoneH;
		colorBackground[] = {-1,-1,-1,0};
	};
};