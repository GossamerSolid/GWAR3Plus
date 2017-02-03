//vehscript_mhq.sqf
//Written by: GossamerSolid
//Vehicle script executed for MHQs which sets the server var and client vars properly

private ["_vehObj","_originalArgs","_side","_sideClients","_oppositeSide"];

_vehObj = _this select 0;
_originalArgs = _this select 1;
_side = _originalArgs select 4;

//Lock the MHQ (Only commander can unlock/lock afterwards)
_vehObj lock true;

//Add toolkit and a backpack to MHQ
_vehObj addItemCargoGlobal ["Toolkit", 1];
_vehObj addBackpackCargoGlobal ["B_Kitbag_rgr", 1];

//Disable repair functionality due to the class we're using
_vehObj setRepairCargo 0;

Call Compile Format ["GW_MHQ_%1 = _vehObj",_side];
_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
{
	GW_CVAR_MHQ = Call Compile Format["GW_MHQ_%1",_side];
	_x publicVariableClient "GW_CVAR_MHQ";
} forEach _sideClients;

//If sudden death, update the other team
if (GW_SERVER_SUDDENDEATH) then
{
	_markedArray = [];
	_markedArray pushBack
	[
		_vehObj,
		[24, 24],
		([_side, "RGBA"] Call fnc_shr_getSideColour),
		GW_MISSIONROOT + "Resources\images\struct_hq.paa",
		-1,
		-1,
		true
	];
	
	_oppositeSide = if (_side == west) then {east} else {west};
	_teamMarkerList = [_oppositeSide, "netid"] Call fnc_shr_getSideMembers;
	[_teamMarkerList, "markedobjects", "", _markedArray] Spawn fnc_srv_requestClientExec;
};