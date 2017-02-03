//fnc_getRandPos.sqf
//Written by: GossamerSolid
//Provides a random spawn position, given a location
//@param _position - center point
//@param _minRadius - minimum radius from _position
//@param _maxRadius - maximum radius from _position
//@param _waterAllowed - is the position allowed to be on water
//@returns - position (will return [-1,-1,-1] if no good position found)

Private["_position","_radius","_direction","_maxRadius","_minRadius","_objectType","_emptyPos"];

_position = _this select 0;
_minRadius = _this select 1;
_maxRadius = _this select 2;
_allowedWater = _this select 3;
_direction = random 360;
_objectType = if (count(_this) > 4) then {_this select 4} else {"nil"};

_radius = (random (_maxRadius - _minRadius)) + _minRadius;
_position = [(_position select 0) + ((sin _direction) * _radius), (_position select 1) + ((cos _direction) * _radius), (_position select 2)];

_near = nearestObjects [_position, ["Thing","AllVehicles","Building","House"], 7];
_nearest = _near select 0;
if (!isNil "_nearest") then
{
	_box = boundingBoxReal _nearest;
	_width = ((_box select 1) select 0);
	_length = ((_box select 1) select 1);
	_longest = (sqrt((_width * _width) + (_length * _length))) / 2;
	if (((_position distance _nearest) - _longest) < 5) then
	{
		_position = [-1,-1,-1];
	};
};

//Should the spawn be allowed on water
if (((_position select 0) != -1) && !_allowedWater && surfaceIsWater _position) then {_position = [-1,-1,-1]};

_position 