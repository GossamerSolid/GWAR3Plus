//fnc_getFrontlineDepDistance.sqf
//Written by: GossamerSolid
//See what a team's frontline deployment distance is

private["_side", "_frontlineDepDistance", "_frontlineDepResarched", "_blitzkriegDepResarched"];

_side = _this;
_frontlineDepDistance = GW_GVAR_FRONTLINE_DISTANCE;

//See if frontline deployments is researched
_frontlineDepResarched = [_side, "Frontline Deployment"] Call fnc_shr_isResearched;
if (_frontlineDepResarched) then {_frontlineDepDistance = GW_GVAR_FRONTLINE_UPG_DISTANCE};

//See if blitzkireg deployment is researched
_blitzkriegDepResarched = [_side, "Blitzkrieg Deployment"] Call fnc_shr_isResearched;
if (_blitzkriegDepResarched) then {_frontlineDepDistance = GW_GVAR_FRONTLINE_UPG2_DISTANCE};

_frontlineDepDistance 