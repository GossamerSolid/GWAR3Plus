private["_sideFor","_structureType","_resultStructArray","_currentRecord","_sides","_conType"];

_sideFor = _this select 0;
_structureType = _this select 1;

_resultStructArray = [];
{
	_currentRecord = _x;
	_conType = _currentRecord select 3;
	_sides = _currentRecord select 4;
	{
		if ((_x == _sideFor) && (_conType == _structureType)) exitWith {_resultStructArray set [count _resultStructArray, _currentRecord]};
	} forEach _sides;
} forEach GW_STRUCTURES;

_resultStructArray 