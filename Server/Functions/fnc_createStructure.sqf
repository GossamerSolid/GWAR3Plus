private["_side","_buildingUID","_classname","_pos","_dir","_returnArray","_availableSupply","_realObj","_structureArray","_cost","_sideClientList","_category","_scriptedCondition","_baseArray","_defArray","_helperObj","_playerUID","_originType","_broadcastMessage"];

_side = _this select 0;
_buildingUID = _this select 1;
_pos = _this select 2;
_dir = _this select 3;
_playerUID = _this select 4;
_originType = _this select 5;
_broadcastMessage = if (count(_this) > 6) then {_this select 6} else {true};
_returnArray = [true,""];

_availableSupply = if (_originType == "MHQ") then {Call Compile Format["GW_SUPPLY_%1",_side]} else {_playerUID Call fnc_srv_getPlayerMoney};
_structureArray = _buildingUID Call fnc_srv_getStructureArray;

_cost = _structureArray select 2;
if ((_availableSupply - _cost) >= 0) then
{
	//Get the classname
	_classname = _structureArray select 0;
	
	//Get the category
	_category = _structureArray select 3;
	
	//Remove resources (Supply or Money, depends on origin type)
	if (_originType == "MHQ") then {[_side, "-", _cost] Spawn fnc_srv_changeSupply} else {[_playerUID, "-", _cost] Spawn fnc_srv_changeMoney};
	
	//Create structure
	_realObj = createVehicle [_classname, [0,0,0], [], 0, "NONE"];
	_realObj setDir _dir;
	_realObj setPosATL _pos;
	
	//Set the UID
	_realObj setVariable ["GW_STRUCTUID", _buildingUID, true];
	
	//Set Side
	_realObj setVariable ["GW_SIDE", _side, true];
	
	//Set flush with terrain
	_realObj setVectorUp (surfaceNormal (getPosATL _realObj));
	
	//If it's not the "other" category
	if (_category != "Other") then
	{
		//Set a var on the object so we know when it was created
		_realObj setVariable ["GW_TIMECREATED", GW_TIME_ELAPSED, true];
		
		//Tell clients on side that a structure was built and mark on the map
		if (_broadcastMessage) then
		{
			_sideClientList = [_side, "netid"] Call fnc_shr_getSideMembers;
			[_sideClientList, "structure", "created", [_realObj, (_structureArray select 1), (_structureArray select 9), (_structureArray select 10), true]] Spawn fnc_srv_requestClientExec;
		};
	
		//Only if Base
		if (_category == "Base") then
		{	
			//Create team flag pole (To help identify it as a team building)
			_boundingBox = boundingBoxReal _realObj;
			_flagPos = _realObj modelToWorld [(_boundingBox select 1) select 0, (_boundingBox select 1) select 1, 0];
			_flagPos set [2, 0];
			_flagObj = createVehicle ["Flag_White_F", _flagPos, [], 0, "NONE"];
			_flagObj setPosATL _flagPos;
			_flagObj setVectorUp (surfaceNormal (getPosATL _flagObj));
			_flagObj setFlagTexture ([_side] Call fnc_shr_getFlagTex);
			_realObj setVariable ["GW_FLAGOBJ", _flagObj];
			
			//Set structure's health
			_realObj setVariable ["GW_BUILDINGHEALTH", (_structureArray select 23), true];
			
			//Set damage timeout
			_realObj setVariable ["GW_DAMAGE_TIMEOUT", -1, false];
			
			//Create construction queue
			_realObj setVariable ["GW_CONSTRUCTION_QUEUE", [], false];
			
			//Blocked placement
			_realObj setVariable ["GW_CONSTRUCTION_BLOCKED", 30, false];
			_realObj setVariable ["GW_CONSTRUCTION_BLOCKED_COUNT", 0, false];
			
			//Add to side's base structures array (Couldn't do this via call compile format - runtime error)
			if (_side == west) then {GW_BUILDINGS_BASE_WEST pushBack _realObj};
			if (_side == east) then {GW_BUILDINGS_BASE_EAST pushBack _realObj};
			
			//Handle the damaging and destruction of structures
			if (_side == west) then
			{
				_realObj addEventHandler ["HandleDamage",{[_this, west] Call fnc_srv_structureScriptedDamage}];
			};
			if (_side == east) then
			{
				_realObj addEventHandler ["HandleDamage",{[_this, east] Call fnc_srv_structureScriptedDamage}];
			};
			
			//Create placement helper (if there needs to be one)
			if (((_structureArray select 20) select 0) != 0) then
			{
				_helperObj = createVehicle ["Land_HelipadCircle_F", [0,0,0], [], 0, "NONE"];
				_helperObj setDir _dir;
				_helperObj setPosATL (_realObj modelToWorld (_structureArray select 20));
				_helperObj setVectorUp (surfaceNormal (getPosATL _helperObj));
				_realObj setVariable ["GW_STRUCTHELPER", _helperObj];
			};
			
			//Send to clients
			_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
			{
				GW_CVAR_BUILDINGS_BASE = Call Compile Format["GW_BUILDINGS_BASE_%1",_side];
				_x publicVariableClient "GW_CVAR_BUILDINGS_BASE";
			} forEach _sideClients;
			
			//If sudden death, update the other team
			if (GW_SERVER_SUDDENDEATH) then
			{
				_markedArray = [];
				_markedArray pushBack
				[
					_realObj,
					[24, 24],
					([_side, "RGBA"] Call fnc_shr_getSideColour),
					(_structureArray select 10),
					-1,
					-1,
					false
				];
				
				_oppositeSide = if (_side == west) then {east} else {west};
				_teamMarkerList = [_oppositeSide, "netid"] Call fnc_shr_getSideMembers;
				[_teamMarkerList, "markedobjects", "", _markedArray] Spawn fnc_srv_requestClientExec;
			};
			
		};
		
		//Only if defenses
		if (_category == "Defenses") then
		{
			//Add to side's base structures array (Couldn't do this via call compile format - runtime error)
			if (_side == west) then {GW_BUILDINGS_DEF_WEST pushBack _realObj};
			if (_side == east) then {GW_BUILDINGS_DEF_EAST pushBack _realObj};
			
			//Put crew into defenses
			waitUntil {!isNull _realObj};
			_unitClassname = (Call Compile Format ["GW_DATA_INFANTRYCLASS_%1",_side]);
			_unit = ([_side, "Statics"] Call fnc_srv_getSideGroup) createUnit [_unitClassname, [0,0,0], [], 0, "FORM"];
			_unit moveInGunner _realObj;
			_unit setCombatMode "RED";
			
			//Equip unit
			_infantryArray = [GW_INFANTRY_DRIVER, _side] Call fnc_shr_getInfantryArray;
			_infantryLoadout = _infantryArray select 3;
			_unitEquipScript = [_unit, _infantryLoadout] spawn fnc_shr_equipUnit;
			waitUntil{scriptDone _unitEquipScript};
			
			//Force AI to face direction of turret
			_unit setFormDir (getDir _realObj);
			_unit setDir (getDir _realObj);
			
			//Set skill
			_unit setSkill ["aimingAccuracy", 0.7];
			_unit setSkill ["spotDistance", 1];
			_unit setSkill ["spotTime", 1];
			_unit setSkill ["general", 1];

			if (_side == west) then
			{
				_unit addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, west] Call fnc_srv_unitKilled;};}];
				_realObj addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, west] Call fnc_srv_structureKilled;};}];
			};
			if (_side == east) then
			{
				_unit addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, east] Call fnc_srv_unitKilled;};}];
				_realObj addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, east] Call fnc_srv_structureKilled;};}];
			};
			if (_side == guer) then
			{
				_unit addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, guer] Call fnc_srv_unitKilled;};}];
				_realObj addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, guer] Call fnc_srv_structureKilled;};}];
			};
			
			//Identifier
			_realObj setVariable ["GW_COMMTURRET", true, true];
			
			//Unlimited ammo
			_realObj addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
			
			//If an AI is placed in the turret, remove them from their player group
			_realObj addEventHandler ["GetIn",
			{
				_crew = _this select 2;
				
				if (!isPlayer _crew) then
				{
					[_crew] joinSilent ([(_crew getVariable ["GW_SIDE", (side _crew)]), "Statics"] Call fnc_srv_getSideGroup);
					_crew setCombatMode "RED";
					_crew setBehaviour "COMBAT";
				};
			}];
			
			//Try to sit it upright again and stick the crew back in
			_realObj addEventHandler ["GetOut",
			{
				_turret = _this select 0;
				_prevPos = _this select 1;
				_crew = _this select 2;
				
				//Set the turret upright again
				_turret setVectorUp (surfaceNormal (getPosATL _turret));
				
				//Put the crew back in
				if (alive _crew) then
				{
					if (!isPlayer _crew) then
					{
						_crew assignAsGunner _turret;
						_crew moveInGunner _turret;
					};
				};
			}];
			
			//Send to clients
			_sideClients = [_side, "netid"] Call fnc_shr_getSideMembers;
			{
				GW_CVAR_BUILDINGS_DEF = Call Compile Format["GW_BUILDINGS_DEF_%1",_side];
				_x publicVariableClient "GW_CVAR_BUILDINGS_DEF";
			} forEach _sideClients;
			
			//If sudden death, update the other team
			if (GW_SERVER_SUDDENDEATH) then
			{
				_markedArray = [];
				_markedArray pushBack
				[
					_realObj,
					[24, 24],
					([_side, "RGBA"] Call fnc_shr_getSideColour),
					getText(configFile >> "CfgVehicles" >> (typeOf (vehicle _realObj)) >> "Icon"),
					-1,
					-1,
					true
				];
				
				_oppositeSide = if (_side == west) then {east} else {west};
				_teamMarkerList = [_oppositeSide, "netid"] Call fnc_shr_getSideMembers;
				[_teamMarkerList, "markedobjects", "", _markedArray] Spawn fnc_srv_requestClientExec;
			};
			
			//Reveal all units within object view distance to the static
			[_unit] Spawn
			{
				sleep 2;
				_listUnits = (getPosASL (_this select 0)) nearEntities [["Car","Tank","Air","Ship",GW_DATA_INFANTRYCLASS_EAST,GW_DATA_INFANTRYCLASS_GUER,GW_DATA_INFANTRYCLASS_WEST], GW_GVAR_OBJVIEWDISTANCE];
				{
					(_this select 0) reveal [_x, 4];
				} forEach _listUnits;                
			};
		};
	};
	
	//Execute the script on the structure if there is one
	_structureScript = _structureArray select 8;
	if (_structureScript != "") then
	{
		//Execute the script - ALL arguments passed to fnc_createStructure + the newly created structure object are available in the script as well
		_scriptCode = Compile preprocessFileLineNumbers (format["Shared\Configuration\StructureScripts\%1", _structureScript]);
		if (!isNil "_scriptCode") then 
		{
			[_realObj, _this] Spawn _scriptCode;
		}
		else
		{
			diag_log text "###[GW ERROR] - fnc_createStructure.sqf could not execute the structure initialization script.";
		};
	};
	
	//Confirm no problems
	_returnArray = [true, ""];
}
else
{
	_returnArray = [false, "Insufficient funds"];
};

_returnArray


