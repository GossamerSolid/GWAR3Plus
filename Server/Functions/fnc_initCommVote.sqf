//fnc_initCommVote.sqf
//Written by: GossamerSolid
//Initializes a voting period if it can

private["_side","_return","_commVoteLastEnd","_sideClients","_prebuiltVotes"];

_side = _this;
_return = [true, ""];

//Is there a vote going on right now?
_commVoteCurrTime = Call Compile Format["GW_COMMVOTE_TIME_%1",_side];
if (_commVoteCurrTime > -1) then
{
	_return = [true, "Vote ongoing"];
}
else
{
	//Can the voting period begin or is it too soon after the last one?
	_commVoteLastEnd = Call Compile Format["GW_COMMVOTE_LAST_%1",_side];
	if (((time -_commVoteLastEnd) >= GW_SERVER_COMMVOTE_WAIT) || (_commVoteLastEnd == -1)) then
	{
		//If there's already a commander, all votes should start on them
		_currentCommander = Call Compile Format["GW_COMMANDER_%1",_side];
		if (_currentCommander != "nil") then
		{
			_sideClients = [_side, "varname"] Call fnc_shr_getSideMembers;
			_prebuiltVotes = [];
			{
				_preBuiltVotes set [count _preBuiltVotes, [_x, _currentCommander]];
			} forEach _sideClients;
			Call Compile Format["GW_COMMVOTES_%1 = _preBuiltVotes",_side];
		};
		
		//Broadcast start of vote to team
		_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
		[_sideClients, "team", "commvotestart", []] Spawn fnc_srv_requestClientExec;
		
		//Start the vote
		_return = [true, "Vote started"];
		Call Compile Format["GW_COMMVOTE_TIME_%1 = GW_SERVER_COMMVOTE_TIME",_side];
		_side Spawn fnc_srv_updateCommanderVoting;
	}
	else
	{
		_testTime = ([(time - _commVoteLastEnd)/60/60] call BIS_fnc_timeToString);
		_return = [false, format["Your team must wait %1 before starting another commander vote",([(GW_SERVER_COMMVOTE_WAIT - (time - _commVoteLastEnd))/60/60] call BIS_fnc_timeToString)]];
	};
};

_return 