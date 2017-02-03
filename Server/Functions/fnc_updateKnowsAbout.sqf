_countWest = _this select 0;
_countEast = _this select 1;
_countGuer = _this select 2;

_knownArr = [];
if (_countWest > 0) then {_knownArr set [count _knownArr, west]};
if (_countEast > 0) then {_knownArr set [count _knownArr, east]};
if (_countGuer > 0) then {_knownArr set [count _knownArr, guer]};

_knownArr 