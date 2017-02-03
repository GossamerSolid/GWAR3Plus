disableSerialization;
_display = _this select 0;

//Voting initialization
GW_COMMVOTE_RETURN = ["GW_NETCALL_WAITING"];
_commVoteInitNetCall = ["commvoting","init",(GW_CVAR_SIDE),"GW_COMMVOTE_RETURN"] Spawn fnc_clt_requestServerExec;
waitUntil {scriptDone _commVoteInitNetCall};
if (!(GW_COMMVOTE_RETURN select 0)) exitWith {closeDialog 60004; systemChat (GW_COMMVOTE_RETURN select 1)};

GW_COMMVOTE_SELECTED = false;
ctrlEnable [2400, false];
if (isNil "GW_CVAR_COMMVOTE_TIME") then {GW_CVAR_COMMVOTE_TIME = 60};

//Get list of votes
GW_COMMVOTE_LIST = ["GW_NETCALL_WAITING"];
_voteListNetCall = ["GW_COMMVOTE_LIST","team","commvotes",(GW_CVAR_SIDE), true] Spawn fnc_clt_requestServerData;
waitUntil {scriptDone _voteListNetCall};

//How much should the vote list update
_voteListUpdate = 1; //1 second

//Main Updater
while {dialog} do
{
	//If player dies or comm vote time is up, close dialog
	if (!alive player || (GW_CVAR_COMMVOTE_TIME <= 0)) exitWith {closeDialog 60004};
	
	//Set text of who current commander is as well as the time left
	_TeamCommanderText = "No Commander";
	if (GW_CVAR_COMMANDER != "nil") then
	{
		_CommanderObj = missionNamespace getVariable GW_CVAR_COMMANDER;
		_TeamCommanderText = if (!isNull _CommanderObj) then {name _CommanderObj} else {"No Commander"};
	};
	_commanderTextCTRL = _display displayCtrl 1102;
	_commanderTextCTRL ctrlSetStructuredText (parseText format ["<t align='left'><img image='a3\ui_f\data\gui\cfg\Ranks\general_gs.paa'/> %1</t><t align='right'>%2</t>",_TeamCommanderText,([GW_CVAR_COMMVOTE_TIME/60/60] call BIS_fnc_timeToString)]);
	
	//Update vote list?
	if (_voteListUpdate <= 0) then
	{
		_voteListNetCall = ["GW_COMMVOTE_LIST","team","commvotes",(GW_CVAR_SIDE)] Spawn fnc_clt_requestServerData;
		_voteListUpdate = 1;
	} else {_voteListUpdate = _voteListUpdate - 0.1};
	
	//Populate list of candidates and their standing vote count
	lbClear 1500;
	lbClear 1501;
	
	//Populate votes overview screen
	_sideMembers = [(GW_CVAR_SIDE), "varname"] Call fnc_shr_getSideMembers;
	{
		_currentVarName = _x;
		_playerName = name(missionNamespace getVariable _x);
		_voteCount = 0;
		{
			_voteVarName = _x select 1;
			if (_voteVarName == _currentVarName) then {_voteCount = _voteCount + 1};
		} forEach GW_COMMVOTE_LIST;
		
		lbAdd [1500, format["%1 - %2",_playerName,_voteCount]];
		lbSetData [1500, _forEachIndex, _x];
	} forEach _sideMembers;
	
	_playerSelected = lbCurSel 1500;
	_amount = lbSize 1500;
	
	//Populate standing vote counts
	if ((_playerSelected != -1) && (_amount > 0)) then
	{
		ctrlEnable [2400, true];
		_varNameSel = lbData [1500, _playerSelected];
		{
			if (_varNameSel == (_x select 0)) then
			{
				lbAdd [1501, name(missionNamespace getVariable (_x select 0))];
			};
		} forEach GW_COMMVOTE_LIST;
	}
	else
	{
		ctrlEnable [2400, false];
	};

	//Player voted
	if (GW_COMMVOTE_SELECTED) then
	{
		GW_COMMVOTE_SELECTED = false;
		["commvoting","vote",[(GW_CVAR_SIDE),(vehicleVarName player),(lbData [1500, lbCurSel 1500])]] Spawn fnc_clt_requestServerExec;
	};
	
	sleep 0.1;
};
