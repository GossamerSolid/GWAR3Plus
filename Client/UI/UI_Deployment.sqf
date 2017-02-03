disableSerialization;
_display = _this select 0;
_map = _display DisplayCtrl 1200;
_map CtrlMapAnimAdd [0.5, 0.05, GW_CVAR_DEATH_POS];
CtrlMapAnimCommit _map;

//Remove the ability for the dialog to close via Esc
_display displaySetEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

//Reset the action var
GW_CVAR_ACTION = [];

GW_DEPLOYMENT_AVAILABLE = [];
GW_DEPLOYMENT_MARKERS = [];
GW_DEPLOYMENT_SELECTED = false;
GW_DEPLOYMENT_SELECTED_ARRAY = [];
GW_DEPLOYMENT_SELECTED_MARKER = "";
GW_DEP_SELECTEDTEMPLATECHANGED = false;
GW_DEPLOYMENT_DISTANCE = GW_CVAR_SIDE Call fnc_shr_getFrontlineDepDistance;
GW_MAPCLICK = -1;
ctrlEnable [2400, false];

//Remove actions from body
removeAllActions player;

//Render map icons
_mapIcons = _map ctrlAddEventHandler ["Draw",{[(_this select 0), true] Call fnc_clt_drawMapMarkers;}];

//Populate the list
lbClear 1500;
{
	lbAdd [1500, format["%1 - $%2",(_x select 0),(_x select 4)]];
	if (((_x select 4) <= GW_CVAR_MONEY ) || ((_x select 0) == "Team Default")) then {lbSetColor [1500, _forEachIndex, [0.1490,0.5647,0.1412,1]]} else {lbSetColor [1500, _forEachIndex, [0.6235,0.1725,0.1725,1]]};
} forEach GW_CVAR_TEMPLATES;

//Spin the deployment marker around
fnc_dep_animateDeploymentMarker =
{
	while {dialog && (GW_DEPLOYMENT_SELECTED_MARKER != "")} do
	{
		GW_DEPLOYMENT_SELECTED_MARKER setMarkerColorLocal "ColorRed";
	};
};

//Build spawn locations
fnc_dep_buildAvailableSpawns =
{
	private["_localBuildArray","_localBuildIndex","_sideHasFrontline"];
	_localBuildArray = [];
	//Does the player's team have Frontline Deployment researched?
	_sideHasFrontline = [GW_CVAR_SIDE, "Frontline Deployment"] Call fnc_shr_isResearched;
	
	//MHQ (Doesn't matter if hostiles are present)
	_localBuildArray pushBack [GW_CVAR_MHQ, "MHQ"];
	
	//Base Buildings (Doesn't matter if hostiles are present)
	{
		_structIndex = [(_x getVariable "GW_STRUCTUID"), 17, GW_CONSTRUCT_BASESTRUCT] Call fnc_shr_arrayGetIndex;
		if (_structIndex != -1) then
		{
			_structArray = GW_CONSTRUCT_BASESTRUCT select _structIndex;
			if (_structArray select 14) then 
			{
				_localBuildArray pushBack [_x, "Base", (_structArray select 1)];
			};
		};
	} forEach GW_CVAR_BUILDINGS_BASE;
	
	//Players specialized as Medic (Matters if hostiles are present, has to be close to player's death location)
	_sideMembers = [GW_CVAR_SIDE, "obj"] Call fnc_shr_getSideMembers;
	{
		if ((_x getVariable ["GW_SPECIALIZATION", ""]) == "Medic") then
		{
			if ((GW_CVAR_DEATH_POS distance _x) < GW_DEPLOYMENT_DISTANCE) then
			{
				_hostiles = [GW_CVAR_SIDE, (getPosATL _x), 30] Call fnc_shr_getHostilesInArea;
				if (_hostiles == 0) then 
				{
					_localBuildIndex = [_x, 0, _localBuildArray] Call fnc_shr_arrayGetIndex;
					if (_localBuildIndex != -1) then {_localBuildArray pushBack [_x, "Medic", (name _x)]};
				};
			};
		};
	} forEach _sideMembers;
	
	//Spawnable vehicles (Matters if hostiles are present, has to be close to player's death location)
	{
		if ((GW_CVAR_DEATH_POS distance _x) < GW_DEPLOYMENT_DISTANCE) then
		{
			_hostiles = [GW_CVAR_SIDE, (getPosATL _x), 30] Call fnc_shr_getHostilesInArea;
			if (_hostiles == 0) then 
			{
				_localBuildIndex = [_x, 0, _localBuildArray] Call fnc_shr_arrayGetIndex;
				if (_localBuildIndex != -1) then {_localBuildArray pushBack [_x, "SpawnVeh"]};
			};
		};
	} forEach GW_CVAR_SPAWNVEH;
	
	//Zones & their camps
	{
		_currentZone = _x;
		
		//Zone itself (requires frontline deployment)
		if (_sideHasFrontline) then
		{
			if ((GW_CVAR_DEATH_POS distance (_currentZone select 0)) < GW_DEPLOYMENT_DISTANCE) then
			{
				_hostiles = [GW_CVAR_SIDE, (getPosATL (_currentZone select 0)), 100] Call fnc_shr_getHostilesInArea;
				if (_hostiles == 0) then {_localBuildArray pushBack [(_currentZone select 0), "Depot", (_currentZone select 3)]};
			};
		};
		
		//Camps
		{
			if ((_x select 3) == GW_CVAR_SIDE) then
			{
				if ((GW_CVAR_DEATH_POS distance (_x select 0)) < GW_DEPLOYMENT_DISTANCE) then
				{
					_hostiles = 0; //[GW_CVAR_SIDE, (getPosATL (_x select 0)), 20] Call fnc_shr_getHostilesInArea;
					if (_hostiles == 0) then {_localBuildArray pushBack [(_x select 0), "Camp", (_currentZone select 3)]};
				};
			};
		} forEach (_currentZone select 6);
	} forEach GW_ZONES_STUB;
	
	//Replace prior selections
	GW_DEPLOYMENT_AVAILABLE =+ _localBuildArray;
	{deleteMarkerLocal _x} forEach GW_DEPLOYMENT_MARKERS;
	GW_DEPLOYMENT_MARKERS = [];
	
	//Create new markers
	{
		_depMarker = createMarkerLocal [format["DeploymentMarker_%1",(_x select 0)], (getPosATL (_x select 0))];
		_depMarker setMarkerColorLocal "ColorYellow";
		_depMarker setMarkerTypeLocal "Select";
		_depMarker setMarkerSizeLocal [1, 1];
		_depMarker setMarkerAlphaLocal 1;
		GW_DEPLOYMENT_MARKERS pushBack _depMarker;
	} forEach GW_DEPLOYMENT_AVAILABLE;
};

