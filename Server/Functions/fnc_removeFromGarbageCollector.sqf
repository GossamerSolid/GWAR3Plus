//fnc_removeFromGarbageCollector.sqf
//Written by: GossamerSolid
//Remove an object reference to be garbage collected.
//@param _garbageObj - Object to be deleted

if (!isServer) exitWith {diag_log text "###[GW ERROR] - fnc_removeFromGarbageCollector.sqf must only be called server-side."};

_garbageObj = _this select 0;

{
	if (typeName _x == "ARRAY") then
	{
		if (_x select 0 == _garbageObj) exitWith {GW_GARBAGE set [_forEachIndex, -1]};
	};
} forEach GW_GARBAGE;