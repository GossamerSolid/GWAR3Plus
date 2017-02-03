disableSerialization;
_display = _this select 0;
_map = _display DisplayCtrl 1202;
_map CtrlMapAnimAdd [0.5, 0.05, (getPosATL player)];
CtrlMapAnimCommit _map;

GW_SQUAD_SQUADUNITS = [];
GW_SQUAD_OTHERPLAYERS = [];
GW_SQUAD_SQUADCHANGED = false;
GW_SQUAD_DISBAND = false;
GW_SQUAD_SENDMONEY = false;
GW_SQUAD_PURCHASESUPPLIES = false;
GW_SQUAD_SELLSUPPLIES = false;
GW_SQUAD_MONEYTOSEND = 0;
GW_SQUAD_MONEYTOSEND_COST = 0;
GW_SQUAD_SUPPLYTOBUY = 0;
GW_SQUAD_SUPPLYTOBUY_COST = 0;
GW_SQUAD_SUPPLYTOSELL = 0;
GW_SQUAD_SUPPLYTOSELL_CASH = 0;

//Show name, rank and specialization in the title bar
_rankImage = format["a3\ui_f\data\gui\cfg\Ranks\%1_gs.paa",(player getVariable ["GW_UNITRANK", "private"])];
_playerName = name player;
_specName = if ((player getVariable ["GW_SPECIALIZATION", "No Specialization"]) != "") then {player getVariable ["GW_SPECIALIZATION", "No Specialization"]} else {"No Specialization"};
(_display displayCtrl 1100) ctrlSetStructuredText (parseText format["<t size='1' align='left' font='PuristaMedium' color='#FFFFFF'>Squad Menu</t><t size='1' align='center' font='PuristaMedium' color='#FFFFFF'><img image='%1'/> %2 - %3</t>",_rankImage,_playerName,_specName]);

//Render map icons
_mapIcons = _map ctrlAddEventHandler ["Draw",{[(_this select 0), true] Call fnc_clt_drawMapMarkers;}];

//Get list of squad members
fnc_squad_subordinateList =
{
	lbClear 1500;
	
	GW_SQUAD_SQUADUNITS = units (group player);
	GW_SQUAD_SQUADUNITS = GW_SQUAD_SQUADUNITS - [player]; //Shouldn't have player in there
	if (!isNull (getConnectedUAV player)) then {GW_SQUAD_SQUADUNITS pushBack (getConnectedUAV player)};
	{
		_name = format["[%1] %2",(_x getVariable ["GW_GROUPNUM", ""]), (_x getVariable ["GW_INFANTRYLOADOUT", name _x])];
		if (!isNull (getConnectedUAV player)) then
		{
			if (_x == (getConnectedUAV player)) then 
			{
				_name = "UAV";
				lbSetData [1500, _forEachIndex, "UAV"];
			};
		};
		lbAdd [1500, format["%1 - %2 - %3m",_name,(mapGridPosition _x),round(player distance _x)]];
	} forEach GW_SQUAD_SQUADUNITS;
};

//Get other player list
fnc_squad_playerList =
{
	lbClear 1501;
	
	GW_SQUAD_OTHERPLAYERS = [GW_CVAR_SIDE, "obj"] Call fnc_shr_getSideMembers;
	GW_SQUAD_OTHERPLAYERS = GW_SQUAD_OTHERPLAYERS - [player]; //Shouldn't have player in there
	{
		lbAdd [1501, format["%1",name _x]];
	} forEach GW_SQUAD_OTHERPLAYERS
};

