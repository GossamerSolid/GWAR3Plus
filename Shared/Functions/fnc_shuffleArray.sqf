/*
Script: fnc_shuffleArray.sqf
Written by: GossamerSolid

Given an array, shuffle the elements using the Fisher-Yates algorithm
*/

private["_originalArray","_copyArray","_i","_j","_iVar","_jVar"];

_originalArray = _this;
_copyArray = _originalArray;

_i = 0;
{
	_j = round(random(count(_copyArray) - 1));
	_iVar = _copyArray select _i;
	_jVar = _copyArray select _j;
	_copyArray set [_i, _jVar];
	_copyArray set [_j, _iVar];
	
	_i = _i + 1;
} forEach _originalArray;

_copyArray 