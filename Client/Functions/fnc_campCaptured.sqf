private["_displayName","_marker","_sideCapturing"];

_displayName = _this select 0;
_marker = _this select 1;
_sideCapturing = _this select 2;
_actualCapture = if (count(_this) > 3) then {_this select 3} else {true};

//Update marker colour
//_marker setMarkerColorLocal ([_sideCapturing, "class"] Call fnc_shr_getSideColour);

//Notification
if (_actualCapture) then
{
	if ((GW_CVAR_SIDE) == _sideCapturing) then
	{
		["notification",["GWAR3_CampCaptured",[_displayName]]] Spawn fnc_clt_messages;
	}
	else
	{
		["notification",["GWAR3_CampLost",[_displayName]]] Spawn fnc_clt_messages;
	};
};