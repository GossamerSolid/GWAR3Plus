private["_actionArgs","_actionName","_returnData"];
_actionArgs = _this;
_actionName = _actionArgs select 3;
_returnData = [false, ""];

switch (_actionName) do
{
	case "HealSoldierSelf":
	{
		_returnData = [true, "Use GWAR3 Healing Actions"];
	};
	
	case "HealSoldier":
	{
		_returnData = [true, "Use GWAR3 Healing Actions"];
	};
};

if (_returnData select 0) then
{
	playSound "UIFail";
	systemChat format["Action not completed - %1", _returnData select 1];
};

_returnData select 0 