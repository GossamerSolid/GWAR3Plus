//fnc_checkVehInactive.sqf
//Written by: GossamerSolid
//Check if a vehicle should be marked as inactive
//@param _vehObj - Vehicle to be checked

if (!isServer) exitWith {diag_log text "###[GW ERROR] - fnc_checkVehInactive.sqf must only be called server-side."};

private ["_vehObj", "_crew"];

_vehObj = _this;

//If it's not the MHQ
if ((_vehObj != GW_MHQ_WEST) && (_vehObj != GW_MHQ_EAST)) then
{
	_crew = crew _vehObj;
	if ((count(_crew) <= 0) && (alive _vehObj)) then
	{
		[_vehObj, GW_SERVER_INACTIVE_TIME] Spawn fnc_srv_addToInactiveCollector;
	}
	else
	{
		_vehObj Spawn fnc_srv_removeFromInactiveCollector;
	};
};