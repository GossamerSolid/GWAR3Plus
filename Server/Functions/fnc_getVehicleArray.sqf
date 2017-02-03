private["_vehicleUID","_currUID","_array"];

_vehicleUID = _this;
_array = [];

{
	_currUID = _x select 11;
	if (_currUID == _vehicleUID) exitWith {_array = _x};
} forEach GW_VEHICLES;

_array 