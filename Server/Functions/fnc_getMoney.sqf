/*
Script: fnc_getMoney.sqf
Written by: GossamerSolid

Given a UID, return how much money they have
*/

private["_playerUID","_return"];

_playerUID = _this;
_return = 0;

//Make sure UID is defined
if (!isNil "_playerUID") then
{
	_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
	if (!isNil "_sessionContainer") then
	{
		_return = _sessionContainer select 0;
	};
};

_return 