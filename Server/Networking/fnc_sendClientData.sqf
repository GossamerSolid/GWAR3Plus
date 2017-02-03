//fnc_sendClientData.sqf
//Written by: GossamerSolid
//Sends back data requested to the client
//Since this executes dynamic code, the parameters will be searched for malicious strings (prevent unauthorized execution of code)
//@param _clientID - Network ID of client that asked for data
//***********************************************************//
//Examples (from client-side):
//Get all information from the 3rd territory
//["GW_CVAR_TERRITORY","territory","all",3] Spawn fnc_clt_requestServerData;
//Get the owner of the 5th territory
//["GW_CVAR_TERRITORY","territory","owner",5] Spawn fnc_clt_requestServerData;
//Get the inventory of the 0th establishment
//["GW_CVAR_ESTABLISHMENT","establishment","inventory",0] Spawn fnc_clt_requestServerData;
//***********************************************************//

if (!isServer) exitWith {diag_log text "###[GW ERROR] - Server\Networking\fnc_sendClientData.sqf must only be called server-side."};

//diag_log text format ["#### [SERVER - START] CLIENT REQUEST SERVER DATA - %1 - %2", time, _this];

_passedParams = _this select 0;
_clientObj = _passedParams select 0;
_clientGVar = _passedParams select 1;
_dataType = _passedParams select 2;
_dataRequest = _passedParams select 3;
_dataArguments = _passedParams select 4;
_returnData = [];

//waitUntil{GW_NETWORK_CALLS <= GW_SERVER_MAX_NETWORK_CALLS};
//GW_NETWORK_CALLS = GW_NETWORK_CALLS + 1;

//Check for malicious intent on behalf of the client
_maliciousIntent = false;
/*
_badStrings = [";", "[", "]", "{", "}", "Spawn", "Call", "Exec", "ExecVM", "set"];
{
	_currentParam = _x;
	{
		_found = [_x,_currentParam] Call fnc_shr_inString;
		if (_found) exitWith {_maliciousIntent = true};
	} forEach _badStrings;
	if (_maliciousIntent) exitWith {};
} forEach [_dataType, _dataRequest, _dataArguments];
*/

