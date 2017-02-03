//fnc_isCommander.sqf
//Written by: GossamerSolid
//See if an object reference is their team's commander

private["_playerObj", "_side", "_isCommander", "_sideCommander", "_commObj"];

_playerObj = _this;
_isCommander = false;

if (!isNil "GW_CVAR_COMMANDER") then
{
	if (GW_CVAR_COMMANDER != "nil") then
	{
		_commObj = missionNamespace getVariable GW_CVAR_COMMANDER;
		if (_playerObj == _commObj) then {_isCommander = true};
	};
};

_isCommander 