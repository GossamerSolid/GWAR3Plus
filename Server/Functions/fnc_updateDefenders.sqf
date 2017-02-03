_unitGroups = _this select 0;
_defendZoneIndex = _this select 1;

//Get zone array
_zoneArr = GW_ZONES select _defendZoneIndex;

//Build an ai logic group
//AI Group, Order, Order Refresh Countdown, 0/1 - Should patrol near camps
_aiLogicGroup = [];
{
	deleteWaypoint [_x, 0];
	_aiLogicGroup set [count _aiLogicGroup, [_x, "", 0, round(random(1))]];
} forEach _unitGroups;

//Keep going until told otherwise
_keepGoing = true;
while {_keepGoing} do
{
	//Get zone array
	_zoneArr = GW_ZONES select _defendZoneIndex;
	
	//Should we keep going?
	if ((_zoneArr select 12) > 0) exitWith {};
	
	//Update each group
	{
		_currentGroup = _x;
		_groupUnits = _currentGroup select 0;
		_order = _currentGroup select 1;
		_orderTimeout = _currentGroup select 2;
		
		//Check if depot is under attack
		_depotUnderAttack = false;
		_countWest = 0;
		_countEast = 0;
		_countGuer = 0;
		_objectsNearDepot = (getPosATL (_zoneArr select 0)) nearEntities [["Car","Tank","Air","Ship",GW_DATA_INFANTRYCLASS_EAST,GW_DATA_INFANTRYCLASS_GUER,GW_DATA_INFANTRYCLASS_WEST], GW_GVAR_DEPOT_CAPTURE_RADIUS];
		{
			if (side _x == west && alive _x) then {_countWest = _countWest + 1};
			if (side _x == east && alive _x) then {_countEast = _countEast + 1};
			if (side _x == guer && alive _x) then {_countGuer = _countGuer + 1};
		} forEach _objectsNearDepot;
		
		//Enemies nearby
		if ((_zoneArr select 7) == west) then
		{
			if ((_countEast + _countGuer) > 0) then {_depotUnderAttack = true};
		};
		if ((_zoneArr select 7) == east) then
		{
			if ((_countWest + _countGuer) > 0) then {_depotUnderAttack = true};
		};
		if ((_zoneArr select 7) == guer) then
		{
			if ((_countEast + _countWest) > 0) then {_depotUnderAttack = true};
		};
		
		//Depot's strength isn't 100%
		if ((_zoneArr select 6) < (_zoneArr select 5)) then {_depotUnderAttack = true};

		//Check if orders need renewal
		if (_orderTimeout <= 0 || _depotUnderAttack) then
		{
			//Clear Order
			_order = "";
			
			//Depot is under attack - go defend it
			if (_depotUnderAttack && (_order != "DefendDepot")) then
			{
				_order = "DefendDepot";
				deleteWaypoint [_groupUnits, 0];
				_randomWaypointOrigin = [getPosATL (_zoneArr select 0), random(GW_GVAR_DEPOT_CAPTURE_RADIUS * 0.25), GW_GVAR_DEPOT_CAPTURE_RADIUS, false] Call fnc_shr_getRandPos;
				while {(_randomWaypointOrigin select 0) == -1} do
				{
					_randomWaypointOrigin = [getPosATL (_zoneArr select 0), random(GW_GVAR_DEPOT_CAPTURE_RADIUS * 0.25), GW_GVAR_DEPOT_CAPTURE_RADIUS, false] Call fnc_shr_getRandPos;
				};
				_wp = _groupUnits addWaypoint [_randomWaypointOrigin, random(GW_GVAR_DEPOT_CAPTURE_RADIUS)];
				_wp setWaypointType "SAD";
				_wp setWaypointCompletionRadius 0;
				_wp setWaypointBehaviour "AWARE";
				_wp setWaypointCombatMode "RED";
				_wp setWaypointFormation "DIAMOND";
				_wp setWaypointSpeed "FULL";
				_groupUnits setCurrentWaypoint _wp;
				_orderTimeout = random(30) + 10;
			}
			else
			{
				if (_order == "DefendDepot") then {deleteWaypoint [_groupUnits, 0]; _order = ""; _orderTimeout = 0};				
			};
			
			//No orders
			if (_order == "") then
			{
				_order = "Patrol";
				deleteWaypoint [_groupUnits, 0];
				_randomWaypointOrigin = [(_zoneArr select 4), random((_zoneArr select 3) * 0.25), (_zoneArr select 3), false] Call fnc_shr_getRandPos;
				while {(_randomWaypointOrigin select 0) == -1} do
				{
					_randomWaypointOrigin = [(_zoneArr select 4), random((_zoneArr select 3) * 0.25), (_zoneArr select 3), false] Call fnc_shr_getRandPos;
				};
				_wp = _groupUnits addWaypoint [_randomWaypointOrigin, 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointCompletionRadius (5 + random(10));
				_wp setWaypointBehaviour "SAFE";
				_wp setWaypointFormation "DIAMOND";
				_wp setWaypointCombatMode "RED";
				_wp setWaypointSpeed "LIMITED";
				_groupUnits setCurrentWaypoint _wp;
				_orderTimeout = random(30) + 10;
			};
		}
		else
		{
			_orderTimeout = _orderTimeout - 5;
		};
		
		//Update logic group array index
		_aiLogicGroup set [_forEachIndex, [_groupUnits, _order, _orderTimeout]];
	} forEach _aiLogicGroup;
	
	sleep 5;
};

