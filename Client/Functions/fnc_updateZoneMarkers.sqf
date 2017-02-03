/*
fnc_updateZoneMarkers.sqf
Written by: GossamerSolid
Updates the ownership knowledge of zones and their camps from the knows about array generated on the server side
*/

private["_intelligenceAgency", "_currentZoneArr", "_knowsAboutArr", "_knowsAboutIndex", "_knowsAboutSideArr", "_zoneAttackMarker", "_zoneDepotMarker", "_campMarker", "_campKnowsAboutArr", "_campArray"];

while {GW_GAMERUNNING} do
{
	//Is intelligence agency researched
	_intelligenceAgency = [GW_CVAR_SIDE, "Intelligence Agency"] Call fnc_shr_isResearched;
	
	//Iterate through zone stubs
	{
		_currentZoneArr =+ _x;
		_knowsAboutArr = _currentZoneArr select 8;
		
		_zoneAttackMarker = format["%1_RadiusAttack",(_currentZoneArr select 0)];
		_zoneDepotMarker = format["%1_Depot",(_currentZoneArr select 0)];
		
		//Reset border
		_zoneAttackMarker setMarkerAlphaLocal 0;
		
		//Reset depot
		_zoneDepotMarker setMarkerTextLocal (_currentZoneArr select 3);
		
		//Reset camps
		{
			_campMarker = format["%1_Camp",(_x select 0)];
			_campMarker setMarkerTextLocal (_x select 6);
		} forEach (_currentZoneArr select 6);
		
		_knowsAboutIndex = [GW_CVAR_SIDE, 0, _knowsAboutArr] Call fnc_shr_arrayGetIndex;
		if (_knowsAboutIndex != -1) then
		{
			_knowsAboutSideArr =+ (_knowsAboutArr select _knowsAboutIndex);
			if (_intelligenceAgency || (_knowsAboutSideArr select 2)) then
			{
				//Set depot marker to match ownership
				_zoneDepotMarker setMarkerColorLocal ([(_currentZoneArr select 4), "class"] Call fnc_shr_getSideColour);
				
				//Set the camp makers to match ownership
				{
					_campMarker = format["%1_Camp",(_x select 0)];
					_campMarker setMarkerColorLocal ([(_x select 3), "class"] Call fnc_shr_getSideColour);
				} forEach (_currentZoneArr select 6);
				
				//Hostiles in zone
				if (_currentZoneArr select 11) then
				{
					//Hostiles at depot
					if (_currentZoneArr select 12) then
					{
						_zoneAttackMarker setMarkerAlphaLocal 0.7;
					};
					
					//Display strength when under attack
					_zoneDepotMarker setMarkerTextLocal format["%1 - %2/%3",(_currentZoneArr select 3),(_currentZoneArr select 9),(_currentZoneArr select 10)];
				};
			}
			else
			{
				//Set depot marker to match who the team thinks owns it
				_zoneDepotMarker setMarkerColorLocal ([(_knowsAboutSideArr select 1), "class"] Call fnc_shr_getSideColour);
				
				//Set camp markers to match who the team thinks owns it
				{
					_campArray =+ _x;
					_campKnowsAboutArr =+ _x select 5;
					
					_knowsAboutIndex = [GW_CVAR_SIDE, 0, _campKnowsAboutArr] Call fnc_shr_arrayGetIndex;
					if (_knowsAboutIndex != -1) then
					{
						_campMarker = format["%1_Camp",(_campArray select 0)];
						_campMarker setMarkerColorLocal ([(_campKnowsAboutArr select _knowsAboutIndex) select 1, "class"] Call fnc_shr_getSideColour);
					};
				} forEach (_currentZoneArr select 6);
			};
		};
		
	} forEach GW_ZONES_STUB;
	
	//Wait 1.5 seconds
	uiSleep 1.5;
};