/*
Filename:
fnc_getObjSide.sqf

Author(s):
GossamerSolid

Description:
Gets the side of a given object (Should work for both units and structures)
*/

private ["_passedObj", "_retSide", "_varName", "_leaderObj"];

_passedObj = _this;
_retSide = civilian;

//By varname (This only works for players)
_varName = toLower(vehicleVarName _passedObj);
if ((_varName find "west") != -1) then {_retSide = west};
if ((_varName find "east") != -1) then {_retSide = east};
if ((_varName find "guer") != -1) then {_retSide = guer};

//Get leader of group's side
if (_retSide == civilian  || _retSide == sideUnknown) then
{
	_leaderObj = leader (group _passedObj);
	_retSide = side _leaderObj;
	
	//Side of the actual object
	if (_retSide == civilian || _retSide == sideUnknown) then
	{
		_retSide = _passedObj getVariable ["GW_SIDE", (side _passedObj)];
	};
};

_retSide 