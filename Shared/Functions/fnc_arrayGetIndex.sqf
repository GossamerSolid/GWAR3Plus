//fnc_arrayGetIndex.sqf
//Written by - GossamerSolid
//Get the index of an element of a multidimensional array
//NOTE - Returns first match
//@param _searchValue - Value to search against
//@param _searchIndex - index of element to search at
//@param _searchArray - Array to search through
//@returns - Scalar - index of element

private ["_searchValue", "_searchIndex", "_searchArray", "_returnIndex"];

_searchValue = "";
_searchIndex = -1;
_searchArray = [];
_returnIndex = -1;

if (count(_this) == 2) then
{
	_searchValue = _this select 0;
	_searchArray = _this select 1;

	{
		if (_x == _searchValue) exitWith {_returnIndex = _forEachIndex};
	} forEach _searchArray;
}
else
{
	_searchValue = _this select 0;
	_searchIndex = _this select 1;
	_searchArray = _this select 2;
	
	{
		_currVal = if (typeName _x == "ARRAY") then {_x select _searchIndex} else {_x};
		if (_currVal == _searchValue) exitWith {_returnIndex = _forEachIndex};
	} forEach _searchArray;
};

_returnIndex

