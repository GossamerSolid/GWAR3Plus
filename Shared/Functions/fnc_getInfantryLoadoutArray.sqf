private["_loadoutName","_side","_currName","_currSide","_array"];

_loadoutName = _this select 0;
_side = _this select 1;
_array = [];

{
	_currName = _x select 0;
	_currSide = _x select 2;
	if ((_currName == _loadoutName) && (_currSide == _side)) exitWith {_array = _x};
} forEach GW_INFANTRY_LOADOUTS;

_array 