/*
Filename:
Server_PlayerDisconnected.sqf

Author(s):
GossamerSolid

Description:
Handles clients disconnecting.

Parameters:
0 - String - The UID of the connecting player
1 - String - The display name of the connecting player

Returns:
Nothing
*/
private["_uid","_name","_playerObj","_playerVarName","_side","_teamCommander","_sideClients"];

if (!isServer) exitWith {diag_log text "###[GW ERROR] - Server\Server_PlayerDisconnected.sqf must only be called server-side."};

_playerObj = _this select 0;
_uid = _this select 2;
_name = _this select 3;

//Don't do anything for the server
if (_name != "__SERVER__") then
{
	diag_log text format ["### PLAYER DISCONNECTED %1 - BEGIN", _name];
	
	//Get the side
	_side = side _playerObj;
	if (isNil "_side") then {_side = side _playerObj};
	
	//Get the varname
	_playerVarName = vehicleVarName _playerObj;

	//Update player container
	_containerVar = format["GW_SESSION_%1",_uid];
	_plyContainer = missionNamespace getVariable _containerVar;
	if (!isNil "_plyContainer") then
	{
		//If player was commander, allow team to vote for a new one
		_teamCommander = Call Compile Format["GW_COMMANDER_%1",_side];
		if (_playerVarName == _teamCommander) then
		{
			Call Compile Format["GW_COMMANDER_%1 = ""nil""",_side];
			Call Compile Format["GW_COMMVOTE_LAST_%1 = -1",_side];
			_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
			[_sideClients, "team", "commdisconnect", []] Spawn fnc_srv_requestClientExec;
			{
				GW_CVAR_COMMANDER = "nil";
				_x publicVariableClient "GW_CVAR_COMMANDER";
			} forEach _sideClients;
			
			_rankIndex = [(_plyContainer select 9), 0, GW_RANKS] Call fnc_shr_arrayGetIndex;
			if (_rankIndex != -1) then
			{
				_newSquadSize = (GW_RANKS select _rankIndex) select 2;
				_plyContainer set [10, _newSquadSize];
			};
		};
	
		//Update container vars
		_plyContainer set [1, damage _playerObj];
		_plyContainer set [2, direction _playerObj];
		_plyContainer set [3, getPosATL _playerObj];
		_plyContainer set [4, (_playerObj Call fnc_shr_getEquipArray)];
		
		//Commit Changes
		missionNamespace setVariable [format["GW_SESSION_%1",_uid], _plyContainer];
	};
	
	//Add to inactive if needed
	if ((vehicle _playerObj) != _playerObj) then
	{
		(vehicle _playerObj) Spawn fnc_srv_checkVehInactive;
	};
	
	//Move to spawn area
	_playerObj setPosATL (getMarkerPos format["respawn_%1",_side]);
	
	//Disconnect from any UAVs
	_playerObj connectTerminalToUAV objNull;
	
	//Strip equipment
	removeAllWeapons _playerObj;
	
	//Remove units in group
	{
		deleteVehicle _x;
	} forEach (units (group _playerObj));
	
	diag_log text format ["### PLAYER DISCONNECTED %1 - FINISH", _name];
};
