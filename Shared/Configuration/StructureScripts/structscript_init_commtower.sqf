//structscript_init_commtower.sqf
//Written by: GossamerSolid
//Initialize a communications tower

private ["_commTowerObj","_originalArgs","_side","_sideClients","_heightASL","_commRange"];

_commTowerObj = _this select 0;
_originalArgs = _this select 1;
_side = _originalArgs select 0;

//Figure out communications range based on height above sea level
_heightASL = (getPosASL _commTowerObj) select 2;
_commRange = round(GW_SERVER_COMMTOWER_BASE_RANGE + (GW_SERVER_COMMTOWER_RANGE_MODIFIER * _heightASL));
if ([_side, "Broadcast Range"] Call fnc_shr_isResearched) then {_commRange = round(GW_SERVER_COMMTOWER_BASE_RANGE_UPG + (GW_SERVER_COMMTOWER_RANGE_MODIFIER_UPG * _heightASL))};
_commTowerObj setVariable ["GW_COMMRANGE", _commRange, true];