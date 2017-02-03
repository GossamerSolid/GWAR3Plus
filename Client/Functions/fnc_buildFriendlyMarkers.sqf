/*
	0 - ASL Position of Object
	1 - Icon
	2 - Direction
	3 - Display Text
	4 - RGBA Colour
	5 - Visual Position
	6 - 3D Marker specific icon
	7 - is cursor target
	8 - Marker is the player (Useful for hiding on 3d markers)
	9 - Object reference (Use this to make smooth 3d markers)
	10 - Override alive check (Useful for marked objects)
*/
private["_markerBuildArray", "_sideMembers","_squadUnits","_direction","_fullSideArray","_friendlyUnits","_vehiclesArray","_name","_colour","_playerSquad","_playerSideRGBA","_vehicleIndex","_crewText","_visualPos","_specIndex","_3dMarkerImage","_isPlayer","_specialization","_zoneDefenders","_markedObjects","_objRef"];

GW_CVAR_FRIENDLYMARKERS = [];

while {GW_GAMERUNNING} do
{
	//Local array
	_markerBuildArray = [];
	_fullSideArray = [];
	
	//Get all side members
	_sideMembers = [GW_CVAR_SIDE, "obj"] Call fnc_shr_getSideMembers;
	_playerIndex = _sideMembers find player;
	if (_playerIndex != -1) then {_sideMembers deleteAt _playerIndex};

	//Get friendly units from other players
	_friendlyUnits = [];
	{
		_friendlyUnits = [_friendlyUnits, (units (group _x))] Call fnc_shr_mergeArrays;
	} forEach _sideMembers;

	//Player's squad
	_playerSquad = units (group player);

	//Player's side colour for the markers
	_playerSideRGBA = ([GW_CVAR_SIDE, "RGBA"] Call fnc_shr_getSideColour);

	//Zone defenses
	_zoneDefenders = [];
	{
		//If the zone is friendly
		if ((_x select 4) == GW_CVAR_SIDE) then
		{
			//Iterate through the defense groups
			{
				if (!isNull _x) then
				{
					//Iterate through the units in the current group
					{
						if (alive _x) then
						{
							_zoneDefenders pushBack _x;
						};
					} forEach (units _x);
				};
			} forEach (_x select 7);
		};
	} forEach GW_ZONES_STUB;

	//Marked objects
	_markedObjects = [];
	{
		//Either has to be alive or has no timeout
		if ((alive (_x select 0)) || ((_x select 5) == -1)) then
		{
			_markedObjects pushBack _x;
		};
	} forEach GW_CVAR_MARKEDOBJECTS;
	
	//Build full side array
	_fullSideArray = [_playerSquad, _sideMembers, _friendlyUnits, _zoneDefenders, _markedObjects, GW_CVAR_VEHICLES] Call fnc_shr_mergeArrays;

	//Build some markers
	_vehiclesArray = [];
	{
		//Marked objects come in array format
		_objRef = if (typeName _x == "ARRAY") then {_x select 0} else {_x};
		
		if (alive _objRef) then
		{
			if (_objRef isKindOf "Man" && ((vehicle _objRef) == _objRef)) then //Infantry
			{
				_name = "";
				_3dMarkerImage = "";
				if (isPlayer _objRef) then 
				{
					_name = name _objRef;
					_specialization = _objRef getVariable ["GW_SPECIALIZATION", "No Specialization"];
					if (_specialization != "No Specialization") then 
					{
						_specIndex = [_specialization, 0, GW_SPECIALIZATIONS] Call fnc_shr_arrayGetIndex;
						if (_specIndex != -1) then
						{
							_3dMarkerImage = (GW_SPECIALIZATIONS select _specIndex) select 2;
						};
					};
				} 
				else 
				{
					_name = _objRef getVariable ["GW_GROUPNUM", ""];
				};
				_colour = [1,1,1,1];
				if (_objRef in _playerSquad) then 
				{
					_colour = GW_CVAR_SQUAD_COLOUR_RGBA;
				} 
				else 
				{
					_colour = ([(_objRef Call fnc_shr_getObjSide), "RGBA"] Call fnc_shr_getSideColour);
				};
				
				_visualPos = getPosATLVisual _objRef;
				_visualPos set [2, (_visualPos select 2) + 1];
				
				_markerBuildArray pushBack
				[
					(getPosASL _objRef),
					getText(configFile >> "CfgVehicles" >> (typeOf (vehicle _objRef)) >> "Icon"),
					(direction (vehicle _objRef)),
					_name,
					_colour,
					_visualPos,
					_3dMarkerImage,
					(cursorTarget == _objRef),
					(player == _objRef),
					_objRef
				];
			}
			else //Vehicles or Structures
			{
				if (typeName _x == "ARRAY") then
				{
					_objRef = _x select 0;
					_found = false;
					{
						if (typeName _x == "ARRAY") then
						{
							if ((_x select 0) == _objRef) then {_found = true};
						}
						else
						{
							if (_x == _objRef) then {_found = true};
						};
						
						if (_found) exitWith {};
					} forEach _vehiclesArray;
					
					if (!_found) then {_vehiclesArray pushBack _x};
				}
				else
				{
					_vehicleIndex = _vehiclesArray find (vehicle _x);
					if (_vehicleIndex == -1) then {_vehiclesArray pushBack (vehicle _x)};
				};
			};
		};
	} forEach _fullSideArray;

	//Parse out them vehicles
	{
		//Marked objects come in array format
		_objRef = if (typeName _x == "ARRAY") then {_x select 0} else {_x};
		
		_crewText = "";
		_3dMarkerImage = getText(configFile >> "CfgVehicles" >> (typeOf (vehicle _objRef)) >> "Icon");
		_icon = getText(configFile >> "CfgVehicles" >> (typeOf (vehicle _objRef)) >> "Icon");
		_direction = direction (vehicle _objRef);
		if (typeName _x == "ARRAY") then
		{
			_3dMarkerImage = _x select 3;
			_icon = _x select 3;
			if (!(_x select 6)) then {_direction = 0};
		};
		
		_isPlayer = false;
		if ((vehicle _objRef) in GW_CVAR_SPAWNVEH) then {_crewText = "Deployment"};
		if ((vehicle _objRef) in GW_CVAR_SUPPORTVEH) then {_crewText = "Service"};
		if ((vehicle _objRef) == GW_CVAR_MHQ) then {_3dMarkerImage = GW_MISSIONROOT + "Resources\images\struct_hq.paa"}; 
		_isUAV = (vehicle _objRef) getVariable ["GW_UAV", false];
		if (!_isUAV) then
		{
			{
				if (alive _x) then
				{
					if (player == _x) then {_isPlayer = true};
					_name = "";
					if (isPlayer _x) then 
					{
						_name = name _x;
					} 
					else 
					{
						_name = if (_x in _playerSquad) then {_x getVariable ["GW_GROUPNUM", ""]} else {"AI"};
					};
					
					if (_crewText == "") then {_crewText = _name} else {_crewText = _crewText + format[", %1",_name]};
				};
			} forEach (crew (vehicle _objRef));
		};
		_colour = if ((effectiveCommander _objRef) in _playerSquad) then {GW_CVAR_SQUAD_COLOUR_RGBA} else {[((vehicle _objRef) Call fnc_shr_getObjSide), "RGBA"] Call fnc_shr_getSideColour};
		
		_visualPos = getPosATLVisual (vehicle _objRef);
		_visualPos set [2, (_visualPos select 2) + 1];
		
		_markerBuildArray pushBack
		[
			(getPosASL (vehicle _objRef)),
			_icon,
			_direction,
			_crewText,
			_colour,
			_visualPos,
			_3dMarkerImage,
			(cursorTarget == _objRef),
			_isPlayer,
			_objRef
		];
	} forEach _vehiclesArray;

	//Copy temp array into global
	GW_CVAR_FRIENDLYMARKERS = [];
	GW_CVAR_FRIENDLYMARKERS =+ _markerBuildArray;
	
	uiSleep GW_CVAR_MARKERUPDATE_RATE;
};