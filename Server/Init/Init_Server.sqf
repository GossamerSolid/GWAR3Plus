//Init_Server.sqf
//Written by: GossamerSolid
//Initializes all required components server side

if (!isServer) exitWith {diag_log text "###[GW ERROR] - Server\Init\Init_Server.sqf must only be called server-side."};

diag_log text "###[GW LOG] - Server initialization started.";

//Server version
GW_GVAR_VERSION_SERVER = "v01024";
publicVariable "GW_GVAR_VERSION_SERVER";

//Mission PBO Name
GW_MISSIONPBO = format["%1.%2.pbo",missionName,worldName];

//Handle player joins and leaves
fnc_srv_playerConnected = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_playerConnected.sqf";
fnc_srv_playerDisconnected = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_playerDisconnected.sqf";
addMissionEventHandler ["HandleDisconnect",{ _this Spawn fnc_srv_playerDisconnected; true }];

//Set server init flag to false
GW_SERVERINIT = false;
publicVariable "GW_SERVERINIT";

//Set game running flag to true
GW_GAMERUNNING = true;
GW_ENDGAMEARGS = [];
publicVariable "GW_GAMERUNNING";

//Load shared init
_sharedInit = CompileFinal preprocessFileLineNumbers "Shared\Init\Init_Shared.sqf";
[] Call _sharedInit;

//Server-side global
GW_SPAWNLOCATIONS = [];
GW_SPAWNLOCATIONSACTUAL = [];
GW_GARBAGE = [];
GW_INACTIVE = [];
GW_NETWORK_CALLS = 0;
GW_TEAMS = [west, east];
GW_ZONES = [];
GW_ZONES_STUB = [];
GW_ZONES_CAMPS_STUB = [];
GW_SUPPLY_WEST = GW_SERVER_START_SUPPLY;
GW_SUPPLY_EAST = GW_SERVER_START_SUPPLY;
GW_MHQ_WEST = objNull;
GW_MHQ_EAST = objNull;
GW_COMMANDER_WEST = "nil";
GW_COMMANDER_EAST = "nil";
GW_BUILDINGS_BASE_WEST = [];
GW_BUILDINGS_BASE_EAST = [];
GW_BUILDINGS_DEF_WEST = [];
GW_BUILDINGS_DEF_EAST = [];
GW_SUPPORTVEH_WEST = [];
GW_SUPPORTVEH_EAST = [];
GW_SPAWNVEH_WEST = [];
GW_SPAWNVEH_EAST = [];
GW_VEH_WEST = [];
GW_VEH_EAST = [];
GW_MATCHLIST = [];
GW_PLAYERMARKERS_WEST = [];
GW_PLAYERMARKERS_EAST = [];
GW_ZONESOWNED_WEST = 0;
GW_ZONESOWNED_EAST = 0;
GW_COMMVOTES_WEST = [];
GW_COMMVOTES_EAST = [];
GW_COMMVOTE_TIME_WEST = -1;
GW_COMMVOTE_TIME_EAST = -1;
GW_COMMVOTE_LAST_WEST = -1;
GW_COMMVOTE_LAST_EAST = -1;
GW_SERVERFPS_MIN = 50;
GW_SERVERFPS_AVG = 50;
GW_SERVERFPS_CURR = 50;
GW_TIME_ELAPSED = 0;
GW_VEHICLES_WEST = [];
GW_VEHICLES_EAST = [];
GW_TICKETS_WEST = GW_PARAM_VC_TICKETS_BLUEFOR;
GW_TICKETS_EAST = GW_PARAM_VC_TICKETS_REDFOR;
GW_TICKETS_WEST_BLEED = 0;
GW_TICKETS_EAST_BLEED = 0;
GW_RESEARCH_WEST = [];
GW_RESEARCH_EAST = [];
GW_SERVER_SUDDENDEATH = false;
publicVariable "GW_ZONESOWNED_WEST";
publicVariable "GW_ZONESOWNED_EAST";
publicVariable "GW_SERVERFPS_MIN";
publicVariable "GW_SERVERFPS_AVG";
publicVariable "GW_SERVERFPS_CURR";
publicVariable "GW_TICKETS_WEST";
publicVariable "GW_TICKETS_EAST";
publicVariable "GW_TICKETS_WEST_BLEED";
publicVariable "GW_TICKETS_EAST_BLEED";

//Hold a list of all session UIDs
missionNamespace setVariable ["GW_SESSIONS_LIST",[]];

