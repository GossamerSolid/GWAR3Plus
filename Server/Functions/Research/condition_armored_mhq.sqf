//condition_armored_mhq.sqf
//Written by: GossamerSolid
//Upgrade the existing MHQ to an armored IFV

private["_playerSide","_returnData","_mhqObj"];

_playerSide = _this;
_returnData = [false, "MHQ cannot be destroyed"];

//Check if the MHQ is alive
_mhqObj = if (_playerSide == west) then {GW_MHQ_WEST} else {GW_MHQ_EAST};
if (alive _mhqObj) then {_returnData = [true, ""]};

_returnData 