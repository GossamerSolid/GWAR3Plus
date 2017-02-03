/* #Hokyso
$[
	1.063,
	["Deployment",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1100,"DeploymentText",[1,"Deployment Available in x Seconds",["0.293477 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.413045 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class GW_DeployScreen
{
	idd = 800;
	movingEnable = 0;
	objects[] = {};
	duration = 15000;
	name = "GW_DeployScreen";
	onLoad = "[""gwar3deploy"", _this Select 0] call fnc_clt_setGUI;";
	onUnload = "[""gwar3deploy"", displayNull] call fnc_clt_setGUI;";
	controlsBackground[] = {};
	controls[] = 
	{
		"DeploymentText"
	};

	class DeploymentText : RscStructuredText
	{
		idc = 1100;
		text = "";
		x = 0.293477 * safezoneW + safezoneX;
		y = 0.445 * safezoneH + safezoneY;
		w = 0.413045 * safezoneW;
		h = 0.066 * safezoneH;
		colorBackground[] = {-1,-1,-1,0};
	};
};