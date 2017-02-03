private["_objPlayer","_objKiller"];
_objPlayer = _this select 0;
_objKiller = _this select 1;

//Disconnect from any UAVs
_objPlayer connectTerminalToUAV objNull;

//Remove actions from body
removeAllActions _objPlayer;

//Reset the action var
GW_CVAR_ACTION = [];

//Close any dialogs
[] Call fnc_clt_closeAllDialogs;

//Wait Till Player is Alive
waitUntil {alive player};

//Workaround because camSetTarget no longer allows positions apparently
_camTarget = "Land_HelipadEmpty_F" createVehicleLocal (getPos _objPlayer);
_camTarget setPos (getPos _objPlayer);

//Move to respawn area
_markerPos = getMarkerPos format["respawn_%1",GW_CVAR_SIDE];
player setPosATL [(_markerPos select 0), (_markerPos select 1), 0];

//Show death screen
GW_CVAR_CLIENTCAMERA = "camera" camCreate [GW_CVAR_DEATH_POS select 0, GW_CVAR_DEATH_POS select 1, 0];
GW_CVAR_CLIENTCAMERA setDir 180; 
GW_CVAR_CLIENTCAMERA camSetTarget _camTarget;
GW_CVAR_CLIENTCAMERA cameraEffect["Internal","Back"];
GW_CVAR_CLIENTCAMERA camSetPos [GW_CVAR_DEATH_POS Select 0, GW_CVAR_DEATH_POS Select 1, 40];
GW_CVAR_CLIENTCAMERA camCommit 5;
showCinemaBorder false;

CutRsc ["GW_DeployScreen", "PLAIN", 0, false];
((["gwar3deploy"] call fnc_clt_getGUI) displayCtrl 1100) ctrlSetStructuredText (parseText format["<t size='1' shadow='2' align='center' font='PuristaMedium' color='#FFFFFF'>Deployment Available in 15 Seconds</t>"]);

//Invincible until spawned back in
player allowDamage false;

//Remove any gear
removeAllWeapons player;

//Refresh side var
player setVariable ["GW_SIDE", GW_CVAR_SIDE, true];

//Respawn Timer
_timer = 15;
while {_timer > 0} do
{
	if (!GW_GAMERUNNING) exitwith {};
	((["gwar3deploy"] call fnc_clt_getGUI) displayCtrl 1100) ctrlSetStructuredText (parseText format["<t size='1' shadow='2' align='center' font='PuristaMedium' color='#FFFFFF'>Deployment Available in %1 %2</t>",_timer,(if (_timer > 1) then {"Seconds"} else {"Second"})]);
	uiSleep 1;
	_timer = _timer - 1;
};
((["gwar3deploy"] call fnc_clt_getGUI) displayCtrl 1100) ctrlShow false;

if (GW_GAMERUNNING) then
{
	//Close any GWAR3 dialogs
	[] Call fnc_clt_closeAllDialogs;
	
	//Close A3 menu
	if (!isNull (findDisplay 49)) then {(findDisplay 49) closeDisplay 0};
	
	createDialog "UI_Deployment";

	waitUntil {!dialog};
};

//Clean up camera target
deleteVehicle _camTarget;