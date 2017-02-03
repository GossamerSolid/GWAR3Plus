private["_structObj","_structDisplay","_structMarkerClass","_structIcon","_structMarker","_displayNote"];

_structObj = _this select 0;
_structDisplay = _this select 1;
_structMarkerClass = _this select 2;
_structIcon = _this select 3;
_displayNote = _this select 4;

//Create building marker
/*
_structMarker = createMarkerLocal [format["%1_Marker",_structObj], getPosATL _structObj];
_structMarker setMarkerColorLocal ([(GW_CVAR_SIDE), "class"] Call fnc_shr_getSideColour);
_structMarker setMarkerTypeLocal _structMarkerClass;
_structMarker setMarkerSizeLocal [0.75, 0.75];
*/

//Notification
if (_displayNote) then
{
	["notification",["GWAR3_StructureCreated",[_structDisplay, _structIcon, (mapGridPosition _structObj)]]] Spawn fnc_clt_messages;
};