disableSerialization;
private _display = _this select 0;

private _btnConstruct = (findDisplay 60006) displayCtrl 1600;
private _btnBuyGear = (findDisplay 60006) displayCtrl 1602;
private _btnService = (findDisplay 60006) displayCtrl 1604;
private _btnSquad = (findDisplay 60006) displayCtrl 1605;
private _btnSpec = (findDisplay 60006) displayCtrl 1607;
private _btnResearch = (findDisplay 60006) displayCtrl 1608;
private _btnServerInfo = (findDisplay 60006) displayCtrl 1606;

//Tell the user whether or not the server is up to date
_textVersionInfo = (findDisplay 60006) displayCtrl 1107;
if (isNil "GW_LATESTVERSION") then
{
	_textVersionInfo ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Created by GossamerSolid - http://www.Gwar3.com<br/>Unable to check latest version</t>"]); 
}
else
{
	if (GW_CVAR_VERSION_CLIENT == GW_LATESTVERSION) then
	{
		_textVersionInfo ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Created by GossamerSolid - http://www.Gwar3.com<br/>This server is running the latest version</t>"]); 
	}
	else
	{
		_textVersionInfo ctrlSetStructuredText (parseText format["<t align='center' font='PuristaMedium' color='#FFFFFF'>Created by GossamerSolid - http://www.Gwar3.com<br/>WARNING - This server is out of date!</t>"]); 
	};
};

//Does the player's team have full mobilization researched?
private _sideHasFullMobilization = [GW_CVAR_SIDE, "Full Mobilization"] Call fnc_shr_isResearched;

//Main Updater
while {dialog} do
{
	//If player dies, close dialog
	if (!alive player || isNull (findDisplay 60006)) exitWith {closeDialog 60006};
	
	//Disable or Enable construction screen if player can build
	private _canBuild = player Call fnc_clt_canBuild;
	if (_canBuild select 0) then {_btnConstruct ctrlEnable true} else {_btnConstruct ctrlEnable false};
	
	//Disable or enable gear purchasing depending on range to barracks or camp
	if (GW_CVAR_BARRACKS_INRANGE || GW_CVAR_CAMP_INRANGE) then {_btnBuyGear ctrlEnable true} else {_btnBuyGear ctrlEnable false};
	
	//Allow gear purchasing if player is close to depot, side has Full Mobilization researched and enemies are not nearby
	if (!(ctrlEnabled _btnBuyGear)) then
	{
		if (GW_CVAR_DEPOT_INRANGE && _sideHasFullMobilization) then
		{
			_hostiles = [GW_CVAR_SIDE, (getPosASL player), 100] Call fnc_shr_getHostilesInArea;
			if (_hostiles == 0) then {_btnBuyGear ctrlEnable true};
		};
	};
	
	//Disable or enable Research menu depending on range to comm tower or mhq
	if (GW_CVAR_HQ_INRANGE || GW_CVAR_COMMTOWER_INRANGE) then {_btnResearch ctrlEnable true} else {_btnResearch ctrlEnable false};
	
	sleep 0.1;
};
