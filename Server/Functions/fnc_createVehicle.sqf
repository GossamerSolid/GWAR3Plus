//fnc_createVehicle.sqf
//Written by: GossamerSolid
//Creates a new vehicle
//Can be used in a Call (returns the vehicle object) or in a Spawn (don't care about vehicle object)
//_newVehicle = ["GWAR3_B_Truck_01_MHQ_F", _randomPos, (random 360), ["", false], _side, _vehicleArray, true] Call fnc_srv_createVehicle; (Need to have the true at the end)
//["GWAR3_B_Truck_01_MHQ_F", _randomPos, (random 360), ["", false], _side, _vehicleArray] Spawn fnc_srv_createVehicle;

if (!isServer) exitWith {diag_log text "###[GW ERROR] - Server\Functions\fnc_createVehicle.sqf must only be called server-side."};

private["_classname","_position","_direction","_lockArray","_side","_vehicleArray","_returnVehicle","_newVehicle"];

_classname = _this select 0;
_position = _this select 1;
_direction = _this select 2;
_lockArray = _this select 3;
_side = _this select 4;
_vehicleArray = _this select 5;
_returnVehicle = if ((count _this) > 6) then {_this select 6} else {false};

//Create vehicle
_newVehicle = createVehicle [_classname, _position, [], 0, "NONE"];
(vehicle _newVehicle) setDir _direction;
(vehicle _newVehicle) setVectorUp (surfaceNormal (getPos (vehicle _newVehicle)));
(vehicle _newVehicle) setPosATL _position;
(vehicle _newVehicle) SetVelocity [0,0,-1];
(vehicle _newVehicle) setVariable ["GW_SIDE",_side,true];

//Lock the car if it's supposed to be locked. Store who the "owner" is so they can choose to unlock/lock it.
(vehicle _newVehicle) lock (_lockArray select 1);
if ((_lockArray select 0) != "") then
{
	(vehicle _newVehicle) setVariable ["GW_VEHOWNER", (_lockArray select 0), true];
};

//Set Vehicle's UID
(vehicle _newVehicle) setVariable ["GW_UNIQUEID", (_vehicleArray select 11), true];

//Remove cargo
clearItemCargoGlobal (vehicle _newVehicle);
clearMagazineCargoGlobal (vehicle _newVehicle);
clearWeaponCargoGlobal (vehicle _newVehicle);
clearBackpackCargoGlobal (vehicle _newVehicle);

//Execute the script on the vehicle if there is one
_vehicleScript = _vehicleArray select 7;
if (_vehicleScript != "") then
{
	//Execute the script - ALL arguments passed to fnc_createVehicle + the newly created vehicle object are available in the script as well
	_scriptCode = Compile preprocessFileLineNumbers (format["Shared\Configuration\VehicleScripts\%1", _vehicleScript]);
	if (!isNil "_scriptCode") then 
	{
		_scriptWait = [(vehicle _newVehicle), _this] Spawn _scriptCode;
		waitUntil {scriptDone _scriptWait};
	}
	else
	{
		diag_log text "###[GW ERROR] - fnc_createVehicle.sqf could not execute a vehicle initialization script.";
	};
};

//Add killed eventhandler
if (_side == west) then {(vehicle _newVehicle) addMPEventHandler ["MPKilled", {if (isServer) then {[_this select 0, _this select 1, west] Call fnc_srv_unitKilled};}]};
if (_side == east) then {(vehicle _newVehicle) addMPEventHandler ["MPKilled", {if (isServer) then {[_this select 0, _this select 1, east] Call fnc_srv_unitKilled};}]};
if (_side == guer) then {(vehicle _newVehicle) addMPEventHandler ["MPKilled", {if (isServer) then {[_this select 0, _this select 1, guer] Call fnc_srv_unitKilled};}]};

//Handle inactivity collection
if (_vehicleArray select 14) then
{
	(vehicle _newVehicle) addEventHandler ["GetIn",{(_this select 0) Spawn fnc_srv_checkVehInactive}];
	(vehicle _newVehicle) addEventHandler ["GetOut",{(_this select 0) Spawn fnc_srv_checkVehInactive}];
	(vehicle _newVehicle) Spawn fnc_srv_checkVehInactive;
};

//Add vehicle to side vehicles array
if (_side == west) then
{
	GW_VEHICLES_WEST pushBack _newVehicle;
	_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
	{
		GW_CVAR_VEHICLES = GW_VEHICLES_WEST;
		_x publicVariableClient "GW_CVAR_VEHICLES";
	} forEach _sideClients;
};
if (_side == east) then
{
	GW_VEHICLES_EAST pushBack _newVehicle;
	_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
	{
		GW_CVAR_VEHICLES = GW_VEHICLES_EAST;
		_x publicVariableClient "GW_CVAR_VEHICLES";
	} forEach _sideClients;
};

//Remove artillery mines (TO-DO - Handle this with custom loadouts)
(vehicle _newVehicle) removeMagazine "6Rnd_155mm_Mo_AT_mine";
(vehicle _newVehicle) removeMagazine "6Rnd_155mm_Mo_mine";

//Flag to list the vehicle as eligible to attach
_attachFlagIndex = ["Attaching", 0, (_vehicleArray select 10)] Call fnc_shr_arrayGetIndex;
if (_attachFlagIndex != -1) then {(vehicle _newVehicle) setVariable ["GW_ATTACHING", true, true]};

//Handle custom loadouts
_loadoutArrIndex = ["CustomLoadout", 0, (_vehicleArray select 10)] Call fnc_shr_arrayGetIndex;
if (_loadoutArrIndex != -1) then
{
	_weaponArray = ((_vehicleArray select 10) select _loadoutArrIndex) select 1;
	_magArray = ((_vehicleArray select 10) select _loadoutArrIndex) select 2;
	
	{(vehicle _newVehicle) removeWeapon _x} forEach (weapons (vehicle _newVehicle));
	{(vehicle _newVehicle) removeMagazine _x} forEach (magazines (vehicle _newVehicle));
	
	{(vehicle _newVehicle) addMagazine _x} forEach _magArray;
	{(vehicle _newVehicle) addWeapon _x} forEach _weaponArray;
};

//Heal and refuel just in case
(vehicle _newVehicle) setDamage 0;
(vehicle _newVehicle) setFuel 1;

//Workaround?
[_newVehicle] Spawn 
{
	sleep 2; 
	(vehicle (_this select 0)) setDamage 0;
};

//Only return the vehicle object if it's asked for
if (!_returnVehicle) exitWith {};
_newVehicle 