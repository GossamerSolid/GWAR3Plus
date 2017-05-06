disableSerialization;
CutRsc["GW_ClientHUD", "PLAIN", 0, false];

//Handle map icons
[] Spawn fnc_clt_initMapMarkers;

//Update zone markers
[] Spawn fnc_clt_updateZoneMarkers;

//Handle 3D markers
addMissionEventHandler ["Draw3D",{[] Call fnc_clt_draw3DMarkers;}];

//Hide Dev Branch Watermark
waitUntil {!isNull findDisplay 46};
{
	((findDisplay 46) displayCtrl _x) ctrlShow false;
} forEach [1202, 11400];

//Need to use stacked EH for Each Frame for compatibility with BIS and 3rd party
//["clientHUDUpdate", "onEachFrame", 
//{
while {true} do
{
	if (isNull GW_CVAR_CLIENTCAMERA) then
	{
		//Hud
		if (isNull (["gwar3hud"] call fnc_clt_getGUI)) then 
		{
			CutRsc ["GW_ClientHUD", "PLAIN", 0, false];
		};	
		if (!isNull (["gwar3hud"] call fnc_clt_getGUI)) then 
		{
			if (!visibleMap) then
			{
				/**********************************/
				/**** DEFINE ALL CONTROLS HERE ****/
				/**********************************/
				private _moneyCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1108;
				private _suppliesCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1107;
				
				private _BGGPSCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1118;
				private _FrameGPSCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1806;
				private _GPSCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1200;
				private _GPSInfoCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1123; 
				
				private _structuresInRangeCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1117; 
				
				private _healthBGCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1120; 
				private _healthFrameCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1807; 
				private _healthBarCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1122; 
				private _healthIconCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1201; 

				private _rankBGCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1114; 
				private _rankFrameCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1808; 
				private _rankBarCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1121; 
				private _rankIconCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1203; 

				private _redBGCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1129;
				private _redMarkerCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1106;
				private _redTicketsCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1111;
				private _redPlayersCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1115;
				private _blueBGCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1110;
				private _blueMarkerCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1106;
				private _blueTicketsCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1112;
				private _bluePlayersCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1116;

				private _commanderCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1109;
				private _squadSizeCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1127;
				private _specializationCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1128;
				
				private _progressActionCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1124;
				private _textActionCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1125;
				
				private _BgZoneCapCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1100;
				private _FrameZoneCapCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1800;
				private _BarZoneCapCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1101;
				private _TextZoneCapCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1102;
				
				private _BGCampCapCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1104;
				private _FrameCampCapCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1801;
				private _CapCampCapCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1103;
				private _TextCampCapCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1105;
				
				private _vehCrewCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1131;
				
				private _constructionHelperCtrl = (["gwar3hud"] call fnc_clt_getGUI) displayCtrl 1126;
				
				/******************************************************************************************************************/
				
				//Money and Supplies
				_moneyCtrl ctrlSetStructuredText (parseText format["<t align='right' font='PuristaMedium' color='#ffd700'>%1 (%2+)  <img image='Resources\images\money.paa'/>",GW_CVAR_MONEY, GW_CVAR_MONEY_INCOME]);
				_moneyCtrl ctrlShow true;
				
				_suppliesCtrl ctrlSetStructuredText (parseText format["<t align='right' font='PuristaMedium' color='#00de34'>%1 (%2+)  <img image='Resources\images\supplies.paa'/>",GW_CVAR_TEAMSUPPLY, GW_CVAR_TEAMSUPPLY_INCOME]);
				_suppliesCtrl ctrlShow true;
				
				/******************************************************************************************************************/
				
				//Update GPS
				if (GW_CVAR_MINIMAP_SHOW) then
				{
					GW_CVAR_WATCHPOS = getPosASL player;
					if (!isNull (getConnectedUAV player)) then
					{
						private _connectedUAV = getConnectedUAV player;
						private _uavControlArray = UAVControl _connectedUAV;
						if ((_uavControlArray select 0) == player) then
						{
							if ((_uavControlArray select 1) != "") then
							{
								GW_CVAR_WATCHPOS = getPosATL _connectedUAV;
							};
						};
					};
					
					_GPSCtrl CtrlMapAnimAdd [0, GW_CVAR_MINIMAP_ZOOM, GW_CVAR_WATCHPOS];
					CtrlMapAnimCommit _GPSCtrl;
					
					GW_CVAR_DIR = round(getDir player);
					GW_CVAR_ASL = round((getPosASL player) select 2);
					GW_CVAR_GRIDREF = mapGridPosition player;
					_GPSInfoCtrl ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>DIR: %1  ASL: %2  REF: %3", GW_CVAR_DIR, GW_CVAR_ASL, GW_CVAR_GRIDREF]);
					
					_GPSCtrl ctrlShow true;
					_BGGPSCtrl ctrlShow true;
					_FrameGPSCtrl ctrlShow true;
					_GPSInfoCtrl ctrlShow true;
				}
				else
				{
					_GPSCtrl ctrlShow false;
					_BGGPSCtrl ctrlShow false;
					_FrameGPSCtrl ctrlShow false;
					_GPSInfoCtrl ctrlShow false;
				};
				
				/******************************************************************************************************************/
				
				//Structures in Range
				private _structInRangeText = "";
				if (GW_CVAR_HQ_INRANGE) then {if (_structInRangeText != "") then {_structInRangeText = _structInRangeText + format["<br /><br /><img image='%1'/>", GW_CVAR_HQ_PIC]} else {_structInRangeText = format["<img image='%1'/>", GW_CVAR_HQ_PIC]}};
				if (GW_CVAR_BARRACKS_INRANGE) then {if (_structInRangeText != "") then {_structInRangeText = _structInRangeText + format["<br /><br /><img image='%1'/>", GW_CVAR_BARRACKS_PIC]} else {_structInRangeText = format["<img image='%1'/>", GW_CVAR_BARRACKS_PIC]}};
				if (GW_CVAR_NAVAL_INRANGE) then {if (_structInRangeText != "") then {_structInRangeText = _structInRangeText + format["<br /><br /><img image='%1'/>", GW_CVAR_NAVAL_PIC]} else {_structInRangeText = format["<img image='%1'/>", GW_CVAR_NAVAL_PIC]}};
				if (GW_CVAR_LIGHT_INRANGE) then {if (_structInRangeText != "") then {_structInRangeText = _structInRangeText + format["<br /><br /><img image='%1'/>", GW_CVAR_LIGHT_PIC]} else {_structInRangeText = format["<img image='%1'/>", GW_CVAR_LIGHT_PIC]}};
				if (GW_CVAR_HEAVY_INRANGE) then {if (_structInRangeText != "") then {_structInRangeText = _structInRangeText + format["<br /><br /><img image='%1'/>", GW_CVAR_HEAVY_PIC]} else {_structInRangeText = format["<img image='%1'/>", GW_CVAR_HEAVY_PIC]}};
				if (GW_CVAR_AIR_INRANGE) then {if (_structInRangeText != "") then {_structInRangeText = _structInRangeText + format["<br /><br /><img image='%1'/>", GW_CVAR_AIR_PIC]} else {_structInRangeText = format["<img image='%1'/>", GW_CVAR_AIR_PIC]}};
				if (GW_CVAR_COMMTOWER_INRANGE) then {if (_structInRangeText != "") then {_structInRangeText = _structInRangeText + format["<br /><br /><img image='%1'/>", GW_CVAR_COMMTOWER_PIC]} else {_structInRangeText = format["<img image='%1'/>", GW_CVAR_COMMTOWER_PIC]}};
				if (GW_CVAR_SERVICE_INRANGE) then {if (_structInRangeText != "") then {_structInRangeText = _structInRangeText + format["<br /><br /><img image='%1'/>", GW_CVAR_SERVICE_PIC]} else {_structInRangeText = format["<img image='%1'/>", GW_CVAR_SERVICE_PIC]}};
				if (GW_CVAR_RESEARCH_INRANGE) then {if (_structInRangeText != "") then {_structInRangeText = _structInRangeText + format["<br /><br /><img image='%1'/>", GW_CVAR_RESEARCH_PIC]} else {_structInRangeText = format["<img image='%1'/>", GW_CVAR_RESEARCH_PIC]}};
				if (GW_CVAR_CAMP_INRANGE) then {if (_structInRangeText != "") then {_structInRangeText = _structInRangeText + format["<br /><br /><img image='%1'/>", GW_MISSIONROOT + "Resources\images\struct_camp.paa"]} else {_structInRangeText = format["<img image='%1'/>", GW_MISSIONROOT + "Resources\images\struct_camp.paa"]}};
				if (GW_CVAR_DEPOT_INRANGE) then {if (_structInRangeText != "") then {_structInRangeText = _structInRangeText + format["<br /><br /><img image='%1'/>", GW_MISSIONROOT + "Resources\images\struct_depot.paa"]} else {_structInRangeText = format["<img image='%1'/>", GW_MISSIONROOT + "Resources\images\struct_depot.paa"]}};
				_structuresInRangeCtrl ctrlSetStructuredText (parseText format["<t shadow='0' align='left'>%1</t>",_structInRangeText]);
				_structuresInRangeCtrl ctrlShow true;
				
				/******************************************************************************************************************/
				
				//Health and Stamina (Only when not in vehicle)
				if ((vehicle player) == player) then
				{
					private _currentHealth = 1 - damage player;
					
					private _HealthMaxWidth = (CtrlPosition _healthBGCtrl select 2) - 0.015;
					private _HealthBarCurPos = CtrlPosition _healthBarCtrl;
					
					_HealthBarCurPos set [2, _HealthMaxWidth * (_currentHealth / 1)];
					_healthBarCtrl CtrlSetPosition _HealthBarCurPos;
					_healthBarCtrl CtrlCommit 0;
					if (_currentHealth >= 0.8) then {_healthBarCtrl CtrlSetBackgroundColor [0,0.8431,0.1961,1]};
					if (_currentHealth >= 0.4 && _currentHealth < 0.8) then {_healthBarCtrl CtrlSetBackgroundColor [0.9019,0.7608,0,1]};
					if (_currentHealth < 0.4) then {_healthBarCtrl CtrlSetBackgroundColor [0.6667,0.1294,0.1294,1]};
					
					_healthBGCtrl ctrlShow true;
					_healthFrameCtrl ctrlShow true;
					_healthBarCtrl ctrlShow true;
					_healthIconCtrl ctrlShow true;
				}
				else
				{
					_healthBGCtrl ctrlShow false;
					_healthFrameCtrl ctrlShow false;
					_healthBarCtrl ctrlShow false;
					_healthIconCtrl ctrlShow false;
				};
				
				//Rank
				_rankBarCtrl CtrlSetBackgroundColor GW_CVAR_TEAM_COLOUR_RGBA;
				private _RankBarMaxWidth = (CtrlPosition _rankBGCtrl select 2) - 0.015;
				private _RankBarCurPos = CtrlPosition _rankBarCtrl;
				if ((GW_CVAR_RANK_INFO select 2) > 0) then {_RankBarCurPos set [2, _RankBarMaxWidth * ((GW_CVAR_RANK_INFO select 1) / (GW_CVAR_RANK_INFO select 2))]};
				_rankBarCtrl CtrlSetPosition _RankBarCurPos;
				_rankBarCtrl CtrlCommit 0;
					
				_rankIconCtrl ctrlSetText format["a3\ui_f\data\gui\cfg\Ranks\%1_gs.paa",(player getVariable ["GW_UNITRANK", "private"])];
				_rankBGCtrl ctrlShow true;
				_rankFrameCtrl ctrlShow true;
				_rankBarCtrl ctrlShow true;
				_rankIconCtrl ctrlShow true;

				
				/******************************************************************************************************************/
				//Team Information
				private _westMembers = [west, "varname"] Call fnc_shr_getSideMembers;
				if (GW_PARAM_VC_TICKETS) then
				{
					private _blueTicketText = format["<t align='center' font='PuristaMedium' color='#FFFFFF'>%1 %2</t>",
						GW_TICKETS_WEST,
						if (GW_TICKETS_WEST_BLEED > 0) then {format["(-%1)",GW_TICKETS_WEST_BLEED]} else {""}
					];
					_blueTicketsCtrl ctrlSetStructuredText (parseText _blueTicketText);
					_blueTicketsCtrl ctrlShow true;
				}
				else
				{
					_blueTicketsCtrl ctrlShow false;
				};
				_bluePlayersCtrl ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>%1 <img image='Resources\images\squad_size.paa'/><br/>%2 <img image='\A3\ui_f\data\map\markers\military\flag_CA.paa'/>",count _westMembers, GW_ZONESOWNED_WEST]);
				_bluePlayersCtrl ctrlShow true;
				_blueBGCtrl ctrlShow true;
				_blueMarkerCtrl ctrlShow true;
				
				private _eastMembers = [east, "varname"] Call fnc_shr_getSideMembers;
				if (GW_PARAM_VC_TICKETS) then
				{
					private _redTicketText = format["<t align='center' font='PuristaMedium' color='#FFFFFF'>%1 %2</t>",
						GW_TICKETS_EAST,
						if (GW_TICKETS_EAST_BLEED > 0) then {format["(-%1)",GW_TICKETS_EAST_BLEED]} else {""}
					];
					_redTicketsCtrl ctrlSetStructuredText (parseText _redTicketText);
					_redTicketsCtrl ctrlShow true;
				}
				else
				{
					_redTicketsCtrl ctrlShow false;
				};
				_redPlayersCtrl ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>%1 <img image='Resources\images\squad_size.paa'/><br/>%2 <img image='\A3\ui_f\data\map\markers\military\flag_CA.paa'/>",count _eastMembers, GW_ZONESOWNED_EAST]);
				_redPlayersCtrl ctrlShow true;
				_redBGCtrl ctrlShow true;
				_redMarkerCtrl ctrlShow true;
				
				/******************************************************************************************************************/
				
				//Commander, Specialization and Squad Size
				private _TeamCommanderVoting = "";
				if (GW_CVAR_COMMVOTE_TIME > 0) then {_TeamCommanderVoting = format["<img image='Resources\images\time.paa'/> %1",([GW_CVAR_COMMVOTE_TIME/60/60] call BIS_fnc_timeToString)]};
				private _TeamCommanderText = "No Commander";
				private _commanderObj = missionNamespace getVariable GW_CVAR_COMMANDER;
				if (!isNil "_commanderObj") then
				{
					if (!isNull _commanderObj) then 
					{
						_TeamCommanderText = if (alive _commanderObj) then {name _commanderObj} else {"Dead"};
					};
				};
				_commanderCtrl ctrlSetStructuredText (parseText format["<t align='right' font='PuristaMedium' color='#FFFFFF'>%2    %1 <img image='a3\ui_f\data\gui\cfg\Ranks\general_gs.paa'/>",_TeamCommanderText,_TeamCommanderVoting]);
				_commanderCtrl ctrlShow true;
				_commanderCtrl ctrlShow true;
				
				_squadSizeCtrl ctrlSetStructuredText (parseText format["<t align='right' font='PuristaMedium' color='#FFFFFF'>%1/%2 <img image='Resources\images\squad_size.paa'/>",(player Call fnc_shr_getSquadSize), GW_CVAR_MAXSQUADSIZE]);
				_squadSizeCtrl ctrlShow true;
				
				private _specialization = player getVariable ["GW_SPECIALIZATION", "No Specialization"];
				private _specArray = [];
				private _specializationImg = "";
				private _specTimer = if ((GW_CVAR_SPECIALIZATION_TIME == -1) || ((time - GW_CVAR_SPECIALIZATION_TIME) > GW_GVAR_SPECIALFORCES_TIMEOUT)) then {""} else {format["<img image='Resources\images\time.paa'/> %1",[(GW_GVAR_SPECIALFORCES_TIMEOUT - (time - GW_CVAR_SPECIALIZATION_TIME))/60/60] call BIS_fnc_timeToString]};
				if (_specialization != "No Specialization") then 
				{
					_specIndex = [_specialization, 0, GW_SPECIALIZATIONS] Call fnc_shr_arrayGetIndex;
					if (_specIndex != -1) then
					{
						_specializationImg = format["<img image='%1'/>",(GW_SPECIALIZATIONS select _specIndex) select 2];
					};
				};
				_specializationCtrl ctrlSetStructuredText (parseText format["<t align='right' font='PuristaMedium' color='#FFFFFF'>%1    %2 %3",
					_specTimer,
					_specialization, 
					_specializationImg
				]);
				_specializationCtrl ctrlShow true;
				
				/******************************************************************************************************************/
				
				//Action System
				if (count GW_CVAR_ACTION > 0) then
				{
					_progressActionCtrl progressSetPosition ((GW_CVAR_ACTION select 1) / (GW_CVAR_ACTION select 2));
					_textActionCtrl ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>%1 - %2s</t>",GW_CVAR_ACTION select 0, ceil(GW_CVAR_ACTION select 1)]);
					_progressActionCtrl ctrlShow true;
					_textActionCtrl ctrlShow true;
				}
				else
				{
					_progressActionCtrl ctrlShow false;
					_textActionCtrl ctrlShow false;
				};
				
				/******************************************************************************************************************/
				
				//Display zone and camp info if inside of a zone and camp
				if (count(GW_CVAR_ZONE) > 1) then
				{
					_BgZoneCapCtrl ctrlShow true;
					_FrameZoneCapCtrl ctrlShow true;
					
					_TextZoneCapCtrl ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>%1 %2/%3",(GW_CVAR_ZONE select 1), (GW_CVAR_ZONE select 6), (GW_CVAR_ZONE select 5)]);
					_TextZoneCapCtrl ctrlShow true;
					
					_BarZoneCapCtrl CtrlSetBackgroundColor ([(GW_CVAR_ZONE select 7), "RGBA"] Call fnc_shr_getSideColour);
					_BarZoneCapCtrl ctrlShow true;
					_BarZoneCapMaxWidth = (CtrlPosition _BGCampCapCtrl select 2) - 0.02;
					_BarZoneCapCurPos = CtrlPosition _BarZoneCapCtrl;
					_BarZoneCapCurPos set [2, _BarZoneCapMaxWidth * ((GW_CVAR_ZONE select 6) / (GW_CVAR_ZONE select 5))];
					_BarZoneCapCtrl CtrlSetPosition _BarZoneCapCurPos;
					_BarZoneCapCtrl CtrlCommit 0;
					
					if (count(GW_CVAR_CAMP) > 1) then
					{
						_BGCampCapCtrl ctrlShow true;
						_FrameCampCapCtrl ctrlShow true;
						
						_TextCampCapCtrl ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>%1 %2/%3",(GW_CVAR_CAMP select 5), (GW_CVAR_CAMP select 1), (GW_CVAR_CAMP select 2)]);
						_TextCampCapCtrl ctrlShow true;
						
						_CapCampCapCtrl CtrlSetBackgroundColor ([(GW_CVAR_CAMP select 3), "RGBA"] Call fnc_shr_getSideColour);
						_CapCampCapCtrl ctrlShow true;
						_CapCampCapMaxWidth = (CtrlPosition _BGCampCapCtrl select 2) - 0.02;
						_CapCampCapCurPos = CtrlPosition _CapCampCapCtrl;
						_CapCampCapCurPos set [2, _CapCampCapMaxWidth * ((GW_CVAR_CAMP select 1) / (GW_CVAR_CAMP select 2))];
						_CapCampCapCtrl CtrlSetPosition _CapCampCapCurPos;
						_CapCampCapCtrl CtrlCommit 0;
					}
					else
					{	
						_BGCampCapCtrl ctrlShow false;
						_FrameCampCapCtrl ctrlShow false;
						_TextCampCapCtrl ctrlShow false;
						_CapCampCapCtrl ctrlShow false;
					};
					
				}
				else
				{
					_BgZoneCapCtrl ctrlShow false;
					_FrameZoneCapCtrl ctrlShow false;
					_TextZoneCapCtrl ctrlShow false;
					_BarZoneCapCtrl ctrlShow false;
					_BGCampCapCtrl ctrlShow false;
					_FrameCampCapCtrl ctrlShow false;
					_TextCampCapCtrl ctrlShow false;
					_CapCampCapCtrl ctrlShow false;
				};
				
				/******************************************************************************************************************/
				
				//Vehicle crew display on the left side
				if (GW_CVAR_VEHICLECREW_TEXT != "") then
				{
					_vehCrewCtrl ctrlSetStructuredText (parseText GW_CVAR_VEHICLECREW_TEXT);
					_vehCrewCtrl ctrlShow true;
				}
				else
				{
					_vehCrewCtrl ctrlShow false;
				};
				
				/******************************************************************************************************************/
				
				//Construction UI Helper
				if (!isNil "GW_CONSTRUCT_LOCALBUILDING") then
				{
					if (!isNull GW_CONSTRUCT_LOCALBUILDING) then 
					{
						_constructionHelperCtrl ctrlSetStructuredText (parseText GW_CONSTRUCT_HELPERTEXT);
						_constructionHelperCtrl ctrlShow true;
					}
					else
					{
						_constructionHelperCtrl ctrlShow false;
					};
				}
				else
				{
					_constructionHelperCtrl ctrlShow false;
				};
			};
		};
	};
	
	uiSleep 0.1;
};
//}] call BIS_fnc_addStackedEventHandler;