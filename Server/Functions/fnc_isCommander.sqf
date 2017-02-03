//fnc_isCommander.sqf
//Written by: GossamerSolid
//See if an object reference is their team's commander

private["_playerObj", "_side", "_isCommander", "_sideCommander", "_commObj"];

_playerObj = _this select 0;
_side = _this select 1;
_isCommander = false;

_sideCommander = Call Compile Format["GW_COMMANDER_%1",_side];
if (!isNil "_sideCommander") then
{
	if (_sideCommander != "nil") then
	{
		_commObj = missionNamespace getVariable _sideCommander;
		if (_playerObj == _commObj) then {_isCommander = true};
	};
};

_isCommander 