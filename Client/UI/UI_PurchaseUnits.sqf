disableSerialization;
_display = _this select 0;
_map = _display DisplayCtrl 1206;
_map CtrlMapAnimAdd [0.5, 0.05, (getPosATL player)];
CtrlMapAnimCommit _map;

_btnPurchaseCTRL = _display displayCTRL 2400;
_btnPurchaseCTRL ctrlEnable false;
_btnPurchaseCTRL ctrlSetText "Purchase";

_btnDriverCTRL = _display displayCTRL 1209;
_btnGunnerCTRL = _display displayCTRL 1207;
_btnCommanderCTRL = _display displayCTRL 1211;
_btnTurretsCTRL = _display displayCTRL 1210;
_btnLockedCTRL = _display displayCTRL 1208;

ctrlShow [1209, false];
ctrlShow [1207, false];
ctrlShow [1211, false];
ctrlShow [1210, false];
ctrlShow [1208, false];

_refreshStructQueue = 0.5;

GW_UNITPUR_UNITLIST = [];
GW_UNITPUR_INFLIST = [];
GW_UNITPUR_UNITCAT = "";
GW_UNITPUR_BUILDSTRUCTS = [];
GW_UNITPUR_STRUCTUREQUEUE = [];
GW_UNITPUR_BUYNETCALLRETURN = [];
GW_UNITPUR_UNITCAT_UPDATE = false;
GW_UNITPUR_STRUCTSELECTED = false;
GW_UNITPUR_STRUCTSELUPDATE = false;
GW_UNITPUR_UNITSELUPDATE = false;
GW_UNITPUR_UNITSELECTED = false;
GW_UNITPUR_DRIVER = false;
GW_UNITPUR_GUNNER = false;
GW_UNITPUR_COMMANDER = false;
GW_UNITPUR_TURRETS = false;
GW_UNITPUR_LOCKED = false;
GW_UNITPUR_PURCHASEUNIT = false;
GW_UNITPUR_CANCELQUEUE = false;
GW_UNITPUR_MOBILIZATION = [GW_CVAR_SIDE, "Limited Mobilization"] Call fnc_shr_isResearched;
GW_UNITPUR_FULLMOBILIZATION = [GW_CVAR_SIDE, "Full Mobilization"] Call fnc_shr_isResearched;
GW_UNITPUR_LISTBOX_POS = ctrlPosition (_display displayCtrl 1500);
//GW_UNITPUR_DISPLAY = _display;

//Render map icons
_mapIcons = _map ctrlAddEventHandler ["Draw",{[(_this select 0), true] Call fnc_clt_drawMapMarkers;}];

