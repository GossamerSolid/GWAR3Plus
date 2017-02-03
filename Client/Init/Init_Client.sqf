//Init_Client.sqf
//Written by: GossamerSolid
//Initializes all required components client side

if (!(!isDedicated)) exitWith {diag_log text "###[GW ERROR] - Client\Init\Init_Client.sqf must only be called client-side."};

diag_log text "###[GW LOG] - Client initialization started.";

//Track how much time it took to initialize the client
_clientStartInitTime = time;

//Handling them GUIs
fnc_clt_setGUI = CompileFinal "UInamespace setVariable [_this select 0, _this select 1];";
fnc_clt_getGUI = CompileFinal "UInamespace getVariable (_this select 0);";

//Client version
GW_CVAR_VERSION_CLIENT = "v01024";

//Loading Screen
_camPos = (getMarkerPos "CameraSpot");
GW_CVAR_CLIENTCAMERA = "camera" camCreate [_camPos select 0, _camPos select 1, 300];
GW_CVAR_CLIENTCAMERA setDir 180; 
GW_CVAR_CLIENTCAMERA camSetFOV 1;
GW_CVAR_CLIENTCAMERA cameraEffect["Internal","Back"];
GW_CVAR_CLIENTCAMERA camCommit 0;
showCinemaBorder false;
waitUntil {camCommitted GW_CVAR_CLIENTCAMERA};

