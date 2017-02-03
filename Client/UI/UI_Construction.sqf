disableSerialization;
_display = _this select 0;
_map = _display DisplayCtrl 1206;
_map CtrlMapAnimAdd [0.5, 0.05, (getPosATL player)];
CtrlMapAnimCommit _map;

//If there's no origin type, we have a fatal error
if (isNil "GW_CONSTRUCT_ORIGINTYPE") then
{
	_canBuild = player Call fnc_clt_canBuild;
	if (_canBuild select 0) then 
	{
		GW_CONSTRUCT_ORIGINTYPE = "MHQ";
	}
	else
	{
		_canBuildSupport = player Call fnc_clt_canBuildSupport;
		if (_canBuildSupport select 0) then {GW_CONSTRUCT_ORIGINTYPE = "SUPPORT"};
	};
};
if (isNil "GW_CONSTRUCT_ORIGINTYPE") exitWith {closeDialog 60001; systemChat "Fatal Error - No Origin Type"};

//Render map icons
_mapIcons = _map ctrlAddEventHandler ["Draw",{[(_this select 0), true] Call fnc_clt_drawMapMarkers;}];

GW_CONSTRUCT_STRUCTURESLIST = [];
GW_CONSTRUCT_DISBANDLIST = [];
GW_CONSTRUCT_LOCALBUILDING = objNull;
GW_CONSTRUCT_LOCALBUILDING_HELPER = objNull;
GW_CONSTRUCT_BUILDINGSEL = false;
GW_CONSTRUCT_CHANGEBUILDCAT = false;
GW_CONSTRUCT_BUILDINGDISBANDSEL = false;
GW_CONSTRUCT_DISBANDUPDATE = false;
if (!isNil "GW_CONSTRUCT_PLACEACTION") then {player removeAction GW_CONSTRUCT_PLACEACTION};
GW_CONSTRUCT_PLACEACTION = player addAction ["",{GW_CONSTRUCT_PLACEBUILDING = true}, "", 0, false, true, "DefaultAction", "_ret = false; if (!isNil 'GW_CONSTRUCT_LOCALBUILDING') then {if (!isNull GW_CONSTRUCT_LOCALBUILDING) then {_ret = true} else {_ret = false}}; _ret"];

modifierCamera = nil;

//Figure out what should be selected first
if (isNil "GW_CONSTRUCT_LASTINDEX") then 
{
	GW_CONSTRUCT_LASTINDEX = 0;
};
if (isNil "GW_CONSTRUCT_BUILDCAT") then 
{
	if (GW_CONSTRUCT_ORIGINTYPE == "MHQ") then {GW_CONSTRUCT_BUILDCAT = "Base"} else {GW_CONSTRUCT_BUILDCAT = "Other"};
}
else
{
	if ((GW_CONSTRUCT_ORIGINTYPE == "Support") && (GW_CONSTRUCT_BUILDCAT != "Other")) then {GW_CONSTRUCT_BUILDCAT = "Other"; GW_CONSTRUCT_LASTINDEX = 0};
};
_currBuildCat = GW_CONSTRUCT_BUILDCAT;

//Disable or enable the build categories depending on what origin type we have
if (GW_CONSTRUCT_ORIGINTYPE == "MHQ") then
{
	(_display displayCtrl 2401) ctrlEnable true;
	(_display displayCtrl 2401) ctrlShow true;
	(_display displayCtrl 2402) ctrlEnable true;
	(_display displayCtrl 2402) ctrlShow true;
	(_display displayCtrl 2403) ctrlEnable true;	
	(_display displayCtrl 2403) ctrlShow true;
}
else
{
	(_display displayCtrl 2401) ctrlEnable false;
	(_display displayCtrl 2401) ctrlShow false;
	(_display displayCtrl 2402) ctrlEnable false;
	(_display displayCtrl 2402) ctrlShow false;
	(_display displayCtrl 2403) ctrlEnable true;	
	(_display displayCtrl 2403) ctrlShow true;
};

//Make sure the player can build
fnc_con_canBuild =
{
	private["_canBuild"];
	
	_canBuild = [true, ""];
	if (GW_CONSTRUCT_ORIGINTYPE == "MHQ") then {_canBuild = player Call fnc_clt_canBuild} else {_canBuild = player Call fnc_clt_canBuildSupport};
	
	_canBuild 
};

