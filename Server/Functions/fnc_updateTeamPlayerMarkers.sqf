//Update player markers (WEST)
_preSave = [];
{
	_timeLeft = (_x select 2) - 1;
	if (_timeLeft > 0) then 
	{
		_x set [2, _timeleft];
		_preSave pushBack _x;
	};
} forEach GW_PLAYERMARKERS_WEST;
GW_PLAYERMARKERS_WEST = _preSave;

//Broadcast to clients
_sideClients = [west, "netid"] Call fnc_shr_getSideMembers;
{
	GW_CVAR_PLAYERMARKERS = GW_PLAYERMARKERS_WEST;
	_x publicVariableClient "GW_CVAR_PLAYERMARKERS";
} forEach _sideClients;

//Update player markers (EAST)
_preSave = [];
{
	_timeLeft = (_x select 2) - 1;
	if (_timeLeft > 0) then 
	{
		_x set [2, _timeleft];
		_preSave pushBack _x;
	};
} forEach GW_PLAYERMARKERS_EAST;
GW_PLAYERMARKERS_EAST = _preSave;

//Broadcast to clients
_sideClients = [east, "netid"] Call fnc_shr_getSideMembers;
{
	GW_CVAR_PLAYERMARKERS = GW_PLAYERMARKERS_EAST;
	_x publicVariableClient "GW_CVAR_PLAYERMARKERS";
} forEach _sideClients;