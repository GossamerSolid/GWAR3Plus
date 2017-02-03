//fnc_addToInactiveCollector.sqf
//Written by: GossamerSolid
//Add an object reference along with a timeout to be inactive collected.
//@param _inactiveObj - Object to be deleted
//@param _timeout - time in seconds until deletion

if (!isServer) exitWith {diag_log text "###[GW ERROR] - fnc_addToInactiveCollector.sqf must only be called server-side."};

_inactiveObj = _this select 0;
_timeout = _this select 1;

GW_INACTIVE set [count GW_INACTIVE, [_inactiveObj, _timeout]];

