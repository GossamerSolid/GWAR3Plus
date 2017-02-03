/*
Script: fnc_changeTickets.sqf
Written by: GossamerSolid

Change a side's tickets. Valid operations are "-", "+", "*", "/" or "=".
*/

private["_side", "_operation", "_value", "_availableTickets", "_teamList", "_fromBleed"];

_side = _this select 0;
_operation = _this select 1;
_value = _this select 2;
_fromBleed = _this select 3;

_availableTickets = Call Compile Format["GW_TICKETS_%1", _side];
if (!isNil "_availableTickets") then
{
	//Previous tickets
	_lastTickets = _availableTickets;
	
	//Perform operation
	if (_operation == "-") then {_availableTickets = _availableTickets - _value};
	if (_operation == "+") then {_availableTickets = _availableTickets + _value};
	if (_operation == "*") then {_availableTickets = _availableTickets * _value};
	if (_operation == "/") then {_availableTickets = _availableTickets / _value};
	if (_operation == "=") then {_availableTickets = _value};
	
	//Can't have negative supply
	if (_availableTickets < 0) then {_availableTickets = 0};
	
	//Update var within updated tickets
	if (_side == west) then 
	{
		GW_TICKETS_WEST = if (_fromBleed) then {_availableTickets max 0} else {_availableTickets};
	} 
	else 
	{
		GW_TICKETS_EAST = if (_fromBleed) then {_availableTickets max 0} else {_availableTickets};
	};
	
	//Broadcast value
	if (_side == west) then {publicVariable "GW_TICKETS_WEST"} else {publicVariable "GW_TICKETS_EAST"};
	
	//Warning about ticket counts
	_ticketWarningAmount = 0;
	if (_lastTickets > 400 && _availableTickets <= 400) then {_ticketWarningAmount = 400};
	if (_lastTickets > 300 && _availableTickets <= 300) then {_ticketWarningAmount = 300};
	if (_lastTickets > 200 && _availableTickets <= 200) then {_ticketWarningAmount = 200};
	if (_lastTickets > 100 && _availableTickets <= 100) then {_ticketWarningAmount = 100};
	if (_lastTickets > 50 && _availableTickets <= 50) then {_ticketWarningAmount = 50};
	if (_lastTickets > 25 && _availableTickets <= 25) then {_ticketWarningAmount = 25};
	if (_lastTickets > 10 && _availableTickets <= 10) then {_ticketWarningAmount = 10};
	if (_ticketWarningAmount != 0) then
	{
		_warnClientList = [_side, "netid"] Call fnc_shr_getSideMembers;
		[_warnClientList, "messages", "", ["notification",["GWAR3_TicketWarning",[_ticketWarningAmount]]]] Spawn fnc_srv_requestClientExec;
	};
};
