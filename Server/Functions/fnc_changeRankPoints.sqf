private["_playerUID","_operation","_value","_rankIndex","_pointsNext","_sessionContainer","_currentPoints","_playerObj"];

_playerUID = _this select 0;
_operation = _this select 1;
_value = _this select 2;

_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
if (!isNil "_sessionContainer") then
{
	_currentPoints = _sessionContainer select 11;
	if (_operation == "-") then {_currentPoints = _currentPoints - _value};
	if (_operation == "+") then {_currentPoints = _currentPoints + _value};
	if (_operation == "*") then {_currentPoints = _currentPoints * _value};
	if (_operation == "/") then {_currentPoints = _currentPoints / _value};
	if (_operation == "=") then {_currentPoints = _value};
	
	//Can't have negative points
	if (_currentPoints < 0) then {_currentPoints = 0};
	
	//Player object
	_playerObj = _playerUID Call fnc_shr_getObjFromUID;
	
	//Did the player rank up?
	_rankIndex = [(_sessionContainer select 9), 0, GW_RANKS] Call fnc_shr_arrayGetIndex;
	_pointsNext = (GW_RANKS select _rankIndex) select 1;
	if ((_pointsNext != -1) && (_currentPoints >= _pointsNext)) then
	{
		//Update var within container
		_newRank = (GW_RANKS select (_rankIndex + 1)) select 0;
		_sessionContainer set [9, _newRank];
		_currentPoints = if (_currentPoints - _pointsNext > 0) then {_currentPoints - _pointsNext} else {0};

		//Update Rank
		_playerObj setVariable ["GW_UNITRANK", _newRank, true];
		
		//Update Max Squad Size (If not commander)
		_currentCommander = Call Compile Format["GW_COMMANDER_%1",(side _playerObj)];
		if (vehicleVarName _playerObj != _currentCommander) then
		{
			_newSquadSize = (GW_RANKS select (_rankIndex + 1)) select 2;
			if ((_playerObj getVariable ["GW_SPECIALIZATION", ""]) == "Officer") then {_newSquadSize = _newSquadSize + 4};
			if ((_playerObj getVariable ["GW_SPECIALIZATION", ""]) == "Special Forces") then {_newSquadSize = _newSquadSize min 8};
			if ((_playerObj getVariable ["GW_SPECIALIZATION", ""]) == "Pilot") then {_newSquadSize = _newSquadSize min 3};
			_sessionContainer set [10, _newSquadSize];
			GW_CVAR_MAXSQUADSIZE = _newSquadSize;
			(owner _playerObj) publicVariableClient "GW_CVAR_MAXSQUADSIZE";
		};

		//Tell player they ranked up
		[[owner _playerObj], "messages", "", ["blueChat",["GWAR_RankUp",[_newRank]]]] Spawn fnc_srv_requestClientExec;
	};
	
	//Update var within container
	_sessionContainer set [11, _currentPoints];
	
	//Update container
	missionNamespace setVariable [format["GW_SESSION_%1",_playerUID], _sessionContainer];
	
	//Broadcast new rank values to client
	_rankIndex = [(_sessionContainer select 9), 0, GW_RANKS] Call fnc_shr_arrayGetIndex;
	_pointsNext = (GW_RANKS select _rankIndex) select 1;
	GW_CVAR_RANK_INFO = [(_sessionContainer select 9), (_sessionContainer select 11), _pointsNext];
	(owner _playerObj) publicVariableClient "GW_CVAR_RANK_INFO";
};