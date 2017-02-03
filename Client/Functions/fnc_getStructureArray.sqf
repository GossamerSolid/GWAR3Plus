private["_buildingUID","_currUID","_array"];

_buildingUID = _this;
_array = [];

//Search through base structures first
{
	_currUID = _x select 17;
	if (_currUID == _buildingUID) exitWith {_array = _x};
} forEach GW_CONSTRUCT_BASESTRUCT;

//Defensive structures next
if (count(_array) < 1) then
{
	{
		_currUID = _x select 17;
		if (_currUID == _buildingUID) exitWith {_array = _x};
	} forEach GW_CONSTRUCT_DEFSTRUCT;
};

//Others finally
if (count(_array) < 1) then
{
	{
		_currUID = _x select 17;
		if (_currUID == _buildingUID) exitWith {_array = _x};
	} forEach GW_CONSTRUCT_MISCSTRUCT;
};

_array 