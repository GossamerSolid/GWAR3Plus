private["_sideForCount", "_countRet"];

_sideForCount = _this;
_countRet = count([_sideForCount, "varname"] Call fnc_shr_getSideMembers);
if (isNil "_countRet") then {_countRet = 0};

_countRet