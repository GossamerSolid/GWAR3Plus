//Init_Zones.sqf
//Written by - GossamerSolid
//Handles the client-side initialization of all zones on the map

if (!(!isDedicated)) exitWith {diag_log text "###[GW ERROR] - Client\Init\Init_Zones.sqf must only be called client-side."};

{
	//Current zone container
	_currentZone = _x;
	
	//Get the owner
	_zoneOwner = _currentZone select 4;
	
	//Get the initial owner's colour class
	_sideColour = if (_zoneOwner == GW_CVAR_SIDE) then {([_zoneOwner, "class"] Call fnc_shr_getSideColour)} else {([guer, "class"] Call fnc_shr_getSideColour)};
	
	//Create marker over depot
	_zoneDepotMarker = createMarkerLocal [format["%1_Depot",(_currentZone select 0)], getPosATL (_currentZone select 0)];
	_zoneDepotMarker setMarkerTextLocal (_currentZone select 3);
	_zoneDepotMarker setMarkerColorLocal _sideColour;
	_zoneDepotMarker setMarkerTypeLocal "mil_flag";
	_zoneDepotMarker setMarkerSizeLocal [0.6, 0.6];
	
	//Border style marker to show the radius of the zone
	_zoneRadiusMarker = createMarkerLocal [format["%1_Radius",(_currentZone select 0)], (_currentZone select 1)];
	_zoneRadiusMarker setMarkerShapeLocal "Ellipse";
	_zoneRadiusMarker setMarkerSizeLocal [(_currentZone select 2), (_currentZone select 2)];
	_zoneRadiusMarker setMarkerColorLocal "ColorBlack";
	_zoneRadiusMarker setMarkerBrushLocal "Border";
	_zoneRadiusMarker setMarkerAlphaLocal 1;
	
	//Border style marker to show the radius of the zone
	_zoneAttackMarker = createMarkerLocal [format["%1_RadiusAttack",(_currentZone select 0)], (_currentZone select 1)];
	_zoneAttackMarker setMarkerShapeLocal "Ellipse";
	_zoneAttackMarker setMarkerSizeLocal [(_currentZone select 2), (_currentZone select 2)];
	_zoneAttackMarker setMarkerBrushLocal "FDiagonal";
	_zoneAttackMarker setMarkerColorLocal "ColorOrange";
	_zoneAttackMarker setMarkerAlphaLocal 0;

	//Setup camps
	{	
		_campOwner = _x select 3;
		_sideCampColour = if (_campOwner == GW_CVAR_SIDE) then {([_campOwner, "class"] Call fnc_shr_getSideColour)} else {([guer, "class"] Call fnc_shr_getSideColour)};
		_zoneCampMarker = createMarkerLocal [format["%1_Camp",(_x select 0)], getPosATL (_x select 0)];
		_zoneCampMarker setMarkerTextLocal ([_forEachIndex, "short"] Call fnc_shr_getCampName);
		_zoneCampMarker setMarkerColorLocal _sideCampColour;
		_zoneCampMarker setMarkerTypeLocal "loc_Bunker";
		_zoneCampMarker setMarkerSizeLocal [0.9, 0.9];
	} forEach (_x select 6);
} forEach GW_ZONES_STUB;

