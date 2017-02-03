private["_salvageTarget","_actionTime","_oldAnimation","_salvageAnim","_completed","_updateRate","_checkConditions"];
_salvageTarget = _this;
_actionTime = 20;
_oldAnimation = animationState player;
_salvageAnim = "AinvPknlMstpSlayWrflDnon_medic";

GW_CVAR_ACTION = ["Salvaging Vehicle", _actionTime, _actionTime];
player switchMove _salvageAnim;

_completed = [true, ""];
_updateRate = 0.05;
_checkConditions = 1;
while {true} do
{
	//Action cancelled
	if ((count GW_CVAR_ACTION) <= 0) exitWith {_completed = [false, "salvaging cancelled"]};
	
	if (_checkConditions < _updateRate) then
	{
		if (!alive player) exitWith {_completed = [false, "player died"]};
		if (isNull _salvageTarget) exitWith {_completed = [false, "unexpected error"]};
		if ((player distance _salvageTarget) > 10) exitWith {_completed = [false, "vehicle too far away"]};
		_playerItems = items player;
		if (!("ToolKit" in _playerItems)) exitWith {_completed = [false, "no toolkit available"]};
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
	if (animationState player != _salvageAnim) then {player switchMove _salvageAnim};
	
	//Update
	GW_CVAR_ACTION set [1, (GW_CVAR_ACTION select 1) - 0.05];
	uiSleep 0.05;
};

GW_CVAR_ACTION = [];
player switchMove _oldAnimation;

if (_completed select 0) then
{
	GW_SALVAGEACTION_RETURN = ["GW_NETCALL_WAITING"];
	_specialNetCall = ["client","salvage",[(GW_CVAR_SIDE),(getPlayerUID player),_salvageTarget],"GW_SALVAGEACTION_RETURN"] Spawn fnc_clt_requestServerExec;
	waitUntil {scriptDone _specialNetCall};
	if (GW_SALVAGEACTION_RETURN select 0) then
	{
		systemChat format["Salvaged %1",GW_SALVAGEACTION_RETURN select 1];
		playSound "UISuccess";
	}
	else
	{
		playSound "UIFail";
		systemChat format["Unable to Salvage Vehicle - %1",GW_SALVAGEACTION_RETURN select 1];
	};
}
else
{
	systemChat format["Action not completed - %1",(_completed select 1)];
};