//fnc_getObjFromUID.sqf
//Written by: GossamerSolid
//Get the object reference of a player from a UID
//@param _objUID - The UID of the desired object
//@returns - object of given UID

private["_returnedObj", "_objUID"];

_objUID = _this;

_returnedObj = objNull;

while {isNull _returnedObj} do
{
	{
		if ((getPlayerUID _x) == _objUID) exitWith {_returnedObj = _x};
	} forEach playableUnits;
};

_returnedObj 