//Main Updater
while {dialog} do
{
	//If player dies, close dialog
	if (!alive player) exitWith {closeDialog 60008};
	
	//Disable commander only stuff if not commander
	if (vehicleVarName player != GW_CVAR_COMMANDER) then
	{
		_supplyToMoneyBtnCtrl = _display displayCtrl 1602;
		_supplyToMoneyBtnCtrl ctrlEnable false;
	};
	
	//Update lists
	[] Spawn fnc_squad_subordinateList;
	[] Spawn fnc_squad_playerList;
	
	//Set max values for sliders
	sliderSetRange [1900, 0, GW_CVAR_MONEY - (GW_CVAR_MONEY * 0.10)];
	if ((sliderPosition 1900) > GW_CVAR_MONEY) then {sliderSetPosition [1900, GW_CVAR_MONEY]};
	sliderSetRange [1901, 0, (GW_CVAR_MONEY / 5)];
	if (((sliderPosition 1901) * 5) > GW_CVAR_MONEY) then {sliderSetPosition [1901, GW_CVAR_MONEY]};
	sliderSetRange [1902, 0, GW_CVAR_TEAMSUPPLY];
	if ((sliderPosition 1902) > GW_CVAR_TEAMSUPPLY) then {sliderSetPosition [1902, GW_CVAR_TEAMSUPPLY]};
	
	//Update buttons to match how much slider values are selected
	GW_SQUAD_MONEYTOSEND = round(sliderPosition 1900);
	GW_SQUAD_MONEYTOSEND_COST = round(GW_SQUAD_MONEYTOSEND + (GW_SQUAD_MONEYTOSEND * 0.10));
	GW_SQUAD_SUPPLYTOBUY = round(sliderPosition 1901);
	GW_SQUAD_SUPPLYTOBUY_COST = round(GW_SQUAD_SUPPLYTOBUY * 5);
	GW_SQUAD_SUPPLYTOSELL = round(sliderPosition 1902);
	GW_SQUAD_SUPPLYTOSELL_CASH = round(GW_SQUAD_SUPPLYTOSELL * 3);
	
	_moneyToPlayerBtnCtrl = _display displayCtrl 1600;
	_moneyToPlayerBtnCtrl ctrlSetText (format["Send $%1 ($%2)", GW_SQUAD_MONEYTOSEND, GW_SQUAD_MONEYTOSEND_COST]);
	_moneyToSupplyBtnCtrl = _display displayCtrl 1601;
	_moneyToSupplyBtnCtrl ctrlSetText (format["Purchase S%1 ($%2)", GW_SQUAD_SUPPLYTOBUY, GW_SQUAD_SUPPLYTOBUY_COST]);
	_supplyToMoneyBtnCtrl = _display displayCtrl 1602;
	_supplyToMoneyBtnCtrl ctrlSetText (format["Sell S%1 ($%2)", GW_SQUAD_SUPPLYTOSELL, GW_SQUAD_SUPPLYTOSELL_CASH]);
	
	//Update map to whatever squad member is selected
	if (lbCurSel 1500 != -1) then
	{
		_unitObjPos = getPosATL(GW_SQUAD_SQUADUNITS select (lbCurSel 1500));
		if (!isNil "_unitObjPos") then
		{
			_map CtrlMapAnimAdd [0, 0.05, _unitObjPos];
			CtrlMapAnimCommit _map;
		};
	};
	
	//Disband Squad Member
	if (GW_SQUAD_DISBAND) then
	{
		GW_SQUAD_DISBAND = false;
		_unitSelected = lbCurSel 1500;
		if (_unitSelected != -1) then
		{
			_unitObj = GW_SQUAD_SQUADUNITS select _unitSelected;
			if (!isNull _unitObj) then
			{
				//Handle UAVs a bit different
				if ((lbData [1500, _unitSelected]) == "uav") then
				{
					deleteVehicle _unitObj;
					
					//Tell player
					systemChat "Unit disbanded";
					playSound "UISuccess";
				}
				else
				{
					//In a vehicle?
					_vehObj = vehicle _unitObj;
					if (_vehObj != _unitObj) then
					{
						_unitObj action ["EJECT", _vehObj];
					};
					
					//Remove from group silently and delete
					[_unitObj] join grpNull;
					deleteVehicle _unitObj;
					
					//Tell player
					systemChat "Unit disbanded";
					playSound "UISuccess";
				};
			};
		};
	};
	
	//Send Money to Player
	if (GW_SQUAD_SENDMONEY) then
	{
		GW_SQUAD_SENDMONEY = false;
		_playerIndex = lbCurSel 1501;
		if (_playerIndex != -1 && GW_SQUAD_MONEYTOSEND > 0) then
		{
			GW_SQUAD_NETCALLRETURN = ["GW_NETCALL_WAITING"];
			_buyNetCall = ["team","sendmoney",[(getPlayerUID player),(getPlayerUID (GW_SQUAD_OTHERPLAYERS select _playerIndex)), GW_SQUAD_MONEYTOSEND, GW_SQUAD_MONEYTOSEND_COST], "GW_SQUAD_NETCALLRETURN"] Spawn fnc_clt_requestServerExec;
			waitUntil {scriptDone _buyNetCall};
			
			if (!(GW_SQUAD_NETCALLRETURN select 0)) then
			{
				playSound "UIFail";
				systemChat format ["Unable to send money - %1",(GW_SQUAD_NETCALLRETURN select 1)];
			}
			else
			{
				playSound "UISuccess";
			};
		};
	};
	
	//Buy Supplies for Team
	if (GW_SQUAD_PURCHASESUPPLIES) then
	{
		GW_SQUAD_PURCHASESUPPLIES = false;
		if (GW_SQUAD_SUPPLYTOBUY > 0) then
		{
			GW_SQUAD_NETCALLRETURN = ["GW_NETCALL_WAITING"];
			_buyNetCall = ["team","purchasesupplies",[(getPlayerUID player), GW_CVAR_SIDE, GW_SQUAD_SUPPLYTOBUY, GW_SQUAD_SUPPLYTOBUY_COST], "GW_SQUAD_NETCALLRETURN"] Spawn fnc_clt_requestServerExec;
			waitUntil {scriptDone _buyNetCall};
			
			if (!(GW_SQUAD_NETCALLRETURN select 0)) then
			{
				playSound "UIFail";
				systemChat format ["Unable to purchase supplies - %1",(GW_SQUAD_NETCALLRETURN select 1)];
			}
			else
			{
				playSound "UISuccess";
			};
		};
	};
	
	//Sell supplies
	if (GW_SQUAD_SELLSUPPLIES) then
	{
		GW_SQUAD_SELLSUPPLIES = false;
		if (GW_SQUAD_SUPPLYTOSELL > 0) then
		{
			GW_SQUAD_NETCALLRETURN = ["GW_NETCALL_WAITING"];
			_sellNetCall = ["team","sellsupplies",[(getPlayerUID player), GW_CVAR_SIDE, GW_SQUAD_SUPPLYTOSELL, GW_SQUAD_SUPPLYTOSELL_CASH], "GW_SQUAD_NETCALLRETURN"] Spawn fnc_clt_requestServerExec;
			waitUntil {scriptDone _sellNetCall};
			
			if (!(GW_SQUAD_NETCALLRETURN select 0)) then
			{
				playSound "UIFail";
				systemChat format ["Unable to sell supplies - %1",(GW_SQUAD_NETCALLRETURN select 1)];
			}
			else
			{
				playSound "UISuccess";
			};
		};
	};
	
	sleep 0.1;
};