//Refresh building list
fnc_con_updateBuildList =
{
	//Get structures array for the side
	if (GW_CONSTRUCT_BUILDCAT == "Base") then {GW_CONSTRUCT_STRUCTURESLIST = GW_CONSTRUCT_BASESTRUCT};
	if (GW_CONSTRUCT_BUILDCAT == "Defenses") then {GW_CONSTRUCT_STRUCTURESLIST = GW_CONSTRUCT_DEFSTRUCT};
	if (GW_CONSTRUCT_BUILDCAT == "Other") then {GW_CONSTRUCT_STRUCTURESLIST = GW_CONSTRUCT_MISCSTRUCT};
	
	//Populate List with structures
	lbClear 1500;
	{
		_name = _x select 1;
		_cost = _x select 2;
		_maxAmount = _x select 11;
		_picture = _x select 12;
		_uid = _x select 17;
		_currAmount = 0;
		
		if (_maxAmount != 0) then
		{
			_structures = [GW_CVAR_BUILDINGS_BASE, GW_CVAR_BUILDINGS_DEF] Call fnc_shr_mergeArrays;
			{
				_structUID = _x getVariable ["GW_STRUCTUID", ""];
				if (_structUID == _uid) then {_currAmount = _currAmount + 1};
			} forEach _structures;
			if (GW_CONSTRUCT_ORIGINTYPE == "MHQ") then {lbAdd [1500, format["S%1 - %2/%3 - %4", _cost, _currAmount, _maxAmount, _name]]} else {lbAdd [1500, format["$%1 - %2/%3 - %4", _cost, _currAmount, _maxAmount, _name]]};
		}
		else
		{
			if (GW_CONSTRUCT_ORIGINTYPE == "MHQ") then {lbAdd [1500, format["S%1 - %2", _cost, _name]]} else {lbAdd [1500, format["$%1 - %2", _cost, _name]]};
		};
		lbSetPicture [1500, _forEachIndex, _picture];
	} forEach GW_CONSTRUCT_STRUCTURESLIST;
	lbSetCurSel [1500, GW_CONSTRUCT_LASTINDEX];
};

//Refresh structures list for disbanding
fnc_con_updateDisbandList =
{
	GW_CONSTRUCT_DISBANDLIST = [];
	{
		GW_CONSTRUCT_DISBANDLIST pushBack [_x, "Base"];
	} forEach GW_CVAR_BUILDINGS_BASE;
	{
		GW_CONSTRUCT_DISBANDLIST pushBack [_x, "Def"];
	} forEach GW_CVAR_BUILDINGS_DEF;
	
	lbClear 1501;
	{
		_structUID = (_x select 0) getVariable ["GW_STRUCTUID", ""];
		if (_structUID != "") then
		{
			_structArray = _structUID Call fnc_clt_getStructureArray;
			_name = _structArray select 1;
			_picture = _structArray select 12;
			_mapGrid = mapGridPosition (_x select 0);
			
			lbAdd [1501, format["%1 - %2", _name, _mapGrid]];
			lbSetPicture [1501, _forEachIndex, _picture];
		};
	} forEach GW_CONSTRUCT_DISBANDLIST
};

