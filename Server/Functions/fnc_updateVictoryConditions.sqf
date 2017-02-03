private ["_gameOver", "_gameOverArgs", "_firstOwner", "_ownAllZones", "_bluforBuildingCount", "_opforBuildingCount", "_structureArray", "_blueforMHQAlive", "_opforMHQAlive"];

_gameOver = false;
_gameOverArgs = [];

//Does somebody own all the zones?
if (GW_PARAM_VC_ZONES && !_gameOver) then
{
	_firstOwner = (GW_ZONES select 0) select 7;
	_ownAllZones = true;
	{
		if ((_x select 7) != _firstOwner) exitWith {_ownAllZones = false};
	} forEach GW_ZONES;
	if (_ownAllZones && (_firstOwner != guer)) then 
	{
		_gameOver = true;
		_gameOverArgs = [_firstOwner, "Full Zone Control"];
	};
};

//Has a team's tickets ran out?
if (GW_PARAM_VC_TICKETS && !_gameOver) then
{
	//Bluefor out of tickets
	if (GW_TICKETS_WEST < 1) exitWith
	{
		_gameOver = true;
		_gameOverArgs = [east, "Tickets Depleted"];
	};
	
	//Opfor out of tickets
	if (GW_TICKETS_EAST < 1) exitWith
	{
		_gameOver = true;
		_gameOverArgs = [west, "Tickets Depleted"];
	};
};

//Buildings/MHQ Alive?
if (GW_PARAM_VC_DESTRUCTION && !_gameOver) then
{
	//See if any bluefor important buildings are alive
	_bluforBuildingCount = 0;
	{
		_structureArray = (_x getVariable "GW_STRUCTUID") Call fnc_srv_getStructureArray;
		if (_structureArray select 15) then {_bluforBuildingCount = _bluforBuildingCount + 1};
	} forEach GW_BUILDINGS_BASE_WEST;
	
	//Is bluefor MHQ alive
	_blueforMHQAlive = false;
	if (!(isNull GW_MHQ_WEST) && (alive GW_MHQ_WEST)) then {_blueforMHQAlive = true};
	
	//Is bluefor defeated
	if (((GW_PARAM_VC_DESTRUCTION_SETTING == 0) && (!_blueforMHQAlive)) || ((GW_PARAM_VC_DESTRUCTION_SETTING == 1) && (_bluforBuildingCount <= 0) && (!_blueforMHQAlive))) exitWith
	{
		_gameOver = true;
		_gameOverArgs = [east, "Destruction"];
	};
	
	//See if any opfor important buildings are alive
	_opforBuildingCount = 0;
	{
		_structureArray = (_x getVariable "GW_STRUCTUID") Call fnc_srv_getStructureArray;
		if (_structureArray select 15) then {_opforBuildingCount = _opforBuildingCount + 1};
	} forEach GW_BUILDINGS_BASE_EAST;
	
	//Is opfor MHQ alive
	_opforMHQAlive = false;
	if (!(isNull GW_MHQ_EAST) && (alive GW_MHQ_EAST)) then {_opforMHQAlive = true};
	
	//Is opfor defeated
	if (((GW_PARAM_VC_DESTRUCTION_SETTING == 0) && (!_opforMHQAlive)) || ((GW_PARAM_VC_DESTRUCTION_SETTING == 1) && (_opforBuildingCount <= 0) && (!_opforMHQAlive))) exitWith
	{
		_gameOver = true;
		_gameOverArgs = [west, "Destruction"];
	};
};

//Game is over, tell everything to stop doing updates and display the endgame screen
if (_gameOver) then 
{
	//Broadcast
	GW_GAMERUNNING = false; 
	publicVariable "GW_GAMERUNNING";
	GW_ENDGAME_TIMER = 60;
	publicVariable "GW_ENDGAME_TIMER";
	GW_ENDGAMEARGS = _gameOverArgs;

	if (GW_DATABASE) then
	{
		//Update results of match
		_winner = _gameOverArgs select 0;
		_loser = if (_winner == west) then {east} else {west};
		_stayedTillEndList = [];
		{
			_stayedTillEndList pushBack (getPlayerUID _x);
		} forEach playableUnits;
		["", ["db"], [GW_SERVERKEY, "EndMatch", GW_MATCHID, _winner, _loser, (_gameOverArgs select 1), GW_SERVER_SUDDENDEATH, GW_MATCHLIST, _stayedTillEndList]] Spawn fnc_srv_spawnExtension;
	};
	
	//Get all clients' netids
	_westClientList = [west, "netid"] Call fnc_shr_getSideMembers;
	_eastClientList = [east, "netid"] Call fnc_shr_getSideMembers;
	_fullClientList = [_westClientList, _eastClientList] Call fnc_shr_mergeArrays;
	
	//Tell all clients to run endgame screen
	[_fullClientList, "gamestate", "endgame", _gameOverArgs] Spawn fnc_srv_requestClientExec;

	//Timer until back to lobby
	while {GW_ENDGAME_TIMER > 0} do
	{
		sleep 1;
		GW_ENDGAME_TIMER = GW_ENDGAME_TIMER - 1;
		publicVariable "GW_ENDGAME_TIMER";
	};
	endMission "END1";
};