//Refresh units list
fnc_purUnit_refreshUnitsList =
{
	lbClear 1500;
	GW_UNITPUR_UNITSELECTED = false;
	GW_UNITPUR_DRIVER = false;
	GW_UNITPUR_GUNNER = false;
	GW_UNITPUR_COMMANDER = false;
	GW_UNITPUR_TURRETS = false;
	GW_UNITPUR_LOCKED = false;
	
	//Vehicles
	if ((GW_UNITPUR_UNITCAT == "Light") || (GW_UNITPUR_UNITCAT == "Heavy") || (GW_UNITPUR_UNITCAT == "Air") || (GW_UNITPUR_UNITCAT == "Zone") || (GW_UNITPUR_UNITCAT == "Naval")) then
	{
		//Get vehicles array for the side
		_sideVehicles = [GW_CVAR_SIDE, GW_UNITPUR_UNITCAT] Call fnc_shr_getSideVehicles;
		GW_UNITPUR_UNITLIST = [];
		{
			_crewCost = 0;
			if ((_x select 13) != "") then
			{
				_crewClass = (Call Compile Format ["GW_INFANTRY_%1",(_x select 13)]);
				_infantryArray = [_crewClass, GW_CVAR_SIDE] Call fnc_shr_getInfantryArray;
				_crewCost = (Call Compile Format["GW_GVAR_INFANTRY_BASECOST_%1",GW_CVAR_SIDE]) + (_infantryArray select 1);
			};
			GW_UNITPUR_UNITLIST pushBack [(_x select 0),
										  (_x select 1),
										  (_x select 2),
										  (_x select 3),
										  (_x select 5),
										  (_x select 6),
										  (_x select 8),
										  (_x select 11),
										  _crewCost,
										  (_x select 10)];
		} forEach _sideVehicles;
		
		//Populate List with vehicles
		{
			_cost = _x select 2;
			if (GW_UNITPUR_MOBILIZATION) then {_cost = round(_cost - (_cost * GW_GVAR_MOBILIZATION_DISCOUNT))};
			if (GW_UNITPUR_FULLMOBILIZATION) then {_cost = round(_cost - (_cost * GW_GVAR_FULL_MOBILIZATION_DISCOUNT))};
			if ((_x select 0) isKindOf "Air") then
			{
				if ((player getVariable ["GW_SPECIALIZATION", ""]) == "Pilot") then {_cost = round(_cost - (_cost * 0.20))};
			};
			lbAdd [1500, format["$%1 - %2",_cost,(_x select 1)]];
			lbSetPicture [1500, _forEachIndex, (getText (configFile >> "CfgVehicles" >> (_x select 0) >> "Picture"))];
		} forEach GW_UNITPUR_UNITLIST;
		lbSetCurSel [1500, -1];

		//Crew buttons
		if (((count GW_UNITPUR_UNITLIST)) > 0 && (GW_UNITPUR_UNITCAT != "Zone")) then
		{
			ctrlShow [1209, true];
			ctrlShow [1207, true];
			ctrlShow [1211, true];
			ctrlShow [1210, true];
			ctrlShow [1208, true];
		}
		else
		{
			ctrlShow [1209, false];
			ctrlShow [1207, false];
			ctrlShow [1211, false];
			ctrlShow [1210, false];
			if (GW_UNITPUR_UNITCAT == "Zone") then {ctrlShow [1208, true]} else {ctrlShow [1208, false]};
		};
	};
	
	//Infantry
	if (GW_UNITPUR_UNITCAT == "Infantry") then
	{
		//Crew buttons
		ctrlShow [1209, false];
		ctrlShow [1207, false];
		ctrlShow [1211, false];
		ctrlShow [1210, false];
		ctrlShow [1208, false];

		//Get loadouts array for the side
		GW_UNITPUR_INFLIST = [];
		{
			if ((_x select 2) == GW_CVAR_SIDE) then {GW_UNITPUR_INFLIST pushBack _x};
		} forEach GW_INFANTRY_LOADOUTS;
		
		//Populate List with infantry loadouts
		{
			_cost = (Call Compile Format["GW_GVAR_INFANTRY_BASECOST_%1",(GW_CVAR_SIDE)]) + (_x select 1);
			if (GW_UNITPUR_MOBILIZATION) then {_cost = round(_cost - (_cost * GW_GVAR_MOBILIZATION_DISCOUNT))};
			if (GW_UNITPUR_FULLMOBILIZATION) then {_cost = round(_cost - (_cost * GW_GVAR_FULL_MOBILIZATION_DISCOUNT))};

			lbAdd [1500, format["$%1 - %2",_cost,(_x select 0)]];
			lbSetPicture [1500, _forEachIndex, GW_MISSIONROOT + "Resources\images\squad_size.paa"];
		} forEach GW_UNITPUR_INFLIST;
		lbSetCurSel [1500, -1];
	};
};

//Refresh structure queue
fnc_purUnit_refreshStructureQueue =
{
	//Get structure queue
	_structSelected = lbCurSel 2100;
	if (_structSelected != -1) then
	{
		GW_UNITPUR_STRUCTUREQUEUE = ["GW_NETCALL_WAITING"];
		_queueNetCall = ["GW_UNITPUR_STRUCTUREQUEUE","team","structurequeue",((GW_UNITPUR_BUILDSTRUCTS select _structSelected) select 0), true] Spawn fnc_clt_requestServerData;
		waitUntil {scriptDone _queueNetCall};

		//Populate queue
		lbClear 1501;
		{
			_playerObj = (_x select 0) Call fnc_shr_getObjFromUID;
			_playerName = if (isNull _playerObj) then {"Unknown Player"} else {name _playerObj};
			
			_timeLeft = _x select 1;
			_unitDisplay = _x select 2;
			
			lbAdd [1501, format["%1s - %2 - %3",(ceil(_timeLeft)), _playerName, _unitDisplay]];
			lbSetPicture [1501, _forEachIndex, GW_MISSIONROOT + "Resources\images\time.paa"];
		} forEach GW_UNITPUR_STRUCTUREQUEUE;
	}
	else
	{
		lbClear 1501;
	};
};

