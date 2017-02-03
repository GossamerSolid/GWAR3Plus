private["_sideFor","_equipType","_fullEquipArray","_resultEquipArray","_currentRecord","_sides","_equipArrNetCall"];

_sideFor = _this select 0;
_equipType = _this select 1;

_fullEquipArray = [];

_fullEquipArray = Call Compile Format["GW_EQUIP_%1",_equipType];
_resultEquipArray = [];
{
	_currentRecord = _x;
	_sides = _currentRecord select 2;
	{
		if (_x == _sideFor) exitWith {_resultEquipArray set [count _resultEquipArray, _currentRecord]};
	} forEach _sides;
} forEach _fullEquipArray;

_resultEquipArray 