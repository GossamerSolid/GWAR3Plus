private["_repairTarget","_actionTime","_oldAnimation","_repairAnim","_completed","_prevDamage","_checkConditions","_updateRate","_isEngineer"];
_repairTarget = _this;
_actionTime = 40;
_isEngineer = if ((player getVariable ["GW_SPECIALIZATION", ""]) == "Engineer") then {true} else {false};
_oldAnimation = animationState player;
_repairAnim = "AinvPknlMstpSlayWrflDnon_medic";

GW_CVAR_ACTION = ["Repairing Vehicle", _actionTime, _actionTime];
player switchMove _repairAnim;

_completed = [true, ""];
_updateRate = 0.05;
_prevDamage = damage _repairTarget;
_checkConditions = 1;
while {true} do
{
	//Action cancelled
	if ((count GW_CVAR_ACTION) <= 0) exitWith {_completed = [false, "repair cancelled"]};
	
	if (_checkConditions < _updateRate) then
	{
		//Fail Conditions
		if (!alive player) exitWith {_completed = [false, "player died"]};
		if (isNull _repairTarget) exitWith {_completed = [false, "unexpected error"]};
		if ((player distance _repairTarget) > 7) exitWith {_completed = [false, "vehicle too far away"]};
		if (!(alive _repairTarget)) exitWith {_completed = [false, "vehicle destroyed"]};
		if ((damage _repairTarget) != _prevDamage) exitWith {_completed = [false, "vehicle under attack"]};
		
		_playerItems = items player;
		if (!("ToolKit" in _playerItems) && (!_isEngineer)) exitWith {_completed = [false, "no toolkit available"]};
		
		
		_checkConditions = 1;
	}
	else
	{
		_checkConditions = _checkConditions - _updateRate;
	};
	
	//Failed?
	if (!(_completed select 0)) exitWith {};
	
	//Success Condition
	if (GW_CVAR_ACTION select 1 <= 0) exitWith {_completed = [true, ""]};

	//Keep Anim State
	if (animationState player != _repairAnim) then {player switchMove _repairAnim};
	
	//Update
	GW_CVAR_ACTION set [1, (GW_CVAR_ACTION select 1) - _updateRate];
	uiSleep _updateRate;
};

GW_CVAR_ACTION = [];
player switchMove _oldAnimation;

if (_completed select 0) then
{
	_repairTarget setDamage 0;
}
else
{
	systemChat format["Action not completed - %1",(_completed select 1)];
};