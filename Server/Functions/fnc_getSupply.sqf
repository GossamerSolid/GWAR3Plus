private["_side", "_supply"];

_side = _this;
_supply = (Call Compile Format["GW_SUPPLY_%1",_side]);

_supply 