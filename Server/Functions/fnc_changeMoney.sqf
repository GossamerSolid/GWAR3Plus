/*
Script: fnc_changeMoney.sqf
Written by: GossamerSolid

Change the money for a player's session container. Valid operations are "-", "+", "*", "/" or "=".
*/

private["_playerUID", "_operation", "_value", "_sessionContainer"];

_playerUID = _this select 0;
_operation = _this select 1;
_value = _this select 2;

//Make sure money is defined
if (!isNil "_value") then
{
	_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
	if (!isNil "_sessionContainer") then
	{
		_currMoney = _sessionContainer select 0;
		if (_operation == "-") then {_currMoney = _currMoney - _value};
		if (_operation == "+") then {_currMoney = _currMoney + _value};
		if (_operation == "*") then {_currMoney = _currMoney * _value};
		if (_operation == "/") then {_currMoney = _currMoney / _value};
		if (_operation == "=") then {_currMoney = _value};
		_currMoney = floor(_currMoney);
		
		//Can't have negative money
		if (_currMoney < 0) then {_currMoney = 0};
		
		//Update var within container
		_sessionContainer set [0, _currMoney];
		
		//Update container
		missionNamespace setVariable [format["GW_SESSION_%1",_playerUID], _sessionContainer];
		
		//Update client money global
		GW_CVAR_MONEY = _currMoney;
		_clientID = owner(_playerUID Call fnc_shr_getObjFromUID);
		_clientID publicVariableClient "GW_CVAR_MONEY";
	}
	else
	{
		//TO-DO error no container available
	};
};

