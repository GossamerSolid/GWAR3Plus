private["_playerUID","_unitType","_unitArray","_structureObj","_playerSide","_structureArray","_vehicleArray","_vehicleClass","_vehicleObj","_playerObj","_randomPos","_unitClassname","_playerObj","_unitGroup","_unit","_infantryLoadout","_squadSize","_maxSquadSize","_buildDirection"];

_structureObj = _this select 0;
_playerUID = (_this select 1) select 0;
_unitArray = (_this select 1) select 2;
_unitType = _unitArray select 0;
_playerObj = _playerUID Call fnc_shr_getObjFromUID;
_buildPos = [0,0,0];

//If NOT zone
if (_unitType != "Zone") then
{
	_structureArray = (_structureObj getVariable "GW_STRUCTUID") Call fnc_srv_getStructureArray;
	_buildPos = _structureObj modelToWorld (_structureArray select 20);
};

//Get player's group
_playerSide = _playerObj Call fnc_shr_getObjSide;
_unitGroup = group _playerObj;

//Get squad sizes
_squadSize = _playerObj Call fnc_shr_getSquadSize;
_maxSquadSize = _playerUID Call fnc_srv_getMaxSquadSize;
_alreadyQueued = [_playerUID, _playerSide] Call fnc_srv_countInfantryInQueue;

//Different handling depending on what type of unit was just purchased
if (_unitType == "infantry") then
{
	//Check if unit can fit in player's squad
	if ((_squadSize + _alreadyQueued + 1) <= _maxSquadSize) then
	{
		//Get infantry loadout
		_infantryArray = [_unitArray select 1,_unitArray select 2] Call fnc_shr_getInfantryArray;
		_infantryLoadout = _infantryArray select 3;
		
		//Get the unit classname
		_unitClassname = (Call Compile Format ["GW_DATA_INFANTRYCLASS_%1",_unitArray select 2]);

		//Create unit
		[[owner _playerObj], "createInfantry", "", [(_unitArray select 1), (_unitArray select 2), _buildPos]] Spawn fnc_srv_requestClientExec;
		
		//Tell player their infantry is here
		[[owner _playerObj], "messages", "", ["blueChat",["GWAR_UnitRecruited",[(_infantryArray select 0)]]]] Spawn fnc_srv_requestClientExec;
	}
	else
	{ 
		//Refund player as they don't have room
		_infantryCost = _unitArray select 3;
		[_playerUID, "+", _infantryCost] Spawn fnc_srv_changeMoney;
		[[owner _playerObj], "messages", "", ["blueChat",["GWAR_RefundedUnit",[_unitArray select 3]]]] Spawn fnc_srv_requestClientExec;
	};
}
else
{
	//Check if selected crew can fit in player's squad
	_crewCount = 0;
	{if (_x) then {_crewCount = _crewCount + 1};} forEach (_unitArray select 3);
	
	_vehicleArray = (_unitArray select 1) Call fnc_srv_getVehicleArray;
	_vehicleClass = _vehicleArray select 0;
	_vehicleCrew = _vehicleArray select 13;
	
	_canBuildUAV = true;
	if ("uav" in (_vehicleArray select 10)) then
	{
		//Need to have a UAV terminal
		_playerItems = assignedItems _playerObj;
		if (!("B_UavTerminal" in _playerItems) && !("O_UavTerminal" in _playerItems)) then
		{
			_canBuildUAV = false;
			
			//Refund player as they don't have a UAV terminal
			[_playerUID, "+", (_unitArray select 5)] Call fnc_srv_changeMoney;
			[[owner _playerObj], "messages", "", ["blueChat",["GWAR_RefundedUnit",[(_unitArray select 5)]]]] Spawn fnc_srv_requestClientExec;
		};
		
		//Only 1 UAV per player
		if (_canBuildUAV) then
		{
			if (!(isNull (getConnectedUAV _playerObj))) then
			{
				_canBuildUAV = false;
			
				//Refund player as they already have a UAV
				[_playerUID, "+", (_unitArray select 5)] Call fnc_srv_changeMoney;
				[[owner _playerObj], "messages", "", ["blueChat",["GWAR_RefundedUnit",[(_unitArray select 5)]]]] Spawn fnc_srv_requestClientExec;
			};
		};
	};
	if (!_canBuildUAV) exitWith {};

	//If there's enough room
	if (((_squadSize + _crewCount + _alreadyQueued) <= _maxSquadSize) || _crewCount == 0) then
	{	
		_buildDirection = getDir _structureObj;
		
		//Zone build loc
		if (_unitType == "Zone") then
		{
		
			_buildPos = [getPosATL _structureObj, random(10 * 0.25), 50, false, _vehicleClass] Call fnc_shr_getRandPos;
			while {(_buildPos select 0) == -1} do
			{
				_buildPos = [getPosATL _structureObj, random(10 * 0.25), 50, false, _vehicleClass] Call fnc_shr_getRandPos;
			};
		};
		
		//Create the vehicle
		_buildPos set [2, 1];
		_vehicleObj = [_vehicleClass, _buildPos, _buildDirection, [_playerUID, (_unitArray select 2)], _playerSide, _vehicleArray, true] Call fnc_srv_createVehicle;
		if (_unitType == "Naval") then
		{
			_vehicleObj setPosASLW [(_buildPos select 0), (_buildPos select 1), 0];
		};
		
		//Connect player to UAV
		if ("uav" in (_vehicleArray select 10)) then {_playerObj connectTerminalToUAV _vehicleObj};
		
		//Create crew
		waitUntil {!isNull _vehicleObj};
		[[owner _playerObj], "fillVehicle", "", [_vehicleObj, (_unitArray select 3)]] Spawn fnc_srv_requestClientExec;
		
		//Tell player their vehicle is here
		[[owner _playerObj], "messages", "", ["blueChat",["GWAR_VehicleConstructed",[(_vehicleArray select 1),(getText (configFile >> "CfgVehicles" >> _vehicleClass >> "Picture"))]]]] Spawn fnc_srv_requestClientExec;
	}
	else
	{
		//Refund player as they don't have room
		[_playerUID, "+", (_unitArray select 5)] Call fnc_srv_changeMoney;
		[[owner _playerObj], "messages", "", ["blueChat",["GWAR_RefundedUnit",[(_unitArray select 5)]]]] Spawn fnc_srv_requestClientExec;
	};
};