//Refresh Structures List
fnc_purUnit_refreshStructuresList =
{
	lbClear 2100;
	GW_UNITPUR_STRUCTSELECTED = false;
	
	//Get structures array for the side
	GW_UNITPUR_BUILDSTRUCTS = [];
	if (GW_UNITPUR_UNITCAT == "Zone") then
	{
		{
			_currZone = _x;
			if ((_currZone select 4) == GW_CVAR_SIDE) then {GW_UNITPUR_BUILDSTRUCTS pushBack [(_currZone select 0), (_currZone select 3)]};
		} forEach GW_ZONES_STUB;
	}
	else
	{
		{
			_structureArray = (_x getVariable "GW_STRUCTUID") Call fnc_clt_getStructureArray;
			if ((toLower(GW_UNITPUR_UNITCAT)) in (_structureArray select 13)) then 
			{
				GW_UNITPUR_BUILDSTRUCTS pushBack [_x, (_structureArray select 1)];
			};
		} forEach GW_CVAR_BUILDINGS_BASE;
	};
	
	//Sort by distance
	GW_UNITPUR_BUILDSTRUCTS = [(getPosATL player), GW_UNITPUR_BUILDSTRUCTS, 0] Call fnc_shr_sortArrayByDistance;
	
	//Populate structures list
	{
		_distance = player distance (_x select 0);
		
		//Is it in range
		_add = false;
		if (GW_CVAR_COMMTOWER_INRANGE) then {_add = true};
		if (!_add) then {if (_distance <= GW_GVAR_STRUCT_BUILD_DISTANCE) then {_add = true}};
		
		if (_add) then {lbAdd [2100, format["%1 - %2m - %3",(_x select 1),round(_distance),(mapGridPosition (_x select 0))]]};
	} forEach GW_UNITPUR_BUILDSTRUCTS;
	lbSetCurSel [2100, -1];
};

