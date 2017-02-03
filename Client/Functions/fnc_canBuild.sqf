private["_canBuild","_nearestZone","_commObj"];

_canBuild = [true,""];

//Make sure MHQ exists
if ((_canBuild select 0) && isNull GW_CVAR_MHQ) then {_canBuild = [false, "MHQ does not exist - this is bad, contact developer"]};

//MHQ is alive
if ((_canBuild select 0) && !(alive GW_CVAR_MHQ)) then {_canBuild = [false, "MHQ is destroyed"]};

//Close enough
if ((_canBuild select 0) && ((player distance GW_CVAR_MHQ) > GW_GVAR_MHQ_BUILD_DISTANCE)) then {_canBuild = [false, "Too far from MHQ"]};

//Not near zone
_nearestZone = (getPosATL player) Call fnc_shr_getNearestZone;
if (_nearestZone != -1) then {_canBuild = [false, "Cannot be in a zone"]};

//Is the commander
if (GW_CVAR_COMMANDER != "nil") then
{
	_commObj = missionNamespace getVariable GW_CVAR_COMMANDER;
	if ((_canBuild select 0) && (_commObj != player)) then {_canBuild = [false, "Only the commander can build"]};
}
else
{
	_canBuild = [false, "Only the commander can build"];
};


_canBuild 
