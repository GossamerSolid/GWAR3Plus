_currZoneIndex = _this;

_currZoneArr = GW_ZONES select _currZoneIndex;
_returnDefenders = [];

_numDefenderSquads = _currZoneArr select 14;

for "_i" from 1 to _numDefenderSquads do
{
	//Get origin creation position for squad
	_randomPos = [(_currZoneArr select 4), random((_currZoneArr select 3) * 0.25), (_currZoneArr select 3), false] Call fnc_shr_getRandPos;
	while {(_randomPos select 0) == -1} do
	{
		_randomPos = [(_currZoneArr select 4), random((_currZoneArr select 3) * 0.25), (_currZoneArr select 3), false] Call fnc_shr_getRandPos;
	};
	_defenseGroup = createGroup (_currZoneArr select 7);
	
	//This is for dev purposes
	if (GW_DEVMODE) then
	{
		_markerMap = createMarker [format ["GroupMarker_%1",_randomPos], _randomPos];
		_markerMap setMarkerSize [0.5, 0.5];
		_markerMap setMarkerColor "ColorYellow";
		_markerMap setMarkerType "hd_dot";
	};
	
	//Pick a random squad template
	_squadTemplate = (GW_DEFENDER_TEMPLATES select (round(random((count GW_DEFENDER_TEMPLATES) - 1))));
	while {(_squadTemplate select 2) > GW_TIME_ELAPSED} do {_squadTemplate = (GW_DEFENDER_TEMPLATES select (round(random((count GW_DEFENDER_TEMPLATES) - 1))))};
	
	if (count(_squadTemplate select 1) == 3) then
	{
		if ((_currZoneArr select 7) == west) then {_squadTemplate = (_squadTemplate select 1) select 0};
		if ((_currZoneArr select 7) == east) then {_squadTemplate = (_squadTemplate select 1) select 1};
		if ((_currZoneArr select 7) == guer) then {_squadTemplate = (_squadTemplate select 1) select 2};
	}
	else
	{
		_squadTemplate = (_squadTemplate select 1) select 0;
	};
	
	//Use data from squad template to build defenders
	{
		if ((_x select 0) == "Infantry") then
		{
			//Get the unit classname
			_unitClassname = (Call Compile Format ["GW_DATA_INFANTRYCLASS_%1",(_currZoneArr select 7)]);
			
			_maxDistance = 10;
			_randomPosUnit = [_randomPos, random(_maxDistance * 0.25), _maxDistance, false, _unitClassname] Call fnc_shr_getRandPos;
			while {(_randomPosUnit select 0) == -1} do
			{
				_randomPosUnit = [_randomPos, random(_maxDistance * 0.25), _maxDistance, false, _unitClassname] Call fnc_shr_getRandPos;
				_maxDistance = _maxDistance + 1;
			};
			
			//Get infantry loadout
			_infantryArray = [(_x select 1), (_currZoneArr select 7)] Call fnc_shr_getInfantryArray;
			_infantryLoadout = _infantryArray select 3;
			
			//Create unit
			_unit = _defenseGroup createUnit [_unitClassname, _randomPosUnit, [], 0, "FORM"];
			_unit setVariable ["GW_SIDE",(_currZoneArr select 7), true];
			_unit setVariable ["GW_TOWNDEFENDER",true,true];
			if ((_currZoneArr select 7) == west) then {_unit addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, west] Call fnc_srv_unitKilled;};}]};
			if ((_currZoneArr select 7) == east) then {_unit addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, east] Call fnc_srv_unitKilled;};}]};
			if ((_currZoneArr select 7) == guer) then {_unit addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, guer] Call fnc_srv_unitKilled;};}]};
			_unitEquipScript = [_unit,_infantryLoadout] spawn fnc_shr_equipUnit;
			waitUntil{scriptDone _unitEquipScript};
			[_unit] joinSilent _defenseGroup;
			_unit setCombatMode "RED";
			
			//Put loadout var on object
			_unit setVariable ["GW_INFANTRYLOADOUT", _infantryArray select 0, true];
			
			//Make less godly
			_unit setSkill ["aimingAccuracy", 0.55];
		}
		else
		{
			_vehUID = _x select 1;
			_vehArray = _vehUID Call fnc_srv_getVehicleArray;
			_vehClassname = _vehArray select 0;
			
			//Get position
			_maxDistance = 10;
			_randomPosUnit = [_randomPos, random(_maxDistance * 0.25), _maxDistance, false, _vehClassname] Call fnc_shr_getRandPos;
			while {(_randomPosUnit select 0) == -1} do
			{
				_randomPosUnit = [_randomPos, random(_maxDistance * 0.25), _maxDistance, false, _vehClassname] Call fnc_shr_getRandPos;
			};
			
			//Create the vehicle
			_vehicleObj = [_vehClassname, _randomPosUnit, random(360), ["", false], (_currZoneArr select 7), _vehArray, true] Call fnc_srv_createVehicle;
			_vehicleObj setVariable ["GW_TOWNDEFENDER",true,true];
			
			//Create crew
			waitUntil {!isNull _vehicleObj};
			{
				if (_x) then
				{
					//Get loadout of crewmen
					_crewClass = (Call Compile Format ["GW_INFANTRY_%1",(_vehArray select 13)]);
					_infantryArray = [_crewClass, (_currZoneArr select 7)] Call fnc_shr_getInfantryArray;
					_infantryLoadout = _infantryArray select 3;
						
					//Get the unit classname
					_unitClassname = (Call Compile Format ["GW_DATA_INFANTRYCLASS_%1", (_currZoneArr select 7)]);
		
					_crew = _defenseGroup createUnit [_unitClassname, _randomPosUnit, [], 0, "FORM"];
					_crew setVariable ["GW_SIDE",(_currZoneArr select 7), true];
					_crew setVariable ["GW_TOWNDEFENDER",true,true];
					if ((_currZoneArr select 7) == west) then {_crew addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, west] Call fnc_srv_unitKilled;};}]};
					if ((_currZoneArr select 7) == east) then {_crew addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, east] Call fnc_srv_unitKilled;};}]};
					if ((_currZoneArr select 7) == guer) then {_crew addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, guer] Call fnc_srv_unitKilled;};}]};
					_unitEquipScript = [_crew, _infantryLoadout] spawn fnc_shr_equipUnit;
					waitUntil{scriptDone _unitEquipScript};
					[_crew] joinSilent _defenseGroup;
					_crew setCombatMode "RED";
					
					//Put loadout var on object
					_crew setVariable ["GW_INFANTRYLOADOUT", _infantryArray select 0, true];
					
					//Make less godly
					_crew setSkill ["aimingAccuracy", 0.55];
				
					//Driver
					if (_forEachIndex == 0) then {_crew moveInDriver _vehicleObj};
					//Gunner
					if (_forEachIndex == 1) then {_crew moveInGunner _vehicleObj};
					//Commander
					if (_forEachIndex == 2) then {_crew moveInCommander _vehicleObj};
					//Turret
					if (_forEachIndex == 3) then {_crew moveInTurret [_vehicleObj,[0]]};
				};
			} forEach (_vehArray select 5);
		};
		
		sleep 0.2;
	} forEach _squadTemplate;

	//Update defense groups array
	_returnDefenders set [count _returnDefenders, _defenseGroup];
	
	sleep 0.2;
};

_returnDefenders 