//Update total costs
fnc_purUnit_updateCosts =
{
	private["_parentDisp","_priceText","_unitCost","_otherCost"];
	disableSerialization;
	_parentDisp = _this select 0;

	_pricingTextCTRL = _parentDisp displayCTRL 1102;
	if ((lbCurSel 1500) != -1) then
	{
		if (GW_UNITPUR_UNITCAT == "infantry") then
		{
			if (count(GW_UNITPUR_INFLIST) > 0) then
			{
				_infantryBase = (Call Compile Format["GW_GVAR_INFANTRY_BASECOST_%1",(GW_CVAR_SIDE)]);
				_loadoutCost = (GW_UNITPUR_INFLIST select (lbCurSel 1500)) select 1;
				_totalCost = _infantryBase + _loadoutCost;
				if (GW_UNITPUR_MOBILIZATION) then {_totalCost = round(_totalCost - (_totalCost * GW_GVAR_MOBILIZATION_DISCOUNT))};
				if (GW_UNITPUR_FULLMOBILIZATION) then {_totalCost = round(_totalCost - (_totalCost * GW_GVAR_FULL_MOBILIZATION_DISCOUNT))};
				_textColor = if (_totalCost <= GW_CVAR_MONEY) then {"#269024"} else {"#c75454"};
				_pricingTextCTRL ctrlSetStructuredText (parseText format ["Price of Unit: <t color='%1'>$%2 ($%3 - Base Cost)</t>",_textColor, _totalCost, _infantryBase]);
			}
			else
			{
				_pricingTextCTRL ctrlSetStructuredText (parseText format ["Price of Unit: <t color='#269024'>$%1</t>",0]);
			};
		}
		else
		{
			if (count(GW_UNITPUR_UNITLIST) > 0) then
			{
				_arrayEntry = GW_UNITPUR_UNITLIST select (lbCurSel 1500);
				_crewCount = 0;
				{if (_x) then {_crewCount = _crewCount + 1};} forEach [GW_UNITPUR_DRIVER, GW_UNITPUR_GUNNER, GW_UNITPUR_COMMANDER, GW_UNITPUR_TURRETS];
				_vehCost = _arrayEntry select 2;
				if (GW_UNITPUR_MOBILIZATION) then {_vehCost = round(_vehCost - (_vehCost * GW_GVAR_MOBILIZATION_DISCOUNT))};
				if (GW_UNITPUR_FULLMOBILIZATION) then {_vehCost = round(_vehCost - (_vehCost * GW_GVAR_FULL_MOBILIZATION_DISCOUNT))};
				if ((_arrayEntry select 0) isKindOf "Air") then
				{
					if ((player getVariable ["GW_SPECIALIZATION", ""]) == "Pilot") then {_vehCost = round(_vehCost - (_vehCost * 0.20))};
				};
				_unitCost = _vehCost + ((_arrayEntry select 8) * _crewCount);
				_otherCost = ((_arrayEntry select 8) * _crewCount);
				_textColor = if (_unitCost <= GW_CVAR_MONEY) then {"#269024"} else {"#c75454"};
				_pricingTextCTRL ctrlSetStructuredText (parseText format ["Price of Unit: <t color='%1'>$%2 ($%3 - Crew Cost)</t>",_textColor, _unitCost, _otherCost]);
			}
			else
			{
				_pricingTextCTRL ctrlSetStructuredText (parseText format ["Price of Unit: <t color='#269024'>$%1</t>",0]);
			};
		};
	}
	else
	{
		_pricingTextCTRL ctrlSetStructuredText (parseText format ["Price of Unit: <t color='#269024'>$%1</t>",0]);
	};
};

