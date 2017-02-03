disableSerialization;
private["_display", "_sideMembers", "_currentSpec", "_specCount"];
_display = _this select 0;

GW_SPEC_CHOOSE = false;
GW_SPEC_CHANGESEL = false;

//Populate list of specializations
fnc_spec_populate = 
{
	lbClear 1500;
	_sideMembers = [GW_CVAR_SIDE, "obj"] Call fnc_shr_getSideMembers;
	{
		_currentSpec = _x;
		_specCount = 0;
		{
			if ((_currentSpec select 0) == (_x getVariable ["GW_SPECIALIZATION", ""])) then {_specCount = _specCount + 1};
		} forEach _sideMembers;
		
		lbAdd [1500, format["%1 - %2",_specCount, _currentSpec select 0]];
		lbSetPicture [1500, _forEachIndex, _currentSpec select 2];
	} forEach GW_SPECIALIZATIONS;
};
[] Spawn fnc_spec_populate;

//Main Updater
while {dialog} do
{
	//If player dies, close dialog
	if (!alive player) exitWith {closeDialog 60010};
	
	//Update how much it'll cost to specialize
	_chooseBtn = _display displayCtrl 1600;
	_chooseBtn ctrlSetText format ["Specialize ($%1)",round(GW_GVAR_SPECALIZATION_INITIAL + (GW_GVAR_SPECALIZATION_INITIAL * GW_CVAR_SPECIALIZE_AMOUNT))]; 
	
	//Disable purchase button
	if (lbCurSel 1500 == -1) then {_chooseBtn ctrlEnable false} else {_chooseBtn ctrlEnable true};
	
	//Update information
	if (GW_SPEC_CHANGESEL) then
	{
		GW_SPEC_CHANGESEL = false;
		_informationText = _display displayCtrl 1101;
		if (lbCurSel 1500 != -1) then
		{
			_specArray = GW_SPECIALIZATIONS select (lbCurSel 1500);
			_informationText ctrlSetStructuredText (parseText (_specArray select 1));
		};
	};
	
	//Choose a specializations
	if (GW_SPEC_CHOOSE) then
	{
		GW_SPEC_CHOOSE = false;
		_specArray = GW_SPECIALIZATIONS select (lbCurSel 1500);
		
		GW_SPECIAL_RETURN = ["GW_NETCALL_WAITING"];
		_specialNetCall = ["client","specializationChoose",[(GW_CVAR_SIDE),(getPlayerUID player),(_specArray select 0)],"GW_SPECIAL_RETURN"] Spawn fnc_clt_requestServerExec;
		waitUntil {scriptDone _specialNetCall};
		if (GW_SPECIAL_RETURN select 0) then
		{
			playSound "UISuccess";
			closeDialog 60010;
		}
		else
		{
			playSound "UIFail";
			systemChat format["Unable to choose specialization - %1",GW_SPECIAL_RETURN select 1];
		};
	};
	
	sleep 0.1;
};
