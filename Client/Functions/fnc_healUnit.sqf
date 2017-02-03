private["_healTarget","_actionTime","_oldAnimation","_healAnim","_completed","_healItems","_truck","_near","_prevHealth","_checkConditions","_updateRate","_isMedic"];
_healTarget = _this;
_actionTime = 12;
_oldAnimation = animationState player;
_isMedic = if ((player getVariable ["GW_SPECIALIZATION", ""]) == "Medic") then {true} else {false};
_healAnim = "";
if ((stance player) == "PRONE") then 
{
	if (_healTarget == player) then
	{
		_healAnim = "ainvppnemstpslaywrfldnon_medic";
	}
	else
	{
		_healAnim = "ainvppnemstpslaywrfldnon_medicother";
	};
} 
else 
{
	if (_healTarget == player) then
	{
		_healAnim = "ainvpknlmstpslaywrfldnon_medic";
	}
	else
	{
		_healAnim = "ainvpknlmstpslaywrfldnon_medicother";
	};
};

if (_healTarget == player) then {GW_CVAR_ACTION = ["Healing Self", _actionTime, _actionTime]} else {GW_CVAR_ACTION = ["Healing Friendly", _actionTime, _actionTime]};
player switchMove _healAnim;

_completed = [true, ""];
_updateRate = 0.05;
_prevHealth = damage _healTarget;
_checkConditions = 1;
while {true} do
{
	//Action cancelled
	if ((count GW_CVAR_ACTION) <= 0) exitWith {_completed = [false, "heal cancelled"]};
	
	if (_checkConditions < _updateRate) then
	{
		//Fail Conditions
		if (!alive player) exitWith {_completed = [false, "player died"]};
		if (isNull _healTarget) exitWith {_completed = [false, "unexpected error"]};
		if ((player distance _healTarget) > 3) exitWith {_completed = [false, "unit too far away"]};
		if (!(alive _healTarget)) exitWith {_completed = [false, "unit died"]};
		if ((damage _healTarget) != _prevHealth) exitWith {_completed = [false, "unit under attack"]};
		
		//Are healing items OR a truck within range (Only required if not a medic)
		if (!_isMedic) then
		{
			_healItems = true;
			_truck = false;
			_playerItems = items player;
			if (!(("FirstAidKit" in _playerItems) || ("Medikit" in _playerItems))) then 
			{
				if ((player getVariable ["GW_SPECIALIZATION", ""]) != "Medic") then {_healItems = false};
			};
			_near = nearestObjects [(getPosATL player), ["Car","Tank","Ship"], 7];
			if ((count _near) > 0) then 
			{
				_nearest = _near select 0;
				if (((_nearest isKindOf GW_DATA_MEDICALTRUCK_WEST) || (_nearest isKindOf GW_DATA_MEDICALTRUCK_EAST)) && alive _nearest) then {_truck = true};
			};
			if (!_truck && !_healItems) exitWith {_completed = [false, "no heal sources available (first aid kit, medikit, etc)"]};
		};
		
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
	if (animationState player != _healAnim) then {player switchMove _healAnim};
	
	//Update
	GW_CVAR_ACTION set [1, (GW_CVAR_ACTION select 1) - _updateRate];
	uiSleep _updateRate;
};

GW_CVAR_ACTION = [];
player switchMove _oldAnimation;

if (_completed select 0) then
{
	//Medic specialization
	if (_isMedic) then
	{
		_healTarget setDamage 0;
	}
	else
	{
		_truck = false;
		_near = nearestObjects [(getPosATL player), ["Car","Tank","Ship"], 7];
		if ((count _near) > 0) then 
		{
			_nearest = _near select 0;
			if (((_nearest isKindOf GW_DATA_MEDICALTRUCK_WEST) || (_nearest isKindOf GW_DATA_MEDICALTRUCK_EAST)) && alive _nearest) then {_truck = true};
		};
		
		if (_truck) then
		{
			_healTarget setDamage 0;
		}
		else
		{
			_playerItems = items player;
			if (("FirstAidKit" in _playerItems) || ("Medikit" in _playerItems)) then 
			{
				if (("FirstAidKit" in _playerItems) && (!("Medikit" in _playerItems))) then {player removeItem "FirstAidKit"};
				_healTarget setDamage 0;
			}
			else
			{
				_healTarget setDamage 0.10;
			};
		};
	};
}
else
{
	systemChat format["Action not completed - %1",(_completed select 1)];
};