//Compile Server Functions (Always use CompileFinal)
//Local function names have been made so these functions are never ran after server init
_initNetworking = CompileFinal preprocessFileLineNumbers "Server\Init\Init_Networking.sqf";
_initZones = CompileFinal preprocessFileLineNumbers "Server\Init\Init_Zones.sqf";
_serverUpdate = CompileFinal preprocessFileLineNumbers "Server\Server_Update.sqf";
fnc_srv_updateZone = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_UpdateZone.sqf";
fnc_srv_unitKilled = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_unitKilled.sqf";
fnc_srv_updateGarbageCollector = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_UpdateGarbageCollector.sqf";
fnc_srv_updateDefenders = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_updateDefenders.sqf";
fnc_srv_addToGarbageCollector = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_addToGarbageCollector.sqf";
fnc_srv_removeFromGarbageCollector = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_removeFromGarbageCollector.sqf";
fnc_srv_updateKnowsAbout = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_updateKnowsAbout.sqf";
fnc_srv_createDefenders = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_createDefenders.sqf";
fnc_srv_changeMoney = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_changeMoney.sqf";
fnc_srv_changeSupply = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_changeSupply.sqf";
fnc_srv_createStructure = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_createStructure.sqf";
fnc_srv_getStructureArray = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_getStructureArray.sqf";
fnc_srv_structureKilled = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_structureKilled.sqf";
fnc_srv_structureDamaged = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_structureDamaged.sqf";
fnc_srv_updateIncome = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_updateIncome.sqf";
fnc_srv_updateVictoryConditions = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_updateVictoryConditions.sqf";
fnc_srv_getSupply = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_getSupply.sqf";
fnc_srv_createVehicle = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_createVehicle.sqf";
fnc_srv_playerVote = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_playerVote.sqf";
fnc_srv_updateCommanderVoting = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_updateCommanderVoting.sqf";
fnc_srv_initCommVote = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_initCommVote.sqf";
fnc_srv_getPlayerMoney = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_getMoney.sqf";
fnc_srv_getVehicleArray = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_getVehicleArray.sqf";
fnc_srv_updateStructQueues = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_updateStructQueues.sqf";
fnc_srv_handleStructQueueItem = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_handleStructQueueItem.sqf";
fnc_srv_getMaxSquadSize = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_getMaxSquadSize.sqf";
fnc_srv_countInfantryInQueue = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_countInfantryInQueue.sqf";
fnc_srv_guerRandomEquip = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_guerRandomEquip.sqf";
fnc_srv_changeRankPoints = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_changeRankPoints.sqf";
fnc_srv_getTemplates = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_getTemplates.sqf";
fnc_srv_updateTeamPlayerMarkers = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_updateTeamPlayerMarkers.sqf";
fnc_srv_updateInactiveCollector = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_updateInactiveCollector.sqf";
fnc_srv_addToInactiveCollector = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_addToInactiveCollector.sqf";
fnc_srv_removeFromInactiveCollector = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_removeFromInactiveCollector.sqf";
fnc_srv_checkVehInactive = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_checkVehInactive.sqf";
fnc_srv_updateTickets = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_updateTickets.sqf";
fnc_srv_changeTickets = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_changeTickets.sqf";
fnc_srv_updateRadars = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_updateRadars.sqf";
fnc_srv_changeSpecialization = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_changeSpecialization.sqf";
fnc_srv_updatePlayerLocations = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_updatePlayerLocations.sqf";
fnc_srv_isCommander = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_isCommander.sqf";
fnc_srv_getSideGroup = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_getSideGroup.sqf";
fnc_srv_structureScriptedDamage = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_structureScriptedDamage.sqf";
fnc_srv_markEnemies = CompileFinal preprocessFileLineNumbers "Server\Functions\fnc_markEnemies.sqf";

//Call Network initialization
[] Call _initNetworking;

//Initialize all zones
[] Call _initZones;

//Initialize research (Set all to not researched)
{
	GW_RESEARCH_WEST pushBack false;
	GW_RESEARCH_EAST pushBack false;
} forEach GW_RESEARCH;
publicVariable "GW_RESEARCH_WEST";
publicVariable "GW_RESEARCH_EAST";

//Create centers so our units can spawn properly without a physical unit on the map being required
GW_WESTHQC = createCenter west;
GW_EASTHQC = createCenter east;
GW_GUERHQC = createCenter guer;
GW_QUEUEGROUP_WEST = createGroup west;
GW_QUEUEGROUP_EAST = createGroup east;
GW_STATICSGROUP_WEST = createGroup west;
GW_STATICSGROUP_EAST = createGroup east;

