//fnc_updateCommanderVoting.sqf
//Written by: GossamerSolid
//Determines the commander when the time runs out

private["_side","_sideClients","_newCommanderVarName","_countSortedVotesArray"];

_side = _this;

//Pass voting time to side clients
GW_CVAR_COMMVOTE_TIME = GW_SERVER_COMMVOTE_TIME;
_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
{
	_x publicVariableClient "GW_CVAR_COMMVOTE_TIME";
} forEach _sideClients;

_commVoteTime = Call Compile Format["GW_COMMVOTE_TIME_%1",_side];
while {_commVoteTime > 0} do
{
	sleep 1;

	//Update time left
	_commVoteTime = _commVoteTime - 1;
	Call Compile Format["GW_COMMVOTE_TIME_%1 = _commVoteTime",_side];
	
	//Pass voting time to side clients
	GW_CVAR_COMMVOTE_TIME = _commVoteTime;
	_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
	{
		_x publicVariableClient "GW_CVAR_COMMVOTE_TIME";
	} forEach _sideClients;
};

//Figure out new commander based on votes
_newCommanderVarName = "nil";
_countSortedVotesArray = [];
{
	_foundIndex = [(_x select 1), 0, _countSortedVotesArray] Call fnc_shr_arrayGetIndex;
	if (_foundIndex == -1) then
	{
		_countSortedVotesArray set [count _countSortedVotesArray, [(_x select 1), 1]];
	}
	else
	{
		_preSave = _countSortedVotesArray select _foundIndex;
		_preSave set [1, ((_preSave select 1) + 1)];
		_countSortedVotesArray set [_foundIndex, _preSave];
	};
} forEach (Call Compile Format["GW_COMMVOTES_%1",_side]);

//Find the highest vote count
if ((count _countSortedVotesArray) > 0) then
{
	_highest = _countSortedVotesArray select 0;
	{
		if ((_x select 1) >= (_highest select 1)) then
		{
			_newCommanderVarName = _x select 0;
		};
	} forEach _countSortedVotesArray;
};

//If the commander actually changed
_currentCommanderVarName = Call Compile Format["GW_COMMANDER_%1",_side];
if (_currentCommanderVarName != _newCommanderVarName) then
{
	//Change max squad size of new commander
	_rankIndex = ["General", 0, GW_RANKS] Call fnc_shr_arrayGetIndex;
	_newSquadSize = (GW_RANKS select _rankIndex) select 2;
	_newCommObj = missionNamespace getvariable _newCommanderVarName;
	if ((_newCommObj getVariable ["GW_SPECIALIZATION", ""]) == "Officer") then {_newSquadSize = _newSquadSize + 4};
	if ((_newCommObj getVariable ["GW_SPECIALIZATION", ""]) == "Special Forces") then {_newSquadSize = _newSquadSize min 8};
	if ((_newCommObj getVariable ["GW_SPECIALIZATION", ""]) == "Pilot") then {_newSquadSize = _newSquadSize min 3};
	_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",getPlayerUID _newCommObj]);
	_sessionContainer set [10, _newSquadSize];
	missionNamespace setVariable [format["GW_SESSION_%1",getPlayerUID _newCommObj], _sessionContainer];
	GW_CVAR_MAXSQUADSIZE = _newSquadSize;
	(owner _newCommObj) publicVariableClient "GW_CVAR_MAXSQUADSIZE";
	
	//Broadcast new commander to side
	GW_CVAR_COMMANDER = _newCommanderVarName;
	Call Compile Format["GW_COMMANDER_%1 = GW_CVAR_COMMANDER",_side];
	_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
	{
		_x publicVariableClient "GW_CVAR_COMMANDER";
	} forEach _sideClients;
	[_sideClients, "team", "commvoted", _newCommanderVarName] Spawn fnc_srv_requestClientExec;

	//Set time to -1 and update last vote ended time and empty out votes array
	Call Compile Format["GW_COMMVOTE_TIME_%1 = -1",_side];
	Call Compile Format["GW_COMMVOTES_%1 = []",_side];

	//If nobody was selected, let them start a vote again
	if (_newCommanderVarName != "nil") then {Call Compile Format["GW_COMMVOTE_LAST_%1 = time",_side]};
	
	//If there was an old commander, set their max squad size to match their rank
	if (_currentCommanderVarName != "nil") then
	{
		_oldCommObj = missionNamespace getVariable _currentCommanderVarName;
		_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",getPlayerUID _oldCommObj]);
		if (!isNil "_sessionContainer") then
		{
			_rankIndex = [(_sessionContainer select 9), 0, GW_RANKS] Call fnc_shr_arrayGetIndex;
			_newSquadSize = (GW_RANKS select _rankIndex) select 2;
			if ((_oldCommObj getVariable ["GW_SPECIALIZATION", ""]) == "Officer") then {_newSquadSize = _newSquadSize + 4};
			if ((_oldCommObj getVariable ["GW_SPECIALIZATION", ""]) == "Special Forces") then {_newSquadSize = _newSquadSize min 8};
			if ((_oldCommObj getVariable ["GW_SPECIALIZATION", ""]) == "Pilot") then {_newSquadSize = _newSquadSize min 3};
			_sessionContainer set [10, _newSquadSize];
			missionNamespace setVariable [format["GW_SESSION_%1",getPlayerUID _oldCommObj], _sessionContainer];
			GW_CVAR_MAXSQUADSIZE = _newSquadSize;
			(owner _oldCommObj) publicVariableClient "GW_CVAR_MAXSQUADSIZE";
		};
	};
}
else
{
	//Commander didn't change
	if (_currentCommanderVarName != "nil") then
	{
		_commObj = missionNamespace getVariable _currentCommanderVarName;
		_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
		[_sideClients, "messages", "", ["notification",["GWAR3_CommVoteResultsSame",[name _commObj]]]] Spawn fnc_srv_requestClientExec;
		Call Compile Format["GW_COMMVOTE_LAST_%1 = time",_side];
		Call Compile Format["GW_COMMVOTE_TIME_%1 = -1",_side];
		Call Compile Format["GW_COMMVOTES_%1 = []",_side];
	}
	else
	{
		//If nobody was selected, let them start a vote again
		Call Compile Format["GW_COMMVOTE_LAST_%1 = -1",_side];
		Call Compile Format["GW_COMMVOTE_TIME_%1 = -1",_side];
		Call Compile Format["GW_COMMVOTES_%1 = []",_side];
		
		_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
		[_sideClients, "messages", "", ["notification",["GWAR3_CommVoteResultsNil",[]]]] Spawn fnc_srv_requestClientExec;
	};
};


