private["_objBuilding","_objKiller","_sideBuilding","_sideKiller","_structureArray","_killerName","_victimClientList","_killerClientList","_fullClientList","_baseArray","_helperObj","_flagObj"];

_objBuilding = _this select 0;
_objKiller = _this select 1;
_sideBuilding = _this select 2;
_sideKiller = side(group(_objKiller));

//Null killer should be replaced with NullGarbage
if (isNull _objKiller) then {_objKiller = NullGarbage};

//Remove the helper if there is one
_helperObj = _objBuilding getVariable ["GW_STRUCTHELPER", objNull];
if (!isNull _helperObj) then {deleteVehicle _helperObj};

//Remove team flag object
_flagObj = _objBuilding getVariable ["GW_FLAGOBJ", objNull];
if (!isNull _flagObj) then {deleteVehicle _flagObj};

//Side of killer is unknown
if (_sideKiller == sideUnknown) then {_sideKiller = _objKiller Call fnc_shr_getObjSide};

_structureArray = (_objBuilding getVariable "GW_STRUCTUID") Call fnc_srv_getStructureArray;
_killerName = name _objKiller;

//Try to find the vehicle owner
if (_killerName == "Error: No unit") then
{
	_killerUID = _objKiller getVariable ["GW_OWNER", ""];
	if (_killerUID != "") then
	{
		_objKiller = _killerUID Call fnc_shr_getObjFromUID;
		_killerName = name _objKiller;
	};
};
if (_killerName == "Error: No Unit") then {_killerName = (_sideKiller Call fnc_shr_getSideName)};

//Remove from base array (Couldn't do this via call compile format - runtime error)
if (_sideBuilding == west) then 
{
	GW_BUILDINGS_BASE_WEST = GW_BUILDINGS_BASE_WEST - [_objBuilding];
	GW_BUILDINGS_DEF_WEST = GW_BUILDINGS_DEF_WEST - [_objBuilding];
	
	//Update Clients
	_sideClients = [west, "netid"] Call fnc_shr_getSideMembers;
	{
		GW_CVAR_BUILDINGS_BASE = Call Compile Format["GW_BUILDINGS_BASE_%1",west];
		_x publicVariableClient "GW_CVAR_BUILDINGS_BASE";
	} forEach _sideClients;
	_sideClients = [west, "netid"] Call fnc_shr_getSideMembers;
	{
		GW_CVAR_BUILDINGS_DEF = Call Compile Format["GW_BUILDINGS_DEF_%1",west];
		_x publicVariableClient "GW_CVAR_BUILDINGS_DEF";
	} forEach _sideClients;
	
};
if (_sideBuilding == east) then 
{
	GW_BUILDINGS_BASE_EAST = GW_BUILDINGS_BASE_EAST - [_objBuilding];
	GW_BUILDINGS_DEF_EAST = GW_BUILDINGS_DEF_EAST - [_objBuilding];
	
	//Update Clients
	_sideClients = [east, "netid"] Call fnc_shr_getSideMembers;
	{
		GW_CVAR_BUILDINGS_BASE = Call Compile Format["GW_BUILDINGS_BASE_%1",east];
		_x publicVariableClient "GW_CVAR_BUILDINGS_BASE";
	} forEach _sideClients;
	_sideClients = [east, "netid"] Call fnc_shr_getSideMembers;
	{
		GW_CVAR_BUILDINGS_DEF = Call Compile Format["GW_BUILDINGS_DEF_%1",east];
		_x publicVariableClient "GW_CVAR_BUILDINGS_DEF";
	} forEach _sideClients;
};

//Remove the defense turrets' wreckage
if (_objBuilding getVariable ["GW_COMMTURRET", false]) then
{
	deleteVehicle _objBuilding;
};

//Run destruction script if there is one
_structureScript = _structureArray select 19;
if (_structureScript != "") then
{
	//Execute the script - ALL arguments passed to fnc_createStructure + the destroyed structure object are available in the script as well
	_scriptCode = Compile preprocessFileLineNumbers (format["Shared\Configuration\StructureScripts\%1", _structureScript]);
	if (!isNil "_scriptCode") then 
	{
		[_objBuilding, _objKiller, _sideBuilding, _sideKiller] Call _scriptCode;
	}
	else
	{
		diag_log text "###[GW ERROR] - fnc_structureKilled.sqf could not execute the structure initialization script.";
	};
}; 

//Alert clients of destruction
_leaderObj = objNull;
_isUAV = _objKiller getVariable ["GW_UAV", false];
if (_isUAV) then
{
	_uavControlArray = UAVControl _objKiller;
	if (count(_uavControlArray) > 0) then
	{
		_leaderObj = _uavControlArray select 0;
	};
}
else
{
	//Get the leader (this should return the player)
	_leaderObj = leader (group _objKiller);
};

if (!isNull _leaderObj) then
{
	if (_sideKiller != _sideBuilding) then
	{
		_victimClientList = [_sideBuilding, "netid"] Call fnc_shr_getSideMembers;
		_killerClientList = [_sideKiller, "netid"] Call fnc_shr_getSideMembers;
		_fullClientList = [_victimClientList, _killerClientList] Call fnc_shr_mergeArrays;
		[_fullClientList, "structure", "destroyed", [(mapGridPosition _objBuilding), _sideKiller, name _leaderObj, (_structureArray select 1), (_structureArray select 10)]] Spawn fnc_srv_requestClientExec;
	}
	else
	{
		_victimClientList = [_sideBuilding, "netid"] Call fnc_shr_getSideMembers;
		[_victimClientList, "structure", "teamkilled", [(mapGridPosition _objBuilding), _sideKiller, name _leaderObj, (_structureArray select 1), (_structureArray select 10)]] Spawn fnc_srv_requestClientExec;
	};
};