//Select a deployment point by checking the user's click position on the map to the nearest deployment marker
fnc_dep_selectSpawn =
{
	private ["_clickPos", "_spawnPosSorted", "_nearest"];
	_clickPos = _this;
	
	_spawnPosSorted = [_clickPos, GW_DEPLOYMENT_AVAILABLE, 0] Call fnc_shr_sortArrayByDistance;
	if ((count _spawnPosSorted) > 0) then
	{
		_nearest = _spawnPosSorted select 0;
		if ((_clickPos distance (_nearest select 0)) <= 200) then
		{
			GW_DEPLOYMENT_SELECTED_ARRAY = _nearest;
			GW_DEPLOYMENT_SELECTED_MARKER setMarkerColorLocal "ColorYellow";
			GW_DEPLOYMENT_SELECTED_MARKER = format["DeploymentMarker_%1",(_nearest select 0)];
	        playSound "UISuccess"; 
		}
		else
		{
			GW_DEPLOYMENT_SELECTED_ARRAY = [];
			GW_DEPLOYMENT_SELECTED_MARKER setMarkerColorLocal "ColorYellow";
			GW_DEPLOYMENT_SELECTED_MARKER = "";
			playSound "UIFail";
		};
	}
	else
	{
		GW_DEPLOYMENT_SELECTED_ARRAY = [];
		GW_DEPLOYMENT_SELECTED_MARKER setMarkerColorLocal "ColorYellow";
		GW_DEPLOYMENT_SELECTED_MARKER = "";
		playSound "UIFail";
	};
	
	[] Spawn fnc_dep_animateDeploymentMarker;
};

//Verify spawn location is still valid
fnc_dep_verifySelection =
{
	if ((count GW_DEPLOYMENT_SELECTED_ARRAY) > 0) then
	{
		_availIndex = [(GW_DEPLOYMENT_SELECTED_ARRAY select 0), 0, GW_DEPLOYMENT_AVAILABLE] Call fnc_shr_arrayGetIndex;
		if (_availIndex == -1) then
		{
			GW_DEPLOYMENT_SELECTED_ARRAY = [];
			GW_DEPLOYMENT_SELECTED_MARKER setMarkerColorLocal "ColorYellow";
			GW_DEPLOYMENT_SELECTED_MARKER = "";
			playSound "UIFail";
		};
	};
};

