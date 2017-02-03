/*
fnc_updateZone.sqf
Written by: GossamerSolid

Update the given zone index and its related camps
*/

private["_zoneIndex",
		"_zoneArray",
		"_startZoneUpdateTime",
		"_depotObject",
		"_displayName",
		"_campArray",
		"_detectRad",
		"_detectPos",
		"_maxSupply",
		"_currentSupply",
		"_currentOwner",
		"_defensesGroups",
		"_inactTimeout",
		"_depotFlagObj",
		"_knowsAbout",
		"_lockDownTime",
		"_wealth",
		"_numDefenderSquads",
		"_timeTillLockdown",
		"_enemiesNearDepot",
		"_westBonusCap",
		"_eastBonusCap",
		"_guerBonusCap",
		"_inZoneWest",
		"_inZoneEast",
		"_inZoneGuer",
		"_hostilesPresent",
		"_objectsIn",
		"_numberInRadius",
		"_newKnowsAbout",
		"_attackingSide",
		"_campKnowsAbout",
		"_campShortName",
		"_campLongName"];

//What zone is being updated
_zoneIndex = _this;

//Keep running as long as the game is going
while {GW_GAMERUNNING} do
{
	//Track how long it takes to update all zones
	_startAllZoneUpdateTime = time;
	_updateClients = false;
	
	//Track how long it takes to update current zone
	_startZoneUpdateTime = time;

	_zoneArray =+ GW_ZONES select _zoneIndex;
	_depotObject = _zoneArray select 0;
	_displayName = _zoneArray select 1;
	_campArray = _zoneArray select 2;
	_detectRad = _zoneArray select 3;
	_detectPos = _zoneArray select 4;
	_maxSupply = _zoneArray select 5;
	_currentSupply = _zoneArray select 6;
	_currentOwner = _zoneArray select 7;
	_defensesGroups = _zoneArray select 8;
	_inactTimeout = _zoneArray select 9;
	_depotFlagObj = _zoneArray select 10;
	_knowsAbout = _zoneArray select 11;
	_lockDownTime = _zoneArray select 12;
	_wealth = _zoneArray select 13;
	_numDefenderSquads = _zoneArray select 14;
	_timeTillLockdown = _zoneArray select 15;
	_enemiesNearDepot = _zoneArray select 16;
	
	//Bonus capture strength (from owning camps)
	_westBonusCap = 0;
	_eastBonusCap = 0;
	_guerBonusCap = 0;
	
	//Numbers in zone
	_inZoneWest = 0;
	_inZoneEast = 0;
	_inZoneGuer = 0;
	
	//Are hostiles present
	_hostilesPresent = false;
	
	//Count how many units from each side are in the detection radius
	_objectsIn = [];
	_numberInRadius = 0;
	_objectsIn = _detectPos nearEntities [["Car","Tank","Air","Ship",GW_DATA_INFANTRYCLASS_EAST,GW_DATA_INFANTRYCLASS_GUER,GW_DATA_INFANTRYCLASS_WEST], _detectRad];
	{
		if (side _x == west && alive _x) then {_inZoneWest = _inZoneWest + 1};
		if (side _x == east && alive _x) then {_inZoneEast = _inZoneEast + 1};
		if (side _x == guer && alive _x) then {_inZoneGuer = _inZoneGuer + 1};
	} forEach _objectsIn;
	
	//Only do update logic if there's actually somebody in the zone
	if ((_inZoneWest > 0) || (_inZoneEast > 0) || (_inZoneGuer > 0)) then
	{
		//Are there hostiles in the zone?
		if ((_currentOwner == west) && ((_inZoneEast + _inZoneGuer) > 0)) then {_hostilesPresent = true};
		if ((_currentOwner == east) && ((_inZoneWest + _inZoneGuer) > 0)) then {_hostilesPresent = true};
		if ((_currentOwner == guer) && ((_inZoneEast + _inZoneWest) > 0)) then {_hostilesPresent = true};
		
		//Update knows about
		_newKnowsAbout =+ _knowsAbout;
		{
			_currentSideCount = Call Compile Format["_inZone%1",(_x select 0)];
			_currentSide = _x select 0;
			if ((_currentOwner == _currentSide) || (_currentSideCount > 0)) then 
			{
				_x set [1, _currentOwner];
				_x set [2, true];
				
				//Update camps
				{
					private["_knowsAboutInnerArr", "_knowsAboutIndex"];
					_knowsAboutInnerArr = _x select 5;
					
					_knowsAboutIndex = [_currentSide, 0, _knowsAboutInnerArr] Call fnc_shr_arrayGetIndex;
					if (_knowsAboutIndex != -1) then
					{
						_knowsAboutInnerArr set [_knowsAboutIndex, [_currentSide, (_x select 3)]];
					};
				} forEach _campArray;
			}
			else
			{
				_x set [2, false];
			};
		} forEach _newKnowsAbout;
		_updateClients = !(_newKnowsAbout isEqualTo _knowsAbout);
		_knowsAbout =+ _newKnowsAbout;
		
		//Hostiles are present
		if (_hostilesPresent) then
		{
			//Reset timeout to the maximum as the zone is active
			_inactTimeout = GW_SERVER_ZONE_TIMEOUT;
			
			/* DISABLED 
			//Set the text to show the supply
			if (_currentOwner != guer) then
			{
				(format["%1_Depot",_depotObject]) setMarkerText format["%1 - %2/%3",_displayName, _currentSupply, _maxSupply];
			};
			*/
			
			//No defense groups, we should spawn some
			if ((count _defensesGroups) == 0) then
			{
				//Alert owner team that their zone is under attack
				_defenderClientList = [_currentOwner, "netid"] Call fnc_shr_getSideMembers;
				[_defenderClientList, "messages", "", ["notification",["GWAR3_ZoneUnderAttack",[_displayName]]]] Spawn fnc_srv_requestClientExec;
			
				//Create defense groups
				_defensesGroups = _zoneIndex Call fnc_srv_createDefenders;
				
				//Pass AI groups to an AI logic thread
				[_defensesGroups, _zoneIndex] Spawn fnc_srv_updateDefenders;
				
				_updateClients = true;
			};
		}
		else
		{	
			//Set the text to not show the supply
			//DISABLED (format["%1_Depot",_depotObject]) setMarkerText format["%1",_displayName];
			
			//Nobody is in the zone, decrease our inactivation timeout
			if (_inactTimeout > 0) then
			{
				_inactTimeout = _inactTimeout - GW_SERVER_UPDATE_ZONES;
			}
			else
			{
				//Update knows about
				_newKnowsAbout =+ _knowsAbout;
				{
					_currentSideCount = Call Compile Format["_inZone%1",(_x select 0)];
					_currentSide = _x select 0;
					if ((_currentOwner == _currentSide) || (_currentSideCount > 0)) then 
					{
						_x set [1, _currentOwner];
						_x set [2, true];
						
						//Update camps
						{
							private["_knowsAboutInnerArr", "_knowsAboutIndex"];
							_knowsAboutInnerArr = _x select 5;
							
							_knowsAboutIndex = [_currentSide, 0, _knowsAboutInnerArr] Call fnc_shr_arrayGetIndex;
							if (_knowsAboutIndex != -1) then
							{
								_knowsAboutInnerArr set [_knowsAboutIndex, [_currentSide, (_x select 3)]];
							};
						} forEach _campArray;
					}
					else
					{
						_x set [2, false];
					};
				} forEach _newKnowsAbout;
				_updateClients = !(_newKnowsAbout isEqualTo _knowsAbout);
				_knowsAbout =+ _newKnowsAbout;
		
				//Our zone is now inactive, clean up any defense groups
				if ((count _defensesGroups) > 0) then
				{
					_defenseVehicles = [];
					{
						//Delete units inside group
						{
							if ((vehicle _x) != _x) then
							{
								_vehIndex = _defenseVehicles find (vehicle _x);
								if (_vehIndex == -1) then {_defenseVehicles pushBack (vehicle _x)};
							};
							
							if (alive _x) then {deleteVehicle _x};
						} forEach (units _x);
						
						//Delete vehicles
						{
							if (alive _x || (count (crew _x) == 0 )) then {deleteVehicle _x};
						} forEach _defenseVehicles;
						
						//Delete group
						DeleteGroup _x;
					} forEach _defensesGroups;
					_defensesGroups = [];
					
					_updateClients = true;
				};
			};
		};
		
		//Update camps
		{
			_campObj = _x select 0;
			_campStr = _x select 1;
			_campMaxStr = _x select 2;
			_campOwner = _x select 3;
			_campFlagObj = _x select 4;
			_campKnowsAbout = _x select 5;
			_campShortName = _x select 6;
			_campLongName = _x select 7;
			
			//Add 1 bonus capture strength per camp owned
			if (_campOwner == west) then {_westBonusCap = _westBonusCap + 1};
			if (_campOwner == east) then {_eastBonusCap = _eastBonusCap + 1};
			if (_campOwner == guer) then {_guerBonusCap = _guerBonusCap + 1};
			
			_countWest = 0;
			_countEast = 0;
			_countGuer = 0;
			_sideCapturing = "";
			_sideCapturingAmt = 0;
			_objectsZoneCap = (getPosATL _campObj) nearEntities [["Man"], GW_GVAR_CAMP_CAPTURE_RADIUS];
			{
				if (side _x == west && alive _x) then {_countWest = _countWest + 1};
				if (side _x == east && alive _x) then {_countEast = _countEast + 1};
				if (side _x == guer && alive _x) then {_countGuer = _countGuer + 1};
			} forEach _objectsZoneCap;
			
			if (_countWest > (_countEast + _countGuer)) then {_sideCapturing = west; _sideCapturingAmt = _countWest - (_countEast + _countGuer)};
			if (_countEast > (_countWest + _countGuer)) then {_sideCapturing = east; _sideCapturingAmt = _countEast - (_countWest + _countGuer)};
			if (_countGuer > (_countWest + _countEast)) then {_sideCapturing = guer; _sideCapturingAmt = _countGuer - (_countWest + _countEast)};
			
			//Capturing Camps
			if ((typeName _sideCapturing) != "STRING") then
			{
				//Raise strength if friendly re-capture, lower strength if enemy capture
				if (_sideCapturing == _campOwner) then
				{
					if (_campStr < _campMaxStr) then
					{
						_campStr = (_campStr + _sideCapturingAmt) min _campMaxStr;
					};
				}
				else
				{
					_campStr = (_campStr - _sideCapturingAmt) max 0;
				};
				
				//If strength is at 0, count camp as captured by capturing side
				if (_campStr <= 0) then
				{
					//Get Camp Marker var name
					//DISABLED _zoneCampMarker = format["%1_Camp",_campObj];
					
					//Get client lists
					_capturingClientList = [_sideCapturing, "netid"] Call fnc_shr_getSideMembers;
					_lostClientList = [_campOwner, "netid"] Call fnc_shr_getSideMembers;
					_fullClientList = [_capturingClientList, _lostClientList] Call fnc_shr_mergeArrays;
					
					//Tell clients to perform update on camp status
					[_fullClientList, "camp", "captured", [_displayName, "", _sideCapturing]] Spawn fnc_srv_requestClientExec;
					
					//Update the marker colour
					//DISABLED _zoneCampMarker setMarkerColor ([_sideCapturing, "class"] Call fnc_shr_getSideColour);

					//Give experience to players of the team that captured in the zone area
					_xpAward = (round(_detectRad * GW_RANK_CAMP_CAPTURE_RATIO)) max 1;
					_moneyAward = round(GW_SERVER_ZONE_CAPTURE_BONUS_CAMPS + _detectRad);
					{
						if (((side _x) == _sideCapturing) && (isPlayer _x)) then
						{
							[(getPlayerUID _x), "+", _moneyAward] Call fnc_srv_changeMoney;
							[(getPlayerUID _x), "+", _xpAward] Spawn fnc_srv_changeRankPoints;
							[[owner _x], "messages", "", ["blueChat",["GWAR3_MoneyXP",[_moneyAward, _xpAward, format["capturing a camp in %1",_displayName]]]]] Spawn fnc_srv_requestClientExec;
						};
					} forEach _objectsIn;

					//Update camp values
					_campStr = _campMaxStr;
					_campOwner = _sideCapturing;
					
					//Update flag texture
					_campFlagObj setFlagTexture ([_sideCapturing] Call fnc_shr_getFlagTex);
					
					//Update stub for clients
					_updateClients = true;
				};
				
				//Update camp array
				_campArray set [_forEachIndex, [_campObj, _campStr, _campMaxStr, _campOwner, _campFlagObj, _campKnowsAbout, _campShortName, _campLongName]];
			};
		} forEach _campArray;
		
		//Update zone itself
		_countWest = 0;
		_countEast = 0;
		_countGuer = 0;
		_sideCapturing = "";
		_sideCapturingAmt = 0;
		_enemiesNearDepot = false;
		_objectsZoneCap = (getPosATL _depotObject) nearEntities [[GW_DATA_INFANTRYCLASS_WEST,GW_DATA_INFANTRYCLASS_EAST,GW_DATA_INFANTRYCLASS_GUER], GW_GVAR_DEPOT_CAPTURE_RADIUS];
		{
			if (side _x == west && alive _x) then {_countWest = _countWest + 1};
			if (side _x == east && alive _x) then {_countEast = _countEast + 1};
			if (side _x == guer && alive _x) then {_countGuer = _countGuer + 1};
		} forEach _objectsZoneCap;
		
		if (_countWest > 0) then {_countWest = _countWest + _westBonusCap};
		if (_countWest > (_countEast + _countGuer)) then 
		{
			_sideCapturing = west; 
			_sideCapturingAmt = (_countWest - (_countEast + _countGuer)) min GW_SERVER_MAX_CAPTURE_STRENGTH;
		};
		
		if (_countEast > 0) then {_countEast = _countEast + _eastBonusCap};
		if (_countEast > (_countWest + _countGuer)) then 
		{
			_sideCapturing = east; 
			_sideCapturingAmt = (_counteast - (_countWest + _countGuer )) min GW_SERVER_MAX_CAPTURE_STRENGTH;
		};
		
		if (_countGuer > 0) then {_countGuer = _countGuer + _guerBonusCap};
		if (_countGuer > (_countWest + _countEast)) then 
		{
			_sideCapturing = guer; 
			_sideCapturingAmt = (_countGuer - (_countWest + _countEast)) min GW_SERVER_MAX_CAPTURE_STRENGTH;
		};

		//Capturing Depot
		if ((typeName _sideCapturing) != "STRING") then
		{
			//Raise strength if friendly re-capture, lower strength if enemy capture
			if (_sideCapturing == _currentOwner) then
			{
				if (_currentSupply < _maxSupply) then
				{
					_currentSupply = (_currentSupply + _sideCapturingAmt) min _maxSupply;
				};
			}
			else
			{
				_currentSupply = (_currentSupply - _sideCapturingAmt) max 0;
				_enemiesNearDepot = true;
				_updateClients = true;
			};
			
			//If strength is at 0, count camp as captured by capturing side
			if (_currentSupply < 1) then
			{
				//Get Zone Marker var name
				//DISABLED _depotMarker = format["%1_Depot",_depotObject]; 
				//DISABLED _campMarkers = [];
				
				//Get client lists
				_capturingClientList = [_sideCapturing, "netid"] Call fnc_shr_getSideMembers;
				_lostClientList = [_currentOwner, "netid"] Call fnc_shr_getSideMembers;
				_fullClientList = [_capturingClientList, _lostClientList] Call fnc_shr_mergeArrays;
				
				//Update zone count
				if (_sideCapturing != guer) then
				{
					_sideCapturingZoneVar = Format["GW_ZONESOWNED_%1",_sideCapturing];
					_sideCapturingZoneCount = (Call Compile _sideCapturingZoneVar) + 1;
					Call Compile Format["%1 = _sideCapturingZoneCount",_sideCapturingZoneVar];
					Call Compile Format ["publicVariable ""%1""",_sideCapturingZoneVar];
				};
				if (_currentOwner != guer) then
				{
					_sideLosingZoneVar = Format["GW_ZONESOWNED_%1",_currentOwner];
					_sideLosingZoneCount = (Call Compile _sideLosingZoneVar) - 1;
					Call Compile Format["%1 = _sideLosingZoneCount",_sideLosingZoneVar];
					Call Compile Format ["publicVariable ""%1""",_sideLosingZoneVar];
					
					//Update knows about (Making sure team who lost zone see the ownership change)
					_newKnowsAbout =+ _knowsAbout;
					{
						_newKnowsAboutIndex = [_currentOwner, 0, _newKnowsAbout] Call fnc_shr_arrayGetIndex;
						if (_newKnowsAboutIndex != -1) then
						{
							_newKnowsAbout set [_newKnowsAboutIndex, [_currentOwner, _sideCapturing, false]];
						};
						
						//Update camps
						{
							private["_knowsAboutInnerArr", "_knowsAboutIndex"];
							_knowsAboutInnerArr = _x select 5;
							
							_knowsAboutIndex = [_currentOwner, 0, _knowsAboutInnerArr] Call fnc_shr_arrayGetIndex;
							if (_knowsAboutIndex != -1) then
							{
								_knowsAboutInnerArr set [_knowsAboutIndex, [_currentOwner, _sideCapturing]];
							};
						} forEach _campArray;
					} forEach _newKnowsAbout;
					_updateClients = !(_newKnowsAbout isEqualTo _knowsAbout);
					_knowsAbout =+ _newKnowsAbout;
				};
				
				//Give experience and money to players of the team that captured in the zone area
				_xpAward = (round(_detectRad * GW_RANK_ZONE_CAPTURE)) max 1;
				_moneyAward = round(GW_SERVER_ZONE_CAPTURE_BONUS + (GW_SERVER_ZONE_CAPTURE_BONUS_CAMPS * (count _campArray)) + _detectRad);
				{
					if (((side _x) == _sideCapturing) && (isPlayer _x)) then
					{
						[(getPlayerUID _x), "+", _moneyAward] Spawn fnc_srv_changeMoney;
						[(getPlayerUID _x), "+", _xpAward] Spawn fnc_srv_changeRankPoints;
						[[owner _x], "messages", "", ["blueChat",["GWAR3_MoneyXP",[_moneyAward, _xpAward, format["capturing %1",_displayName]]]]] Spawn fnc_srv_requestClientExec;
					};
				} forEach _objectsIn;

				//Update flag texture
				_depotFlagObj setFlagTexture ([_sideCapturing] Call fnc_shr_getFlagTex);
				
				//Update depot vars
				_currentSupply = _maxSupply;
				_currentOwner = _sideCapturing;
				
				//Capture all camps
				{
					_campObj = _x select 0;
					_campStr = _x select 1;
					_campMaxStr = _x select 2;
					_campOwner = _x select 3;
					_campFlagObj = _x select 4;
					_campKnowsAbout = _x select 5;
					_campShortName = _x select 6;
					_campLongName = _x select 7;
					
					_campStr = _campMaxStr;
					_campOwner = _sideCapturing;
					_campFlagObj setFlagTexture ([_sideCapturing] Call fnc_shr_getFlagTex);
					//DISABLED _campMarkers set [count _campMarkers, (format["%1_Camp",_campObj])];
					
					//Update the marker colour
					//DISABLED (format["%1_Camp",_campObj]) setMarkerColor ([_sideCapturing, "class"] Call fnc_shr_getSideColour);
					
					_campArray set [_forEachIndex, [_campObj, _campStr, _campMaxStr, _campOwner, _campFlagObj, _campKnowsAbout, _campShortName, _campLongName]];
				} forEach _campArray;
				
				//Tell clients to perform update on zone status
				[_fullClientList, "zone", "captured", [_displayName, "", _sideCapturing, "", true]] Spawn fnc_srv_requestClientExec;
				
				//Update the marker colour
				//DISABLED _depotMarker setMarkerColor ([_sideCapturing, "class"] Call fnc_shr_getSideColour);
				_inactTimeout = 0;
				
				//Reset zone building queue
				_depotObject setVariable ["GW_CONSTRUCTION_QUEUE", [], false];
				_depotObject setVariable ["GW_CONSTRUCTION_BLOCKED", 30, true];
				
				//Clean up AI
				_defenseVehicles = [];
				{
					//Delete units inside group
					{
						if ((vehicle _x) != _x) then
						{
							_vehIndex = _defenseVehicles find (vehicle _x);
							if (_vehIndex == -1) then {_defenseVehicles pushBack (vehicle _x)};
						};
						
						if (alive _x) then {deleteVehicle _x};
					} forEach (units _x);
					
					//Delete vehicles
					{
						if (alive _x || (count (crew _x) == 0)) then {deleteVehicle _x};
					} forEach _defenseVehicles;
					
					//Delete group
					DeleteGroup _x;
				} forEach _defensesGroups;
				_defensesGroups = [];
				
				//Enemies are not at the depot anymore (technically)
				_enemiesNearDepot = false;
				
				//Update stub for clients
				_updateClients = true;
			};
		};
	};
	
	//Update zone array
	GW_ZONES set [_zoneIndex,[_depotObject,
							  _displayName,
							  _campArray,
							  _detectRad,
							  _detectPos,
							  _maxSupply,
							  _currentSupply,
							  _currentOwner,
							  _defensesGroups,
							  _inactTimeout,
							  _depotFlagObj,
							  _knowsAbout,
							  _lockDownTime,
							  _wealth,
							  _numDefenderSquads,
							  _timeTillLockdown,
							  _enemiesNearDepot]];
	//Update stub array							 
	GW_ZONES_STUB set [_zoneIndex,[_depotObject,
								   _detectPos,
								   _detectRad,
								   _displayName,
								   _currentOwner,
								   _wealth,
								   _campArray,
								   _defensesGroups,
								   _knowsAbout,
								   _currentSupply,
								   _maxSupply,
								   _hostilesPresent,
								   _enemiesNearDepot]];
								 
	//Update zone stub (for clients)
	if (_updateClients) then
	{
		_updateClients = false;
		publicVariable "GW_ZONES_STUB";
	};
	
	sleep GW_SERVER_UPDATE_ZONES;
};