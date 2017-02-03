//fnc_getNearestZone.sqf
//Written by - GossamerSolid
//Get the nearest zone index based on a given origin position
//@param _pos - Original Position
//@returns - Scalar - The index to be used to find the full zone info in the global GW_ZONES on the server

_originPos = _this;
_returnIndex = -1;

_closest = GW_ZONES_STUB select 0;
{
	_current = _x;
	_distance = _originPos distance (_current select 1);
	_distanceClosest = _originPos distance (_closest select 1);
	
	if (_distance <= _distanceClosest) then
	{
		_closest = _current;
		_distanceActual = _distance - (_closest select 2);
		if (_distanceActual < 1) then
		{
			_returnIndex = _forEachIndex;
		};
	};
} forEach GW_ZONES_STUB;

_returnIndex