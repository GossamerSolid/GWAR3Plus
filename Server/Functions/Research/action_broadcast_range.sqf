//action_broadcast_range.sqf
//Written by: GossamerSolid
//Update any existing comm tower or radar station's broadcast range

private["_playerSide", "_commRange", "_commTowerObj", "_heightASL", "_sideStructures", "_structUID", "_structIndex", "_structArray", "_baseStructures"];

_playerSide = _this;
_sideStructures = Call Compile Format["GW_BUILDINGS_BASE_%1",_playerSide];
_baseStructures = [_playerSide, "Base"] Call fnc_shr_getSideStructures;

{
	_structUID = _x getVariable ["GW_STRUCTUID", ""];
	if (_structUID != "") then
	{
		_structIndex = [_structUID, 17, _baseStructures] Call fnc_shr_arrayGetIndex;
		if (_structIndex != -1) then
		{
			_structArray = _baseStructures select _structIndex;
			if ("Comm" in (_structArray select 21) || "Radar" in (_structArray select 21)) then
			{
				_heightASL = (getPosASL _x) select 2;
				_commRange = round(GW_SERVER_COMMTOWER_BASE_RANGE_UPG + (GW_SERVER_COMMTOWER_RANGE_MODIFIER_UPG * _heightASL));
				_x setVariable ["GW_COMMRANGE", _commRange, true];
			};
		};
	};
} forEach _sideStructures;
Call Compile Format["GW_BUILDINGS_BASE_%1 = _sideStructures",_playerSide];

//Send to clients
_sideClients = [_playerSide, "netid"] Call fnc_shr_getSideMembers;
{
	GW_CVAR_BUILDINGS_BASE = Call Compile Format["GW_BUILDINGS_BASE_%1",_playerSide];
	_x publicVariableClient "GW_CVAR_BUILDINGS_BASE";
} forEach _sideClients;