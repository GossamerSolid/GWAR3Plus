disableSerialization;
_display = _this select 0;

_researchBtn = _display displayCtrl 2403;
_researchBtn ctrlEnable false;
GW_RESEARCH_SELECTED = false;
GW_RESEARCH_CURRTECH_CHANGED = false;
GW_RESEARCH_BUYNETCALLRETURN = [];

//Get list of squad members
fnc_research_researchList =
{
	disableSerialization;
	_display = _this select 0;
	
	_listBoxCtrl = _display displayCtrl 1500;
	lbClear _listBoxCtrl;
	
	_teamResearchArray = Call Compile Format["GW_RESEARCH_%1",GW_CVAR_SIDE];
	{
		_listBoxCtrl lbAdd format["S%1 - %2",(_x select 1),(_x select 0)];
		if (_teamResearchArray select _forEachIndex) then {_listBoxCtrl lbSetColor [_forEachIndex, [0.1490,0.5647,0.1412,1]]} else {_listBoxCtrl lbSetColor [_forEachIndex, [0.6235,0.1725,0.1725,1]]};
	} forEach GW_RESEARCH;
};

fnc_research_populateDescription =
{
	disableSerialization;
	private["_descriptionText"];
	_display = _this select 0;
	
	_listBoxCtrl = _display displayCtrl 1500;
	
	_descriptionText = "";
	if ((count ((GW_RESEARCH select (lbCurSel _listBoxCtrl)) select 2)) > 0) then
	{
		{
			if (_descriptionText == "") then {_descriptionText = format["Prerequisite(s): %1", _x]} else {_descriptionText = _descriptionText + format[", %1", _x]};
		} forEach ((GW_RESEARCH select (lbCurSel _listBoxCtrl)) select 2);
	};
	if (_descriptionText != "") then {_descriptionText = _descriptionText + format["<br /><br />"]};
	_descriptionText = _descriptionText + format["%1",((GW_RESEARCH select (lbCurSel _listBoxCtrl)) select 3)];
	
	_descriptionCtrl = _display displayCtrl 1103;
	_descriptionCtrl ctrlSetStructuredText (parseText format["%1",_descriptionText]);
};

//Initial populate
[_display] Spawn fnc_research_researchList;

//Main Updater
while {dialog} do
{
	//If player dies, close dialog
	if (!alive player) exitWith {closeDialog 60012};
	
	//Update button
	_listBoxCtrl = _display displayCtrl 1500;
	_isCommander = player Call fnc_clt_isCommander;
	if (((lbCurSel _listBoxCtrl) != -1) && _isCommander) then 
	{
		_teamResearchArray = Call Compile Format["GW_RESEARCH_%1",GW_CVAR_SIDE];
		if (!(_teamResearchArray select (lbCurSel _listBoxCtrl))) then
		{
			_researchArray = GW_RESEARCH select (lbCurSel _listBoxCtrl);
			if ((_researchArray select 1) <= GW_CVAR_TEAMSUPPLY) then
			{
				_hasResearch = true;
				{
					if (!([GW_CVAR_SIDE, _x] Call fnc_shr_isResearched)) exitWith {_hasResearch = false};
				} forEach (_researchArray select 2);
				
				if (_hasResearch) then
				{
					_researchBtn ctrlEnable true;
				}
				else
				{
					_researchBtn ctrlEnable false;
				};
			}
			else
			{
				_researchBtn ctrlEnable false;
			};
		}
		else
		{
			_researchBtn ctrlEnable false;
		};
	}
	else
	{
		_researchBtn ctrlEnable false;
	};
	
	//Selected a tech
	if (GW_RESEARCH_SELECTED) then
	{
		GW_RESEARCH_SELECTED = false;
		_listBoxCtrl = _display displayCtrl 1500;
		
		GW_RESEARCH_BUYNETCALLRETURN = ["GW_NETCALL_WAITING"];
		_buyNetCall = ["research","buy",[player, GW_CVAR_SIDE, ((GW_RESEARCH select (lbCurSel _listBoxCtrl)) select 0)], "GW_RESEARCH_BUYNETCALLRETURN"] Spawn fnc_clt_requestServerExec;
		waitUntil {scriptDone _buyNetCall};
		
		if (!(GW_RESEARCH_BUYNETCALLRETURN select 0)) then
		{
			playSound "UIFail";
			systemChat format ["Unable to research technology - %1",(GW_RESEARCH_BUYNETCALLRETURN select 1)];
		}
		else
		{
			[_display] Spawn fnc_research_researchList;
			playSound "UISuccess";
		};
	};
	
	//Picked a different one in the list
	if (GW_RESEARCH_CURRTECH_CHANGED) then
	{
		GW_RESEARCH_CURRTECH_CHANGED = false;
		[_display] Spawn fnc_research_populateDescription;
	};
	
	sleep 0.1;
};