//Redraw template inventory
fnc_dep_redrawInventory =
{
	private["_parentDisplay","_currentTemplate"];
	disableSerialization;
	_parentDisplay = _this select 0;
	
	_uniformCTRL = _parentDisplay displayCtrl 1201;
	_vestCTRL = _parentDisplay displayCtrl 1202;
	_backpackCTRL = _parentDisplay displayCtrl 1203;
	_headgearCTRL = _parentDisplay displayCtrl 1204;
	_faceCTRL = _parentDisplay displayCtrl 1205;
	_nvgCTRL = _parentDisplay displayCtrl 1206;
	_binocsCTRL = _parentDisplay displayCtrl 1207;
	_mapCTRL = _parentDisplay displayCtrl 1208;
	_gpsCTRL = _parentDisplay displayCtrl 1209;
	_radioCTRL = _parentDisplay displayCtrl 1210;
	_compassCTRL = _parentDisplay displayCtrl 1211;
	_watchCTRL = _parentDisplay displayCtrl 1212;
	_primaryCTRL = _parentDisplay displayCtrl 1213;
	_primaryMuzCTRL = _parentDisplay displayCtrl 1216;
	_primarySideCTRL = _parentDisplay displayCtrl 1217;
	_primaryTopCTRL = _parentDisplay displayCtrl 1218;
	_primaryBipodCTRL = _parentDisplay displayCtrl 1225;
	_secondaryCTRL = _parentDisplay displayCtrl 1214;
	_secondaryMuzCTRL = _parentDisplay displayCtrl 1219;
	_secondarySideCTRL = _parentDisplay displayCtrl 1220;
	_secondaryTopCTRL = _parentDisplay displayCtrl 1221;
	_secondaryBipodCTRL = _parentDisplay displayCtrl 1226;
	_handgunCTRL = _parentDisplay displayCtrl 1215;
	_handgunMuzCTRL = _parentDisplay displayCtrl 1222;
	_handgunSideCTRL = _parentDisplay displayCtrl 1223;
	_handgunTopCTRL = _parentDisplay displayCtrl 1224;
	_handgunBipodCTRL = _parentDisplay displayCtrl 1227;
	_uniformContentsCTRL = _parentDisplay displayCtrl 1501;
	_vestContentsCTRL = _parentDisplay displayCtrl 1502;
	_backpackContentsCTRL = _parentDisplay displayCtrl 1503;
	
	_selectedIndex = lbCurSel (_parentDisplay displayCtrl 1500);
	if (_selectedIndex != -1) then
	{
		_currentTemplate = (GW_CVAR_TEMPLATES select _selectedIndex) select 2;
		
		//Uniform
		_uniformPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_uniform_gs.paa";
		_uniformTT = "No Uniform";
		_uniformClass = (_currentTemplate select 4) select 0;
		if (_uniformClass != "") then 
		{
			_uniformPic = getText (configFile >> "CfgWeapons" >> _uniformClass >> "Picture");
			_uniformTT = getText (configFile >> "CfgWeapons" >> _uniformClass >> "DisplayName");
			_itemIndex = [_uniformClass, 0, GW_EQUIP_UNIFORMS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_uniformTT = _uniformTT + format[" - $%1",(GW_EQUIP_UNIFORMS select _itemIndex) select 1]};
		};
		_uniformCTRL ctrlSetText _uniformPic;
		_uniformCTRL ctrlSetTooltip _uniformTT;
		
		//Vest
		_vestPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_vest_gs.paa";
		_vestTT = "No Vest";
		_vestClass = (_currentTemplate select 5) select 0;
		if (_vestClass != "") then 
		{
			_vestPic = getText (configFile >> "CfgWeapons" >> _vestClass >> "Picture");
			_vestTT = getText (configFile >> "CfgWeapons" >> _vestClass >> "DisplayName");
			_itemIndex = [_vestClass, 0, GW_EQUIP_VESTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_vestTT = _vestTT + format[" - $%1",(GW_EQUIP_VESTS select _itemIndex) select 1]};
		};
		_vestCTRL ctrlSetText _vestPic;
		_vestCTRL ctrlSetTooltip _vestTT;
		
		//Backpack
		_backpackPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_backpack_gs.paa";
		_backpackTT = "No Backpack";
		_backClass = (_currentTemplate select 6) select 0;
		if (_backClass != "") then 
		{
			_backpackPic = getText (configFile >> "CfgVehicles" >> _backClass >> "Picture");
			_backpackTT = getText (configFile >> "CfgVehicles" >> _backClass >> "DisplayName");
			_itemIndex = [_backClass, 0, GW_EQUIP_BACKPACKS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_backpackTT = _backpackTT + format[" - $%1",(GW_EQUIP_BACKPACKS select _itemIndex) select 1]};
		};
		_backpackCTRL ctrlSetText _backpackPic;
		_backpackCTRL ctrlSetTooltip _backpackTT;
		
		//Headgear
		_headgearPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_helmet_gs.paa";
		_headgearTT = "No Headgear";
		_headClass = _currentTemplate select 0;
		if (_headClass != "") then 
		{
			_headgearPic = getText (configFile >> "CfgWeapons" >> _headClass >> "Picture");
			_headgearTT = getText (configFile >> "CfgWeapons" >> _headClass >> "DisplayName");
			_itemIndex = [_headClass, 0, GW_EQUIP_HEADGEAR] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_headgearTT = _headgearTT + format[" - $%1",(GW_EQUIP_HEADGEAR select _itemIndex) select 1]};
		};
		_headgearCTRL ctrlSetText _headgearPic;
		_headgearCTRL ctrlSetTooltip _headgearTT;
		
		//Facewear
		_facePic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_glasses_gs.paa";
		_faceTT = "No Facewear";
		_faceClass = _currentTemplate select 1;
		if (_faceClass != "") then 
		{
			_facePic = getText (configFile >> "CfgGlasses" >> _faceClass >> "Picture");
			_faceTT = getText (configFile >> "CfgGlasses" >> _faceClass >> "DisplayName");
			_itemIndex = [_faceClass, 0, GW_EQUIP_FACEWEAR] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_faceTT = _faceTT + format[" - $%1",(GW_EQUIP_FACEWEAR select _itemIndex) select 1]};
		};
		_faceCTRL ctrlSetText _facePic;
		_faceCTRL ctrlSetTooltip _faceTT;
		
		//NVG
		_nvgPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_nvg_gs.paa";
		_nvgTT = "No Head Mounted Display";
		_nvgClass = _currentTemplate select 3;
		if (_nvgClass != "") then 
		{
			_nvgPic = getText (configFile >> "CfgWeapons" >> _nvgClass >> "Picture");
			_nvgTT = getText (configFile >> "CfgWeapons" >> _nvgClass >> "DisplayName");
			_itemIndex = [_nvgClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_nvgTT = _nvgTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
		};
		_nvgCTRL ctrlSetText _nvgPic;
		_nvgCTRL ctrlSetTooltip _nvgTT;
		
		//Binoculars
		_binocsPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_binocular_gs.paa";
		_binocsTT = "No Binocular";
		_binocClass = _currentTemplate select 2;
		if (_binocClass != "") then 
		{
			_binocsPic = getText (configFile >> "CfgWeapons" >> _binocClass >> "Picture");
			_binocsTT = getText (configFile >> "CfgWeapons" >> _binocClass >> "DisplayName");
			_itemIndex = [_binocClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_binocsTT = _binocsTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
		};
		_binocsCTRL ctrlSetText _binocsPic;
		_binocsCTRL ctrlSetTooltip _binocsTT;
		
		//Map
		_mapPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_map_gs.paa";
		_mapTT = "No Map";
		_mapClass = (_currentTemplate select 10) select 2;
		if (_mapClass != "") then
		{
			_mapPic = getText (configFile >> "CfgWeapons" >> _mapClass >> "Picture");
			_mapTT = getText (configFile >> "CfgWeapons" >> _mapClass >> "DisplayName");
			_itemIndex = [_mapClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_mapTT = _mapTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
		};
		_mapCTRL ctrlSetText _mapPic;
		_mapCTRL ctrlSetTooltip _mapTT;
		
		//GPS
		_gpsPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_gps_gs.paa";
		_gpsTT = "No GPS";
		_gpsClass = (_currentTemplate select 10) select 1;
		if (_gpsClass != "") then
		{
			_gpsPic = getText (configFile >> "CfgWeapons" >> _gpsClass >> "Picture");
			_gpsTT = getText (configFile >> "CfgWeapons" >> _gpsClass >> "DisplayName");
			_itemIndex = [_gpsClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_gpsTT = _gpsTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
		};
		_gpsCTRL ctrlSetText _gpsPic;
		_gpsCTRL ctrlSetTooltip _gpsTT;
		
		//Radio
		_radioPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_radio_gs.paa";
		_radioTT = "No Radio";
		_radioClass = (_currentTemplate select 10) select 3;
		if (_radioClass != "") then
		{
			_radioPic = getText (configFile >> "CfgWeapons" >> _radioClass >> "Picture");
			_radioTT = getText (configFile >> "CfgWeapons" >> _radioClass >> "DisplayName");
			_itemIndex = [_radioClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_radioTT = _radioTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
		};
		_radioCTRL ctrlSetText _radioPic;
		_radioCTRL ctrlSetTooltip _radioTT;
		
		//Compass
		_compassPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_compass_gs.paa";
		_compassTT = "No Compass";
		_compassClass = (_currentTemplate select 10) select 0;
		if (_compassClass != "") then
		{
			_compassPic = getText (configFile >> "CfgWeapons" >> _compassClass >> "Picture");
			_compassTT = getText (configFile >> "CfgWeapons" >> _compassClass >> "DisplayName");
			_itemIndex = [_compassClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_compassTT = _compassTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
		};
		_compassCTRL ctrlSetText _compassPic;
		_compassCTRL ctrlSetTooltip _compassTT;
		
		//Watch
		_watchPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_watch_gs.paa";
		_watchTT = "No Watch";
		_watchClass = (_currentTemplate select 10) select 4;
		if (_watchClass != "") then
		{
			_watchPic = getText (configFile >> "CfgWeapons" >> _watchClass >> "Picture");
			_watchTT = getText (configFile >> "CfgWeapons" >> _watchClass >> "DisplayName");
			_itemIndex = [_watchClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_watchTT = _watchTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
		};
		_watchCTRL ctrlSetText _watchPic;
		_watchCTRL ctrlSetTooltip _watchTT;
		
		//Primary Weapon
		_primaryPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_primary_gs.paa";
		_primaryTT = "No Primary Weapon";
		_primaryMuzPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa";
		_primaryMuzTT = "No Muzzle Attachment";
		_primarySidePic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_side_gs.paa";
		_primarySideTT = "No Side Attachment";
		_primaryTopPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_top_gs.paa";
		_primaryTopTT = "No Optic Attachment";
		_primaryBipodPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_bipod_gs.paa";
		_primaryBipodTT = "No Bipod Attachment";
		_primaryClass = (_currentTemplate select 7) select 0;
		if (_primaryClass != "") then
		{
			_primaryPic = getText (configFile >> "CfgWeapons" >> _primaryClass >> "Picture");
			_primaryTT = getText (configFile >> "CfgWeapons" >> _primaryClass >> "DisplayName");
			_itemIndex = [_primaryClass, 0, GW_EQUIP_WEAP_PRIMARY] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_primaryTT = _primaryTT + format[" - $%1",(GW_EQUIP_WEAP_PRIMARY select _itemIndex) select 1]};
			
			_primaryAttach = (_currentTemplate select 7) select 1;
			if (_primaryAttach select 0 != "") then
			{
				_primaryMuzPic = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 0) >> "Picture");
				_primaryMuzTT = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 0) >> "DisplayName");
				_itemIndex = [(_primaryAttach select 0), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) then {_primaryMuzTT = _primaryMuzTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
			};
			if (_primaryAttach select 1 != "") then
			{
				_primarySidePic = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 1) >> "Picture");
				_primarySideTT = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 1) >> "DisplayName");
				_itemIndex = [(_primaryAttach select 1), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) then {_primarySideTT = _primarySideTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
			};
			if (_primaryAttach select 2 != "") then
			{
				_primaryTopPic = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 2) >> "Picture");
				_primaryTopTT = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 2) >> "DisplayName");
				_itemIndex = [(_primaryAttach select 2), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) then {_primaryTopTT = _primaryTopTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
			};
			if ((_primaryAttach select 3) != "") then
			{
				_primaryBipodPic = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 3) >> "Picture");
				_primaryBipodTT = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 3) >> "DisplayName");
				_itemIndex = [(_primaryAttach select 3), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) then {_primaryBipodTT = _primaryBipodTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
			};
		};
		_primaryCTRL ctrlSetText _primaryPic;
		_primaryCTRL ctrlSetTooltip _primaryTT;
		_primaryMuzCTRL ctrlSetText _primaryMuzPic;
		_primaryMuzCTRL ctrlSetTooltip _primaryMuzTT;
		_primarySideCTRL ctrlSetText _primarySidePic;
		_primarySideCTRL ctrlSetTooltip _primarySideTT;
		_primaryTopCTRL ctrlSetText _primaryTopPic;
		_primaryTopCTRL ctrlSetTooltip _primaryTopTT;
		_primaryBipodCTRL ctrlSetText _primaryBipodPic;
		_primaryBipodCTRL ctrlSetTooltip _primaryBipodTT;
		
		//Secondary Weapon
		_secondaryPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_secondary_gs.paa";
		_secondaryTT = "No Secondary Weapon";
		_secondaryMuzPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa";
		_secondaryMuzTT = "No Muzzle Attachment";
		_secondarySidePic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_side_gs.paa";
		_secondarySideTT = "No Side Attachment";
		_secondaryTopPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_top_gs.paa";
		_secondaryTopTT = "No Optic Attachment";
		_secondaryBipodPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_bipod_gs.paa";
		_secondaryBipodTT = "No Bipod Attachment";
		_secondaryClass = (_currentTemplate select 8) select 0;
		if (_secondaryClass != "") then
		{
			_secondaryPic = getText (configFile >> "CfgWeapons" >> _secondaryClass >> "Picture");
			_secondaryTT = getText (configFile >> "CfgWeapons" >> _secondaryClass >> "DisplayName");
			_itemIndex = [_secondaryClass, 0, GW_EQUIP_WEAP_SECONDARY] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_secondaryTT = _secondaryTT + format[" - $%1",(GW_EQUIP_WEAP_SECONDARY select _itemIndex) select 1]};
			
			_secondaryAttach = (_currentTemplate select 8) select 1;
			if ((_secondaryAttach select 0) != "") then
			{
				_secondaryMuzPic = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 0) >> "Picture");
				_secondaryMuzTT = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 0) >> "DisplayName");
				_itemIndex = [(_secondaryAttach select 0), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) then {_secondaryMuzTT = _secondaryMuzTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
			};
			if ((_secondaryAttach select 1) != "") then
			{
				_secondarySidePic = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 1) >> "Picture");
				_secondarySideTT = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 1) >> "DisplayName");
				_itemIndex = [(_secondaryAttach select 1), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) then {_secondarySideTT = _secondarySideTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
			};
			if ((_secondaryAttach select 2) != "") then
			{
				_secondaryTopPic = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 2) >> "Picture");
				_secondaryTopTT = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 2) >> "DisplayName");
				_itemIndex = [(_secondaryAttach select 2), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) then {_secondaryTopTT = _secondaryTopTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
			};
			if ((_secondaryAttach select 3) != "") then
			{
				_secondaryBipodPic = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 3) >> "Picture");
				_secondaryBipodTT = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 3) >> "DisplayName");
				_itemIndex = [(_secondaryAttach select 3), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) then {_secondaryBipodTT = _secondaryBipodTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
			};
		};
		_secondaryCTRL ctrlSetText _secondaryPic;
		_secondaryCTRL ctrlSetTooltip _secondaryTT;
		_secondaryMuzCTRL ctrlSetText _secondaryMuzPic;
		_secondaryMuzCTRL ctrlSetTooltip _secondaryMuzTT;
		_secondarySideCTRL ctrlSetText _secondarySidePic;
		_secondarySideCTRL ctrlSetTooltip _secondarySideTT;
		_secondaryTopCTRL ctrlSetText _secondaryTopPic;
		_secondaryTopCTRL ctrlSetTooltip _secondaryTopTT;
		_secondaryBipodCTRL ctrlSetText _secondaryBipodPic;
		_secondaryBipodCTRL ctrlSetTooltip _secondaryBipodTT;
		
		//Handgun
		_handgunPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_hgun_gs.paa";
		_handgunTT = "No Handgun";
		_handgunMuzPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa";
		_handgunMuzTT = "No Muzzle Attachment";
		_handgunSidePic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_side_gs.paa";
		_handgunSideTT = "No Side Attachment";
		_handgunTopPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_top_gs.paa";
		_handgunTopTT = "No Optic Attachment";
		_handgunBipodPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_bipod_gs.paa";
		_handgunBipodTT = "No Bipod Attachment";
		_handgunClass = (_currentTemplate select 9) select 0;
		if (_handgunClass != "") then
		{
			_handgunPic = getText (configFile >> "CfgWeapons" >> _handgunClass >> "Picture");
			_handgunTT = getText (configFile >> "CfgWeapons" >> _handgunClass >> "DisplayName");
			_itemIndex = [_handgunClass, 0, GW_EQUIP_WEAP_SIDEARM] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_handgunTT = _handgunTT + format[" - $%1",(GW_EQUIP_WEAP_SIDEARM select _itemIndex) select 1]};
			
			_handgunAttach = (_currentTemplate select 9) select 1;
			if ((_handgunAttach select 0) != "") then
			{
				_handgunMuzPic = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 0) >> "Picture");
				_handgunMuzTT = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 0) >> "DisplayName");
				_itemIndex = [(_handgunAttach select 0), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) then {_handgunMuzTT = _handgunMuzTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
			};
			if ((_handgunAttach select 1) != "") then
			{
				_handgunSidePic = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 1) >> "Picture");
				_handgunSideTT = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 1) >> "DisplayName");
				_itemIndex = [(_handgunAttach select 1), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) then {_handgunSideTT = _handgunSideTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
			};
			if ((_handgunAttach select 2) != "") then
			{
				_handgunTopPic = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 2) >> "Picture");
				_handgunTopTT = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 2) >> "DisplayName");
				_itemIndex = [(_handgunAttach select 2), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) then {_handgunTopTT = _handgunTopTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
			};
			if ((_handgunAttach select 3) != "") then
			{
				_handgunBipodPic = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 3) >> "Picture");
				_handgunBipodTT = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 3) >> "DisplayName");
				_itemIndex = [(_handgunAttach select 3), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) then {_handgunBipodTT = _handgunBipodTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
			};
		};
		_handgunCTRL ctrlSetText _handgunPic;
		_handgunCTRL ctrlSetTooltip _handgunTT;
		_handgunMuzCTRL ctrlSetText _handgunMuzPic;
		_handgunMuzCTRL ctrlSetTooltip _handgunMuzTT;
		_handgunSideCTRL ctrlSetText _handgunSidePic;
		_handgunSideCTRL ctrlSetTooltip _handgunSideTT;
		_handgunTopCTRL ctrlSetText _handgunTopPic;
		_handgunTopCTRL ctrlSetTooltip _handgunTopTT;
		_handgunBipodCTRL ctrlSetText _handgunBipodPic;
		_handgunBipodCTRL ctrlSetTooltip _handgunBipodTT;
		
		//Contents of Uniform
		lbClear _uniformContentsCTRL;
		_uniformContents = (_currentTemplate select 4) select 1;
		{
			_classname = _x;
			_cfgClass = _x Call fnc_shr_getEquipCfgClass;
			
			//Get the price of the item (we don't know what category it's in, so unfortunately we need to search the entire equipment array)
			_price = 0;
			_classNameIndex = [_classname, 0, GW_PUREQUIP_FULLLIST] Call fnc_shr_arrayGetIndex;
			if (_classNameIndex != -1) then {_price = (GW_PUREQUIP_FULLLIST select _classNameIndex) select 1};

			_displayString = format["$%1 - %2",_price,(getText (configFile >> _cfgClass >> _classname >> "DisplayName"))];
			_uniformContentsCTRL lbAdd _displayString;
			_uniformContentsCTRL lbSetTooltip [_forEachIndex, _displayString];
			_uniformContentsCTRL lbSetPicture [_forEachIndex, (getText (configFile >> _cfgClass >> _classname >> "Picture"))];
		} forEach _uniformContents;
		
		//Contents of Vest
		lbClear _vestContentsCTRL;
		_vestContents = (_currentTemplate select 5) select 1;
		{
			_classname = _x;
			_cfgClass = _x Call fnc_shr_getEquipCfgClass;
			
			//Get the price of the item (we don't know what category it's in, so unfortunately we need to search the entire equipment array)
			_price = 0;
			_classNameIndex = [_classname, 0, GW_PUREQUIP_FULLLIST] Call fnc_shr_arrayGetIndex;
			if (_classNameIndex != -1) then {_price = (GW_PUREQUIP_FULLLIST select _classNameIndex) select 1};

			_displayString = format["$%1 - %2",_price,(getText (configFile >> _cfgClass >> _classname >> "DisplayName"))];
			_vestContentsCTRL lbAdd _displayString;
			_vestContentsCTRL lbSetTooltip [_forEachIndex, _displayString];
			_vestContentsCTRL lbSetPicture [_forEachIndex, (getText (configFile >> _cfgClass >> _classname >> "Picture"))];
		} forEach _vestContents;
		
		//Contents of Backpack
		lbClear _backpackContentsCTRL;
		_backpackContents = (_currentTemplate select 6) select 1;
		{
			_classname = _x;
			_cfgClass = _x Call fnc_shr_getEquipCfgClass;
			
			//Get the price of the item (we don't know what category it's in, so unfortunately we need to search the entire equipment array)
			_price = 0;
			_classNameIndex = [_classname, 0, GW_PUREQUIP_FULLLIST] Call fnc_shr_arrayGetIndex;
			if (_classNameIndex != -1) then {_price = (GW_PUREQUIP_FULLLIST select _classNameIndex) select 1};

			_displayString = format["$%1 - %2",_price,(getText (configFile >> _cfgClass >> _classname >> "DisplayName"))];
			_backpackContentsCTRL lbAdd _displayString;
			_backpackContentsCTRL lbSetTooltip [_forEachIndex, _displayString];
			_backpackContentsCTRL lbSetPicture [_forEachIndex, (getText (configFile >> _cfgClass >> _classname >> "Picture"))];
		} forEach _backpackContents;
	};
};

