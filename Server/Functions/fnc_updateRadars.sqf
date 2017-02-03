//fnc_updateRadars.sqf
//Written by: GossamerSolid
//Update what each team's radars have spotted in terms of aircraft and artillery
private["_currentSide","_radarStructures","_radarObjects","_radarMarkers","_hasImprovedRadars","_updateInterval"];
_currentSide = _this;

while {GW_GAMERUNNING} do
{
	_radarStructures = [];
	_radarObjects = [];
	_radarMarkers = [];
	_hasImprovedRadars = [_currentSide, "Improved Radar Detection"] Call fnc_shr_isResearched;
	_updateInterval = if (_hasImprovedRadars) then {5} else {15};
	_aircraftDetectionHeight = if (_hasImprovedRadars) then {30} else {50};
	
	//Figure out where our radars are
	{
		_currentStructure = _x;
		_structureArray = (_currentStructure getVariable "GW_STRUCTUID") Call fnc_srv_getStructureArray;
		if ("Radar" in (_structureArray select 21)) then {_radarStructures pushBack _currentStructure};
	} forEach (Call Compile Format["GW_BUILDINGS_BASE_%1",_currentSide]);
	
	//Go through each radar and search for eligible objects
	{
		_towerRange = _x getVariable ["GW_COMMRANGE", 0];
		_unitList = (getPosATL _x) nearEntities [["Air", "O_MBT_02_arty_F", "B_MBT_01_arty_F", "B_MBT_01_mlrs_F", "B_Mortar_01_F", "O_Mortar_01_F"], _towerRange];
		
		//Go through the units
		{
			if (!(_x in _radarObjects) && ((side _x) != _currentSide)) then
			{
				if (_x isKindOf "Air") then
				{
					if (((getPosATL _x) select 2) >= _aircraftDetectionHeight) then {_radarObjects pushBack _x};
				}
				else
				{
					_artyLastFired = _x getVariable ["GW_ARTYLASTFIRED", 0];
					if ((_artyLastFired + 60) >= time) then
					{
						_radarObjects pushBack _x;
					};
				};
			};
		} forEach _unitList;
	} forEach _radarStructures;
	
	//Turn the objects found into some beautiful markers
	{
		_pos = getPosATL _x;
		_icon = getText(configFile >> "CfgVehicles" >> (typeOf (vehicle _x)) >> "Icon");
		_dir = round(getDirVisual _x);
		_colour = [(_x getVariable ["GW_SIDE", (side _x)]), "RGBA"] Call fnc_shr_getSideColour;
		
		_radarMarkers pushBack [_pos, _icon, _dir, _colour];
	} forEach _radarObjects;
	
	//Broadcast value to clients
	GW_CVAR_RADARMARKERS = _radarMarkers;
	_teamList = [_currentSide, "netid"] Call fnc_shr_getSideMembers;
	{
		_x publicVariableClient "GW_CVAR_RADARMARKERS";
	} forEach _teamList;
	
	//Radar Update Interval
	sleep _updateInterval;
};