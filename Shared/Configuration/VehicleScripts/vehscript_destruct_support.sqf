//vehscript_destruct_support.sqf
//Written by: GossamerSolid
//Vehicle script executed for support vehicles which removes it from the team's support vehicle array

private ["_vehObj","_killerObj","_sideVictim","_sideKiller","_killerName"];

_vehObj = _this select 0;
_killerObj = _this select 1;
_sideVictim = _this select 2;
_sideKiller = _this select 3;

if (_sideVictim == west) then 
{
	_vehIndex = GW_SUPPORTVEH_WEST find _vehObj;
	if (_vehIndex != -1) then {GW_SUPPORTVEH_WEST deleteAt _vehIndex};
};
if (_sideVictim == east) then 
{
	_vehIndex = GW_SUPPORTVEH_EAST find _vehObj;
	if (_vehIndex != -1) then {GW_SUPPORTVEH_EAST deleteAt _vehIndex};
};

//Broadcast to clients
_sideClients = [_sideVictim, "netid"] Call fnc_shr_getSideMembers;
{
	GW_CVAR_SUPPORTVEH = Call Compile Format["GW_SUPPORTVEH_%1",_sideVictim];
	_x publicVariableClient "GW_CVAR_SUPPORTVEH";
} forEach _sideClients;