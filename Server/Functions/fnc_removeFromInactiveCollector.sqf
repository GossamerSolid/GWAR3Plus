//fnc_removeFromInactiveCollector.sqf
//Written by: GossamerSolid
//Remove an object reference to be inactive collected.
//@param _inactiveObj - Object to be deleted

if (!isServer) exitWith {diag_log text "###[GW ERROR] - fnc_removeFromInactiveCollector.sqf must only be called server-side."};

private ["_inactiveObj"];

_inactiveObj = _this;

{
	if (typeName _x == "ARRAY") then
	{
		if (_x select 0 == _inactiveObj) exitWith {GW_INACTIVE set [_forEachIndex, -1]};
	};
} forEach GW_INACTIVE;