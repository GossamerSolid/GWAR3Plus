//fnc_clientExec.sqf
//Written by: GossamerSolid
//Used for allowing the client to ask the server to execute code
//Since this executes dynamic code, the parameters will be searched for malicious strings (prevent unauthorized execution of code)
//@param _clientID - Network ID of client that asked for data

if (!isServer) exitWith {diag_log text "###[GW ERROR] - Server\Networking\fnc_clientExec.sqf must only be called server-side."};

private["_passedParams", "_clientObj", "_dataType", "_dataRequest", "_dataArguments", "_synchedCallVar"];
_passedParams = _this select 0;
_clientObj = _passedParams select 0;
_dataType = _passedParams select 1;
_dataRequest = _passedParams select 2;
_dataArguments = _passedParams select 3;
_synchedCallVar = if ((count _passedParams) > 4) then {_passedParams select 4} else {""};
_returnData = [""];

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
	_returnData = "MALICIOUSINTENT";
}
else
{
	switch (_dataType) do
	{
		case "construction":
		{
			switch (_dataRequest) do
			{
				case "build":
				{
					_returnData = _dataArguments Call fnc_srv_createStructure;
				};
				
				case "disband":
				{
					_side = _dataArguments select 0;
					_object = _dataArguments select 1;
					_buildType = _dataArguments select 2;
					_returnData = [false, "Unexpected error"];

					_structures = Call Compile Format["GW_BUILDINGS_%1_%2", _buildType, _side];
					_structIndex = _structures find _object;
					if (_structIndex != -1) then
					{
						//Get structure array
						_structureArray = (_object getVariable "GW_STRUCTUID") Call fnc_srv_getStructureArray;
						
						//Check for enemies within 300m
						_hostiles = [_side, (getPosATL _object), 300] Call fnc_shr_getHostilesInArea;
						if (_hostiles <= 0) then 
						{
							//Was the structure attacked within 5 minutes ago?
							_damageTimer = _object getVariable ["GW_DAMAGE_TIMEOUT", -1];
							if (((GW_TIME_ELAPSED - _damageTimer) > 300) || (_damageTimer == -1)) then
							{
								//Refunds based on time elapsed
								_refundSupplies = 0;
								if ((GW_TIME_ELAPSED - (_object getVariable ["GW_TIMECREATED", 0])) <= 60) then
								{
									_refundSupplies = _structureArray select 2;
								}
								else
								{
									if ((GW_TIME_ELAPSED - (_object getVariable ["GW_TIMECREATED", 0])) <= 300) then
									{
										_refundSupplies = round((_structureArray select 2) * 0.5);
									};
								};
								
								//Refund supplies (if eligible) and send notification
								_disbandTeamList = [_side, "netid"] Call fnc_shr_getSideMembers;
								if (_refundSupplies > 0) then
								{
									[_side, "+", _refundSupplies] Spawn fnc_srv_changeSupply;
									[_disbandTeamList, "messages", "", ["notification",["GWAR3_StructureDisband_Refund",[(_structureArray select 12), (_structureArray select 1), (mapGridPosition _object), _refundSupplies]]]] Spawn fnc_srv_requestClientExec;
								}
								else
								{
									[_disbandTeamList, "messages", "", ["notification",["GWAR3_StructureDisband",[(_structureArray select 12), (_structureArray select 1), (mapGridPosition _object)]]]] Spawn fnc_srv_requestClientExec;
								};
								
								//Remove the helper if there is one
								_helperObj = _object getVariable ["GW_STRUCTHELPER", objNull];
								if (!isNull _helperObj) then {deleteVehicle _helperObj};
								
								//Remove team flag object
								_flagObj = _object getVariable ["GW_FLAGOBJ", objNull];
								if (!isNull _flagObj) then {deleteVehicle _flagObj};
								
								//Delete object
								deleteVehicle _object;
								
								//Remove structure from building array
								Call Compile Format["GW_BUILDINGS_%1_%2 deleteAt _structIndex;", _buildType, _side];
								
								//Broadcast values to clients
								if (_buildType == "base") then
								{
									GW_CVAR_BUILDINGS_BASE = (Call Compile Format["GW_BUILDINGS_BASE_%1", _side]);
									_teamList = [_side, "netid"] Call fnc_shr_getSideMembers;
									{
										_x publicVariableClient "GW_CVAR_BUILDINGS_BASE";
									} forEach _teamList;
								}
								else
								{
									GW_CVAR_BUILDINGS_DEF = (Call Compile Format["GW_BUILDINGS_DEF_%1", _side]);
									_teamList = [_side, "netid"] Call fnc_shr_getSideMembers;
									{
										_x publicVariableClient "GW_CVAR_BUILDINGS_DEF";
									} forEach _teamList;
								};

								//Return data
								_returnData = [true, "success"];
							}
							else
							{
								_returnData = [false, "Structure was attacked less than 5 minutes ago"];
							};
						}
						else
						{
							_returnData = [false, "Enemy units near structure"];
						};
					};
				};
			};
		};
		
		case "commvoting":
		{
			switch (_dataRequest) do
			{
				case "init":
				{
					_returnData = _dataArguments Call fnc_srv_initCommVote;
				};
				
				case "vote":
				{
					_returnData = _dataArguments Call fnc_srv_playerVote;
				};
			};
		};
		
		case "units":
		{
			switch (_dataRequest) do
			{
				case "buy":
				{
					_playerUID = _dataArguments select 0;
					_structureObj = _dataArguments select 1;
					_queueArray = _dataArguments select 2;
					_returnData = [false, "Unexpected Error"];
					
					//Not null object
					if (!isNull _structureObj) then
					{
						//Alive
						if (alive _structureObj) then
						{
							_unitBuildTime = 0;
							_playerObj = _playerUID Call fnc_shr_getObjFromUID;
							_playerMoney = _playerUID Call fnc_srv_getPlayerMoney;
							
							//Get squad sizes
							_squadSize = _playerObj Call fnc_shr_getSquadSize;
							_maxSquadSize = _playerUID Call fnc_srv_getMaxSquadSize;
							_alreadyQueued = [_playerUID, (_playerObj Call fnc_shr_getObjSide)] Call fnc_srv_countInfantryInQueue;
							
							//Does the team have mobilization researched
							_hasMobilization = [(_playerObj Call fnc_shr_getObjSide), "Limited Mobilization"] Call fnc_shr_isResearched;
							_hasFullMobilization = [(_playerObj Call fnc_shr_getObjSide), "Full Mobilization"] Call fnc_shr_isResearched;
							
							//Infantry
							if ((_queueArray select 0) == "Infantry") then
							{
								//If there's enough room, start the building
								if ((_squadSize + _alreadyQueued + 1) <= _maxSquadSize) then
								{
									_unitArray = [_queueArray select 1, _queueArray select 2] Call fnc_shr_getInfantryArray;
									_unitBuildTime = _unitArray select 4;
									if (_hasMobilization) then {_unitBuildTime = round(_unitBuildTime - (_unitBuildTime * GW_GVAR_MOBILIZATION_INFTIME))};
									if (_hasFullMobilization) then {_unitBuildTime = round(_unitBuildTime - (_unitBuildTime * GW_GVAR_FULL_MOBILIZATION_INFTIME))};
									_unitCost = _unitArray select 1;
									_totalCost = (Call Compile Format["GW_GVAR_INFANTRY_BASECOST_%1",(_queueArray select 2)]) + _unitCost;
									if (_hasMobilization) then {_totalCost = round(_totalCost - (_totalCost * GW_GVAR_MOBILIZATION_DISCOUNT))};
									if (_hasFullMobilization) then {_totalCost = round(_totalCost - (_totalCost * GW_GVAR_FULL_MOBILIZATION_DISCOUNT))};
									_queueArray pushBack _totalCost;
									if (_playerMoney >= _totalCost) then
									{
										[_playerUID, "-", _totalCost] Call fnc_srv_changeMoney;
										_structureQueue = _structureObj getVariable "GW_CONSTRUCTION_QUEUE";
										_structureQueue pushBack [_playerUID, _unitBuildTime, _queueArray];
										_structureObj setVariable["GW_CONSTRUCTION_QUEUE",_structureQueue];
										_returnData = [true, "Unit added to construction queue"];
									}
									else
									{
										_returnData = [false, "Insufficient Funds"];
									};
								}
								else
								{
									_returnData = [false, format["Squad is at maximum size (Squad Size: %1/In Build Queue: %2)",_squadSize, _alreadyQueued]];
								};
							}
							else //Vehicle
							{
								//Check if selected crew can fit in player's squad
								_crewCount = 0;
								{if (_x) then {_crewCount = _crewCount + 1};} forEach (_queueArray select 3);
								
								//If there's enough room
								if (((_squadSize + _crewCount + _alreadyQueued) <= _maxSquadSize) || _crewCount == 0) then
								{
									_vehicleArray = (_queueArray select 1) Call fnc_srv_getVehicleArray;
									_unitBuildTime = _vehicleArray select 8;
									if (_hasMobilization) then {_unitBuildTime = round(_unitBuildTime - (_unitBuildTime * GW_GVAR_MOBILIZATION_VEHTIME))};
									if (_hasFullMobilization) then {_unitBuildTime = round(_unitBuildTime - (_unitBuildTime * GW_GVAR_FULL_MOBILIZATION_VEHTIME))};
									_vehicleCost = _vehicleArray select 2;
									if (_hasMobilization) then {_vehicleCost = round(_vehicleCost - (_vehicleCost * GW_GVAR_MOBILIZATION_DISCOUNT))};
									if (_hasFullMobilization) then {_vehicleCost = round(_vehicleCost - (_vehicleCost * GW_GVAR_FULL_MOBILIZATION_DISCOUNT))};
									if ((_vehicleArray select 0) isKindOf "Air") then
									{
										if ((_playerObj getVariable ["GW_SPECIALIZATION", ""]) == "Pilot") then {_vehicleCost = round(_vehicleCost - (_vehicleCost * 0.20))};
									};
									_vehicleCrew = _vehicleArray select 13;
									_crewClass = if (_vehicleCrew == "") then {""} else {(Call Compile Format ["GW_INFANTRY_%1",_vehicleCrew])};
									_totalCost = 0;
									
									//Figure out cost
									if (_crewClass != "") then
									{
										_infantryArray = [_crewClass, (_playerObj Call fnc_shr_getObjSide)] Call fnc_shr_getInfantryArray;
										_totalCost = (((Call Compile Format["GW_GVAR_INFANTRY_BASECOST_%1",(_playerObj Call fnc_shr_getObjSide)]) + (_infantryArray select 1)) * _crewCount) + _vehicleCost;
									}
									else
									{
										_totalCost = _vehicleCost;
									};
									
									//If player can afford
									if (_playerMoney >= _totalCost) then
									{
										[_playerUID, "-", _totalCost] Call fnc_srv_changeMoney;
										_queueArray pushBack _totalCost;
										_structureQueue = _structureObj getVariable "GW_CONSTRUCTION_QUEUE";
										_structureQueue pushBack [_playerUID, _unitBuildTime, _queueArray];
										_structureObj setVariable["GW_CONSTRUCTION_QUEUE",_structureQueue];
										_returnData = [true, "Unit added to construction queue"];
									}
									else
									{
										_returnData = [false, "Insufficient Funds"];
									};
								}
								else
								{
									_returnData = [false, format["Squad is at maximum size (Squad Size: %1/Crew Size: %2/Already Queued: %3/Max Squad Size: %4)",_squadSize,_crewCount,_alreadyQueued,_maxSquadSize]];
								};
							};
						}
						else
						{
							_returnData = [false, "Building Destroyed"];
						};
					}
					else
					{
						_returnData = [false, "Building Destroyed"];
					};
				};
				
				case "cancel":
				{
					_playerSide = _dataArguments select 0;
					_selectedStructure = _dataArguments select 1;
					_selectedIndex = _dataArguments select 2;
					_playerUID = _dataArguments select 3;
					_returnData = [];
					
					_fullList = [];
					_zoneList = [];
					_teamStructures = Call Compile Format["GW_BUILDINGS_BASE_%1",_playerSide];
					{
						_currZone = _x;
						if ((_currZone select 7) == _playerSide) then {_zoneList pushBack (_currZone select 0)};
					} forEach GW_ZONES;
					_fullList = [_teamStructures, _zoneList] Call fnc_shr_mergeArrays;
					
					_structIndex = _fullList find _selectedStructure;
					if (_structIndex != -1) then
					{
						_queueStructure = _fullList select _structIndex;
						_queue = _queueStructure getVariable "GW_CONSTRUCTION_QUEUE";
						_selectedQueueItem = _queue select _selectedIndex;
						if ((_selectedQueueItem select 0) == _playerUID) then
						{
							_queue deleteAt _selectedIndex;
							_queueStructure setVariable ["GW_CONSTRUCTION_QUEUE", _queue];
							
							//Refund the player
							_totalCost = 0;
							if (((_selectedQueueItem select 2) select 0) == "Infantry") then
							{
								_unitArray = [((_selectedQueueItem select 2) select 1), ((_selectedQueueItem select 2) select 2)] Call fnc_shr_getInfantryArray;
								_unitCost = _unitArray select 1;
								_totalCost = (Call Compile Format["GW_GVAR_INFANTRY_BASECOST_%1",((_selectedQueueItem select 2) select 2)]) + _unitCost;
							}
							else
							{
								_crewCount = 0;
								{if (_x) then {_crewCount = _crewCount + 1};} forEach ((_selectedQueueItem select 2) select 3);
								
								_vehicleArray = ((_selectedQueueItem select 2) select 1) Call fnc_srv_getVehicleArray;
								_vehicleCost = _vehicleArray select 2;
								_vehicleCrew = _vehicleArray select 13;
								_crewClass = if (_vehicleCrew == "") then {""} else {(Call Compile Format ["GW_INFANTRY_%1",_vehicleCrew])};
									
								if (_crewClass != "") then
								{
									_infantryArray = [_crewClass, _playerSide] Call fnc_shr_getInfantryArray;
									_totalCost = (((Call Compile Format["GW_GVAR_INFANTRY_BASECOST_%1",_playerSide]) + (_infantryArray select 1)) * _crewCount) + _vehicleCost;
								}
								else
								{
									_totalCost = _vehicleCost;
								};
							};
							
							if (_totalCost > 0) then
							{
								_returnData = [true, format["$%1 refunded",_totalCost]];
								[_playerUID, "+", _totalCost] Call fnc_srv_changeMoney;
							}
							else
							{
								_returnData = [false, "Unexpected error"];
							};
						}
						else
						{
							_returnData = [false, "This is not your unit"];
						};
					}
					else
					{
						_returnData = [false, "Unexpected error"];
					};
				};
				
				case "servicebuy":
				{
					_playerUID = _dataArguments select 0;
					_serviceType = _dataArguments select 1;
					_vehUID = _dataArguments select 2;
					_playerSide = _dataArguments select 3;
					_origUnit = _dataArguments select 4;
					
					_returnData = [false, "Unexpected Error"];
					
					_vehArray = _vehUID Call fnc_srv_getVehicleArray;
					_vehiclePrice = _vehArray select 2;
					if ((_vehArray select 7) == "vehscript_init_mhq.sqf") then 
					{
						if (!GW_SERVER_SUDDENDEATH) then
						{
							_availableSupply = (Call Compile Format["GW_SUPPLY_%1",_playerSide]);
							if ((_availableSupply - _vehiclePrice) >= 0) then
							{
								[_playerSide, "-", _vehiclePrice] Spawn fnc_srv_changeSupply;
								_returnData = [true, "Success"];
								[(_vehArray select 0), (getPosATL _origUnit), (direction _origUnit), ["", false], _playerSide, _vehArray] Spawn fnc_srv_createVehicle;
								deleteVehicle _origUnit;
							}
							else
							{
								_returnData = [false, "Insufficient Supply"];
							};
						}
						else
						{
							_returnData = [false, "Cannot repair MHQ during sudden death"];
						};
					}
					else
					{
						_serviceCost = 0;
						if (_serviceType == "repair") then {_serviceCost = if ([_playerSide, "Logistics"] Call fnc_shr_isResearched) then {round(_vehiclePrice * GW_SERVER_SERVICE_REPAIR_UPG)} else {round(_vehiclePrice * GW_SERVER_SERVICE_REPAIR)};};
						if (_serviceType == "refuel") then {_serviceCost = if ([_playerSide, "Logistics"] Call fnc_shr_isResearched) then {round(_vehiclePrice * GW_SERVER_SERVICE_REFUEL_UPG)} else {round(_vehiclePrice * GW_SERVER_SERVICE_REFUEL)};};
						if (_serviceType == "rearm") then {_serviceCost = if ([_playerSide, "Logistics"] Call fnc_shr_isResearched) then {round(_vehiclePrice * GW_SERVER_SERVICE_REARM_UPG)} else {round(_vehiclePrice * GW_SERVER_SERVICE_REARM)};};
						
						_playerMoney = _playerUID Call fnc_srv_getPlayerMoney;
						if (_playerMoney >= _serviceCost) then
						{
							[_playerUID, "-", _serviceCost] Call fnc_srv_changeMoney;
							_returnData = [true, "Success"];
						}
						else
						{
							_returnData = [false, "Insufficient Funds"];
						};
					};
				};
			};
		};
		
		case "equipment":
		{
			switch (_dataRequest) do
			{
				case "templatenew":
				{
					_returnData = [false, "Unexpected Error"];
					_playerUID = _dataArguments select 0;
					_newTemplateName = _dataArguments select 1;
					_equipmentArray = _dataArguments select 2;
					
					_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
					if (!isNil "_sessionContainer") then
					{
						_playerTemplates = _sessionContainer select 12;
						
						//Max number of templates check
						if (count(_playerTemplates) >= 5) then
						{
							_returnData = [false, "Maximum number of templates reached (5)"];
						}
						else
						{
							//Duplicate check
							_templateIndex = [_newTemplateName, 0, _playerTemplates] Call fnc_shr_arrayGetIndex;
							if (_templateIndex == -1) then
							{
								//Validate that equipment in template is valid for the player's side
								_playerObj = _playerUID Call fnc_shr_getObjFromUID;
								_playerSide = _playerObj Call fnc_shr_getObjSide;
								_equipmentValid = [_equipmentArray, _playerSide] Call fnc_shr_getEquipmentValid;
								if (_equipmentValid) then
								{
									//Add it to the player's templates
									_playerTemplates pushBack [_newTemplateName, true, _equipmentArray, false];
									_sessionContainer set [12, _playerTemplates];
									
									//Update session container
									missionNamespace setVariable [format["GW_SESSION_%1",_playerUID], _sessionContainer];
									
									//Update the database
									if (GW_DATABASE) then 
									{
										_dbRequest = "UpdatePlayerTemplates";
										if (GW_GWPLUS) then {_dbRequest = "UpdatePlayerTemplates+"};
										["", ["db"], [GW_SERVERKEY, _dbRequest, _playerUID, _playerSide, _playerTemplates]] Spawn fnc_srv_spawnExtension;
									};
									
									//Price the template for the client
									_templatePrice = _equipmentArray Call fnc_shr_getEquipmentCost;
									_returnData = [true, _templatePrice];
								}
								else
								{
									_returnData = [false, "Template contains items not available for your team!"];
								};
							}
							else
							{
								_returnData = [false, "Template names must be unique"];
							};
						};
					};
				};
				
				case "templateupdate":
				{
					_returnData = [false, "Unexpected Error"];
					_playerUID = _dataArguments select 0;
					_templateUpdateName = _dataArguments select 1;
					_equipmentArray = _dataArguments select 2;
					
					_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
					if (!isNil "_sessionContainer") then
					{
						_playerTemplates = _sessionContainer select 12;
						
						//Find index of template
						_templateIndex = [_templateUpdateName, 0, _playerTemplates] Call fnc_shr_arrayGetIndex;
						if (_templateIndex != -1) then
						{
							//Validate that equipment in template is valid for the player's side
							_playerObj = _playerUID Call fnc_shr_getObjFromUID;
							_playerSide = _playerObj Call fnc_shr_getObjSide;
							_equipmentValid = [_equipmentArray, _playerSide] Call fnc_shr_getEquipmentValid;
							if (_equipmentValid) then
							{
								//Update template's equip array
								_playerTemplates set [_templateIndex, [_templateUpdateName, true, _equipmentArray, false]];
								_sessionContainer set [12, _playerTemplates];
								
								//Update session container
								missionNamespace setVariable [format["GW_SESSION_%1",_playerUID], _sessionContainer];
								
								//Update the database
								if (GW_DATABASE) then 
								{
									_dbRequest = "UpdatePlayerTemplates";
									if (GW_GWPLUS) then {_dbRequest = "UpdatePlayerTemplates+"};
									["", ["db"], [GW_SERVERKEY, _dbRequest, _playerUID, _playerSide, _playerTemplates]] Spawn fnc_srv_spawnExtension;
								};
								
								//Price the template for the client
								_templatePrice = _equipmentArray Call fnc_shr_getEquipmentCost;
								_returnData = [true, _templatePrice];
							}
							else
							{
								_returnData = [false, "Template contains items not available for your team!"];
							};
						}
						else
						{
							_returnData = [false, "Unable to find template to update"];
						};
					};
				};
				
				case "templatedelete":
				{
					_returnData = [false, "Unexpected Error"];
					_playerUID = _dataArguments select 0;
					_templateDeleteName = _dataArguments select 1;
					
					_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
					if (!isNil "_sessionContainer") then
					{
						_playerTemplates = _sessionContainer select 12;
						
						//Find index of template
						_templateIndex = [_templateDeleteName, 0, _playerTemplates] Call fnc_shr_arrayGetIndex;
						if (_templateIndex != -1) then
						{
							_playerObj = _playerUID Call fnc_shr_getObjFromUID;
							_playerSide = _playerObj Call fnc_shr_getObjSide;
							
							//Remove entry from player's template array
							_playerTemplates deleteAt _templateIndex;
							_sessionContainer set [12, _playerTemplates];
							
							//Update session container
							missionNamespace setVariable [format["GW_SESSION_%1",_playerUID], _sessionContainer];
							
							//Update the database
							if (GW_DATABASE) then 
							{
								_dbRequest = "UpdatePlayerTemplates";
								if (GW_GWPLUS) then {_dbRequest = "UpdatePlayerTemplates+"};
								["", ["db"], [GW_SERVERKEY, _dbRequest, _playerUID, _playerSide, _playerTemplates]] Spawn fnc_srv_spawnExtension;
							};
							
							_returnData = [true, ""];
						}
						else
						{
							_returnData = [false, "Unable to find template to delete"];
						};
					};
				};
				
				case "buy":
				{
					_returnData = [false, "Unexpected Error"];
					_playerUID = _dataArguments select 0;
					_equipmentArray = _dataArguments select 1;
					_fromDeploy = _dataArguments select 2;
					_requiresFullAmount = if (count _dataArguments > 3) then {_dataArguments select 3} else {false};
					
					_playerObj = _playerUID Call fnc_shr_getObjFromUID;
					_playerSide = _playerObj Call fnc_shr_getObjSide;
					
					_equipArrayCost = _equipmentArray Call fnc_shr_getEquipmentCost;
					_moneyVal = 0;
					if (!_fromDeploy) then
					{
						_playerEquip = _playerObj Call fnc_shr_getEquipArray;
						_playerEquipCost = _playerEquip Call fnc_shr_getEquipmentCost;
						_moneyVal = (_equipArrayCost - _playerEquipCost) max 0;
					}
					else
					{
						_moneyVal = _equipArrayCost;
					};
					
					//Some kits (Team defaults) don't require the full amount, but they will subtract what they can
					if (!_requiresFullAmount) then
					{
						[_playerUID, "-", _moneyVal] Call fnc_srv_changeMoney;
						
						//Only update last purchased if the equipment is valid for the player's side
						_equipmentValid = [_equipmentArray, _playerSide] Call fnc_shr_getEquipmentValid;
						if (_equipmentValid) then
						{
							_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
							if (!isNil "_sessionContainer") then
							{
								_sessionContainer set [5, _equipmentArray];
								missionNamespace setVariable [format["GW_SESSION_%1",_playerUID], _sessionContainer];
							};
							
							//Return updated last purchased template cost to client
							_returnData = [true, _equipArrayCost];
						}
						else
						{
							//-1 means don't update last purchased
							_returnData = [true, -1];
						};
					}
					else
					{
						_playerMoney = _playerUID Call fnc_srv_getPlayerMoney;
						if ((_playerMoney >= _moneyVal)) then
						{
							[_playerUID, "-", _moneyVal] Call fnc_srv_changeMoney;
							
							//Only update last purchased if the equipment is valid for the player's side
							_equipmentValid = [_equipmentArray, _playerSide] Call fnc_shr_getEquipmentValid;
							if (_equipmentValid) then
							{
								_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
								if (!isNil "_sessionContainer") then
								{
									_sessionContainer set [5, _equipmentArray];
									missionNamespace setVariable [format["GW_SESSION_%1",_playerUID], _sessionContainer];
								};
								
								//Return updated last purchased template cost to client
								_returnData = [true, _equipArrayCost];
							}
							else
							{
								//-1 means don't update last purchased
								_returnData = [true, -1];
							};
						}
						else
						{
							_returnData = [false, format["Insufficient funds ($%1 short)",(_moneyVal - _playerMoney)]];
						};
					};
				};
			};
		};
		
		case "team":
		{
			switch (_dataRequest) do
			{
				case "commredeploy":
				{
					_team = _dataArguments;
					_returnData = [false, "Unexpected error"];
					
					if (GW_PARAM_VC_TICKETS) then
					{
						[_team, "-", 1, false] Call fnc_srv_changeTickets;
						_returnData = [true, ""];
					}
					else
					{
						_availableSupply = (Call Compile Format["GW_SUPPLY_%1",_team]);
						if ((_availableSupply - 500) >= 0) then
						{
							[_team, "-", 500] Spawn fnc_srv_changeSupply;
							_returnData = [true, ""];
						}
						else
						{
							_returnData = [false, "Insufficient supplies"];
						};
					};
				};
				
				case "sendmoney":
				{
					_senderUID = _dataArguments select 0;
					_receiverUID = _dataArguments select 1;
					_amountToSend = _dataArguments select 2;
					_amountToSendCost = _dataArguments select 3;
					_returnData = [false, "Unexpected error"];
					
					_senderMoney = _senderUID Call fnc_srv_getPlayerMoney;
					if (_senderMoney >= _amountToSendCost) then
					{
						//Take money from sender
						[_senderUID, "-", _amountToSendCost] Call fnc_srv_changeMoney;
						
						//Add money to receiver
						[_receiverUID, "+", _amountToSend] Call fnc_srv_changeMoney;
						
						//Tell player they recieved money
						_receiverObj = _receiverUID Call fnc_shr_getObjFromUID;
						_senderObj = _senderUID Call fnc_shr_getObjFromUID;
						[[owner _receiverObj], "messages", "", ["notification",["GWAR_ReceivedMoney",[name _senderObj, _amountToSend]]]] Spawn fnc_srv_requestClientExec;
						
						//Set success
						_returnData = [true, ""];
					}
					else
					{
						_returnData = [false, "You don't have enough money"];
					};
				};
				
				case "purchasesupplies":
				{
					_senderUID = _dataArguments select 0;
					_playerSide = _dataArguments select 1;
					_amountToPurchase = _dataArguments select 2;
					_amountToPurchaseCost = _dataArguments select 3;
					_returnData = [false, "Unexpected error"];
					
					_senderMoney = _senderUID Call fnc_srv_getPlayerMoney;
					if (_senderMoney >= _amountToPurchaseCost) then
					{
						//Take money from sender
						[_senderUID, "-", _amountToPurchaseCost] Call fnc_srv_changeMoney;
						
						//Add supply to team
						[_playerSide, "+", _amountToPurchase] Spawn fnc_srv_changeSupply;
						
						//Tell team player has purchased supplies
						_senderObj = _senderUID Call fnc_shr_getObjFromUID;
						_sideClients = [_playerSide, "netid"] Call fnc_shr_getSideMembers;
						[_sideClients, "messages", "", ["notification",["GWAR3_SuppliesPurchased",[name _senderObj, _amountToPurchase]]]] Spawn fnc_srv_requestClientExec;
						
						//Set success
						_returnData = [true, ""];
					}
					else
					{
						_returnData = [false, "You don't have enough money"];
					};
				};
				
				case "sellsupplies":
				{
					_senderUID = _dataArguments select 0;
					_playerSide = _dataArguments select 1;
					_amountToSell = _dataArguments select 2;
					_amountOfCash = _dataArguments select 3;
					_returnData = [false, "Unexpected error"];
					
					_availableSupply = _playerSide Call fnc_srv_getSupply;
					_commander = Call Compile Format["GW_COMMANDER_%1",_playerSide];
					if (_availableSupply >= _amountToSell) then
					{
						_commanderObj = missionNameSpace getVariable _commander;
						if (getPlayerUID _commanderObj == _senderUID) then
						{
							//Remove supply from team
							[_playerSide, "-", _amountToSell] Spawn fnc_srv_changeSupply;
							
							//Send money to each player on team
							_sideClients = [_playerSide, "uid"] Call fnc_shr_getSideMembers;
							_cashToSend = round(_amountOfCash / (count _sideClients));
							{
								[_x, "+", _cashToSend] Call fnc_srv_changeMoney;
							} forEach _sideClients;
							
							//Tell players
							_sideClients = [_playerSide, "netid"] Call fnc_shr_getSideMembers;
							[_sideClients, "messages", "", ["notification",["GWAR3_SuppliesSold",[name _commanderObj, _amountToSell, _cashToSend]]]] Spawn fnc_srv_requestClientExec;
							
							//Set success
							_returnData = [true, ""];
						}
						else
						{
							_returnData = [false, "You are not the team commander"];
						};
					}
					else
					{
						_returnData = [false, "Your team doesn't have enough supplies"];
					};
				};
			};	
		};
		
		//Group
		//_dataType = "group"
		//_dataRequest = One of the cases below
		//_dataArguments = Depends on what the function called expects (see each individual function)
		case "group":
		{	
			switch (_dataRequest) do
			{
				case "add":
				{
					_returnData = [_dataArguments Call fnc_srv_addGroupMember];
				};
				case "remove":
				{
					_returnData = [_dataArguments Call fnc_srv_removeGroupMember];
				};
				case "create":
				{
					_returnData = [_dataArguments Call fnc_srv_createGroup];
				};
				case "delete":
				{
					_returnData = [_dataArguments Call fnc_srv_deleteGroup];
				};
				default
				{
					_returnData = "GWBADREQUEST";
				};
			};
		};
		
		case "client":
		{	
			switch (_dataRequest) do
			{
				case "connected":
				{
					_dataArguments Spawn fnc_srv_playerConnected;
				};
				case "killed":
				{
					_dataArguments Spawn fnc_srv_unitKilled;
				};
				
				case "playermarker":
				{
					_dataArguments Spawn fnc_srv_markEnemies;
				};
				
				case "specialforces":
				{
					_playerSide = _dataArguments select 0;
					_playerUID = _dataArguments select 1;
					_playerPos = _dataArguments select 2;
					_returnData = [true, "Unexpected Error"];
					
					_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
					if (!isNil "_sessionContainer") then
					{
						if ((_sessionContainer select 13) == "Special Forces") then
						{
							_playerObj = _playerUID call fnc_shr_getObjFromUID;
							_squadSize = _playerObj Call fnc_shr_getSquadSize;
							_maxSquadSize = _playerUID Call fnc_srv_getMaxSquadSize;
							if ((_squadSize + 1) <= _maxSquadSize) then
							{
								//Create AI
								_unitClassname = (Call Compile Format ["GW_DATA_INFANTRYCLASS_%1", _playerSide]);
								{
									_squadSize = _playerObj Call fnc_shr_getSquadSize;
									if ((_squadSize + 1) > _maxSquadSize) exitWith {};
									
									_maxDistance = 10;
									_randomPosUnit = [_playerPos, random(_maxDistance * 0.25), _maxDistance, false, _unitClassname] Call fnc_shr_getRandPos;
									while {(_randomPosUnit select 0) == -1} do
									{
										_randomPosUnit = [_playerPos, random(_maxDistance * 0.25), _maxDistance, false, _unitClassname] Call fnc_shr_getRandPos;
									};

									//Create unit
									[[owner _playerObj], "createInfantry", "", [_x, _playerSide, _randomPosUnit]] Spawn fnc_srv_requestClientExec;
									
									sleep 0.5;
								} forEach ["Special Forces Operator","Special Forces AT","Special Forces Marksman"];
							}
							else
							{
								_returnData = [false, format["Not enough room in squad! (Squad Size: %1)",_squadSize]];
							};
						}
						else
						{
							_returnData = [false, "You are not Special Forces"];
						};
					}
					else
					{
						_returnData = [false, "Unexpected Error"];
					};
				};
				
				case "salvage":
				{
					_playerSide = _dataArguments select 0;
					_playerUID = _dataArguments select 1;
					_salvageObj = _dataArguments select 2;
					_returnData = [false, "Unexpected Error"];
					
					if (!isNull _salvageObj) then
					{
						if ((_salvageObj != GW_MHQ_WEST) && (_salvageObj != GW_MHQ_EAST)) then
						{
							_vehArray = (_salvageObj getVariable "GW_UNIQUEID") Call fnc_srv_getVehicleArray;
							if (!isNil "_vehArray") then
							{
								_vehCost = round((_vehArray select 2) * 0.25);
								[_playerUID, "+", _vehCost] Call fnc_srv_changeMoney;
								_returnData = [true, format["%1 for $%2",(_vehArray select 1),_vehCost]];
								[_salvageObj] Call fnc_srv_removeFromGarbageCollector;
								deleteVehicle _salvageObj;
							};
						}
						else
						{
							_returnData = [false, "Cannot salvage MHQ"];
						};
					};
				};
				
				case "specializationChoose":
				{
					_playerSide = _dataArguments select 0;
					_playerUID = _dataArguments select 1;
					_specializationSelected = _dataArguments select 2;

					_returnData = [_playerUID, _specializationSelected] Call fnc_srv_changeSpecialization;
				};
				
				case "jipinit":
				{
					_playerUID = _dataArguments select 0;
					_playerSide = _dataArguments select 1;
					_playerObj = _playerUID Call fnc_shr_getObjFromUID;
					
					//Make sure structures are visible on the map
					_structArray = [];
					if (_playerSide == west) then {_structArray = GW_BUILDINGS_BASE_WEST};
					if (_playerSide == east) then {_structArray = GW_BUILDINGS_BASE_EAST};
					{
						_structUID = _x getVariable "GW_STRUCTUID";
						_structArray = _structUID Call fnc_srv_getStructureArray;
						
						//Tell client to make marker
						[[owner _playerObj], "structure", "created", [_x, (_structArray select 1), (_structArray select 9), (_structArray select 10), false]] Spawn fnc_srv_requestClientExec;
						
						//WORKAROUND
						_structureScript = _structArray select 8;
						if (_structureScript == "structscript_init_commtower.sqf") then
						{
							_heightASL = (getPosASL _x) select 2;
							_commRange = round(GW_SERVER_COMMTOWER_BASE_RANGE + (GW_SERVER_COMMTOWER_RANGE_MODIFIER * _heightASL));
							if ([_playerSide, "Broadcast Range"] Call fnc_shr_isResearched) then {_commRange = round(GW_SERVER_COMMTOWER_BASE_RANGE_UPG + (GW_SERVER_COMMTOWER_RANGE_MODIFIER_UPG * _heightASL))};
							[[owner _playerObj], "structure", "commtowerinit", [(getPosATL _x),(format["%1_TOWERRANGE",_x]), _commRange]] Spawn fnc_srv_requestClientExec;
						};
					} forEach _structArray;
				};
				default
				{
					_returnData = "GWBADREQUEST";
				};
			};
		};
		
		case "research":
		{
			switch (_dataRequest) do
			{
				case "buy":
				{
					_playerObj = _dataArguments select 0;
					_playerSide = _dataArguments select 1;
					_techName = _dataArguments select 2;
					_returnData = [];
					
					_researchArray = [];
					_researchIndex = [_techName, 0, GW_RESEARCH] Call fnc_shr_arrayGetIndex;
					if (_researchIndex != -1) then 
					{
						_researchArray = GW_RESEARCH select _researchIndex;
						
						_isCommander = [_playerObj, _playerSide] Call fnc_srv_isCommander;
						if (_isCommander) then
						{
							_teamSupply = (Call Compile Format["GW_SUPPLY_%1",_playerSide]);
							if ((_researchArray select 1) <= _teamSupply) then
							{
								//Perform condition script if there is one
								_conditionReturn = [true, ""];
								_researchConditionScript = _researchArray select 5;
								if (_researchConditionScript != "") then
								{
									//Execute the script - the side that researched the tech is passed to the script
									_scriptCode = Compile preprocessFileLineNumbers (format["Server\Functions\Research\%1", _researchConditionScript]);
									if (!isNil "_scriptCode") then {_conditionReturn = _playerSide Call _scriptCode} else {diag_log text "###[GW ERROR] - fnc_clientExec.sqf could not execute a research condition script."};
								};
								
								if (_conditionReturn select 0) then
								{
									//Subtract supplies
									[_playerSide, "-", (_researchArray select 1)] Spawn fnc_srv_changeSupply;
									
									//Set researched
									if (_playerSide == west) then
									{
										GW_RESEARCH_WEST set [_researchIndex, true];
										publicVariable "GW_RESEARCH_WEST";
									};
									if (_playerSide == east) then
									{
										GW_RESEARCH_EAST set [_researchIndex, true];
										publicVariable "GW_RESEARCH_EAST";
									};
								
									//Perform action script if there is one
									_researchActionScript = _researchArray select 4;
									if (_researchActionScript != "") then
									{
										//Execute the script - the side that researched the tech is passed to the script
										_scriptCode = Compile preprocessFileLineNumbers (format["Server\Functions\Research\%1", _researchActionScript]);
										if (!isNil "_scriptCode") then 
										{
											_scriptWait = _playerSide Spawn _scriptCode;
											waitUntil {scriptDone _scriptWait};
										}
										else
										{
											diag_log text "###[GW ERROR] - fnc_clientExec.sqf could not execute a research action script.";
										};
									};
									
									//Send Message
									_messageResearchClientList = [_playerSide, "netid"] Call fnc_shr_getSideMembers;
									[_messageResearchClientList, "messages", "", ["notification",["GWAR3_ResearchDone",[_techName]]]] Spawn fnc_srv_requestClientExec;
									
									//Set return
									_returnData = [true, "success"];
								}
								else
								{
									_returnData = _conditionReturn;
								};
							}
							else
							{
								_returnData = [false, format["Insufficient supplies (S%1 short)",(_researchArray select 1) - _teamSupply]];
							};
						}
						else
						{
							_returnData = [false, "You are not the team commander"];
						};
					}
					else
					{
						_returnData = [false, "Unexpected error"];
					};
				};
				
				default
				{
					_returnData = "GWBADREQUEST";
				};
			};
		};
		
		//Messages
		//_dataType = "messages"
		//_dataRequest = One of the cases below
		//_dataArguments = Depends on what the function called expects (see each individual function)
		case "messages":
		{	
			switch (_dataRequest) do
			{
				case "MarkRead":
				{	
					_returnData = [_dataArguments Call fnc_srv_messageMarkRead];
				};
				case "Delete":
				{
					_returnData = [_dataArguments Call fnc_srv_messageDelete];
				};
				case "Send":
				{
					_returnData = [_dataArguments Call fnc_srv_messageSend];
				};
				default
				{
					_returnData = "GWBADREQUEST";
				};
			};
		};
		
		//If the switch gets to this block, it was a bad request
		default
		{
			_returnData = "GWBADREQUEST";
		};
	};
};

//Log if there was an issue
if (typeName _returnData == "STRING") then
{
	if (_returnData == "GWBADREQUEST") then
	{
		diag_log text format["###[GW ERROR] - fnc_clientExec.sqf - Bad data request from client #%1 - Type: %2  Request: %3  Arguments: %4",owner _clientObj, _dataType, _dataRequest, _dataArguments];
	};
	if (_returnData == "MALICIOUSINTENT") then
	{
		diag_log text format["###[GW ERROR] - fnc_clientExec.sqf - Malicious intent possible from client #%1 - Type: %2  Request: %3  Arguments: %4",owner _clientObj, _dataType, _dataRequest, _dataArguments]; 
	};
	_returnData = [false];
};

//If it's a synched call, return the result to the client
if (_synchedCallVar != "") then
{
	Call Compile Format ["%1 = _returnData",_synchedCallVar];
	Call Compile Format ["%1 publicVariableClient ""%2""",(owner _clientObj),_synchedCallVar];
};

//GW_NETWORK_CALLS = GW_NETWORK_CALLS - 1;