//Placement function
fnc_con_updatePosition =
{
	private["_buildingPreview", "_structureArray","_heightMod","_positionOk"];

	_buildingPreview = _this select 0;
	_buildingPreviewHelper = _this select 1;
	_structureArray = _this select 2;

	GW_CONSTRUCT_STRUCTARR_HEIGHTMOD = _structureArray select 5;
	GW_CONSTRUCT_HEIGHT_MOD = 0;
	GW_CONSTRUCT_LOCALBUILDING = _buildingPreview;
	GW_CONSTRUCT_LOCALBUILDING_HELPER = _buildingPreviewHelper;
	GW_CONSTRUCT_DIRECTION = 0;
	GW_CONSTRUCT_PLACEBUILDING = false;

	//Set starting pos
	_posOrig = player modelToWorld [0,10,0];
	_buildingPreview setPosATL _posOrig;
	_buildingPreview setDir (getDir player);
	GW_CONSTRUCT_DIRECTION = (getDir player);
	
	if (!isNull GW_CONSTRUCT_LOCALBUILDING_HELPER) then
	{
		GW_CONSTRUCT_LOCALBUILDING_HELPER setPos (GW_CONSTRUCT_LOCALBUILDING modelToWorld (_structureArray select 20));
	};

	//Update position
	while {!isNull _buildingPreview && !isNil "GW_CONSTRUCT_LOCALBUILDING"} do
	{
		if (!isNull GW_CONSTRUCT_LOCALBUILDING) then
		{
			//Reset can place variable (always start false - assume it's not ok until told otherwise)
			_positionOk = true;
			
			//Make sure the player is near the MHQ
			_canBuild = player Call fnc_con_canBuild;
			if (!(_canBuild select 0)) exitWith 
			{
				deleteVehicle GW_CONSTRUCT_LOCALBUILDING;
				GW_CONSTRUCT_LOCALBUILDING = nil;
				if (!isNull GW_CONSTRUCT_LOCALBUILDING_HELPER) then
				{
					deleteVehicle GW_CONSTRUCT_LOCALBUILDING_HELPER;
				};
				systemChat (_canBuild select 1);
				playSound "UIFail";
			};
			
			//Update Pos
			if (isNil "GW_CONSTRUCT_LOCALBUILDING") exitWith {};
			_playerPos = player modelToWorld (_structureArray select 18);
			_newPos = getPosATL GW_CONSTRUCT_LOCALBUILDING;
			_newPos set [0, _playerPos select 0];
			_newPos set [1, _playerPos select 1];
			GW_CONSTRUCT_LOCALBUILDING setPosATL _newPos;
			GW_CONSTRUCT_LOCALBUILDING setDir GW_CONSTRUCT_DIRECTION;
			
			//Updater Helper Pos
			if (!isNull GW_CONSTRUCT_LOCALBUILDING_HELPER) then
			{
				GW_CONSTRUCT_LOCALBUILDING_HELPER setPos (GW_CONSTRUCT_LOCALBUILDING modelToWorld (_structureArray select 20));
				GW_CONSTRUCT_LOCALBUILDING_HELPER setDir GW_CONSTRUCT_DIRECTION;
			};
			
			//Make sure it isn't colliding with another object
			if (GW_CONSTRUCT_BUILDCAT == "Base") then
			{
				_near = nearestObjects [getPosASL (GW_CONSTRUCT_LOCALBUILDING), ["Thing","AllVehicles","Building","House","Car","Ship","Tank","Air"], 50];
				if ((count _near) > 0) then {_near deleteAt 0}; //0th element is the preview building
				{
					_nearest = _x;
					if (!isNil "_nearest") then
					{
						_box = boundingBoxReal _nearest;
						_width = ((_box select 1) select 0);
						_length = ((_box select 1) select 1);
						_longest = (sqrt((_width * _width) + (_length * _length))) / 2;
						if (((getPosASL (GW_CONSTRUCT_LOCALBUILDING) distance _nearest) - _longest) < 10) then
						{
							_positionOk = false;
						};
					};
					
					if (!_positionOk) exitWith {};
				} forEach _near;
			};
			
			//Make sure it's not on water
			if (surfaceIsWater (getPosATL (GW_CONSTRUCT_LOCALBUILDING))) then {_positionOk = false};		

			//Place building
			if (GW_CONSTRUCT_PLACEBUILDING) then
			{
				GW_CONSTRUCT_PLACEBUILDING = false;
				
				//Make sure building is not over limit
				_maxAllowed = _structureArray select 11;
				_amountAllowed = true;
				if (_maxAllowed != -1) then
				{
					_currAmount = 0;
					if (GW_CONSTRUCT_BUILDCAT == "Base") then
					{
						{
							if ((_x getVariable "GW_STRUCTUID") == (_structureArray select 17)) then {_currAmount = _currAmount + 1};
						} forEach GW_CVAR_BUILDINGS_BASE;
						if (_currAmount >= _maxAllowed) then {_amountAllowed = false};
					}
					else
					{
						if (GW_CONSTRUCT_BUILDCAT == "Defenses") then
						{
							{
								if ((_x getVariable "GW_STRUCTUID") == (_structureArray select 17)) then {_currAmount = _currAmount + 1};
							} forEach GW_CVAR_BUILDINGS_DEF;
							if (_currAmount >= _maxAllowed) then {_amountAllowed = false};
						};
					};
				};
				
				if (!_amountAllowed) then
				{
					systemChat format ["Unable to place structure - Exceeded max allowed of structure"];
					playSound "UIFail";
				}
				else
				{
					if (_positionOk) then
					{
						//Get information and delete preview
						_pos = getPosATL GW_CONSTRUCT_LOCALBUILDING;
						_dir = getDir GW_CONSTRUCT_LOCALBUILDING;
						_className = typeOf GW_CONSTRUCT_LOCALBUILDING;
						_buildingUID = (_structureArray select 17);
						_constructionValid = [true,""];

						//If we're ok, continue
						if (_constructionValid select 0) exitWith
						{
							deleteVehicle GW_CONSTRUCT_LOCALBUILDING;
							GW_CONSTRUCT_LOCALBUILDING = nil;
							if (!isNull GW_CONSTRUCT_LOCALBUILDING_HELPER) then
							{
								deleteVehicle GW_CONSTRUCT_LOCALBUILDING_HELPER;
							};

							//Pass information to server
							GW_BUILDINGNET_RETURN = ["GW_NETCALL_WAITING"];
							_buildingNetCall = ["construction","build",[(GW_CVAR_SIDE),_buildingUID,_pos,_dir,(getPlayerUID player),GW_CONSTRUCT_ORIGINTYPE],"GW_BUILDINGNET_RETURN"] Spawn fnc_clt_requestServerExec;
							waitUntil {scriptDone _buildingNetCall};
							if (!(GW_BUILDINGNET_RETURN select 0)) then 
							{
								systemChat (GW_BUILDINGNET_RETURN select 1); 
								playSound "UIFail";
							} 
							else 
							{
								[] Spawn fnc_con_updateBuildList;
								playSound "UISuccess";
							};
						};
						if (!(_constructionValid select 0)) then 
						{
							systemChat format ["Unable to place structure - %1",_constructionValid select 1];
							playSound "UIFail";
						};
					}
					else
					{
						systemChat format ["Unable to place structure - %1","Position not clear"];
						playSound "UIFail";
					};
				};
			};
		};
	};
};

