//Init_Zones.sqf
//Written by - GossamerSolid
//Handles the initialization of all zones on the map

if (!isServer) exitWith {diag_log text "###[GW ERROR] - Server\Init\Init_Zones.sqf must only be called server-side."};

GW_ZONES = [];
GW_ZONES_STUB = [];
_layoutParameter = (Call Compile Format ["GW_PARAM_ML_%1",worldName]);

{
	_layoutArray = _x select 8;
	if (_layoutParameter in _layoutArray) then
	{
		_depotObject = _x select 0;
		_displayName = _x select 1;
		_campArray = _x select 2;
		_detectRad = _x select 3;
		_detectMarker = _x select 4;
		_maxSupply = _x select 5;
		_currentSupply = _x select 6;
		_currentOwner = _x select 7;
		
		//Depot object's build queue
		_depotObject setVariable ["GW_CONSTRUCTION_QUEUE", [], false];
		_depotObject setVariable ["GW_CONSTRUCTION_BLOCKED", 30, true];
		
		//Depot should not be able to take damage
		_depotObject allowDamage false;

		//Wealth of a zone (0 - Poor, 1 - Average, 2 - Rich)
		_wealth = round(random(2));

		//If max supply or current supply is equal to 0, auto calculate
		if (_maxSupply == 0 || _currentSupply == 0) then
		{
			//_lowestLow = ((GW_SERVER_ZONE_WEALTH_CONST select _wealth) select 0);
			//_wealthFactor = (_lowestLow + random((GW_SERVER_ZONE_WEALTH_CONST select _wealth) select 1)) - _lowestLow;
			_wealthFactor = 1; //Disable wealth factors for now

			_supplyCalc = round((GW_SERVER_ZONE_BASE_WEALTH + (count(_campArray) * GW_SERVER_ZONE_CAMP_BONUS_WEALTH) + (_detectRad * GW_SERVER_ZONE_CAMP_RADIUS_WEALTH)) * _wealthFactor);
			_maxSupply = 5;//_supplyCalc;
			_currentSupply = 5;//_supplyCalc;
		};

		//Create depot flag
		_depotBound = boundingBoxReal _depotObject;
		_depotWidth = ((_depotBound select 1) select 0);
		_depotFlag = createVehicle ["Flag_White_F", [((getPosATL _depotObject) select 0) + (_depotWidth + 2), ((getPosATL _depotObject) select 1), ((getPosATL _depotObject) select 2)], [], 0, "NONE"];
		_depotFlag setFlagTexture ([_currentOwner] Call fnc_shr_getFlagTex);
		
		//Figure out the radius position
		_radiusPos = if (_detectMarker != "") then {getMarkerPos _detectMarker} else {getPosATL _depotObject};
		
		//Get the owner's colour
		_sideColour = ([_currentOwner, "class"] Call fnc_shr_getSideColour);
		
		//Who knows about the zone (The current owner should)
		_knowsAbout = [[west, _currentOwner, false], [east, _currentOwner, false], [resistance, _currentOwner, false]];
		_ownerIndex = [_currentOwner, 0, _knowsAbout] Call fnc_shr_arrayGetIndex;
		if (_ownerIndex != -1) then
		{
			_knowsAbout set [_ownerIndex, [_currentOwner, _currentOwner, true]];
		};

		//Initialize camps
		_campArrayInit = [];
		{
			_campBound = boundingBoxReal _x;
			_campWidth = ((_campBound select 1) select 0);
			_campFlag = createVehicle ["Flag_White_F", [((getPosATL _x) select 0) + (_campWidth + 2), ((getPosATL _x) select 1), ((getPosATL _x) select 2)], [], 0, "NONE"];
			_campFlag setFlagTexture ([_currentOwner] Call fnc_shr_getFlagTex);
			
			//Don't allow the camp to take damage
			_x allowDamage false;
			
			_campArrayInit pushBack [_x, 
			                         round(_currentSupply / (count _campArray)), 
									 round(_maxSupply / (count _campArray)), 
									 _currentOwner, 
									 _campFlag,
									 [[west, _currentOwner], [east, _currentOwner], [resistance, _currentOwner]],
									 ([_forEachIndex, "short"] Call fnc_shr_getCampName),
									 ([_forEachIndex, "long"] Call fnc_shr_getCampName)];
			
		} forEach _campArray;
		
		//Other vars that are stored on the zone, but we don't do anything with them here
		_defensesGroups = [];
		_inactTimeout = 0;
		_lockDownTime = 0;
		_timeTillLockDown = 0;
		_enemiesNearDepot = false;
		
		//Number of defender squads (1 squad per 115m of radius and 1 squad per camp)
		_numDefenderSquads = round(_detectRad/115) + (count _campArrayInit);
		
		//Update zone counts
		if (_currentOwner == west) then {GW_ZONESOWNED_WEST = GW_ZONESOWNED_WEST + 1};
		if (_currentOwner == east) then {GW_ZONESOWNED_EAST = GW_ZONESOWNED_EAST + 1};
		
		GW_ZONES_STUB pushBack [_depotObject,_radiusPos,_detectRad,_displayName,_currentOwner,_wealth,_campArrayInit,[],_knowsAbout,_currentSupply,_currentSupply,_enemiesNearDepot,_enemiesNearDepot];
		GW_ZONES pushBack [_depotObject,
						   _displayName,
						   _campArrayInit, 
						   _detectRad, 
						   _radiusPos,
						   _maxSupply,
						   _currentSupply,
						   _currentOwner,
						   _defensesGroups,
						   _inactTimeout,
						   _depotFlag,
						   _knowsAbout,
						   _lockDownTime,
						   _wealth,
						   _numDefenderSquads,
						   _timeTillLockDown,
						   _enemiesNearDepot];
	}
	else
	{
		//Clean up depot and camp objects
		hideObjectGlobal (_x select 0);
		(_x select 0) enableSimulationGlobal false;
		{
			hideObjectGlobal _x;
			_x enableSimulationGlobal false;
		} forEach (_x select 2);
	};
} forEach GW_DATA_ZONES;

//Broadcast stubs to client (They will use these as an index to get more info on the actual zones)
publicVariable "GW_ZONES_CAMPS_STUB";
publicVariable "GW_ZONES_STUB";
publicVariable "GW_ZONESOWNED_WEST";
publicVariable "GW_ZONESOWNED_EAST";

