//fnc_getNearestCamp.sqf
//Written by - GossamerSolid
//Get the nearest zone index based on a given origin position
//@param _pos - Original Position

//@returns - Scalar - The index to be used to find the full zone info in the global GW_ZONES on the server

_originPos = _this select 0;
_campArray = _this select 1;
_returnIndex = -1;

_closest = missionNameSpace getVariable ((_campArray select 0) select 0);
{
	_current = (missionNameSpace getVariable (_x select 0));

	_distance = _originPos distance (getPosATL(_current));
	_distanceClosest = _originPos distance (getPosATL(_closest));
	
	if (_distance <= _distanceClosest) then
	{
		_closest = _current;
		_distanceActual = _distance - GW_GVAR_CAMP_CAPTURE_RADIUS;
		if (_distanceActual < 1) then
		{
			_returnIndex = _forEachIndex;
		};
	};
} forEach _campArray;

_returnIndex