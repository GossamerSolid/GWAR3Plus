private["_displayName","_marker","_sideCapturing","_campMarkerArray"];

_displayName = _this select 0;
_marker = _this select 1;
_sideCapturing = _this select 2;
_campMarkerArray = _this select 3;
_changedOwnership = _this select 4;

/*
//Update zone marker colour
_marker setMarkerColorLocal ([_sideCapturing, "class"] Call fnc_shr_getSideColour);

//Update camp markers' colour
{
	_x setMarkerColorLocal ([_sideCapturing, "class"] Call fnc_shr_getSideColour);
} forEach _campMarkerArray;
*/

//Notification
if (_changedOwnership) then
{
	if ((GW_CVAR_SIDE) == _sideCapturing) then
	{
		["notification",["GWAR3_ZoneCaptured",[_displayName]]] Spawn fnc_clt_messages;
	}
	else
	{
		["notification",["GWAR3_ZoneLost",[_displayName]]] Spawn fnc_clt_messages;
	};
};

