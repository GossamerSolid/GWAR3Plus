/*
Script: fnc_expandCargoArray.sqf
Written by: GossamerSolid

Given a cargo array (getItemCargo, getWeaponCargo, getMagazineCargo), it will return an array expanded by using the two parallel
arrays from a cargo array to form 1 array.
*/

private ["_collapsedArray","_expandedArray","_classname","_amount"];

_collapsedArray = _this;
_expandedArray = [];

if ((count _collapsedArray) > 0) then
{
	_classnameArray = _collapsedArray select 0;
	_amountArray = _collapsedArray select 1;
	{
		_classname = _classnameArray select _forEachIndex;
		_amount = _amountArray select _forEachIndex;

		for "_i" from 1 to _amount do
		{
			_expandedArray set [count _expandedArray, _classname];
		};
	
	} forEach _classnameArray;
};

_expandedArray