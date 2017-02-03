//vehscript_init_uav.sqf
//Written by: GossamerSolid
//Vehicle script executed on creation of a UAV

private ["_vehObj"];

_vehObj = _this select 0;

createVehicleCrew _vehObj;

_vehObj setVariable ["GW_UAV", true, true];

//We don't want our UAV getting unbound from the player who purchased it
[_vehObj] Spawn
{
	private["_uavObj", "_ownerUID", "_ownerObj", "_playerItems", "_keepGoing", "_uavControl"];
	_uavObj = _this select 0;
	_ownerUID = _uavObj getVariable ["GW_VEHOWNER", ""];
	
	//Keep going until told otherwise
	_timesFailed = 0;
	while {true} do
	{
		_keepGoing = true;
		
		//UAV is null
		if (isNull _uavObj) exitWith {_keepGoing = false};
		//UAV is dead
		if (!(alive _uavObj)) exitWith {_keepGoing = false};
		//Failed 150 times (5 minutes) to figure out who the owner is (most likely disconnected) OR they removed their UAV terminal - delete UAV
		if (_timesFailed >= 149) exitWith {_keepGoing = false; deleteVehicle _uavObj};
		
		//Figure out who the owner is and make sure it stays attached
		_ownerObj = _ownerUID Call fnc_shr_getObjFromUID;
		if (!isNil "_ownerObj") then
		{
			if (!isNull _ownerObj) then
			{
				_playerItems = assignedItems _ownerObj;
				if (("B_UavTerminal" in _playerItems) || ("O_UavTerminal" in _playerItems)) then
				{
					//Only reconnect if UAV isn't already connected to the owner
					_uavControl = UAVControl _uavObj;
					if (!(_ownerObj in _uavControl)) then
					{
						_ownerObj connectTerminalToUAV _uavObj;
						_timesFailed = 0;
					};
				}
				else
				{
					_timesFailed = _timesFailed + 1;
				};
			}
			else
			{
				_timesFailed = _timesFailed + 1;
			};
		}
		else
		{
			_timesFailed = _timesFailed + 1;
		};
		
		sleep 2;
	};
};