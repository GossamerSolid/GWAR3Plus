private["_canBuild","_nearestZone","_commObj","_nearVehicles","_supportNear"];

_canBuild = [true,""];

//Is the player an engineer
if ((player getVariable ["GW_SPECIALIZATION", ""]) == "Engineer") then
{
	//Get nearby vehicles
	_supportNear = false;
	_nearVehicles = nearestObjects [player, ["Car", "Tank", "Air", "Ship"], GW_GVAR_MHQ_BUILD_DISTANCE];
	{
		if ((_x in GW_CVAR_SUPPORTVEH) && (alive _x)) exitWith {_supportNear = true};
	} forEach _nearVehicles;

	if (_supportNear) then
	{
		//Not near zone
		_nearestZone = (getPosASL player) Call fnc_shr_getNearestZone;
		if (_nearestZone != -1) then {_canBuild = [false, "Cannot be in a zone"]};
	}
	else
	{
		_canBuild = [false, "There are no nearby support vehicles"];
	};
}
else
{
	_canBuild = [false, "You are not an engineer"];
};

_canBuild 