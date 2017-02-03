/* #Bysomi
$[
	1.063,
	["Voting",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1100,"Header",[1,"Commander Voting",["0.381249 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.211686 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,1,1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"MainBack",[1,"",["0.381249 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.211686 * safezoneW","0.484 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[2400,"AcceptVote",[1,"Vote",["0.536141 * safezoneW + safezoneX","0.742 * safezoneH + safezoneY","0.0567187 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"BGFrame",[1,"",["0.381249 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.211686 * safezoneW","0.484 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"",[1,"",["0.386413 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.20136 * safezoneW","0.275 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1102,"TextCurrentCommander",[1,"Current Commander",["0.382811 * safezoneW + safezoneX","0.25163 * safezoneH + safezoneY","0.206523 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"VoteDetail",[1,"",["0.386413 * safezoneW + safezoneX","0.566 * safezoneH + safezoneY","0.20136 * safezoneW","0.154 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class UI_CommanderVote
{
	movingEnable = 1;
	enableSimulation = 1;
	enableDisplay = 1;
	idd = 60004;
	onLoad = "_this Spawn GUI_CommanderVote";
	
	class controlsBackground
	{
		class MainBack: IGUIBack
		{
			idc = 1101;
			x = 0.381249 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.211686 * safezoneW;
			h = 0.484 * safezoneH;
			colorBackground[] = {0.2196,0.2196,0.2196,0.8};
		};
	};
	
	class controls 
	{
		class Header: RscStructuredText
		{
			idc = 1100;
			text = "Commander Voting"; //--- ToDo: Localize;
			x = 0.381249 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.211686 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
		};
		class AcceptVote: RscButton
		{
			idc = 2400;
			text = "Vote"; //--- ToDo: Localize;
			x = 0.536141 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "GW_COMMVOTE_SELECTED = true";
		};
		class BGFrame: RscFrame
		{
			idc = 1800;
			x = 0.381249 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.211686 * safezoneW;
			h = 0.484 * safezoneH;
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.386413 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.20136 * safezoneW;
			h = 0.275 * safezoneH;
			onLBDblClick = "GW_COMMVOTE_SELECTED = true";
		};
		class VoteDetail: RscListbox
		{
			idc = 1501;
			x = 0.386413 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.20136 * safezoneW;
			h = 0.154 * safezoneH;
		};
		class TextCurrentCommander: RscStructuredText
		{
			idc = 1102;
			text = ""; //--- ToDo: Localize;
			x = 0.382811 * safezoneW + safezoneX;
			y = 0.25163 * safezoneH + safezoneY;
			w = 0.206523 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
	};
};

