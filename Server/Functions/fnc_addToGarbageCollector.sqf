//fnc_addToGarbageCollector.sqf
//Written by: GossamerSolid
//Add an object reference along with a timeout to be garbage collected.
//@param _garbageObj - Object to be deleted
//@param _timeout - time in seconds until deletion

if (!isServer) exitWith {diag_log text "###[GW ERROR] - fnc_addToGarbageCollector.sqf must only be called server-side."};

_garbageObj = _this select 0;
_timeout = _this select 1;

GW_GARBAGE set [count GW_GARBAGE, [_garbageObj, _timeout]];

