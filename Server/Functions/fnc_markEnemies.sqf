private["_playerSide", "_playerUID", "_markedPosition", "_markRadius", "_markedArray", "_objectSide", "_listObjects", "_playerObj", "_timeout"];
_playerSide = _this select 0;
_playerUID = _this select 1;
_markedPosition = _this select 2;
_markRadius = _this select 3;
_markedArray = [];

_playerObj = _playerUID Call fnc_shr_getObjFromUID;
_timeout = if ((_playerObj getVariable ["GW_SPECIALIZATION", ""]) == "Special Forces") then {180} else {60};

_listObjects = nearestObjects [_markedPosition, ["Car","Tank","Air","Ship",GW_DATA_INFANTRYCLASS_EAST,GW_DATA_INFANTRYCLASS_GUER,GW_DATA_INFANTRYCLASS_WEST,"Building"], _markRadius];
if ((count _listObjects) > 0) then
{
	{
		//Get the object side
		_objectSide = _x Call fnc_shr_getObjSide;
		
		//Ignore marking your own side or civilian
		if ((_objectSide != _playerSide) && (_objectSide != civ)) then
		{
			_icon = getText(configFile >> "CfgVehicles" >> (typeOf (vehicle _x)) >> "Icon");
			_updateDirection = true;
			_structureUID = _x getVariable ["GW_STRUCTUID", ""];
			if (_structureUID != "") then
			{
				_structIndex = [_structureUID, 17, GW_STRUCTURES] Call fnc_shr_arrayGetIndex;
				if (_structIndex != -1) then
				{
					_structArray = GW_STRUCTURES select _structIndex;
					if ((_structArray select 3) != "Defenses") then
					{
						_icon = _structArray select 10;
						_updateDirection = false;
					};
				};
			};
			if ((_x == GW_MHQ_WEST) || (_x == GW_MHQ_EAST)) then {_icon = GW_MISSIONROOT + "Resources\images\struct_hq.paa"};
			
			_markedArray pushBack
			[
				_x,
				[24, 24],
				([_objectSide, "RGBA"] Call fnc_shr_getSideColour),
				_icon,
				-1,
				_timeout,
				_updateDirection
			];
		};
	} forEach _listObjects;
	
	//Broadcast marker(s) to side
	_teamMarkerList = [_playerSide, "netid"] Call fnc_shr_getSideMembers;
	[_teamMarkerList, "markedobjects", "", _markedArray] Spawn fnc_srv_requestClientExec;
	
	//Let commander turrets know about the units
	{
		([_playerSide, "Statics"] Call fnc_srv_getSideGroup) reveal [(_x select 0), 4]; 
	} forEach _markedArray;
};