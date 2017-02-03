private["_side","_teamStructures","_queueList","_buildQueue","_currentQueue","_removeIndexes","_structure","_structureArray","_buildPos","_nearEntities","_sideClients","_warningTimeout"];
_side = _this;

while {GW_GAMERUNNING} do
{
	_queueList = [];
	_zoneList = [];
	_teamStructures = Call Compile Format["GW_BUILDINGS_BASE_%1",_side];
	{
		_currZone = _x;
		if ((_currZone select 7) == _side) then {_zoneList pushBack (_currZone select 0)};
	} forEach GW_ZONES;
	_queueList = [_teamStructures, _zoneList] Call fnc_shr_mergeArrays;
	
	{
		_structure = _x;
		if (!isNull _structure) then
		{
			_removeIndexes = [];
			_buildQueue = _x getVariable "GW_CONSTRUCTION_QUEUE";
			_warningTimeout = _x getVariable "GW_CONSTRUCTION_BLOCKED";
			_timesWarned = _x getVariable "GW_CONSTRUCTION_BLOCKED_COUNT";
			if ((count _buildQueue) > 0) then
			{
				_currentQueue = _buildQueue select 0;
				_timeLeft = _currentQueue select 1;
				if (_timeLeft < 1) then
				{
					if (_structure isKindOf GW_DATA_ZONEDEPOT_CLASS) then
					{
						[_structure, _currentQueue] Spawn fnc_srv_handleStructQueueItem;
						_buildQueue deleteAt 0;
						_removeIndexes set [count _removeIndexes, _forEachIndex];
						_x setVariable ["GW_CONSTRUCTION_BLOCKED", 30, false];
						_x setVariable ["GW_CONSTRUCTION_BLOCKED_COUNT", 0, false];
					}
					else
					{
						//There can't be vehicles within a certain amount of meters of the buildpos
						_structureArray = (_structure getVariable "GW_STRUCTUID") Call fnc_srv_getStructureArray;
						_buildPos = _structure modelToWorld (_structureArray select 20);
						_canBeObstructed = (_structureArray select 22) select 0;
						
						//Get nearest objects
						_nearEntities = [];
						if (_canBeObstructed) then
						{
							_nearEntities = nearestObjects [_buildPos, ["Car","Tank","Air","Ship",GW_DATA_INFANTRYCLASS_EAST,GW_DATA_INFANTRYCLASS_GUER,GW_DATA_INFANTRYCLASS_WEST], (_structureArray select 22) select 1];
								
							//If nearest object is dead, clean it up
							if ((count _nearEntities) > 0) then
							{
								_nearest = _nearEntities select 0;
								if (!alive _nearest) then 
								{
									deleteVehicle _nearest;
									_nearEntities = _nearEntities - [_nearest];
								};
							};
						};
						
						//Construction obstructed?
						if ((count _nearEntities) < 1 || !_canBeObstructed) then
						{
							[_structure, _currentQueue] Spawn fnc_srv_handleStructQueueItem;
							_buildQueue deleteAt 0;
							_removeIndexes set [count _removeIndexes, _forEachIndex];
							_x setVariable ["GW_CONSTRUCTION_BLOCKED", 30, false];
							_x setVariable ["GW_CONSTRUCTION_BLOCKED_COUNT", 0, false];
						}
						else
						{
							_warningTimeout = _warningTimeout - 1;
							diag_log text format["###[GW WARNING] - fnc_updateStructQueues.sqf %1's build queue cannot process because there is an object in the way - %2 (%3)",_x,_nearEntities select 0,typeOf (_nearEntities select 0)];
							if (_warningTimeout <= 1) then
							{
								if (_timesWarned >= 1) then
								{
									//Move the object elsewhere
									_nuisanceObj = (_nearEntities select 0);
									_randomPos = [(getPosATL _nuisanceObj), random(150 * 0.25), 150, false, (typeOf _nuisanceObj)] Call fnc_shr_getRandPos;
									while {(_randomPos select 0) == -1} do
									{
										_randomPos = [(getPosATL _nuisanceObj), random(150 * 0.25), 150, false, (typeOf _nuisanceObj)] Call fnc_shr_getRandPos;
									};
									_nuisanceObj setPosATL _randomPos;
									_x setVariable ["GW_CONSTRUCTION_BLOCKED_COUNT", 0, false];
								}
								else
								{
									_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
									[_sideClients, "structure", "productionblocked", [(_structureArray select 1), _buildPos]] Spawn fnc_srv_requestClientExec;
									_x setVariable ["GW_CONSTRUCTION_BLOCKED_COUNT",(_timesWarned + 1), false];
								};
								
								_x setVariable ["GW_CONSTRUCTION_BLOCKED", 30, false];
							}
							else
							{
								_x setVariable ["GW_CONSTRUCTION_BLOCKED", _warningTimeout, false];
							};
						};
					};
				}
				else
				{
					_currentQueue set [1, (_timeLeft - 1)];
					_buildQueue set [0, _currentQueue];
				};
			}; //forEach _buildQueue;
			
			//Update build queue var
			if (!isNull _structure) then {_structure setVariable ["GW_CONSTRUCTION_QUEUE", _buildQueue]};
		};
	} forEach _queueList;
	
	sleep 1;
};