if (_maliciousIntent) then 
{
	_returnData = ["GW_NETCALL_MALICIOUSINTENT"];
}
else
{
	switch (_dataType) do
	{
		case "team":
		{
			switch (_dataRequest) do
			{
				case "startLoc":
				{
					_plySide = _dataArguments select 0;
					{
						if (_x select 0 == _plySide) exitWith {_returnData = [_x select 1]};
					} forEach GW_SPAWNLOCATIONSACTUAL;
				};
				case "supply":
				{
					_returnData = [Call Compile Format["GW_SUPPLY_%1",_dataArguments]];
				};
				case "basestructures":
				{
					_baseStructures = Call Compile Format["GW_BUILDINGS_BASE_%1",_dataArguments];
					_returnData = _baseStructures;
				};
				case "spawnablestructures":
				{
					_baseStructures = Call Compile Format["GW_BUILDINGS_BASE_%1",_dataArguments];
					_spawnable = [];
					{
						_structureArray = (_x getVariable "GW_STRUCTUID") Call fnc_srv_getStructureArray;
						if (_structureArray select 14) then {_spawnable set [count _spawnable, _x]};
					} foreach _baseStructures;
					_returnData = _spawnable;
				};
				case "supportorigins":
				{
					_playerSide = _dataArguments select 0;
					_playerPos = _dataArguments select 1;
					_returnData = [];
					
					//Get the support structures within range of the player
					_baseStructures = Call Compile Format["GW_BUILDINGS_BASE_%1",_playerSide];
					{
						_currStructure = _x;
						_structureArray = (_currStructure getVariable "GW_STRUCTUID") Call fnc_srv_getStructureArray;
						_propertiesArray = _structureArray select 21;
						{
							if (_x == "Service") exitWith {_returnData pushBack [_currStructure, (_structureArray select 1)]};
						} forEach _propertiesArray;
					} forEach _baseStructures; 
					
					//Get all zones
					{
						_currZone = _x;
						if ((_currZone select 7) == _playerSide) then {_returnData pushBack [(_currZone select 0), (_currZone select 1)]};
					} forEach GW_ZONES;
				};
				case "buildstructures":
				{
					_playerSide = _dataArguments select 0;
					_playerPos = _dataArguments select 1;
					_buildType = _dataArguments select 2;
					
					_buildStructs = [];
					
					//Get all zones
					if (_buildType == "Zone") then
					{
						{
							_currZone = _x;
							if ((_currZone select 7) == _playerSide) then {_buildStructs pushBack [(_currZone select 0), (_currZone select 1)]};
						} forEach GW_ZONES;
					}
					else
					{
						_baseStructures = Call Compile Format["GW_BUILDINGS_BASE_%1",_playerSide];
						{
							_structureArray = (_x getVariable "GW_STRUCTUID") Call fnc_srv_getStructureArray;
							if ((toLower(_buildType)) in (_structureArray select 13)) then 
							{
								_buildStructs pushBack [_x, (_structureArray select 1)];
							};
						} forEach _baseStructures;
					};
					
					_returnData = _buildStructs;
				};
				case "structurequeue":
				{
					_conQueue = _dataArguments getVariable ["GW_CONSTRUCTION_QUEUE", []];
					_returnQueue = [];
					{
						_uid = _x select 0;
						_timeLeft = _x select 1;
						_unitDisplay = "";
						
						//Vehicles
						if (((_x select 2) select 0) != "Infantry") then
						{
							_vehicleArray = ((_x select 2) select 1) Call fnc_srv_getVehicleArray;
							_unitDisplay = _vehicleArray select 1;
						}
						else //Infantry
						{
							_unitDisplay = ((_x select 2) select 1);
						};
						
						_returnQueue pushBack [_uid, _timeLeft, _unitDisplay];
					} forEach _conQueue;
					_returnData =+ _returnQueue;
				};
				case "commvotes":
				{
					_returnData = Call Compile Format["GW_COMMVOTES_%1",_dataArguments];
				};
				default
				{
					_returnData = ["GW_NETCALL_BADREQUEST"];
				};
			};
		};
		
		case "equipment":
		{
			switch (_dataRequest) do
			{
				case "sidelist":
				{
					_equipmentSide = _dataArguments select 0;
					_equipmentType = _dataArguments select 1;
					_returnData = [];
					
					//Parse through the data to only return equipment for the player's side
					_equipmentFullArray = Call Compile Format["GW_EQUIP_%1",_equipmentType];
					{
						if (_equipmentSide in (_x select 2)) then
						{
							_returnData set [count _returnData, _x];
						};
					} forEach _equipmentFullArray;
				};
				case "fulllist":
				{
					_returnData = GW_EQUIP_ALL;
				};
				case "templates":
				{
					_returnData = _dataArguments Call fnc_srv_getTemplates;
				};
			};
		};
		
		case "mhq":
		{
			default
			{
				_returnData = [Call Compile Format["GW_MHQ_%1",_dataRequest]];
			};
		};
		
		case "structures":
		{
			switch (_dataRequest) do
			{
				case "full":
				{
					_returnData = _dataArguments Call fnc_shr_getSideStructures;
				};

				case "uilist":
				{
					_sideStructures = _dataArguments Call fnc_shr_getSideStructures;
					_returnData = [];
					{
						_returnData set [count _returnData,[(_x select 0),
						                                    (_x select 1),
															(_x select 2),
															(_x select 11),
															(_x select 12),
															(_x select 5),
															(_x select 18),
															(_x select 17)]];
					} forEach _sideStructures;
				};
			};
		};
		
		case "units":
		{
			switch (_dataRequest) do
			{
				case "inflist":
				{
					_returnData = [];
					{
						if ((_x select 2) == _dataArguments) then {_returnData pushBack _x};
					} forEach GW_INFANTRY_LOADOUTS;
				};
				case "vehuilist":
				{
					_sideVehicles = _dataArguments Call fnc_shr_getSideVehicles;
					_returnData = [];
					{
						_crewCost = 0;
						if ((_x select 13) != "") then
						{
							_crewClass = (Call Compile Format ["GW_INFANTRY_%1",(_x select 13)]);
							_infantryArray = [_crewClass, (side _clientObj)] Call fnc_shr_getInfantryArray;
							_crewCost = (Call Compile Format["GW_GVAR_INFANTRY_BASECOST_%1",(side _clientObj)]) + (_infantryArray select 1);
						};
						_returnData pushBack [(_x select 0),
											  (_x select 1),
											  (_x select 2),
											  (_x select 3),
											  (_x select 5),
											  (_x select 6),
											  (_x select 8),
											  (_x select 11),
											  _crewCost];
					} forEach _sideVehicles;
				};
				case "spawnablevehs":
				{
					_sideVehicles = _dataArguments Call fnc_shr_getSideVehicles;
					_returnData = [];
					{
						if ("Spawnable" in (_x select 10)) then {_returnData pushBack [(_x select 1),(_x select 11)]};
					} forEach _sideVehicles;
				};
				case "serviceprices":
				{
					_currTeam = _dataArguments select 0;
					_vehUID = _dataArguments select 1;
					_vehArray = _vehUID Call fnc_srv_getVehicleArray;
					_vehiclePrice = _vehArray select 2;
					_rearmPrice = if ([_currTeam, "Logistics"] Call fnc_shr_isResearched) then {round(_vehiclePrice * GW_SERVER_SERVICE_REARM_UPG)} else {round(_vehiclePrice * GW_SERVER_SERVICE_REARM)};
					_repairPrice = if ([_currTeam, "Logistics"] Call fnc_shr_isResearched) then {round(_vehiclePrice * GW_SERVER_SERVICE_REPAIR_UPG)} else {round(_vehiclePrice * GW_SERVER_SERVICE_REPAIR)};
					_refuelPrice = if ([_currTeam, "Logistics"] Call fnc_shr_isResearched) then {round(_vehiclePrice * GW_SERVER_SERVICE_REFUEL_UPG)} else {round(_vehiclePrice * GW_SERVER_SERVICE_REFUEL)};
					if ((_vehArray select 7) == "vehscript_init_mhq.sqf") then {_repairPrice = _vehiclePrice};
					_returnData = [_repairPrice, _refuelPrice, _rearmPrice];
				};
			};
		};
		
		case "zone":
		{
			switch (_dataRequest) do
			{
				case "all":
				{
					_zoneArray = GW_ZONES select _dataArguments;
					
					_campArray = [];
					{
						_campArray set [count _campArray, [vehicleVarName (_x select 0),
						                                   _x select 1,
														   _x select 2,
														   _x select 3,
														   _x select 6,
														   _x select 7]];
					} forEach (_zoneArray select 2);
					
					_returnData = [vehicleVarName (_zoneArray select 0),
					               _zoneArray select 1,
					               _campArray,
								   _zoneArray select 3,
								   _zoneArray select 4,
								   _zoneArray select 5,
								   _zoneArray select 6,
								   _zoneArray select 7,
								   _zoneArray select 12,
								   _zoneArray select 15];
				};
				case "knowsAbout":
				{
					_returnData = (GW_ZONES select _dataArguments) select 11;
				};
				default
				{
					_returnData = ["GW_NETCALL_BADREQUEST"];
				};
			};
		};
		
		case "client":
		{
			switch (_dataRequest) do
			{
				case "boughtgear":
				{
					_containerVar = format["GW_SESSION_%1",_dataArguments];
					_plyContainer = missionNamespace getVariable _containerVar;
					
					_returnData = [_plyContainer select 5];
				};
				
				case "rankinfo":
				{
					_containerVar = format["GW_SESSION_%1",_dataArguments];
					_plyContainer = missionNamespace getVariable _containerVar;
					
					_currentRank = _plyContainer select 9;
					_accumulatedPoints = _plyContainer select 11;
					
					_rankIndex = [_currentRank, 0, GW_RANKS] Call fnc_shr_arrayGetIndex;
					_pointsNext = (GW_RANKS select _rankIndex) select 1;
					
					_returnData = [_currentRank, _accumulatedPoints, _pointsNext];
				};
				
				case "lastpurchasedtemplate":
				{
					_containerVar = format["GW_SESSION_%1",_dataArguments];
					_plyContainer = missionNamespace getVariable _containerVar;
					
					_returnData = _plyContainer select 5;
				};
			};
		};
		
		//If the switch gets to this block, it was a bad request
		default
		{
			_returnData = ["GW_NETCALL_BADREQUEST"];
		};
	};
};

//GW_NETWORK_CALLS = GW_NETWORK_CALLS - 1;

//Broadcast Value
_clientID = owner _clientObj;
Call Compile Format ["%1 = _returnData",_clientGVar];
Call Compile Format ["_clientID publicVariableClient ""%1""",_clientGVar];
//diag_log text format ["#### [SERVER - FINISH] CLIENT REQUEST SERVER DATA - %1 - %2", time, _this];