//Update Unit Information
fnc_purUnit_updateUnitInfo =
{
	private["_parentDisp", "_btnDriverCTRL", "_btnGunnerCTRL", "_btnCommanderCTRL", "_btnTurretsCTRL", "_btnLockedCTRL"];
	disableSerialization;
	_parentDisp = _this select 0;
	
	_btnDriverCTRL = _parentDisp displayCTRL 1209;
	_btnGunnerCTRL = _parentDisp displayCTRL 1207;
	_btnCommanderCTRL = _parentDisp displayCTRL 1211;
	_btnTurretsCTRL = _parentDisp displayCTRL 1210;
	_btnLockedCTRL = _parentDisp displayCTRL 1208;

	//Unselect everything when changing
	GW_UNITPUR_DRIVER = false;
	GW_UNITPUR_GUNNER = false;
	GW_UNITPUR_COMMANDER = false;
	GW_UNITPUR_TURRETS = false;
	GW_UNITPUR_LOCKED = false;
	
	_unitSelected = lbCurSel 1500;
	if (_unitSelected != -1 && (GW_UNITPUR_UNITCAT != "Infantry")) then
	{
		//Enable or disable crew buttons depending on if the unit actually supports
		_crewArray = (GW_UNITPUR_UNITLIST select _unitSelected) select 4;
		if (_crewArray select 0) then {_btnDriverCTRL ctrlEnable true; _btnDriverCTRL ctrlSetTextColor [1,1,1,0.5]} else {_btnDriverCTRL ctrlEnable false; _btnDriverCTRL ctrlSetTextColor [1,1,1,0.10]};
		if (_crewArray select 1) then {_btnGunnerCTRL ctrlEnable true; _btnGunnerCTRL ctrlSetTextColor [1,1,1,0.5]} else {_btnGunnerCTRL ctrlEnable false; _btnGunnerCTRL ctrlSetTextColor [1,1,1,0.10]};
		if (_crewArray select 2) then {_btnCommanderCTRL ctrlEnable true; _btnCommanderCTRL ctrlSetTextColor [1,1,1,0.5]} else {_btnCommanderCTRL ctrlEnable false; _btnCommanderCTRL ctrlSetTextColor [1,1,1,0.10]};
		if (_crewArray select 3) then {_btnTurretsCTRL ctrlEnable true; _btnTurretsCTRL ctrlSetTextColor [1,1,1,0.5]} else {_btnTurretsCTRL ctrlEnable false; _btnTurretsCTRL ctrlSetTextColor [1,1,1,0.10]};
		_btnLockedCTRL ctrlEnable true;
		
		//Hide stuff if unit is a UAV
		_unitPropertiesArr = (GW_UNITPUR_UNITLIST select _unitSelected) select 9;
		if ("uav" in _unitPropertiesArr) then
		{
			_btnDriverCTRL ctrlShow false;
			_btnGunnerCTRL ctrlShow false;
			_btnCommanderCTRL ctrlShow false;
			_btnTurretsCTRL ctrlShow false;
			_btnLockedCTRL ctrlShow false;
		}
		else
		{
			_btnDriverCTRL ctrlShow true;
			_btnGunnerCTRL ctrlShow true;
			_btnCommanderCTRL ctrlShow true;
			_btnTurretsCTRL ctrlShow true;
			_btnLockedCTRL ctrlShow true;
		};
	}
	else
	{
		_btnDriverCTRL ctrlEnable false;
		_btnGunnerCTRL ctrlEnable false;
		_btnCommanderCTRL ctrlEnable false;
		_btnTurretsCTRL ctrlEnable false;
		_btnLockedCTRL ctrlEnable false;
	};
	
	/*
	//Unit Selected
	_unitSelected = lbCurSel 1500;
	if (_unitSelected != -1) then
	{
		_unitInfoTextCTRL = _parentDisp displayCTRL 1103;
		if (GW_UNITPUR_UNITCAT == "infantry") then
		{
			//Costs
			_infantryBase = (Call Compile Format["GW_GVAR_INFANTRY_BASECOST_%1",(GW_CVAR_SIDE)]);
			_loadoutCost = (GW_UNITPUR_INFLIST select _unitSelected) select 1;
			_unitInfoTextCTRL ctrlSetStructuredText (parseText format ["Infantry Cost: $%1    Loadout Cost: $%2",_infantryBase,_loadoutCost]);
		}
		else
		{
			//Costs
			_vehicleCost = (GW_UNITPUR_UNITLIST select _unitSelected) select 2;
			_crewCost = 0;//(GW_UNITPUR_INFLIST select _unitSelected) select 1;
			_unitInfoTextCTRL ctrlSetStructuredText (parseText format ["Vehicle Cost: $%1    Crew Cost: $%2",_vehicleCost,_crewCost]);
		};
	};
	*/
};

//Cancel Queue Item
fnc_purUnit_cancelQueue =
{
	_queueItem = GW_UNITPUR_STRUCTUREQUEUE select (lbCurSel 1501);
	if ((_queueItem select 0) == (getPlayerUID player)) then
	{
		GW_UNITPUR_CANCEL_RETURN = ["GW_NETCALL_WAITING"];
		_cancelNetCall = ["units","cancel",[(GW_CVAR_SIDE), ((GW_UNITPUR_BUILDSTRUCTS select lbCurSel 2100) select 0), (lbCurSel 1501), (getPlayerUID player)],"GW_UNITPUR_CANCEL_RETURN"] Spawn fnc_clt_requestServerExec;
		waitUntil {scriptDone _cancelNetCall};
		
		if (!(GW_UNITPUR_CANCEL_RETURN select 0)) then
		{
			playSound "UIFail";
			systemChat format ["Unable to cancel unit - %1",(GW_UNITPUR_CANCEL_RETURN select 1)];
		}
		else
		{
			playSound "UISuccess";
			systemChat format ["Unit cancelled - %1",(GW_UNITPUR_CANCEL_RETURN select 1)];
		};
	}
	else
	{
		playSound "UIFail";
		systemChat format ["Unable to cancel unit - This is not your unit"];
	};
};

