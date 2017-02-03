disableSerialization;
_display = _this select 0;

_txtServerFrameRates = (findDisplay 60009) displayCtrl 1102;
_txtServerUptime = (findDisplay 60009) displayCtrl 1101;

//Main Updater
while {dialog} do
{
	//If player dies, close dialog
	if (!alive player || isNull (findDisplay 60009)) exitWith {closeDialog 60009};
	
	_txtServerFrameRates ctrlSetStructuredText (parseText format["<t size='1' align='left' font='PuristaMedium' color='#FFFFFF'>Server Uptime: %1</t>",([GW_TIME_ELAPSED/60/60] call BIS_fnc_timeToString)]); 
	_txtServerUptime ctrlSetStructuredText (parseText format["<t size='1' align='left' font='PuristaMedium' color='#FFFFFF'>Min: %1FPS   Avg: %2FPS   Current: %3FPS</t>",GW_SERVERFPS_MIN, GW_SERVERFPS_AVG, GW_SERVERFPS_CURR]); 
	
	sleep 0.1;
};