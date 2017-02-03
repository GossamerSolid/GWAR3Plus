private["_team","_pos","_radius","_hostiles","_entities"];

_team = _this select 0;
_pos = _this select 1;
_radius = _this select 2;

_hostiles = 0;
_entities = _pos nearEntities [["Car","Tank","Air","Ship",GW_DATA_INFANTRYCLASS_EAST,GW_DATA_INFANTRYCLASS_GUER,GW_DATA_INFANTRYCLASS_WEST], _radius];
{
	if (_team == west) then {if (((side _x) == east) || ((side _x) == guer)) then {_hostiles = _hostiles + 1};};
	if (_team == east) then {if (((side _x) == west) || ((side _x) == guer)) then {_hostiles = _hostiles + 1};};
	if (_team == guer) then {if (((side _x) == west) || ((side _x) == east)) then {_hostiles = _hostiles + 1};};
} forEach _entities;

_hostiles 