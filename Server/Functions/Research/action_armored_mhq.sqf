//action_armored_mhq.sqf
//Written by: GossamerSolid
//Upgrade the existing MHQ to an armored IFV

private["_playerSide","_armoredMHQUID","_vehicleArray","_vehicleClass","_vehicleCreationCall","_oldMHQ","_oldPosATL","_oldDir","_newMHQ"];

_playerSide = _this;
_armoredMHQUID = if (_playerSide == west) then {"38BD300B07C7D896DBE4819FF8628B3237B5D7D2"} else {"9D45FF0C9291F8F7B24DC9B787186B91E81771C0"};

//Get details from the old MHQ
_oldMHQ = if (_playerSide == west) then {GW_MHQ_WEST} else {GW_MHQ_EAST};
_oldPosATL = getPosATL _oldMHQ;
_oldDir = getDir _oldMHQ;

//Kick everybody out of the old MHQ
{
	(_x select 0) action ["Eject", _oldMHQ];
} forEach (fullCrew _oldMHQ);

//Create new MHQ
_vehicleArray = _armoredMHQUID Call fnc_srv_getVehicleArray;
_vehicleClass = _vehicleArray select 0;
_newMHQ = [_vehicleClass, [(_oldPosATL select 0), (_oldPosATL select 1), 2000], _oldDir, ["", false], _playerSide, _vehicleArray, true] Call fnc_srv_createVehicle;

//Remove old MHQ
deleteVehicle _oldMHQ;

//Reposition new MHQ
waitUntil {isNull _oldMHQ};
_newMHQ setDir _oldDir;
_newMHQ setPosATL [(_oldPosATL select 0), (_oldPosATL select 1), 1];

//If sudden death, update the other team
if (GW_SERVER_SUDDENDEATH) then
{
	_markedArray = [];
	_markedArray pushBack
	[
		_newMHQ,
		[24, 24],
		([_playerSide, "RGBA"] Call fnc_shr_getSideColour),
		GW_MISSIONROOT + "Resources\images\struct_hq.paa",
		-1,
		-1,
		true
	];
	
	_oppositeSide = if (_playerSide == west) then {east} else {west};
	_teamMarkerList = [_oppositeSide, "netid"] Call fnc_shr_getSideMembers;
	[_teamMarkerList, "markedobjects", "", _markedArray] Spawn fnc_srv_requestClientExec;
};