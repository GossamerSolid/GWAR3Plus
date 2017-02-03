//vehscript_init_support.sqf
//Written by: GossamerSolid
//Vehicle script executed for support vehicles which sets adds it to the team's support vehicle array

private ["_vehObj","_originalArgs","_vehSide"];

_vehObj = _this select 0;
_originalArgs = _this select 1;
_vehSide = _originalArgs select 4;

if (_vehSide == west) then {GW_SUPPORTVEH_WEST pushBack _vehObj};
if (_vehSide == east) then {GW_SUPPORTVEH_EAST pushBack _vehObj};

//Disable refueling functionality due to the class we're using
_vehObj setFuelCargo 0;

//Broadcast to clients
_sideClients = [_vehSide, "netid"] Call fnc_shr_getSideMembers;
{
	GW_CVAR_SUPPORTVEH = Call Compile Format["GW_SUPPORTVEH_%1",_vehSide];
	_x publicVariableClient "GW_CVAR_SUPPORTVEH";
} forEach _sideClients;
