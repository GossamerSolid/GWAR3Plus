/*
Filename:
Server_PlayerConnected.sqf

Author(s):
GossamerSolid

Description:
Handles clients connecting. More specifically, deals with a "persistance" for the player.

Data Structure of session container
0 - Scalar - Money - Updated on currency transactions
1 - Scalar - Damage - Updated on disconnect, applied to player object on connect
2 - Scalar - Direction - Updated on disconnect, applied to player object on connect
3 - Array - Position - Updated on disconnect, applied to player object on connect
4 - Array - Equipment - Updated on disconnect, applied to player object on connect
5 - Array - EquipmentPurchase - Updated when player purchases gear, used for respawns
6 - Side - Last Side - Updated on disconnect, checks for side swap on connect
*/

if (!isServer) exitWith {diag_log text "###[GW ERROR] - Server\Server_PlayerConnected.sqf must only be called server-side."};

//Wait for the server to finish initialization
waitUntil {GW_SERVERINIT};

_uid = _this select 0;
_name = _this select 1;

//Don't do anything for the server
if (_name != "__SERVER__") then
{
	diag_log text format ["### PLAYER CONNECTED %1 - BEGIN", _name];
	
	//Get the player's object
	_playerObj = _uid Call fnc_shr_getObjFromUID;
	
	//Wait until the player isn't on civilian
	waitUntil {(side _playerObj) != civilian};

	//Get the player's UID
	_playerUID = _uid;
	
	//Initialization message (we use this for team swap prevention)
	_initMessage = "";
	
	//Add player to Database if they don't already exist
	if (GW_DATABASE) then
	{
		waitUntil {GW_MATCHID != -1};
		["", ["db"], [GW_SERVERKEY, "PlayerConnected", _playerUID, (name _playerObj), GW_MATCHID, (side _playerObj)]] Spawn fnc_srv_spawnExtension;
	};
		
	//See if the player has a session record or not
	_containerVar = format["GW_SESSION_%1",_playerUID];
	_plyContainer = missionNamespace getVariable _containerVar;
	if (!isNil "_plyContainer") then
	{	
		//Check previous team
		_prevTeam = _plyContainer select 6;
		if (side _playerObj != _prevTeam) exitWith
		{
			_initMessage = format["You have attempted to team swap from %1 to %2<br /><br />Due to how GWAR3 is played, switching teams once the match has started would lead to an unfair advantage as you know all of %1's base positions, zone ownership and possibly plans for future attacks/tactics.<br /><br />Please either re-join as a slot on %1 or wait until the match has ended.<br /><br />",(_prevTeam Call fnc_shr_getSideName), ((side _playerObj) Call fnc_shr_getSideName)];
			
			//Tell all players that the player attempted to teamswap
			_allPlayers = [];
			{
				if (isPlayer _x) then {_allPlayers pushBack (owner _x)};
			} forEach playableUnits;
			[_allPlayers, "messages", "", ["yellowChat", ["GWAR_TeamSwapAttempt", [name _playerObj, (_prevTeam Call fnc_shr_getSideName), ((side _playerObj) Call fnc_shr_getSideName)]]]] Spawn fnc_srv_requestClientExec;
		};
		
		//Check for session ban
		_sessionBan = _plyContainer select 7;
		if ((count _sessionBan) > 0) exitWith
		{
			_initMessage = format["You are unable to play for this session because you have received a session ban for %1.<br />You may play again once this match is over.<br /><br />More details - %2",_sessionBan select 0,_sessionBan select 1];
			
			//Tell all players that the player is session banned
			_allPlayers = [];
			{
				if (isPlayer _x) then {_allPlayers pushBack (owner _x)};
			} forEach playableUnits;
			[_allPlayers, "messages", "", ["yellowChat", ["GWAR_SessionBanConnect", [name _playerObj, (_sessionBan select 0)]]]] Spawn fnc_srv_requestClientExec;
		};
		
		//Update container
		missionNamespace setVariable [_containerVar, _plyContainer];
	}
	else
	{
		//Check side player counts (only for new players - can't force number balancing on people that are already bound to a side)
		_playerCountOk = true;
		_countWest = west Call fnc_shr_getSideCount;
		_countEast = east Call fnc_shr_getSideCount;
		if ((side _playerObj) == west) then
		{
			if ((_countWest - _countEast) > 1) then {_playerCountOk = false};
		};
		if ((side _playerObj) == east) then
		{
			if ((_countEast - _countWest) > 1) then {_playerCountOk = false};
		};

		if (_playerCountOk) then
		{
			//Initialize Container
			_plyContainer = [];
			
			//Money
			_plyContainer set [0, GW_SERVER_START_MONEY];
			
			//Damage (0 - perfect health, 1 - dead (should never be set on dead, that makes no sense))
			_plyContainer set [1, 0];
			
			//Direction
			_plyContainer set [2, 0];
			
			//Position (All -1 tells our client it's a first spawn)
			_plyContainer set [3, [-1,-1,-1]];
			
			//Equipment
			_plyContainer set [4, (Call Compile Format["GW_DATA_STARTEQUIP_%1",side _playerObj])];
			
			//Last Purchased Equipment
			_plyContainer set [5, (Call Compile Format["GW_DATA_STARTEQUIP_%1",side _playerObj])];
			
			//Last Side
			_plyContainer set [6, side _playerObj];
			
			//Session Ban
			_plyContainer set [7, []];
			
			//Email Address
			_plyContainer set [8, ""];
			
			//Rank
			_plyContainer set [9, "private"];
			
			//Max Squad Size
			_plyContainer set [10, 0];
			
			//Accumulated Experience Points
			_plyContainer set [11, 0];
			
			//Equipment Templates
			_plyContainer set [12, []];
			
			//Specialization
			_plyContainer set [13, ""];
			
			//Player has a premium account
			_plyContainer set [14, false];
			
			//Amount of times a player has specialized
			_plyContainer set [15, 0];
			
			//Late Joiner Shite
			if (GW_TIME_ELAPSED >= 300) then
			{
				//Other players on team
				_sideMembers = [(side _playerObj), "uid"] Call fnc_shr_getSideMembers;
				
				//Average out money and rank of all team members
				_moneyOfOthers = 0;
				_rankOfOthers = 0;
				{
					_sideMemberContainer = missionNamespace getVariable (format["GW_SESSION_%1",_x]);
					if (!isNil "_sideMemberContainer") then
					{	
						_moneyOfOthers = _moneyOfOthers + (_sideMemberContainer select 0);
						_rankIndex = [(_sideMemberContainer select 9), 0, GW_RANKS] Call fnc_shr_arrayGetIndex;
						if (_rankIndex != -1) then {_rankOfOthers = _rankOfOthers + _rankIndex};
					};
				} forEach _sideMembers;
				
				if (_moneyOfOthers > 0) then 
				{
					_averageMoney = (round(_moneyOfOthers / (count _sideMembers))) max GW_SERVER_START_MONEY;
					_plyContainer set [0, _averageMoney];
				};
				if (_rankOfOthers > 0) then 
				{
					_averageRank = round(_rankOfOthers / (count _sideMembers));
					_plyContainer set [9, (GW_RANKS select _averageRank) select 0];
				};
			};
			
			//Create container
			missionNamespace setVariable [_containerVar, _plyContainer];
		}
		else
		{
			_initMessage = format["You have attempted to join a team that has too many players on it.<br /><br />Teams in GWAR3 can only have a max of 1 more player than the other team.<br /><br />Please either re-join as a slot on another team or wait until the match has ended.<br /><br />"];
		
			//Tell all players that the player is team stacking
			_allPlayers = [];
			{
				if (isPlayer _x) then {_allPlayers pushBack (owner _x)};
			} forEach playableUnits;
			[_allPlayers, "messages", "", ["yellowChat", ["GWAR_TeamStackAttempt",[name _playerObj, ((side _playerObj) Call fnc_shr_getSideName)]]]] Spawn fnc_srv_requestClientExec;
		};
	};
	
	//Send account info to client (only send if no init message)
	if (_initMessage == "") then
	{
		//Set Side
		_playerObj setVariable ["GW_SIDE",(side _playerObj), true];

		//Unit Rank
		_playerObj setVariable ["GW_UNITRANK", (_plyContainer select 9), true];
		
		//Verify max squad size (Recheck max squad size against rank)
		_currentCommanderVarName = Call Compile Format["GW_COMMANDER_%1",(side _playerObj)];
		_rankName = (_plyContainer select 9);
		if (vehicleVarName _playerObj == _currentCommanderVarName) then {_rankName = "General"};
		_rankIndex = [_rankName, 0, GW_RANKS] Call fnc_shr_arrayGetIndex;
		_actualSquadSize = (GW_RANKS select _rankIndex) select 2;
		if ((_plyContainer select 10) != _actualSquadSize) then {_plyContainer set [10, _actualSquadSize]};
		
		//Unit specialization
		[_uid, (_plyContainer select 13), true] Call fnc_srv_changeSpecialization;
		
		//Setup event handlers
		_playerObj removeAllMPEventHandlers "MPKilled"; 
		_playerObj addMPEventHandler ["MPKilled", {if (isServer) then {[_this select 0, _this select 1] Call fnc_srv_unitKilled};}]; 
		
		//Add player to match list (If not already in it)
		_found = false;
		{
			if (_uid == _x) exitWith {_found = true};
		} forEach GW_MATCHLIST;
		if (!_found) then {GW_MATCHLIST pushBack _uid};

		//Broadcast up to date values to client
		GW_CVAR_MHQ = Call Compile Format["GW_MHQ_%1",(side _playerObj)];
		(owner _playerObj) publicVariableClient "GW_CVAR_MHQ";
		
		//Team Supply
		GW_CVAR_TEAMSUPPLY = (Call Compile Format["GW_SUPPLY_%1",(side _playerObj)]);
		(owner _playerObj) publicVariableClient "GW_CVAR_TEAMSUPPLY";
		
		//Support vehicles
		GW_CVAR_SUPPORTVEH = Call Compile Format["GW_SUPPORTVEH_%1",(side _playerObj)];
		(owner _playerObj) publicVariableClient "GW_CVAR_SUPPORTVEH";
		
		//Spawnable vehicles
		GW_CVAR_SPAWNVEH = Call Compile Format["GW_SPAWNVEH_%1",(side _playerObj)];
		(owner _playerObj) publicVariableClient "GW_CVAR_SPAWNVEH";
		
		//Commander
		GW_CVAR_COMMANDER = Call Compile Format["GW_COMMANDER_%1",(side _playerObj)];
		(owner _playerObj) publicVariableClient "GW_CVAR_COMMANDER";
		
		//Side vehicles
		GW_CVAR_VEHICLES = Call Compile Format["GW_VEHICLES_%1",(side _playerObj)];
		(owner _playerObj) publicVariableClient "GW_CVAR_VEHICLES";
		
		//Send buildings over
		GW_CVAR_BUILDINGS_BASE = Call Compile Format["GW_BUILDINGS_BASE_%1",(side _playerObj)];
		(owner _playerObj) publicVariableClient "GW_CVAR_BUILDINGS_BASE";
		GW_CVAR_BUILDINGS_DEF = Call Compile Format["GW_BUILDINGS_DEF_%1",(side _playerObj)];
		(owner _playerObj) publicVariableClient "GW_CVAR_BUILDINGS_DEF";
		
		//Zones owned
		(owner _playerObj) publicVariableClient "GW_ZONESOWNED_WEST";
		(owner _playerObj) publicVariableClient "GW_ZONESOWNED_EAST";
		
		//Set the account container
		GW_CVAR_ACCOUNT_CONTAINER = _plyContainer;
	}
	else
	{
		//No account container
		GW_CVAR_ACCOUNT_CONTAINER = [];
	};

	//Tell client that account has been loaded
	GW_CVAR_ACCOUNT_LOADED = [true, _initMessage];
	(owner _playerObj) publicVariableClient "GW_CVAR_ACCOUNT_LOADED";
	(owner _playerObj) publicVariableClient "GW_CVAR_ACCOUNT_CONTAINER";
	
	//Tell the player what their team's supply is (it'll be updated later)
	GW_CVAR_TEAMSUPPLY = (side _playerObj) Call fnc_srv_getSupply;
	(owner _playerObj) publicVariableClient "GW_CVAR_TEAMSUPPLY";
	
	diag_log text format ["### PLAYER CONNECTED %1 - FINISH", _name];
};