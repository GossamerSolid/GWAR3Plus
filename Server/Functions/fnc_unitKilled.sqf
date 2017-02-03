//fnc_unitKilled.sqf
//Written by: GossamerSolid
//Handle the death of a unit
//@param _objVictim - The object reference of the unit killed
//@param _objKiller - The object reference of the unit that killed the victim

//TO-DO: Multiple player player crew - award split between them

_objVictim = _this select 0;
_objKiller = _this select 1;
_groupVictim = group(_objVictim);
_groupKiller = group(_objKiller);
_sideVictim = if ((count _this) == 3) then {_this select 2} else {side(group(_objVictim))};
_sideKiller = side(group(_objKiller));

diag_log text format["### UNIT KILL - _objVictim: %1  _objKiller: %2  _groupVictim: %3  _groupKiller: %4  _sideVictim: %5  _sideKiller: %6",_objVictim,_objKiller,_groupVictim,_groupKiller,_sideVictim,_sideKiller];

//Null killer should be replaced with NullGarbage
if (isNull _objKiller) then {_objKiller = NullGarbage};

//Side of victim is unknown
if (_sideVictim == sideUnknown) then {_sideVictim = _objVictim Call fnc_shr_getObjSide};

//Side of killer is unknown
if (_sideKiller == sideUnknown) then {_sideKiller = _objKiller Call fnc_shr_getObjSide};

//Show death position to victim's side
if ((_sideVictim != civ) && (_sideVictim != guer)) then
{
	_victimTeamList = [_sideVictim, "netid"] Call fnc_shr_getSideMembers;
	[_victimTeamList, "marker", "", [objNull, (getPosASL _objVictim), [0.75, 0.75], ["Class", "KIA"], ([_sideVictim, "class"] Call fnc_shr_getSideColour), 0, 1, "", 60, ""]] Spawn fnc_srv_requestClientExec;
};

//Detach victim from anything they are attached to
if (!isNull (attachedTo _objVictim)) then {detach _objVictim; _objVictim setVelocity [0, 0, -1]};

//Detach any objects attached
_attachedObjs = attachedObjects _objVictim;
{
	detach _x;
	_x setVelocity [0, 0, -1];
} forEach _attachedObjs;

//Can't proceed if we don't know the victim's side
if (_sideVictim == sideUnknown) exitWith {diag_log text format ["### UNIT KILLED - Unable to determine side of victim"]};

//Figure out stuff for DB
_killedWith = "";
_killerType = "";
_distance = if (_objKiller != NullGarbage) then {_objKiller distance _objVictim} else {0};
if (_objKiller isKindOf "Man") then 
{
	_killedWith = currentWeapon _objKiller;
	_killerType = "Infantry";
} 
else 
{
	_killedWith = _objKiller getVariable ["GW_UNIQUEID", "ERROR"];
	_killerType = "Vehicle";
};

_victimClass = "";
_victimType = "";
if (_objVictim isKindOf "Man") then 
{
	_victimType = "Infantry";
	_victimClass = "";
} 
else 
{
	_victimType = "Vehicle";
	_victimClass = _objVictim getVariable ["GW_UNIQUEID", "ERROR"];
};

//Execute the death script on the vehicle if there is one
_vehicleUID = _objVictim getVariable ["GW_UNIQUEID", ""];
_vehicleArray = [];
if (_vehicleUID != "") then
{
	_vehicleArray = _vehicleUID Call fnc_srv_getVehicleArray;
	_vehicleScript = _vehicleArray select 12;
	if (_vehicleScript != "") then
	{
		//Execute the script - ALL arguments passed to fnc_unitKilled + the specific object are available in the script as well
		_scriptCode = Compile preprocessFileLineNumbers (format["Shared\Configuration\VehicleScripts\%1", _vehicleScript]);
		if (!isNil "_scriptCode") then 
		{
			[_objVictim, _objKiller, _sideVictim, _sideKiller] Call _scriptCode;
		}
		else
		{
			diag_log text "###[GW ERROR] - fnc_unitKilled.sqf could not execute a vehicle initialization script.";
		};
	};
};

//Remove from vehicles array
_vehIndex = GW_VEHICLES_WEST find _objVictim;
if (_vehIndex != -1) then
{
	GW_VEHICLES_WEST deleteAt _vehIndex;
	_sideClients = [_sideVictim, "netid"] Call fnc_shr_getSideMembers;
	{
		GW_CVAR_VEHICLES = GW_VEHICLES_WEST;
		_x publicVariableClient "GW_CVAR_VEHICLES";
	} forEach _sideClients;
};
_vehIndex = GW_VEHICLES_EAST find _objVictim;
if (_vehIndex != -1) then
{
	GW_VEHICLES_EAST deleteAt _vehIndex;
	_sideClients = [_sideVictim, "netid"] Call fnc_shr_getSideMembers;
	{
		GW_CVAR_VEHICLES = GW_VEHICLES_EAST;
		_x publicVariableClient "GW_CVAR_VEHICLES";
	} forEach _sideClients;
};