//Updater Loop
_updateAvailable = 0;
_updateDeploymentDistance = 3;
while {dialog} do
{
	//If player dies, close dialog
	if (!alive player) exitWith {closeDialog 60002};
	
	//Update money
	_headerTextCTRL = _display displayCtrl 1100;
	_headerTextCTRL ctrlSetStructuredText (parseText format ["<t align='left'>Deployment</t><t align='right'>%1 <img image='Resources\images\money.paa'/></t>", GW_CVAR_MONEY]);
	
	//Update the availability
	{
		if (_x select 4 <= GW_CVAR_MONEY || _x select 0 == "Team Default") then {lbSetColor [1500, _forEachIndex, [0.1490,0.5647,0.1412,1]]} else {lbSetColor [1500, _forEachIndex, [0.6235,0.1725,0.1725,1]]};
	} forEach GW_CVAR_TEMPLATES;
	
	//Update available spawn locations
	if (_updateAvailable < 0.1) then
	{
		_buildAvail = [] Spawn fnc_dep_buildAvailableSpawns;
		waitUntil {scriptDone _buildAvail};
		
		_verifySelection = [] Spawn fnc_dep_verifySelection;
		waitUntil {scriptDone _verifySelection};
		
		_updateAvailable = 1;
	} else {_updateAvailable = _updateAvailable - 0.1};
	
	//Update deployment distance
	if (_updateDeploymentDistance < 0.1) then
	{
		GW_DEPLOYMENT_DISTANCE = GW_CVAR_SIDE Call fnc_shr_getFrontlineDepDistance;
		_updateDeploymentDistance = 3;
	} else {_updateDeploymentDistance = _updateDeploymentDistance - 0.1};
	
	//Update Marker Positions (Only for MHQ, Medics and Spawn vehicles as they are the only ones that can move)
	{
		if ((_x select 1 == "MHQ") || (_x select 1 == "Medic") || (_x select 1 == "SpawnVeh")) then
		{
			_depMarker = format ["DeploymentMarker_%1",(_x select 0)];
			if (!isNil "_depMarker") then {_depMarker setMarkerPosLocal (getPosASL (_x select 0))};
		};
	} forEach GW_DEPLOYMENT_AVAILABLE;
	
	//Map Clicked (Choosing a deployment location)
	if (GW_MAPCLICK == 0) then
	{
		GW_MAPCLICK = -1;
		
		//Select a spawn
		_clickPos = _map PosScreenToWorld[GW_MOUSEX, GW_MOUSEY];
		_deploymentSelect = _clickPos Spawn fnc_dep_selectSpawn;
	};
	
	//Update spawn text and button
	_spawnTextCTRL = _display displayCtrl 1102;
	if ((count GW_DEPLOYMENT_SELECTED_ARRAY) > 0) then
	{
		ctrlEnable [2400, true];
		switch(GW_DEPLOYMENT_SELECTED_ARRAY select 1) do
		{
			case "MHQ":
			{
				_spawnTextCTRL ctrlSetStructuredText (parseText format ["Deploy on Mobile Headquarters"]);
			};
			
			case "Base":
			{
				_spawnTextCTRL ctrlSetStructuredText (parseText format ["Deploy on Base Structure - %1",(GW_DEPLOYMENT_SELECTED_ARRAY select 2)]);
			};
			
			case "SpawnVeh":
			{
				_spawnTextCTRL ctrlSetStructuredText (parseText format ["Deploy on Mobile Spawn - %1",getText (configFile >> "CfgVehicles" >> (typeOf (GW_DEPLOYMENT_SELECTED_ARRAY select 0)) >> "displayName")]);
			};
			
			case "Camp":
			{
				_spawnTextCTRL ctrlSetStructuredText (parseText format ["Deploy on Camp in %1",(GW_DEPLOYMENT_SELECTED_ARRAY select 2)]);
			};
			
			case "Zone":
			{
				_spawnTextCTRL ctrlSetStructuredText (parseText format ["Deploy on Zone Depot in %1",(GW_DEPLOYMENT_SELECTED_ARRAY select 2)]);
			};
			
			case "Medic":
			{
				_spawnTextCTRL ctrlSetStructuredText (parseText format ["Deploy on Medic - %1",(GW_DEPLOYMENT_SELECTED_ARRAY select 2)]);
			};
		};
	}
	else
	{
		ctrlEnable [2400, false];
		_spawnTextCTRL ctrlSetStructuredText (parseText format ["No Deployment Selected"]);
	};
	
	//Deploy button clicked
	if (GW_DEPLOYMENT_SELECTED) then
	{
		GW_DEPLOYMENT_SELECTED = false;

		//Equip player based on loadout selected
		_selectedIndex = (lbCurSel 1500);
		if (_selectedIndex != -1) then
		{
			GW_PUREQUIP_BUYNETCALLRETURN = ["GW_NETCALL_WAITING"];
			_buyNetCall = ["equipment","buy",[(getPlayerUID player), ((GW_CVAR_TEMPLATES select _selectedIndex) select 2), true, ((GW_CVAR_TEMPLATES select _selectedIndex) select 3)], "GW_PUREQUIP_BUYNETCALLRETURN"] Spawn fnc_clt_requestServerExec;
			waitUntil {scriptDone _buyNetCall};
			
			if (!(GW_PUREQUIP_BUYNETCALLRETURN select 0)) then
			{
				playSound "UIFail";
				systemChat format ["Unable to purchase gear - %1",(GW_PUREQUIP_BUYNETCALLRETURN select 1)];
			}
			else
			{
				//Equip player
				_unitEquipScript = [player, ((GW_CVAR_TEMPLATES select _selectedIndex) select 2)] spawn fnc_shr_equipUnit;
				waitUntil{scriptDone _unitEquipScript};
				
				//Update last purchased template
				if ((GW_PUREQUIP_BUYNETCALLRETURN select 1) != -1) then {GW_CVAR_TEMPLATES set [0, ["Last Purchased", false, ((GW_CVAR_TEMPLATES select _selectedIndex) select 2), true, ((GW_CVAR_TEMPLATES select _selectedIndex) select 4)]]};
				
				//Remove actions from body
				removeAllActions player;
				
				//Add player's actions
				[] Spawn fnc_clt_addPlayerActions;
				
				//Remove invulnerability
				player allowDamage true;

				//Close the dialog
				closeDialog 60002;
				
				//If the deployment was a spawn vehicle, attempt to put the player inside of the cargo space
				_putInside = false;
				if ((GW_DEPLOYMENT_SELECTED_ARRAY select 1) == "SpawnVeh") then
				{
					//Try to put player inside
					player action ["GetInCargo", (GW_DEPLOYMENT_SELECTED_ARRAY select 0)];
					
					//Give it 1 second before reverting back to old logic
					_timeout = 1;
					while {_timeout > 0} do
					{
						if (player in (crew (GW_DEPLOYMENT_SELECTED_ARRAY select 0))) exitWith {_putInside = true};
						uiSleep 1;
						_timeout = _timeout - 1;
					};
				};
				
				//Move player to spawn location
				if (!_putInside) then
				{
					_spawnPos = getPosATL (GW_DEPLOYMENT_SELECTED_ARRAY select 0);
					_randomPos = [_spawnPos, random(35 * 0.25), 35, false, (typeOf player)] Call fnc_shr_getRandPos;
					while {(_randomPos select 0) == -1} do
					{
						_randomPos = [_spawnPos, random(35 * 0.25), 35, false, (typeOf player)] Call fnc_shr_getRandPos;
					};
					_randomPos set [2, 0];
					player setPosATL _randomPos;
					player setDir (random 360);
				};
				
				//Close Camera
				GW_CVAR_CLIENTCAMERA cameraEffect ["TERMINATE", "BACK"];
				camDestroy GW_CVAR_CLIENTCAMERA;

			};
		}
		else
		{
			playSound "UIFail";
			systemChat format ["No gear template selected"];
		};
	};
	
	//Redraw template contents
	if (GW_DEP_SELECTEDTEMPLATECHANGED) then
	{
		GW_DEP_SELECTEDTEMPLATECHANGED = false;
		_redrawUI = [_display] Spawn fnc_dep_redrawInventory;
	};
	
	uiSleep 0.1;
};

//Reset the action var
GW_CVAR_ACTION = [];

//Delete Markers
{deleteMarkerLocal _x} forEach GW_DEPLOYMENT_MARKERS;
GW_DEPLOYMENT_MARKERS = [];

//Give special forces sprinting back
if ((player getVariable ["GW_SPECIALIZATION", ""]) == "Special Forces") then
{
	player enableFatigue false;
};

//Handle map icons
[] Spawn fnc_clt_initMapMarkers;