//Set enemy values to ensure everybody is against each other
WEST setFriend [EAST, 0];
WEST setFriend [GUER, 0];
EAST setFriend [WEST, 0];
EAST setFriend [GUER, 0];
GUER setFriend [WEST, 0];
GUER setFriend [EAST, 0];

//Fast time
if (GW_PARAM_MC_QUICKTIME) then {setTimeMultiplier 60};

//Set Viewdistance and terrain grid
setViewDistance GW_GVAR_VIEWDISTANCE;
setObjectViewDistance (GW_GVAR_OBJVIEWDISTANCE - 200);
setShadowDistance GW_GVAR_SHADOWDISTANCE;
setTerrainGrid GW_GVAR_TERRAINGRID;

//Gather available spawn locations
_layoutParameter = (Call Compile Format ["GW_PARAM_ML_%1",worldName]);
{
	if (_layoutParameter in (_x select 1)) then {GW_SPAWNLOCATIONS pushBack (_x select 0)};
} forEach GW_STARTING_LOCATIONS;

//Shuffle the spawn locations
_spawnLocationsShuffled = GW_SPAWNLOCATIONS Call fnc_shr_shuffleArray;

diag_log text format ["### FIND SPAWN LOCATIONS"];
//Chose spawn locations for each team
{
	_valid = false;
	_spawn = "";
	_index = -1;
	
	while {!_valid} do
	{
		_valid = true;
		_index = (round(random((count _spawnLocationsShuffled) - 1)));
		_spawn = _spawnLocationsShuffled select _index;
		
		//Check if spawn is ok against existing spawn points
		{	
			_pos = getMarkerPos(_x select 1);
			if ((getMarkerPos(_spawn) distance _pos) < GW_SPAWNDISTANCE) exitWith {_valid = false}; 
		} foreach GW_SPAWNLOCATIONSACTUAL;
		
		GW_SPAWNDISTANCE = GW_SPAWNDISTANCE - 100;
	};
	
	GW_SPAWNLOCATIONSACTUAL set [count GW_SPAWNLOCATIONSACTUAL, [_x, _spawn]];
	_spawnLocationsShuffled deleteAt _index;
} forEach GW_TEAMS;

diag_log text format ["### CREATE STARTING VEHICLES"];
//Create MHQ and starting vehicles at the spawn points
{
	_side = _x select 0;
	_pos = getMarkerPos(_x select 1);
	
	//Spawn starting units at start location
	{
		//Vehicle array
		_vehicleIndex = [_x, 11, GW_VEHICLES] Call fnc_shr_arrayGetIndex;
		_vehicleArray = GW_VEHICLES select _vehicleIndex;
		
		_randomPos = [_pos, random(50 * 0.25), 50, false, (_vehicleArray select 0)] Call fnc_shr_getRandPos;
		while {(_randomPos select 0) == -1} do
		{
			_randomPos = [_pos, random(50 * 0.25), 50, false, (_vehicleArray select 0)] Call fnc_shr_getRandPos;
		};
		
		//Create the vehicle
		_vehicleCreationCall = [(_vehicleArray select 0), _randomPos, (random 360), ["", false], _side, _vehicleArray] Spawn fnc_srv_createVehicle;
		waitUntil {scriptDone _vehicleCreationCall};
	} forEach (Call Compile Format ["GW_DATA_STARTINGVEH_%1",_side]);
	
	if (GW_DEVMODE) then
	{
		_markerMap = createMarker [format ["Marker_%1",_side], _pos];
		_markerMap setMarkerSize [0.5, 0.5];
		_markerMap setMarkerColor "ColorBrown";
		_markerMap setMarkerType "hd_dot";	
	};
} forEach GW_SPAWNLOCATIONSACTUAL;

diag_log text format ["### LAUNCH SERVER UPDATE"];
//Launch server main update thread
[] Spawn _serverUpdate;

//Server is done initialization
GW_SERVERINIT = true;
publicVariable "GW_SERVERINIT";
diag_log text "###[GW LOG] - Server initialization completed.";

//Workaround - Building objects taking too long to initialize the first time around (BIS Problem?)
_precacheStructures = [];
{
	_className = _x select 0;
	_classType = _x select 3;
	_currPre = createVehicle [_className, [0,0,0], [], 0, "NONE"];
	_precacheStructures pushBack _currPre;
} forEach GW_STRUCTURES;
sleep 3;
{
	deleteVehicle _x;
} forEach _precacheStructures;