//Add to inactive if needed
if ((vehicle _objVictim) != _objVictim) then
{
	(vehicle _objVictim) Spawn fnc_srv_checkVehInactive;
};

//Add body to garbage collector
if ((_objVictim != GW_MHQ_WEST) && (_objVictim != GW_MHQ_EAST)) then
{	
	[_objVictim, GW_SERVER_GARBAGE_TIME] Spawn fnc_srv_addToGarbageCollector;
};

//Ignore player suicides
if (_objKiller == _objVictim) exitWith {diag_log text format["### UNIT KILLED - KILLER OBJECT AND VICTIM OBJECT ARE THE SAME - %1",_this]};
if (_groupKiller == _groupVictim) exitWith {diag_log text format["### UNIT KILLED - KILLER GROUP AND VICTIM GROUP ARE THE SAME - %1",_this]};

//Ignore AI teamkills
if (!(isPlayer _objKiller) && (_sideVictim == _sideKiller)) exitWith {diag_log text format["### UNIT KILLED - IGNORE AI TEAMKILLS - %1",_this]};

//Take a ticket away
if (isPlayer _objVictim) then
{
	[_sideVictim, "-", 1, false] Call fnc_srv_changeTickets;
};

//Get the value of the unit
_unitCost = [_objVictim, _sideVictim] Call fnc_shr_getUnitCost;

