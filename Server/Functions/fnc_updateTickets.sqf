//fnc_updateTickets.sqf
//Written by: GossamerSolid
//Update the ticket bleed

private["_timeTillUpdate","_startTime","_numberOfZones","_halfwayPoint","_ticketBleedWest","_ticketBleedEast","_westOverEast","_eastOverWest","_actualWest","_actualEast"];

_timeTillUpdate = GW_PARAM_VC_TICKETS_FREQUENCY;
_startTime = time;
_numberOfZones = count(GW_ZONES);
_halfwayPoint = round(_numberOfZones / 2);

_lastTicketsWest = 0;
_lastTicketsEast = 0;
_lastTicketBleedWest = 0;
_lastTicketBleedEast = 0;

while {GW_GAMERUNNING} do
{
	_ticketBleedWest = 0;
	_ticketBleedEast = 0;

	_actualWest = 0;
	_actualEast = 0;
	
	//Wait until minimum time elapsed and don't calculate if sudden death
	if (!GW_SERVER_SUDDENDEATH && (GW_TIME_ELAPSED >= GW_PARAM_VC_TICKETS_MINTIME)) then
	{
		//Go through the zones to figure out the proper counts
		{
			if (((_x select 7) == west) && !(_x select 16)) then {_actualWest = _actualWest + 1};
			if (((_x select 7) == east) && !(_x select 16)) then {_actualEast = _actualEast + 1};
		} forEach GW_ZONES;

		_westOverEast = _actualWest - _actualEast;
		if (_westOverEast > 0) then
		{
			_ticketBleedEast = 0;
			if (GW_PARAM_VC_TICKETS_CALC == 0) then {_ticketBleedEast = round(_actualWest + ((_actualWest - _actualEast) * 2))};
			if (GW_PARAM_VC_TICKETS_CALC == 1) then {_ticketBleedEast = (_actualWest - _actualEast) * 3};
			if (GW_PARAM_VC_TICKETS_CALC == 2) then {_ticketBleedEast = round(((_actualWest - _actualEast) * 2) + (_actualWest * 1.5))};
			if (_lastTicketBleedEast != _ticketBleedEast) then
			{
				_lastTicketBleedEast = _ticketBleedEast;
				if (_ticketBleedEast > 0) then
				{
					_bleedClientList = [east, "netid"] Call fnc_shr_getSideMembers;
					[_bleedClientList, "messages", "", ["blueChat",["GWAR3_TicketBleed",[_ticketBleedEast]]]] Spawn fnc_srv_requestClientExec;
				};
			};
		};

		_eastOverWest = _actualEast - _actualWest;
		if (_eastOverWest > 0) then
		{
			_ticketBleedWest = 0;
			if (GW_PARAM_VC_TICKETS_CALC == 0) then {_ticketBleedWest = round(_actualEast + ((_actualEast - _actualWest) * 2))};
			if (GW_PARAM_VC_TICKETS_CALC == 1) then {_ticketBleedWest = (_actualEast - _actualWest) * 3};
			if (GW_PARAM_VC_TICKETS_CALC == 2) then {_ticketBleedWest = round(((_actualEast - _actualWest) * 2) + (_actualEast * 1.5))};
			if (_lastTicketBleedWest != _ticketBleedWest) then
			{
				_lastTicketBleedWest = _ticketBleedWest;
				if (_ticketBleedWest > 0) then
				{
					_bleedClientList = [west, "netid"] Call fnc_shr_getSideMembers;
					[_bleedClientList, "messages", "", ["blueChat",["GWAR3_TicketBleed",[_ticketBleedWest]]]] Spawn fnc_srv_requestClientExec;
				};
			};
		};
		
		//Update Clients on bleed
		GW_TICKETS_WEST_BLEED = _ticketBleedWest;
		GW_TICKETS_EAST_BLEED = _ticketBleedEast;
		publicVariable "GW_TICKETS_WEST_BLEED";
		publicVariable "GW_TICKETS_EAST_BLEED"; 
		
		//Apply Bleed
		if ((time - _startTime) > _timeTillUpdate) then
		{
			//Update tickets
			if (GW_TICKETS_WEST_BLEED > 0) then 
			{
				[west, "-", GW_TICKETS_WEST_BLEED, true] Call fnc_srv_changeTickets;
			};
			
			if (GW_TICKETS_EAST_BLEED > 0) then
			{
				[east, "-", GW_TICKETS_EAST_BLEED, true] Call fnc_srv_changeTickets;
			};

			_timeTillUpdate = time + GW_PARAM_VC_TICKETS_FREQUENCY;
		};
	};
	
	sleep 1;
};