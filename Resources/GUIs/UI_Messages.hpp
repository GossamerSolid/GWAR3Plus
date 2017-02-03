/* #Cobusi
$[
	1.063,
	["GW_Messages",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1100,"BG",[1,"",["0.345312 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.304219 * safezoneW","0.44 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"BGFrame",[1,"",["0.345312 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.304219 * safezoneW","0.44 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"TitleFrame",[1,"",["0.350469 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.293906 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"TitleText",[1,"Messages",["0.348386 * safezoneW + safezoneX","0.289148 * safezoneH + safezoneY","0.293906 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]],
	[1802,"ListFrame",[1,"",["0.350469 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.118594 * safezoneW","0.385 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1803,"ContentsFrame",[1,"",["0.474219 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.170156 * safezoneW","0.385 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"BtnClose",[1,"X",["0.632812 * safezoneW + safezoneX","0.29074 * safezoneH + safezoneY","0.0103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"MessagesList",[1,"",["0.355625 * safezoneW + safezoneX","0.335 * safezoneH + safezoneY","0.108281 * safezoneW","0.363 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1102,"ContentsText",[1,"",["0.479375 * safezoneW + safezoneX","0.335 * safezoneH + safezoneY","0.159844 * safezoneW","0.33 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,0],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"BtnDelete",[1,"Delete",["0.479375 * safezoneW + safezoneX","0.676 * safezoneH + safezoneY","0.0309375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"BtnYes",[1,"Accept",["0.603125 * safezoneW + safezoneX","0.676 * safezoneH + safezoneY","0.0360937 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"BtnNo",[1,"Decline",["0.561875 * safezoneW + safezoneX","0.676 * safezoneH + safezoneY","0.0360937 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1604,"BtnBack",[1,"&lt;",["0.618594 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.0103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class UI_Messages
{
	movingEnable = 1;
	enableSimulation = 1;
	enableDisplay = 1;
	idd = 60000;
	onLoad = "_this Spawn UI_Messages";
	
	class controlsBackground 
	{
		class GW_Messages_BG : RscStructuredText
		{
			idc = 1100;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.304219 * safezoneW;
			h = 0.44 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
			colorText[] = {1,1,1,1};
		};
	};
	
	class controls 
	{
		class GW_Messages_BG_Frame : RscStructuredText
		{
			idc = 1800;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.304219 * safezoneW;
			h = 0.44 * safezoneH;
		};
		
		class GW_Messages_TitleFrame: RscFrame
		{
			idc = 1801;
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.293906 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class GW_Messages_TitleText: RscStructuredText
		{
			idc = 1101;
			text = "Messages";
			x = 0.348386 * safezoneW + safezoneX;
			y = 0.289148 * safezoneH + safezoneY;
			w = 0.293906 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		
		class GW_Messages_ListFrame: RscFrame
		{
			idc = 1802;
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.385 * safezoneH;
		};
		
		class GW_Messages_ContentsFrame: RscFrame
		{
			idc = 1803;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.385 * safezoneH;
		};
		
		class GW_Messages_BtnClose: RscButton
		{
			idc = 1600;
			text = "X"; //--- ToDo: Localize;
			x = 0.632812 * safezoneW + safezoneX;
			y = 0.29074 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "GW_MESSAGES_ACTION = 'Close'";
		};
		
		class GW_Messages_MessagesList: RscListbox
		{
			idc = 1500;
			x = 0.355625 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.363 * safezoneH;
			onLBSelChanged = "GW_MESSAGES_ACTION = 'ChangeMessage'";
		};
		
		class GW_Messages_ContentsText: RscStructuredText
		{
			idc = 1102;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.33 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
		
		class GW_Messages_BtnDelete: RscButton
		{
			idc = 1601;
			text = "Delete";
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "GW_MESSAGES_ACTION = 'Delete'";
		};
		
		class GW_Messages_BtnYes: RscButton
		{
			idc = 1602;
			text = "Accept";
			x = 0.603125 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "GW_MESSAGES_ACTION = 'Accept'";
		};
		
		class GW_Messages_BtnNo: RscButton
		{
			idc = 1603;
			text = "Decline";
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "GW_MESSAGES_ACTION = 'Decline'";
		};
		
		class GW_Messages_BtnBack: RscButton
		{
			idc = 1604;
			text = "&lt;";
			x = 0.618594 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "GW_MESSAGES_ACTION = 'Back'";
		};
	};
};

