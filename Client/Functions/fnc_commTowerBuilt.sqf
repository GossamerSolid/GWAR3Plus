private ["_towerPos","_markerName","_towerRange","_towerMarker"];

_towerPos = _this select 0;
_markerName = _this select 1;
_towerRange = _this select 2;

_towerMarker = createMarkerLocal [_markerName, _towerPos];
_towerMarker setMarkerShapeLocal "Ellipse";
_towerMarker setMarkerSizeLocal [_towerRange, _towerRange];
_towerMarker setMarkerColorLocal GW_CVAR_TEAM_COLOUR_CLASS;
_towerMarker setMarkerBrushLocal "Border";
_towerMarker setMarkerAlphaLocal 1;