//Don't allow undefined costs to be used
if (!isNil "_unitCost") then
{
	//Get the displayname of the unit
	_unitDisplayName = "";
	if (_objVictim isKindOf "Man") then
	{
		_unitDisplayName = format["%1 %2",(_sideVictim Call fnc_shr_getSideName),(_objVictim getVariable ["GW_INFANTRYLOADOUT", (GetText (configFile >> "CfgVehicles" >> (typeOf _objVictim) >> "displayName"))])];
	}
	else
	{
		if ((count _vehicleArray) > 0) then
		{
			_unitDisplayName = _vehicleArray select 1;
		}
		else
		{
			_unitDisplayName = GetText (configFile >> "CfgVehicles" >> (typeOf _objVictim) >> "displayName");
		};
	};
	
	//Bonus if it was a player
	_bonus = 0;
	_player = false;
	if ((isPlayer _objVictim) && (_objVictim isKindOf "Man")) then 
	{
		_containerVar = format["GW_SESSION_%1",(getPlayerUID _objVictim)];
		_plyContainer = missionNamespace getVariable _containerVar;
		if (!isNil "_plyContainer") then
		{
			_rankIndex = [(_plyContainer select 9), 0, GW_RANKS] Call fnc_shr_arrayGetIndex;
			_bonus = (GW_RANKS select _rankIndex) select 4;
			_player = true;
		};
	};
	
	_leaderObj = objNull;
	
	//If it's a UAV
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
	
	//If it's a commander turret, give money to commander
	if (_objKiller getVariable ["GW_COMMTURRET", false]) then
	{
		_sideCommander = Call Compile Format["GW_COMMANDER_%1",_sideKiller];
		if (_sideCommander != "nil") then
		{
			_leaderObj = missionNamespace getVariable _sideCommander;
		};
	};

	if (!isNull _leaderObj) then
	{
		//Make sure leader is player
		if (isPlayer _leaderObj) then
		{			
			//Payout is based on what the player's rank is
			_containerVar = format["GW_SESSION_%1",getPlayerUID _leaderObj];
			_plyContainer = missionNamespace getVariable _containerVar;
			_sideCommander = Call Compile Format["GW_COMMANDER_%1",_sideKiller];
			_rankName = if ((vehicleVarName _leaderObj) == _sideCommander) then {"General"} else {_plyContainer select 9};
			_rankIndex = [_rankName, 0, GW_RANKS] Call fnc_shr_arrayGetIndex;
			
			//Get player's specialization
			_playerSpec = _leaderObj getVariable ["GW_SPECIALIZATION", ""];
			
			//Give a ticket to the team that killed the player
			if (_player && (_sideKiller == west || _sideKiller == east)) then 
			{
				if (!GW_SERVER_SUDDENDEATH) then {[_sideKiller, "+", 1, false] Call fnc_srv_changeTickets};
			};

			//Killed enemy
			if (_sideVictim != _sideKiller) then
			{
				//Calculate bounty & XP
				_bounty = round(_unitCost * ((GW_RANKS select _rankIndex) select 3)) + _bonus;
				_xp = (ceil(_unitCost * GW_RANK_KILL_RATIO)) max 1;
				switch (toLower(_playerSpec)) do
				{
					case "officer":
					{
						//25% extra XP for all unit kills
						_xp = _xp + (_xp * 0.25);
						
						//100% extra money for all infantry kills
						if (_objVictim isKindOf "Man") then {_bounty = _bounty * 2};
					};
					
					case "engineer":
					{
						//20% extra money for all vehicle kills
						if ((_objVictim isKindOf "Car") || (_objVictim isKindOf "Ship") || (_objVictim isKindOf "Tank") || (_objVictim isKindOf "Air")) then {_bounty = _bounty + (_bounty * 0.20)};
					};
				};
			
				//Give the player money for the kill
				[(getPlayerUID _leaderObj), "+", _bounty] Call fnc_srv_changeMoney;
				
				//Give the player experience for the kill
				[(getPlayerUID _leaderObj), "+", _xp] Spawn fnc_srv_changeRankPoints;
				
				//Send Message
				[[owner _leaderObj], "messages", "", ["blueChat",["GWAR3_UnitKilled",[round(_unitCost * ((GW_RANKS select _rankIndex) select 3)), _xp, _unitDisplayName]]]] Spawn fnc_srv_requestClientExec;
				if (_player) then
				{
					//Tell the player they got bonus for killing a player
					[[owner _leaderObj], "messages", "", ["blueChat",["GWAR3_UnitKilled_Player",[round(_bonus), name _objVictim]]]] Spawn fnc_srv_requestClientExec;
					
					//Give the player bonus experience for killing a player
					[(getPlayerUID _leaderObj), "+", (GW_RANKS select _rankIndex) select 5] Spawn fnc_srv_changeRankPoints;
				};
				
				//Log event in DB
				if (GW_DATABASE) then
				{
					if ((_killedWith != "ERROR") && (_victimClass != "ERROR")) then
					{
						_victimUID = (getPlayerUID _objVictim);
						if (isNil "_victimUID") then {_victimUID = ""};
						["", ["db"], [GW_SERVERKEY, "UnitKill", GW_MATCHID, (getPlayerUID _leaderObj), _victimUID, _sideKiller, _sideVictim, _killedWith, _killerType, _victimClass, _victimType, _distance, _bounty]] Spawn fnc_srv_spawnExtension;
					};
				};
			};
			
			//Teamkill
			if (_sideVictim == _sideKiller) then
			{
				//Calculate bounty & XP
				_bounty = round(_unitCost * ((GW_RANKS select _rankIndex) select 3)) + _bonus;
				_xp = (round(_unitCost * GW_RANK_TEAMKILL_RATIO)) max 1;
				
				//Take money away for teamkilling
				[(getPlayerUID _leaderObj), "-", _bounty] Call fnc_srv_changeMoney;
				
				//Take experience away for the kill
				[(getPlayerUID _leaderObj), "-", _xp] Spawn fnc_srv_changeRankPoints;
				
				//Send Message
				[[owner _leaderObj], "messages", "", ["blueChat",["GWAR3_UnitTeamKilled",[round(_unitCost), _xp, _unitDisplayName]]]] Spawn fnc_srv_requestClientExec;
				if (_player) then
				{
					//Tell the player they teamkilled a player
					[[owner _leaderObj], "messages", "", ["blueChat",["GWAR3_UnitTeamKilled_Player",[round(_bonus), name _objVictim]]]] Spawn fnc_srv_requestClientExec;
					
					//Take away extra for killing a friendly player
					[(getPlayerUID _leaderObj), "-", (GW_RANKS select _rankIndex) select 5] Spawn fnc_srv_changeRankPoints;
				};
				
				//Log event in DB
				if (GW_DATABASE) then
				{
					if ((_killedWith != "ERROR") && (_victimClass != "ERROR")) then
					{
						_victimUID = (getPlayerUID _objVictim);
						if (isNil "_victimUID") then {_victimUID = ""};
						["", ["db"], [GW_SERVERKEY, "UnitKill", GW_MATCHID, (getPlayerUID _leaderObj), _victimUID, _sideKiller, _sideVictim, _killedWith, _killerType, _victimClass, _victimType, _distance, _bounty]] Spawn fnc_srv_spawnExtension;
					};
				};
			};
		};
	};
};

//Delete group if this unit was the last unit
if (count(units _groupVictim) < 1) then {deleteGroup _groupVictim};