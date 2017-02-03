//fnc_playerVote.sqf
//Written by: GossamerSolid
//Handle a player casting a vote for commander

private ["_side","_voterVarName","_votedVarName","_teamVotes","_duplicate","_returnString"];

_side = _this select 0;
_voterVarName = _this select 1;
_votedVarName = _this select 2;
_returnString = "Ok";

//Check player's previous vote (remove if not a duplicate)
_duplicate = false;
_teamVotes = Call Compile Format ["GW_COMMVOTES_%1",_side];
{
	private ["_vote","_voter","_votedFor"];
	
	_vote = _x;
	_voter = _x select 0;
	_votedFor = _x select 1;
	
	//Voter has a previous vote
	if (_voterVarName == _voter) exitWith
	{
		//If it's not a duplicate, remove their previous vote
		if (_votedVarName == _votedFor) then
		{
			_duplicate = true;
		}
		else
		{
			_teamVotes deleteAt _forEachIndex;
			Call Compile Format ["GW_COMMVOTES_%1 = _teamVotes",_side];
		};
	};
} forEach _teamVotes;

//If the vote is not a duplicate of their prior vote (No need to do any logic as the vote isn't changing)
if (!_duplicate) then
{
	_teamVotes = Call Compile Format ["GW_COMMVOTES_%1",_side];
	_teamVotes pushBack [_voterVarName, _votedVarName];
	Call Compile Format ["GW_COMMVOTES_%1 = _teamVotes",_side];
};

_returnString 