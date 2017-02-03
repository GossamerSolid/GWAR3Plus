//vehscript_init_spawnable.sqf
//Written by: GossamerSolid
//Vehicle script executed for spawnable vehicles which sets adds it to the team's spawnable vehicle array

private ["_vehObj","_originalArgs","_vehSide"];

_vehObj = _this select 0;
_originalArgs = _this select 1;
_vehSide = _originalArgs select 4;

if (_vehSide == west) then {GW_SPAWNVEH_WEST pushBack _vehObj};
if (_vehSide == east) then {GW_SPAWNVEH_EAST pushBack _vehObj};

//Broadcast to clients
_sideClients = [_vehSide, "netid"] Call fnc_shr_getSideMembers;
{
	GW_CVAR_SPAWNVEH = Call Compile Format["GW_SPAWNVEH_%1",_vehSide];
	_x publicVariableClient "GW_CVAR_SPAWNVEH";
} forEach _sideClients;