//Main updater
while {dialog} do
{
	//Unit category changed
	if (GW_UNITPUR_UNITCAT_UPDATE) then
	{
		_btnInfantryCTRL = _display displayCTRL 1202;
		_btnInfantryCTRL ctrlSetTextColor [1,1,1,0.5];
		_btnLightVehCTRL = _display displayCTRL 1203;
		_btnLightVehCTRL ctrlSetTextColor [1,1,1,0.5];
		_btnHeavyVehCTRL = _display displayCTRL 1204;
		_btnHeavyVehCTRL ctrlSetTextColor [1,1,1,0.5];
		_btnAirVehCTRL = _display displayCTRL 1205;
		_btnAirVehCTRL ctrlSetTextColor [1,1,1,0.5];
		_btnZoneVehCTRL = _display displayCTRL 1213;
		_btnZoneVehCTRL ctrlSetTextColor [1,1,1,0.5];
		_btnNavalVehCTRL = _display displayCTRL 1212;
		_btnNavalVehCTRL ctrlSetTextColor [1,1,1,0.5];
		if (GW_UNITPUR_UNITCAT == "infantry") then {_btnInfantryCTRL ctrlSetTextColor [1,1,1,1]};
		if (GW_UNITPUR_UNITCAT == "light") then {_btnLightVehCTRL ctrlSetTextColor [1,1,1,1]};
		if (GW_UNITPUR_UNITCAT == "heavy") then {_btnHeavyVehCTRL ctrlSetTextColor [1,1,1,1]};
		if (GW_UNITPUR_UNITCAT == "air") then {_btnAirVehCTRL ctrlSetTextColor [1,1,1,1]};
		if (GW_UNITPUR_UNITCAT == "zone") then {_btnZoneVehCtrl ctrlSetTextColor [1,1,1,1]};
		if (GW_UNITPUR_UNITCAT == "naval") then {_btnNavalVehCTRL ctrlSetTextColor [1,1,1,1]};
		
		//Populate unit list
		_populateUnitList = [] Spawn fnc_purUnit_refreshUnitsList;
		waitUntil {scriptDone _populateUnitList};
		
		//Populate structure list
		_populateStructList = [] Spawn fnc_purUnit_refreshStructuresList;
		waitUntil {scriptDone _populateStructList};
		
		//Refresh queue
		_queueCall = [] Spawn fnc_purUnit_refreshStructureQueue;
		waitUntil {scriptDone _queueCall};
		
		GW_UNITPUR_UNITCAT_UPDATE = false;
	};	
	
	//Update unit specific information
	if (GW_UNITPUR_UNITSELUPDATE) then
	{
		GW_UNITPUR_UNITSELUPDATE = false;
		
		//Update unit info
		[_display] Spawn fnc_purUnit_updateUnitInfo;
	};

	//Update crew selection & locked status
	if (GW_UNITPUR_DRIVER) then 
	{
		_btnDriverCTRL ctrlSetTextColor [1,1,1,1];
	} 
	else 
	{
		if (ctrlEnabled _btnDriverCTRL) then {_btnDriverCTRL ctrlSetTextColor [1,1,1,0.5]} else {_btnDriverCTRL ctrlSetTextColor [1,1,1,0.10]};
	};
	if (GW_UNITPUR_GUNNER) then 
	{
		_btnGunnerCTRL ctrlSetTextColor [1,1,1,1];
	} 
	else 
	{
		if (ctrlEnabled _btnGunnerCTRL) then {_btnGunnerCTRL ctrlSetTextColor [1,1,1,0.5]} else {_btnGunnerCTRL ctrlSetTextColor [1,1,1,0.10]};
	};
	if (GW_UNITPUR_COMMANDER) then 
	{
		_btnCommanderCTRL ctrlSetTextColor [1,1,1,1];
	} 
	else 
	{
		if (ctrlEnabled _btnCommanderCTRL) then {_btnCommanderCTRL ctrlSetTextColor [1,1,1,0.5]} else {_btnCommanderCTRL ctrlSetTextColor [1,1,1,0.10]};
	};
	if (GW_UNITPUR_TURRETS) then 
	{
		_btnTurretsCTRL ctrlSetTextColor [1,1,1,1];
	} 
	else 
	{
		if (ctrlEnabled _btnTurretsCTRL) then {_btnTurretsCTRL ctrlSetTextColor [1,1,1,0.5]} else {_btnTurretsCTRL ctrlSetTextColor [1,1,1,0.10]};
	};
	if (GW_UNITPUR_LOCKED) then 
	{
		_btnLockedCTRL ctrlSetTextColor [1,1,1,1];
	} 
	else 
	{
		if (ctrlEnabled _btnLockedCTRL) then {_btnLockedCTRL ctrlSetTextColor [1,1,1,0.5]} else {_btnLockedCTRL ctrlSetTextColor [1,1,1,0.10]};
	};
	
	//Update structure selection
	if (GW_UNITPUR_STRUCTSELUPDATE) then
	{
		GW_UNITPUR_STRUCTSELUPDATE = false;
		_structSelected = lbCurSel 2100;
		if (_structSelected != -1) then
		{
			_structObjPos = getPosATL((GW_UNITPUR_BUILDSTRUCTS select _structSelected) select 0);
			_map = _display DisplayCtrl 1206;
			_map CtrlMapAnimAdd [0.5, 0.05, _structObjPos];
			CtrlMapAnimCommit _map;
		};
	};
	
	//If both structure and unit selected, enable purchase button
	if (GW_UNITPUR_STRUCTSELECTED && GW_UNITPUR_UNITSELECTED) then
	{
		_unitCost = 0;
		if (GW_UNITPUR_UNITCAT == "Infantry") then
		{
			_unitCost = (Call Compile Format["GW_GVAR_INFANTRY_BASECOST_%1",(GW_CVAR_SIDE)]) + ((GW_UNITPUR_INFLIST select (lbCurSel 1500)) select 1);
			if (GW_UNITPUR_MOBILIZATION) then {_unitCost = round(_unitCost - (_unitCost * GW_GVAR_MOBILIZATION_DISCOUNT))};
			if (GW_UNITPUR_FULLMOBILIZATION) then {_unitCost = round(_unitCost - (_unitCost * GW_GVAR_FULL_MOBILIZATION_DISCOUNT))};
		}
		else
		{
			_arrayEntry = GW_UNITPUR_UNITLIST select (lbCurSel 1500);
			_crewCount = 0;
			{if (_x) then {_crewCount = _crewCount + 1};} forEach [GW_UNITPUR_DRIVER, GW_UNITPUR_GUNNER, GW_UNITPUR_COMMANDER, GW_UNITPUR_TURRETS];
			_vehCost = _arrayEntry select 2;
			if (GW_UNITPUR_MOBILIZATION) then {_vehCost = round(_vehCost - (_vehCost * GW_GVAR_MOBILIZATION_DISCOUNT))};
			if (GW_UNITPUR_FULLMOBILIZATION) then {_vehCost = round(_vehCost - (_vehCost * GW_GVAR_FULL_MOBILIZATION_DISCOUNT))};
			if ((_arrayEntry select 0) isKindOf "Air") then
			{
				if ((player getVariable ["GW_SPECIALIZATION", ""]) == "Pilot") then {_vehCost = round(_vehCost - (_vehCost * 0.20))};
			};
			_unitCost = _vehCost + ((_arrayEntry select 8) * _crewCount);
		};
		
		_btnPurchaseCTRL ctrlSetText (format["Purchase"]);
		if (GW_CVAR_MONEY >= _unitCost) then
		{
			_btnPurchaseCTRL ctrlEnable true;
		}
		else
		{
			_btnPurchaseCTRL ctrlEnable false;
		};
	}
	else
	{
		_btnPurchaseCTRL ctrlEnable false;
		_btnPurchaseCTRL ctrlSetText "Purchase";
	};
	
	//Refresh structure queue
	if (_refreshStructQueue <= 0) then
	{
		//Populate unit list
		_structSelected = lbCurSel 2100;
		if (_structSelected != -1) then
		{
			_populateQueue = [] Spawn fnc_purUnit_refreshStructureQueue;
			waitUntil {scriptDone _populateQueue};
		};
		
		_refreshStructQueue = 0.5;
	} else {_refreshStructQueue = _refreshStructQueue - 0.1};
	
	//Buy Unit
	if (GW_UNITPUR_PURCHASEUNIT) then
	{
		GW_UNITPUR_PURCHASEUNIT = false;
		_unitSelected = lbCurSel 1500; 
		_structureSelected = lbCurSel 2100;
		if (_unitSelected != -1 && _structureSelected != -1) then
		{
			_unitType = toLower(GW_UNITPUR_UNITCAT);
			_structureObj = (GW_UNITPUR_BUILDSTRUCTS select _structureSelected) select 0;
			
			//Is it in range
			_inRange = false;
			if (GW_CVAR_COMMTOWER_INRANGE) then {_inRange = true};
			if (!_inRange) then 
			{
				_distance = (player distance _structureObj); 
				if (_distance <= GW_GVAR_STRUCT_BUILD_DISTANCE) then 
				{
					_inRange = true;
				};
			};
			
			if (_inRange) then
			{
				if (_unitType == "infantry") then //Infantry
				{
					_loadoutName = (GW_UNITPUR_INFLIST select _unitSelected) select 0;
					
					GW_UNITPUR_BUYNETCALLRETURN = ["GW_NETCALL_WAITING"];
					_buyNetCall = ["units","buy",[(getPlayerUID player), _structureObj, [_unitType, _loadoutName, (GW_CVAR_SIDE)]], "GW_UNITPUR_BUYNETCALLRETURN"] Spawn fnc_clt_requestServerExec;
					waitUntil {scriptDone _buyNetCall};
					
					if (!(GW_UNITPUR_BUYNETCALLRETURN select 0)) then
					{
						playSound "UIFail";
						systemChat format ["Unable to recruit infantry - %1",(GW_UNITPUR_BUYNETCALLRETURN select 1)];
					}
					else
					{
						playSound "UISuccess";
					};
				}
				else //Vehicles
				{
					_unitPropertiesArr = (GW_UNITPUR_UNITLIST select _unitSelected) select 9;
					_canBuildUAV = [true, ""];
					if ("uav" in _unitPropertiesArr) then
					{
						//Need UAV terminal
						_playerItems = assignedItems player;
						if (("B_UavTerminal" in _playerItems) || ("O_UavTerminal" in _playerItems)) then {_canBuildUAV = [true, ""]} else {_canBuildUAV = [false, "You do not have a UAV terminal"]};
						
						//Only 1 UAV per player due to issues
						if (!isNull (getConnectedUAV player)) then {_canBuildUAV = [false, "You can only have 1 UAV"]};
					};
					
					if (_canBuildUAV select 0) then
					{
						_unitUID = (GW_UNITPUR_UNITLIST select _unitSelected) select 7;
						
						GW_UNITPUR_BUYNETCALLRETURN = ["GW_NETCALL_WAITING"];
						_buyNetCall = ["units","buy",[(getPlayerUID player), _structureObj, [_unitType, _unitUID, GW_UNITPUR_LOCKED, [GW_UNITPUR_DRIVER, GW_UNITPUR_GUNNER, GW_UNITPUR_COMMANDER, GW_UNITPUR_TURRETS], (GW_CVAR_SIDE)]], "GW_UNITPUR_BUYNETCALLRETURN"] Spawn fnc_clt_requestServerExec;
						waitUntil {scriptDone _buyNetCall};
						
						if (!(GW_UNITPUR_BUYNETCALLRETURN select 0)) then
						{
							playSound "UIFail";
							systemChat format ["Unable to purchase unit - %1",(GW_UNITPUR_BUYNETCALLRETURN select 1)];
						}
						else
						{
							playSound "UISuccess";
						};
					}
					else
					{
						playSound "UIFail";
						systemChat format ["Unable to purchase unit - %1", _canBuildUAV select 1];
					};
				};
			}
			else
			{
				playSound "UIFail";
				systemChat format ["Unable to purchase unit - %1","Building is not in range"];
			};
		};
	};
	
	//Update prices
	[_display] Spawn fnc_purUnit_updateCosts;
	
	//Check if a queue cancellation was requested
	if (GW_UNITPUR_CANCELQUEUE) then
	{
		GW_UNITPUR_CANCELQUEUE = false;
		[] Spawn fnc_purUnit_cancelQueue;
	};

	sleep 0.1;
};