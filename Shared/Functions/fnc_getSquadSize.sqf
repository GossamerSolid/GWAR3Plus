private["_obj","_squadSize"];

_obj = _this;
_squadSize = 0;

//Always subtract one to not count the player
if (!isNull _obj) then {_squadSize = (count(units(group _obj))) - 1};

_squadSize 