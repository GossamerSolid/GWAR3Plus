//Server_Update.sqf
//Written by: GossamerSolid
//The main server-side logic updater thread

//Wait until there's actually a player present
waitUntil {time != -1};

//Initialize the update timers for each specific piece of logic
_updateIncome = GW_SERVER_UPDATE_INCOME;
_updateIncomeCalc = GW_SERVER_UPDATE_INCOME_CALC;
_updateVictoryConditions = 10; //Wait at least 10 seconds before trying to update the victory conditions
_updateTeamPlayerMarkers = 1;
//_updateLocations = 60; //60 seconds per location check
_updatePurgeGroups = 15; //Every 15 seconds delete groups with nobody alive in them

//How long the max concurrent network calls has been reached
_maxNetworkCallsTimer = 0;

//Zone updater, garbage collector and inactive collector must be on their own update threads at all times
{
	_forEachIndex Spawn fnc_srv_updateZone;
	sleep random(1);
} forEach GW_ZONES;
sleep (random(1));
[] Spawn fnc_srv_updateGarbageCollector;
sleep (random(1));
[] Spawn fnc_srv_updateInactiveCollector;
sleep (random(1));
if (GW_PARAM_VC_TICKETS) then
{
	[] Spawn fnc_srv_updateTickets;
	sleep (random(1));
};

//Radar update
west Spawn fnc_srv_updateRadars;
sleep (random(1));
east Spawn fnc_srv_updateRadars;
sleep (random(1));

//Structure update construction queues for each team
west Spawn fnc_srv_updateStructQueues;
sleep (random(1));
east Spawn fnc_srv_updateStructQueues;
sleep (random(1));

//Calculating server average fps
_averages = [];
_average = 0;

//Main server logic updater thread
while {GW_GAMERUNNING} do
{
	//Handle updating resource calculations
	if (_updateIncomeCalc < 1) then
	{
		false Spawn fnc_srv_updateIncome;
		_updateIncomeCalc = GW_SERVER_UPDATE_INCOME_CALC;
		if (_updateIncome < 1) then
		{
			true Spawn fnc_srv_updateIncome;
			_updateIncome = GW_SERVER_UPDATE_INCOME;
		} else {_updateIncome = _updateIncome - GW_SERVER_UPDATE_MAIN};
	} else {_updateIncomeCalc = _updateIncomeCalc - GW_SERVER_UPDATE_MAIN};
	
	//Handle checking the victory conditions
	if (_updateVictoryConditions < 1) then
	{
		[] Spawn fnc_srv_updateVictoryConditions;
		_updateVictoryConditions = GW_SERVER_UPDATE_VICTORYCONDITIONS;
	} else {_updateVictoryConditions = _updateVictoryConditions - GW_SERVER_UPDATE_MAIN};
	
	//Purge groups with only dead people in them
	if (_updatePurgeGroups < 1) then
	{
		{
			_currentGroup = _x;
			
			//Check if group has anybody alive in it
			_atLeastOneAlive = false;
			{
				if (alive _x) exitWith {_atLeastOneAlive = true};
			} forEach (units _currentGroup);
			
			if (!_atLeastOneAlive) then
			{
				//Make sure the group isn't a town defense group, those get cleaned up differently
				_isZoneGroup = false;
				{
					_currZoneGroups = _x select 8;
					if (_currentGroup in _currZoneGroups) exitWith {_isZoneGroup = true};
				} forEach GW_ZONES;
				
				if (!_isZoneGroup) then {deleteGroup _currentGroup};
			};
		} forEach allGroups;
		_updatePurgeGroups = 15;
	} else {_updatePurgeGroups = _updatePurgeGroups - GW_SERVER_UPDATE_MAIN};
	
	//Timer to keep track of when the first player initialized
	if ((count GW_MATCHLIST) > 0) then
	{
		GW_TIME_ELAPSED = GW_TIME_ELAPSED + GW_SERVER_UPDATE_MAIN;
		publicVariable "GW_TIME_ELAPSED";
	};
	
	//Trigger sudden death
	if (!GW_SERVER_SUDDENDEATH) then
	{
		if (GW_PARAM_VC_SUDDENDEATH && (GW_TIME_ELAPSED >= GW_PARAM_VC_SUDDENDEATH_TIME)) then
		{
			GW_SERVER_SUDDENDEATH = true;

			//Send global message
			_allPlayers = [];
			{
				if (isPlayer _x) then {_allPlayers pushBack (owner _x)};
			} forEach playableUnits;
			_globalMessage = [_allPlayers, "messages", "", ["notification", ["GWAR3_SuddenDeath",[]]]] Spawn fnc_srv_requestClientExec;
			
			//We want the sudden death message to go fist
			sleep 0.5;
			
			//Mark all current base and defensive structures
			{
				_currentSide = _x;
				_markedArray = [];
				_baseStructures =+ Call Compile Format["GW_BUILDINGS_BASE_%1",_currentSide];
				_defenseStructures =+ Call Compile Format["GW_BUILDINGS_DEF_%1",_currentSide];
				_MHQObj = Call Compile Format["[GW_MHQ_%1]",_currentSide];
				
				//Go through all structures
				_combinedStructures = [_baseStructures, _defenseStructures, _MHQObj] Call fnc_shr_mergeArrays;
				{
					_icon = getText(configFile >> "CfgVehicles" >> (typeOf (vehicle _x)) >> "Icon");
					_updateDirection = true;
					_structureUID = _x getVariable ["GW_STRUCTUID", ""];
					if (_structureUID != "") then
					{
						_structIndex = [_structureUID, 17, GW_STRUCTURES] Call fnc_shr_arrayGetIndex;
						if (_structIndex != -1) then
						{
							_structArray = GW_STRUCTURES select _structIndex;
							if ((_structArray select 3) != "Defenses") then
							{
								_icon = _structArray select 10;
								_updateDirection = false;
							};
						};
					};
					if ((_x == GW_MHQ_WEST) || (_x == GW_MHQ_EAST)) then {_icon = GW_MISSIONROOT + "Resources\images\struct_hq.paa"};
					
					_markedArray pushBack
					[
						_x,
						[24, 24],
						([_currentSide, "RGBA"] Call fnc_shr_getSideColour),
						_icon,
						-1,
						-1,
						_updateDirection
					];
				} forEach _combinedStructures;
				
				//Broadcast marker(s) to side
				_oppositeSide = if (_currentSide == west) then {east} else {west};
				_teamMarkerList = [_oppositeSide, "netid"] Call fnc_shr_getSideMembers;
				[_teamMarkerList, "markedobjects", "", _markedArray] Spawn fnc_srv_requestClientExec;
				
			} forEach [west,east];
			
			//Set tickets to 25
			[west, "=", 25, true] Call fnc_srv_changeTickets;
			[east, "=", 25, true] Call fnc_srv_changeTickets;
		};
	};
	
	//Server Framerate
	_serverFPS = diag_fps;
	GW_SERVERFPS_CURR = round(_serverFPS);
	GW_SERVERFPS_MIN = round(_serverFPS min GW_SERVERFPS_MIN);
	
	//Server average
	if (count(_averages) <= 16) then
	{
		_averages pushBack _serverFPS;
	}
	else
	{
		_total = 0;
		{_total = _total + _x} forEach _averages;
		_averages = [];
		GW_SERVERFPS_AVG = round(_total / 17);
	};
	publicVariable "GW_SERVERFPS_MIN";
	publicVariable "GW_SERVERFPS_AVG";
	publicVariable "GW_SERVERFPS_CURR";

	sleep GW_SERVER_UPDATE_MAIN;
};