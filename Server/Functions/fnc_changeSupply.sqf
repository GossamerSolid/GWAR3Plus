/*
Script: fnc_changeSupply.sqf
Written by: GossamerSolid

Change a side's supply. Valid operations are "-", "+", "*", "/" or "=".
*/

private["_side", "_operation", "_value", "_availableSupply", "_teamList", "_maxSupply", "_supplyUpgraded", "_surplusSales", "_excessSupply", "_sideClients", "_cashToSend"];

_side = _this select 0;
_operation = _this select 1;
_value = _this select 2;

_availableSupply = _side Call fnc_srv_getSupply;
if (!isNil "_availableSupply") then
{
	if (_operation == "-") then {_availableSupply = _availableSupply - _value};
	if (_operation == "+") then {_availableSupply = _availableSupply + _value};
	if (_operation == "*") then {_availableSupply = _availableSupply * _value};
	if (_operation == "/") then {_availableSupply = _availableSupply / _value};
	if (_operation == "=") then {_availableSupply = _value};
	
	//Can't have negative supply
	if (_availableSupply < 0) then {_availableSupply = 0};
	
	//Can't have more than your team can hold
	_maxSupply = GW_GVAR_MAXSUPPLY;
	_supplyUpgraded = [_side, "Supply Storage"] Call fnc_shr_isResearched;
	if (_supplyUpgraded) then {_maxSupply = GW_GVAR_MAXSUPPLY_UPG};
	
	//Surplus sales
	_surplusSales = [_side, "Surplus Sales"] Call fnc_shr_isResearched;
	if (_surplusSales) then
	{
		_excessSupply = 0;
		if (_availableSupply > _maxSupply) then {_excessSupply = _availableSupply - _maxSupply};
		if (_excessSupply > 0) then
		{
			//Send money to each player on team
			_sideClients = [_side, "uid"] Call fnc_shr_getSideMembers;
			_cashToSend = round((_excessSupply * 3) / (count _sideClients));
			{
				[_x, "+", _cashToSend] Call fnc_srv_changeMoney;
			} forEach _sideClients;
		};
	};
	
	//Max sure available is not above max
	if (!GW_DEVMODE) then {_availableSupply = _availableSupply min _maxSupply};
	
	//Update var within updated supply
	Call Compile Format["GW_SUPPLY_%1 = %2",_side,_availableSupply];
	
	//Send updated value to proper team
	GW_CVAR_TEAMSUPPLY = (Call Compile Format["GW_SUPPLY_%1",_side]);
	_teamList = [_side, "netid"] Call fnc_shr_getSideMembers;
	{
		_x publicVariableClient "GW_CVAR_TEAMSUPPLY";
	} forEach _teamList;
};
