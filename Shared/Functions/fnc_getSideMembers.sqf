/*
Filename:
fnc_getSideMembers.sqf

Author(s):
GossamerSolid

Description:
Gets the members of a specified side
*/

private ["_sideOn", "_retType", "_obj", "_sideObj", "_returnArray", "_varName"];

_sideOn = _this select 0;
_retType = _this select 1;

_returnArray = [];
{
	if (!isNull _x) then
	{
		_sideObj = _x Call fnc_shr_getObjSide;
		
		if (_sideObj == _sideOn) then
		{
			switch (_retType) do 
			{
				case "netid":
				{
					_returnArray set [count _returnArray, (owner _x)];
				};
				case "obj":
				{
					_returnArray set [count _returnArray, _x];
				};
				case "uid":
				{
					_returnArray set [count _returnArray, (getPlayerUID _x)];
				};
				case "varname":
				{
					_returnArray set [count _returnArray, (vehicleVarName _x)];
				};
			};
		};
	};
} forEach allPlayers;

_returnArray 