//This will populate building list with base items
[] Spawn fnc_con_updateBuildList;
if (GW_CONSTRUCT_ORIGINTYPE == "MHQ") then {[] Spawn fnc_con_updateDisbandList};

//Main Updater
while {dialog} do
{
	//If player dies, close dialog
	if (!alive player) exitWith {closeDialog 60001};
	
	//Make sure the player is near the MHQ
	_canBuild = player Call fnc_con_canBuild;
	if (!(_canBuild select 0)) exitWith {closeDialog 60001; systemChat (_canBuild select 1); playSound "UIFail";};
	
	//Pick a different category
	if (_currBuildCat != GW_CONSTRUCT_BUILDCAT) then
	{
		[] Call fnc_con_updateBuildList;
		_currBuildCat = GW_CONSTRUCT_BUILDCAT;
	};
	
	//Pick a building to place
	if (GW_CONSTRUCT_BUILDINGSEL) then
	{	
		GW_CONSTRUCT_BUILDINGSEL = false;
		
		//Structure Array
		_structureArray = GW_CONSTRUCT_STRUCTURESLIST select (lbCurSel 1500);
		
		//Have enough supply
		_cost = _structureArray select 2;
		if ((GW_CVAR_TEAMSUPPLY - _cost) >= 0) then
		{
			//Create the preview
			GW_CONSTRUCT_LOCALBUILDING = (_structureArray select 0) createVehicleLocal [0,0,0];
			GW_CONSTRUCT_LOCALBUILDING enableSimulation false;
			if (GW_CONSTRUCT_BUILDCAT == "Base") then
			{
				if (((_structureArray select 20) select 0) != 0) then
				{
					GW_CONSTRUCT_LOCALBUILDING_HELPER = "Land_HelipadCircle_F" createVehicleLocal (GW_CONSTRUCT_LOCALBUILDING modelToWorld (_structureArray select 20));
					GW_CONSTRUCT_LOCALBUILDING_HELPER enableSimulation false;
				};
			};
			
			//Update the positioning
			[GW_CONSTRUCT_LOCALBUILDING, GW_CONSTRUCT_LOCALBUILDING_HELPER, _structureArray] Spawn fnc_con_updatePosition;

			//Update last selected index
			GW_CONSTRUCT_LASTINDEX = lbCurSel 1500;
			
			//Close the building dialog
			closeDialog 60001;
		}
		else
		{
			systemChat "Not enough supply for structure.";
			playSound "UIFail";
		};
	};
	
	//Pick a building to disband
	if (GW_CONSTRUCT_BUILDINGDISBANDSEL) then
	{
		GW_CONSTRUCT_BUILDINGDISBANDSEL = false;
		
		_disbandObj = (GW_CONSTRUCT_DISBANDLIST select (lbCurSel 1501)) select 0;
		_disbandType = (GW_CONSTRUCT_DISBANDLIST select (lbCurSel 1501)) select 1;
		if (!isNil "_disbandObj") then
		{
			//Pass information to server
			GW_BUILDINGNET_RETURN = ["GW_NETCALL_WAITING"];
			_buildingNetCall = ["construction","disband",[(GW_CVAR_SIDE),_disbandObj,_disbandType],"GW_BUILDINGNET_RETURN"] Spawn fnc_clt_requestServerExec;
			waitUntil {scriptDone _buildingNetCall};
			if (!(GW_BUILDINGNET_RETURN select 0)) then {systemChat (GW_BUILDINGNET_RETURN select 1); playSound "UIFail"} else {playSound "UISuccess"};
			[] Spawn fnc_con_updateDisbandList;
		};
	};
	
	//Update map showing building to disband
	if (GW_CONSTRUCT_DISBANDUPDATE) then
	{
		GW_CONSTRUCT_DISBANDUPDATE = false;
		
		_structSelected = lbCurSel 1501;
		if (_structSelected != -1) then
		{
			_structObjPos = getPosATL((GW_CONSTRUCT_DISBANDLIST select _structSelected) select 0);
			_map = _display DisplayCtrl 1206;
			_map CtrlMapAnimAdd [0.5, 0.05, _structObjPos];
			CtrlMapAnimCommit _map;
		};
	};
};