CutRsc ["GW_LoadingScreen", "PLAIN", 0, false];
((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1100) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Created By: GossamerSolid - http://Gwar3.com</t>"]);
((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1101) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>%1</t>", GW_CVAR_VERSION_CLIENT]);
((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Waiting on Server</t>"]);
((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 0;
waitUntil {!isNull player};

//Wait for the server to finish initialization
waitUntil {!isNil "GW_SERVERINIT"};
waitUntil {GW_SERVERINIT};

//If the client version doesn't match the server, we don't want to go any further
_counter = 5;
while {isNil "GW_GVAR_VERSION_SERVER" && _counter > 0} do
{
	sleep 1;
	_counter = _counter - 1;
};
if (isNil "GW_GVAR_VERSION_SERVER") then {GW_GVAR_VERSION_SERVER = "Unknown"};

if (GW_CVAR_VERSION_CLIENT != GW_GVAR_VERSION_SERVER) exitWith
{
	_badText = format["Fatal Error - Client and Server versions mismatch!<br /><br />Client Version - %1<br />Server Version - %2<br /><br />Please contact server administrator.",GW_CVAR_VERSION_CLIENT, GW_GVAR_VERSION_SERVER];
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlShow false;
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) ctrlShow false;
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1104) ctrlSetStructuredText (parseText format["<t shadow='1' align='center' font='PuristaMedium' color='#FFFFFF'>%1</t>",_badText]);
};

//Shared init
_sharedInit = CompileFinal preprocessFileLineNumbers "Shared\Init\Init_Shared.sqf";
_shareInitCall = [] Spawn _sharedInit;
waitUntil {scriptDone _shareInitCall};

//Networking functions
fnc_clt_requestServerData = CompileFinal preprocessFileLineNumbers "Client\Networking\fnc_requestServerData.sqf";
fnc_clt_requestServerExec = CompileFinal preprocessFileLineNumbers "Client\Networking\fnc_requestServerExec.sqf";
fnc_clt_serverFncExec = CompileFinal preprocessFileLineNumbers "Client\Networking\fnc_serverFncExec.sqf";

//Server remote execution
GW_SERVER_FNC_EXEC = [];
"GW_SERVER_FNC_EXEC" addPublicVariableEventHandler
{
	(_this select 1) Spawn fnc_clt_serverFncExec;
};

//Tell the server that we have connected
["client", "connected" ,[(getPlayerUID player), (name player)]] Spawn fnc_clt_requestServerExec;

//Wait until we got our stuff loaded
//12452 cutText [format["%1%2",GW_SPLASH,"Initializing Client..."],"BLACK FADED",999999];
waitUntil {player == player};
((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Waiting for Session Initialization</t>"]);
((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 0.3;
waitUntil {!isNil "GW_CVAR_ACCOUNT_LOADED"};
((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Waiting for Session Data</t>"]);
((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 0.32;
waitUntil {!isNil "GW_CVAR_ACCOUNT_CONTAINER"};
((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Reading Session Data</t>"]);
((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 0.35;
waitUntil {GW_CVAR_ACCOUNT_LOADED select 0};

//Player side
GW_CVAR_SIDE = side player;

//If there's a message attached to the loaded, don't proceed
if ((GW_CVAR_ACCOUNT_LOADED select 1) != "") then
{
	//Hide other loading screen stuff and show fail text
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlShow false;
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) ctrlShow false;
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1104) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>%1%2</t>",format["%1%2",(GW_CVAR_ACCOUNT_LOADED select 1),format["Returning to Lobby in %1 seconds",60]]]);
	
	//60 seconds till auto-returned to lobby
	_kickTimer = 60;
	
	//Display message
	while {_kickTimer > 1} do
	{
		_kickTimer = _kickTimer - 1;
		sleep 1;
		((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1104) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>%1%2</t>",format["%1%2",(GW_CVAR_ACCOUNT_LOADED select 1),format["Returning to Lobby in %1 seconds",_kickTimer]]]);
	};
	
	//Close Camera
	GW_CVAR_CLIENTCAMERA cameraEffect ["TERMINATE", "BACK"];
	camDestroy GW_CVAR_CLIENTCAMERA;
	
	//Return to lobby
	endMission "END1";
}
else
{
	//Call Shared Initialization (Use Call instead of Spawn so that the thread only continues AFTER shared has been init on the client)
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Shared Logic Initialization</t>"]);
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 0.4;

	//Compile Client Functions (Always use CompileFinal)
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Client Function Definitions</t>"]);
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 0.5;
	_fnc_clt_clientUpdate = CompileFinal preprocessFileLineNumbers "Client\Client_Update.sqf";
	fnc_clt_updateGUI = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_updateGUI.sqf";
	fnc_clt_messages = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_messages.sqf";
	fnc_clt_campCaptured = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_campCaptured.sqf";
	fnc_clt_zoneCaptured = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_zoneCaptured.sqf";
	fnc_clt_structureCreated = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_structureCreated.sqf";
	fnc_clt_structureDestroyed = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_structureDestroyed.sqf";
	fnc_clt_structureDamaged = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_structureDamaged.sqf";
	fnc_clt_endGame = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_endGame.sqf";
	fnc_clt_structureTeamkilled = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_structureTeamkilled.sqf";
	fnc_clt_canBuild = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_canBuild.sqf";
	fnc_clt_playerKilled = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_playerKilled.sqf";
	fnc_clt_drawMapMarkers = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_drawMapMarkers.sqf";
	fnc_clt_commanderVoted = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_commanderVoted.sqf";
	fnc_clt_commanderVoteStart = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_commanderVoteStart.sqf";
	fnc_clt_commanderDisconnected = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_commanderDisconnected.sqf";
	fnc_clt_objectBlockingConstruction = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_objectBlockingConstruction.sqf";
	fnc_clt_showNotification = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_showNotification.sqf";
	fnc_clt_buildFriendlyMarkers = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_buildFriendlyMarkers.sqf";
	fnc_clt_addPlayerActions = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_addPlayerActions.sqf";
	fnc_clt_commTowerBuilt = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_commTowerBuilt.sqf";
	fnc_clt_commTowerDestroyed = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_commTowerDestroyed.sqf";
	fnc_clt_getNearbyStructures = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_getNearbyStructures.sqf";
	fnc_clt_drawScreenText = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_drawScreenText.sqf";
	fnc_clt_closeAllDialogs = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_closeAllDialogs.sqf";
	fnc_clt_attachKeyhandlers = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_attachKeyhandlers.sqf";
	fnc_clt_initMapMarkers = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_initMapMarkers.sqf";
	fnc_clt_getStructureArray = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_getStructureArray.sqf";
	fnc_clt_specialForcesCallIn = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_specialForcesCallIn.sqf";
	fnc_clt_healUnit = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_healUnit.sqf";
	fnc_clt_repairVehicle = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_repairVehicle.sqf";
	fnc_clt_salvageVehicle = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_salvageVehicle.sqf";
	fnc_clt_isCommander = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_isCommander.sqf";
	fnc_clt_updateMarkedObjects = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_updateMarkedObjects.sqf";
	fnc_clt_canBuildSupport = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_canBuildSupport.sqf";
	fnc_clt_getVehicleCrewUI = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_getVehicleCrewUI.sqf";
	fnc_clt_detachVehicle = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_detachVehicle.sqf";
	fnc_clt_draw3DMarkers = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_draw3DMarkers.sqf";
	fnc_clt_updateZoneMarkers = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_updateZoneMarkers.sqf";
	fnc_clt_handleActionMenu = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_handleActionMenu.sqf";
	fnc_clt_updateActions = CompileFinal preprocessFileLineNumbers "Client\Functions\fnc_updateActions.sqf";
	
	//Client GUIs
	GUI_CommanderVote = CompileFinal preprocessFileLineNumbers "Client\UI\UI_CommanderVote.sqf";
	GUI_Construction = CompileFinal preprocessFileLineNumbers "Client\UI\UI_Construction.sqf";
	GUI_Deployment = CompileFinal preprocessFileLineNumbers "Client\UI\UI_Deployment.sqf";
	GUI_Equipment = CompileFinal preprocessFileLineNumbers "Client\UI\UI_PurchaseEquipment.sqf";
	GUI_UnitPurchasing = CompileFinal preprocessFileLineNumbers "Client\UI\UI_PurchaseUnits.sqf";
	GUI_ServiceMenu = CompileFinal preprocessFileLineNumbers "Client\UI\UI_ServiceMenu.sqf";
	GUI_Menu = CompileFinal preprocessFileLineNumbers "Client\UI\UI_Menu.sqf";
	GUI_Squad = CompileFinal preprocessFileLineNumbers "Client\UI\UI_Squad.sqf";
	GUI_ServerInfo = CompileFinal preprocessFileLineNumbers "Client\UI\UI_ServerInfo.sqf";
	GUI_Specializations = CompileFinal preprocessFileLineNumbers "Client\UI\UI_Specializations.sqf";
	GUI_CommanderRedeploy = CompileFinal preprocessFileLineNumbers "Client\UI\UI_CommanderRedeploy.sqf";
	GUI_Research = CompileFinal preprocessFileLineNumbers "Client\UI\UI_Research.sqf";
	GUI_Attach = CompileFinal preprocessFileLineNumbers "Client\UI\UI_Attach.sqf";
	GUI_ClientSettings = CompileFinal preprocessFileLineNumbers "Client\UI\UI_ClientSettings.sqf";

	//Client globals (These should only be changed in Client_Update.sqf or via a PV from the srv - But can be read globally on the client)
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Client Globals</t>"]);
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 0.55;
	GW_CVAR_ZONE = [];
	GW_CVAR_CAMP = [];
	GW_CVAR_FRIENDLYMARKERS = [];
	GW_CVAR_MONEY = GW_CVAR_ACCOUNT_CONTAINER select 0;
	if (isNil "GW_CVAR_TEAMSUPPLY") then {GW_CVAR_TEAMSUPPLY = 0};
	if (isNil "GW_CVAR_MHQ") then {GW_CVAR_MHQ = objNull};
	if (isNil "GW_CVAR_COMMANDER") then {GW_CVAR_COMMANDER = "nil"};
	if (isNil "GW_CVAR_MONEY_INCOME") then {GW_CVAR_MONEY_INCOME = 0};
	if (isNil "GW_CVAR_TEAMSUPPLY_INCOME") then {GW_CVAR_TEAMSUPPLY_INCOME = 0};
	if (isNil "GW_CVAR_MAXSQUADSIZE") then {GW_CVAR_MAXSQUADSIZE = 0};
	if (isNil "GW_CVAR_RANK_INFO") then {GW_CVAR_RANK_INFO = ["private", 100, 100]};
	if (isNil "GW_CVAR_SUPPORTVEH") then {GW_CVAR_SUPPORTVEH = []};
	if (isNil "GW_CVAR_SPAWNVEH") then {GW_CVAR_SPAWNVEH = []};
	if (isNil "GW_CVAR_PLAYERMARKERS") then {GW_CVAR_PLAYERMARKERS = []};
	if (isNil "GW_CVAR_VEHICLES") then {GW_CVAR_VEHICLES = []};
	if (isNil "GW_TICKETS_WEST") then {GW_TICKETS_WEST = 0};
	if (isNil "GW_TICKETS_EAST") then {GW_TICKETS_EAST = 0};
	if (isNil "GW_TICKETS_WEST_BLEED") then {GW_TICKETS_WEST_BLEED = 0};
	if (isNil "GW_TICKETS_EAST_BLEED") then {GW_TICKETS_EAST_BLEED = 0};
	if (isNil "GW_CVAR_BUILDINGS_BASE") then {GW_CVAR_BUILDINGS_BASE = []};
	if (isNil "GW_CVAR_BUILDINGS_DEF") then {GW_CVAR_BUILDINGS_DEF = []};
	if (isNil "GW_CVAR_RADARMARKERS") then {GW_CVAR_RADARMARKERS = []};
	if (isNil "GW_TIME_ELAPSED") then {GW_TIME_ELAPSED = 0};
	if (isNil "GW_CVAR_COMMVOTE_TIME") then {GW_CVAR_COMMVOTE_TIME = 0};
	GW_CVAR_HQ_INRANGE = false;
	GW_CVAR_HQ_PIC = "";
	GW_CVAR_BARRACKS_INRANGE = false;
	GW_CVAR_BARRACKS_PIC = "";
	GW_CVAR_LIGHT_INRANGE = false;
	GW_CVAR_LIGHT_PIC = "";
	GW_CVAR_HEAVY_INRANGE = false;
	GW_CVAR_HEAVY_PIC = "";
	GW_CVAR_AIR_INRANGE = false;
	GW_CVAR_AIR_PIC = "";
	GW_CVAR_COMMTOWER_INRANGE = false;
	GW_CVAR_COMMTOWER_PIC = "";
	GW_CVAR_SERVICE_INRANGE = false;
	GW_CVAR_SERVICE_PIC = "";
	GW_CVAR_RESEARCH_INRANGE = false;
	GW_CVAR_RESEARCH_PIC = "";
	GW_CVAR_DEATH_POS = getMarkerPos "CenterPoint";
	GW_PUREQUIP_WEAP_PRIMARY = [];
	GW_PUREQUIP_WEAP_SECONDARY = [];
	GW_PUREQUIP_WEAP_SIDEARM = [];
	GW_PUREQUIP_MAGAZINES = [];
	GW_PUREQUIP_ATTACHMENTS = [];
	GW_PUREQUIP_HEADGEAR = [];
	GW_PUREQUIP_VESTS = [];
	GW_PUREQUIP_UNIFORMS = [];
	GW_PUREQUIP_BACKPACKS = [];
	GW_PUREQUIP_FACEWEAR = [];
	GW_PUREQUIP_OTHERS = [];
	GW_PUREQUIP_FULLLIST = [];
	GW_UNITPUR_LIGHTLIST = [];
	GW_UNITPUR_HEAVYLIST = [];
	GW_UNITPUR_AIRLIST = [];
	GW_UNITPUR_ZONELIST = [];
	GW_UNITPUR_INFANTRYLIST = [];
	GW_CONSTRUCT_BASESTRUCT = [];
	GW_CONSTRUCT_DEFSTRUCT = [];
	GW_CONSTRUCT_MISCSTRUCT = [];
	GW_CVAR_TEMPLATES = [];
	GW_CVAR_MINIMAP_ZOOM = 0.03;
	GW_CVAR_MINIMAP_SHOW = true;
	GW_CVAR_WATCHPOS = [0,0,0];
	GW_CVAR_DIR = 0;
	GW_CVAR_ASL = 0;
	GW_CVAR_GRIDREF = 0;
	GW_CVAR_ACTION = [];
	GW_CVAR_SPECIALIZATION_TIME = -1;
	GW_CVAR_MARKEDOBJECTS = [];
	GW_CVAR_VEHICLECREW_TEXT = "";
	GW_CONSTRUCT_HELPERTEXT = format["<t align='left' font='PuristaMedium' color='#FFFFFF'>Structure Placement Help<br/><br/>CTRL + Left Arrow - Rotate Left<br/>CTRL + Right - Rotate Right<br/>CTRL + Down Arrow - Lower<br/>CTRL + Up Arrow - Raise<br/>ESC - Cancel placement<br/>Left-Click - Confirm placement"];
	GW_CVAR_TERRAIN_VD = GW_GVAR_VIEWDISTANCE;
	GW_CVAR_OBJECT_VD = GW_GVAR_OBJVIEWDISTANCE;
	GW_CVAR_SHADOW_VD = GW_GVAR_SHADOWDISTANCE;
	GW_CVAR_3DMARKERS = true;
	GW_CVAR_MARKERUPDATE_RATE = 0.5;
	GW_CVAR_3DMARKER_ALPHA = 1;
	GW_CVAR_ZONEMARKERS = [];
	GW_CVAR_MINIMAP_DRAWDISTANCE = 0;
	GW_CVAR_MINIMAP_MAXDISTANCE = 0;
	if (worldName == "altis") then {GW_CVAR_MINIMAP_MAXDISTANCE = 2000};
	if (worldName == "stratis") then {GW_CVAR_MINIMAP_MAXDISTANCE = 2000};
	
	//Colour CVARS (Fill once, use many times)
	GW_CVAR_TEAM_COLOUR_CLASS = [(GW_CVAR_SIDE), "Class"] Call fnc_shr_getSideColour;
	GW_CVAR_TEAM_COLOUR_HEX = [(GW_CVAR_SIDE), "Hex"] Call fnc_shr_getSideColour;
	GW_CVAR_TEAM_COLOUR_RGB = [(GW_CVAR_SIDE), "RGB"] Call fnc_shr_getSideColour;
	GW_CVAR_TEAM_COLOUR_RGBA = [(GW_CVAR_SIDE), "RGBA"] Call fnc_shr_getSideColour;
	GW_CVAR_SQUAD_COLOUR_CLASS = "GWAR3_ColorSquad";
	GW_CVAR_SQUAD_COLOUR_HEX = "#2a752a";
	GW_CVAR_SQUAD_COLOUR_RGB = [0.1647,0.4588,0.1647];
	GW_CVAR_SQUAD_COLOUR_RGBA = [0.1647,0.4588,0.1647,1];
	
	//GUI Sizes
	GW_CVAR_TEXTSIZE = ((((safezoneW / safezoneH) min 1.2) / 1.2) * 1);
	GW_CVAR_TEXTSIZE_SMALL = ((((safezoneW / safezoneH) min 1.2) / 1.2) * 0.8);

	//Set Viewdistance and terrain grid (Everybody should run the same draw distances for fairness)
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Setting Render Distances</t>"]);
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 0.6;
	setViewDistance GW_GVAR_VIEWDISTANCE;
	setObjectViewDistance GW_GVAR_OBJVIEWDISTANCE;
	setShadowDistance GW_GVAR_SHADOWDISTANCE;
	setTerrainGrid GW_GVAR_TERRAINGRID;
	
	//On Screen Texts
	GW_CVAR_ONSCREENTEXTS =
	[
		[
			"GWAR3_UnitKilled",
			"+<img image='Resources\images\money.paa'/>%1 - Killing Enemy %2"
		],
		[
			"GWAR3_UnitTeamKilled",
			"-<img image='Resources\images\money.paa'/>%1 - Killing Friendly %2"
		]
	];
	
	//Config structure Arrays
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Retrieving Structure Data</t>"]);
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 0.65;
	GW_CONSTRUCT_BASESTRUCT = [GW_CVAR_SIDE, "Base"] Call fnc_shr_getSideStructures;
	GW_CONSTRUCT_DEFSTRUCT = [GW_CVAR_SIDE, "Defenses"] Call fnc_shr_getSideStructures;
	GW_CONSTRUCT_MISCSTRUCT = [GW_CVAR_SIDE, "Other"] Call fnc_shr_getSideStructures;

	//Get Templates (with prices)
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Retrieving Equipment Templates</t>"]);
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 0.75;
	GW_PUREQUIP_WEAP_PRIMARY = [GW_CVAR_SIDE, "WEAP_PRIMARY"] Call fnc_shr_getSideEquipment;
	GW_PUREQUIP_WEAP_SECONDARY = [GW_CVAR_SIDE, "WEAP_SECONDARY"] Call fnc_shr_getSideEquipment;
	GW_PUREQUIP_WEAP_SIDEARM = [GW_CVAR_SIDE, "WEAP_SIDEARM"] Call fnc_shr_getSideEquipment;
	GW_PUREQUIP_MAGAZINES = [GW_CVAR_SIDE, "MAGAZINES"] Call fnc_shr_getSideEquipment;
	GW_PUREQUIP_ATTACHMENTS = [GW_CVAR_SIDE, "ATTACHMENTS"] Call fnc_shr_getSideEquipment;
	GW_PUREQUIP_HEADGEAR = [GW_CVAR_SIDE, "HEADGEAR"] Call fnc_shr_getSideEquipment;
	GW_PUREQUIP_VESTS = [GW_CVAR_SIDE, "VESTS"] Call fnc_shr_getSideEquipment;
	GW_PUREQUIP_UNIFORMS = [GW_CVAR_SIDE, "UNIFORMS"] Call fnc_shr_getSideEquipment;
	GW_PUREQUIP_BACKPACKS = [GW_CVAR_SIDE, "BACKPACKS"] Call fnc_shr_getSideEquipment;
	GW_PUREQUIP_FACEWEAR = [GW_CVAR_SIDE, "FACEWEAR"] Call fnc_shr_getSideEquipment;
	GW_PUREQUIP_OTHERS = [GW_CVAR_SIDE, "OTHERS"] Call fnc_shr_getSideEquipment;
	
	//Build a complete list
	GW_PUREQUIP_FULLLIST = 
	[
		GW_PUREQUIP_WEAP_PRIMARY,
		GW_PUREQUIP_WEAP_SECONDARY,
		GW_PUREQUIP_WEAP_SIDEARM,
		GW_PUREQUIP_MAGAZINES,
		GW_PUREQUIP_ATTACHMENTS,
		GW_PUREQUIP_HEADGEAR,
		GW_PUREQUIP_VESTS,
		GW_PUREQUIP_UNIFORMS,
		GW_PUREQUIP_BACKPACKS,
		GW_PUREQUIP_FACEWEAR,
		GW_PUREQUIP_OTHERS
	] Call fnc_shr_mergeArrays;
	
	//Get server-side templates (Last purchased & DB/Session Templates)
	GW_CVAR_TEMPLATES = ["GW_NETCALL_WAITING"];
	_netCall = ["GW_CVAR_TEMPLATES","equipment","templates",[(getPlayerUID player), GW_CVAR_SIDE, true], true] Spawn fnc_clt_requestServerData;
	waitUntil {scriptDone _netCall};
	
	//Templates from Team's Infantry (can't delete)
	{
		if ((_x select 2) == GW_CVAR_SIDE) then 
		{
			_price = (_x select 3) Call fnc_shr_getEquipmentCost;
			GW_CVAR_TEMPLATES pushBack [(_x select 0), false, (_x select 3), true, _price];
		};
	} forEach GW_INFANTRY_LOADOUTS;
	
	//Clear any previous EHs
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Applying Session Data</t>"]);
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 0.90;
	player removeAllEventHandlers "Killed";
	player removeAllEventHandlers "Fired";
	player removeAllEventHandlers "GetOut";
	player allowDamage true;
	
	//Move to spawn location
	if (((GW_CVAR_ACCOUNT_CONTAINER select 3) select 0) == -1) then
	{
		GW_CLT_STARTMARK = ["GW_NETCALL_WAITING"];
		_spawnLocNetCall = ["GW_CLT_STARTMARK","team","startLoc",[GW_CVAR_SIDE], true] Spawn fnc_clt_requestServerData;
		waitUntil {scriptDone _spawnLocNetCall};
		_spawnPos = getMarkerPos(GW_CLT_STARTMARK select 0);
		_randomPos = [_spawnPos, random(25 * 0.25), 25, false, (typeOf player)] Call fnc_shr_getRandPos;
		while {(_randomPos select 0) == -1} do
		{
			_randomPos = [_spawnPos, random(25 * 0.25), 25, false, (typeOf player)] Call fnc_shr_getRandPos;
		};
		player setPosATL _randomPos;
		player setDir (random 360);
	}
	else
	{
		player setPosATL (GW_CVAR_ACCOUNT_CONTAINER select 3);
		player setDir (GW_CVAR_ACCOUNT_CONTAINER select 2);
		player setDamage (GW_CVAR_ACCOUNT_CONTAINER select 1);
	};

	//Equip Player
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Equipping Player</t>"]);
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 0.95;
	_unitEquipScript = [player, (GW_CVAR_ACCOUNT_CONTAINER select 5)] spawn fnc_shr_equipUnit;
	waitUntil{scriptDone _unitEquipScript};
	
	//Set Rank
	GW_CVAR_RANK_INFO = [(GW_CVAR_ACCOUNT_CONTAINER select 9), 0, (GW_CVAR_ACCOUNT_CONTAINER select 11)];
	
	//Max Squad Size
	GW_CVAR_MAXSQUADSIZE = (GW_CVAR_ACCOUNT_CONTAINER select 10);
	
	//Amount of times the player has already specialized
	GW_CVAR_SPECIALIZE_AMOUNT = GW_CVAR_ACCOUNT_CONTAINER select 15;
	
	//Add our eventhandlers
	player addEventHandler ["Killed",
	{
		//Death pos
		GW_CVAR_DEATH_POS = getPos player;

		//Run client side kill event
		[_this select 0, _this select 1] Spawn fnc_clt_playerKilled;
	}];

	//Attach our keyhandlers
	[] Spawn fnc_clt_attachKeyhandlers;

	//Add player's actions
	[] Spawn fnc_clt_updateActions;
	[] Spawn fnc_clt_addPlayerActions;
	
	//Developer Mode
	if (GW_DEVMODE) then
	{
		//Click on map to warp to position
		onMapSingleClick "vehicle player setpos _pos";
		
		//Code Push from Server (Be careful with this, should only be available in dev mode)
		GW_SERVER_PUSH_EXEC = [];
		"GW_SERVER_PUSH_EXEC" addPublicVariableEventHandler
		{
			[] Spawn {Call Compile Format["%1",(_this select 1)]};
		};
	};
	
	//Zone Init
	_zoneInit = CompileFinal preprocessFileLineNumbers "Client\Init\Init_Zones.sqf";
	_zoneInitCall = [] Spawn _zoneInit;
	waitUntil {scriptDone _zoneInitCall};
	
	//Track how much time it took to initialize the client (This includes waiting for the server)
	diag_log text format["###[GW LOG] - Client initialization done - %1 seconds.", time - _clientStartInitTime];

	//Launch client update thread
	[] Spawn _fnc_clt_clientUpdate;
	
	//If game is over, launch endgame script
	if (!GW_GAMERUNNING) then {[] Spawn fnc_clt_endGame};

	//Launch client main update thread (If in first minute, add a random pause to attempt to stagger the client to server calls)
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Finishing Initialization</t>"]);
	((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) progressSetPosition 1;
	if (time < 60) then 
	{
		//12452 cutText [format["%1%2",GW_SPLASH,"Finalizing Client Initialization...\n\n"],"BLACK FADED",999999];
		sleep random(2);
	};
	
	//Warning about the server not running the latest version
	if (!isNil "GW_LATESTVERSION") then
	{
		if (GW_LATESTVERSION != GW_CVAR_VERSION_CLIENT) then
		{
			_warningText = format["WARNING - This server is not running the latest version of GWAR3!<br /><br />Current Version - %1<br />Latest Version - %2<br /><br />It is highly recommended that the server be updated.",GW_CVAR_VERSION_CLIENT, GW_LATESTVERSION];
			((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1103) ctrlShow false;
			((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1102) ctrlShow false;
			((["gwar3loading"] call fnc_clt_getGUI) displayCtrl 1104) ctrlSetStructuredText (parseText format["<t shadow='1' align='center' font='PuristaMedium' color='#FFFFFF'>%1</t>",_warningText]);
			sleep 5;
		};
	};
	
	//Late joiner should get respawn screen
	_sideMarker = format["respawn_%1",GW_CVAR_SIDE];
	if (time > 30 && ((((GW_CVAR_ACCOUNT_CONTAINER select 3) select 0) == -1) || ((player distance (getMarkerPos _sideMarker)) < 300))) then
	{
		player setPosATL (getMarkerPos format["respawn_%1",GW_CVAR_SIDE]);
		createDialog "UI_Deployment";
		waitUntil {!dialog};
	}
	else
	{
		//Remove camera
		GW_CVAR_CLIENTCAMERA cameraEffect ["TERMINATE", "BACK"];
		camDestroy GW_CVAR_CLIENTCAMERA;
	};
	
	//Manipulate BIS actions
	inGameUISetEventHandler ["Action", ' _this Call fnc_clt_handleActionMenu '];
	
	//Update friendly markers
	[] Spawn fnc_clt_buildFriendlyMarkers;
	
	//Update GUI
	[] Spawn fnc_clt_updateGUI;
};