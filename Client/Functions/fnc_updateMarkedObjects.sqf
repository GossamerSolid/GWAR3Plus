//fnc_updateMarkedObjects.sqf
//Written by: GossamerSolid
//Update marked object references that have timed out

private["_previousArray"];

_previousArray =+ GW_CVAR_MARKEDOBJECTS;
{
	private["_timeCreated", "_timeout"];
	_timeCreated = _x select 4;
	_timeout = _x select 5;
	
	//-1 means no timeout
	if (_timeout != -1) then
	{
		if ((time > (_timeCreated + _timeout)) || (!(alive (_x select 0)))) then {GW_CVAR_MARKEDOBJECTS deleteAt _forEachIndex};
	};
} forEach _previousArray;