//fnc_UpdateInactiveCollector.sqf
//Written by - GossamerSolid
//Handles inactive vehicle collection update for GWAR3

private["_inactiveIndexes", "_object", "_timer", "_side", "_vehUID"];

while {GW_GAMERUNNING} do
{
	//Update inactive queue contents
	{
		//Only update if array - otherwise it's an item that should be removed from the queue
		if (typeName _x == "ARRAY") then
		{
			_object = _x select 0;
			_timer = _x select 1;
			
			//If it's not alive, should be removed as it'll be dealt with via garbage collection
			if (alive _object) then
			{
				//Delete object and mark index for removal if time is lower than 1, otherwise decrement time
				if (_timer < 1) then
				{
					//If there are players around it, it shouldn't be deleted (within 200m)
					_entities = nearestObjects [(getPosATL _object), ["Car","Tank","Air","Ship",GW_DATA_INFANTRYCLASS_EAST,GW_DATA_INFANTRYCLASS_GUER,GW_DATA_INFANTRYCLASS_WEST], 200];
					_playerPresent = false;
					{
						if (isPlayer _x) exitWith {_playerPresent = true};
					} forEach _entities;
					
					if (_playerPresent) then
					{
						GW_INACTIVE set [_forEachIndex, [_object, 60]]; // Try again in a minute
					}
					else
					{
						//Remove it from the team vehicles list
						_vehIndex = GW_VEHICLES_WEST find _object;
						if (_vehIndex != -1) then
						{
							GW_VEHICLES_WEST deleteAt _vehIndex;
							_sideClients = [west, "netid"] Call fnc_shr_getSideMembers;
							{
								GW_CVAR_VEHICLES = GW_VEHICLES_WEST;
								_x publicVariableClient "GW_CVAR_VEHICLES";
							} forEach _sideClients;
						};
						_vehIndex = GW_VEHICLES_EAST find _object;
						if (_vehIndex != -1) then
						{
							GW_VEHICLES_EAST deleteAt _vehIndex;
							_sideClients = [east, "netid"] Call fnc_shr_getSideMembers;
							{
								GW_CVAR_VEHICLES = GW_VEHICLES_EAST;
								_x publicVariableClient "GW_CVAR_VEHICLES";
							} forEach _sideClients;
						};
						
						//Run the destruct script
						_vehUID = _object getVariable "GW_UNIQUEID";
						if (!isNil "_vehUID") then
						{
							_vehicleArray = _vehUID Call fnc_srv_getVehicleArray;
							_vehicleScript = _vehicleArray select 12;
							if (_vehicleScript != "") then
							{
								//Execute the script - ALL arguments passed to fnc_unitKilled + the specific object are available in the script as well
								_scriptCode = Compile preprocessFileLineNumbers (format["Shared\Configuration\VehicleScripts\%1", _vehicleScript]);
								if (!isNil "_scriptCode") then 
								{
									_scriptWait = [_object, ["","",_side]] Spawn _scriptCode;
									waitUntil {scriptDone _scriptWait};
								}
								else
								{
									diag_log text "###[GW ERROR] - fnc_updateInactiveCollector.sqf could not execute a vehicle initialization script.";
								};
							};
						};
						
						//Remove the vehicle
						deleteVehicle _object;
						GW_INACTIVE set [_forEachIndex, -1];
					};
				}
				else
				{
					GW_INACTIVE set [_forEachIndex, [_object, (_timer - GW_SERVER_UPDATE_GARBAGE)]];
				};
			}
			else
			{
				GW_INACTIVE set [_forEachIndex, -1];
			};
		};
	} forEach GW_INACTIVE;
	
	//Run through and remove deleted indexes
	{
		GW_INACTIVE = GW_INACTIVE - [-1];
	} forEach GW_INACTIVE;
	
	sleep GW_SERVER_UPDATE_GARBAGE;
};