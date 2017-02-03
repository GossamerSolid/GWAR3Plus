private["_buildingUID","_currUID","_array"];

_buildingUID = _this;
_array = [];

{
	_currUID = _x select 17;
	if (_currUID == _buildingUID) exitWith {_array = _x};
} forEach GW_STRUCTURES;

_array 