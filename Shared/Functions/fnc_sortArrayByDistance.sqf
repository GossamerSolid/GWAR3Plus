Private["_count","_count1","_current","_nearest","_nearestDistance","_referencePoint","_arrayToSort","_sortedArray","_total"];

_referencePos = _this select 0;
_arrayToSort = _this select 1;
_arrayIndex = -1;
if (count(_this) == 3) then {_arrayIndex = _this select 2};

_sortedArray = [];

_total = Count _arrayToSort;

for [{_count = 0},{_count < _total},{_count = _count + 1}] do
{
	_nearest = [];
	_nearestDistance = 9999999;

	for [{_count1 = Count _arrayToSort - 1},{_count1 >= 0},{_count1 = _count1 - 1}] do
	{
		_current = _arrayToSort Select _count1;
		_distance = if (_arrayIndex == -1) then {_current Distance _referencePos} else {(_current select _arrayIndex) Distance _referencePos};

		if (_distance < _nearestDistance) then {_nearest = _current;_nearestDistance = _distance};
	};

	_sortedArray pushBack _nearest;
	_nearestIndex = if (_arrayIndex == -1) then {[_nearest, 0, _arrayToSort] Call fnc_shr_arrayGetIndex} else {[(_nearest select _arrayIndex), 0, _arrayToSort] Call fnc_shr_arrayGetIndex};
	if (_nearestIndex != -1) then {_arrayToSort deleteAt _nearestIndex};
};

_sortedArray 