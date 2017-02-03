disableSerialization;
_display = _this select 0;
_map = _display DisplayCtrl 1202;
_map CtrlMapAnimAdd [0.5, 0.05, (getPosATL player)];
CtrlMapAnimCommit _map;

//Disable action buttons
ctrlEnable [2400, false];
ctrlEnable [2401, false];
ctrlEnable [2402, false];

//Render map icons
_mapIcons = _map ctrlAddEventHandler ["Draw",{[(_this select 0), true] Call fnc_clt_drawMapMarkers;}];

//Vars
GW_SERVICE_ORIGINS = [];
GW_SERVICE_UNITS = [];
GW_SERVICE_UNITS_ACTUAL = [];
GW_SERVICE_UNITS_SIDE = [];
GW_SERVICE_PRICES = [];
GW_SERVICE_ORIGINSELECTED = false;
GW_SERVICE_UNITSELECTED = false;
GW_SERVICE_REFUEL = false;
GW_SERVICE_REPAIR = false;
GW_SERVICE_REARM = false;

//Get list of service points
fnc_service_getOrigins =
{
	//Get the support origins
	GW_SERVICE_ORIGINS = [];
	{
		_currStructure = _x;
		_structureArray = (_currStructure getVariable "GW_STRUCTUID") Call fnc_clt_getStructureArray;
		_propertiesArray = _structureArray select 21;
		{
			if (_x == "Service") exitWith {GW_SERVICE_ORIGINS pushBack [_currStructure, (_structureArray select 1)]};
		} forEach _propertiesArray;
	} forEach GW_CVAR_BUILDINGS_BASE; 
	
	//Get all zones
	{
		_currZone = _x;
		if ((_currZone select 4) == GW_CVAR_SIDE) then {GW_SERVICE_ORIGINS pushBack [(_currZone select 0), (_currZone select 3)]};
	} forEach GW_ZONES_STUB;
	
	//Sort each array by distance
	GW_SERVICE_ORIGINS = [(getPosATL player), GW_SERVICE_ORIGINS, 0] Call fnc_shr_sortArrayByDistance;
	GW_CVAR_SUPPORTVEH = [(getPosATL player), GW_CVAR_SUPPORTVEH] Call fnc_shr_sortArrayByDistance;
	
	GW_SERVICE_ORIGINS = [GW_SERVICE_ORIGINS,GW_CVAR_SUPPORTVEH] Call fnc_shr_mergeArrays;
	
	lbClear 2100;
	{
		if (typeName _x == "ARRAY") then
		{
			_displayName = _x select 1; 
			lbAdd [2100, format["%1 - %2 - %3m",_displayName,(mapGridPosition (_x select 0)),round(player distance (_x select 0))]];
		}
		else
		{
			_displayName = "";
			_vehicleIndex = [(_x getVariable "GW_UNIQUEID"), 11, GW_VEHICLES] Call fnc_shr_arrayGetIndex;
			if (_vehicleIndex != -1) then {_displayName = ((GW_VEHICLES select _vehicleIndex) select 1)};
			lbAdd [2100, format["%1 - %2 - %3m",_displayName,(mapGridPosition _x),round(player distance _x)]];
		};
	} forEach GW_SERVICE_ORIGINS;
	lbSetCurSel [2100, -1];
};

//Get list of units within origin
fnc_service_getUnitList =
{
	ctrlEnable [2400, false];
	ctrlEnable [2401, false];
	ctrlEnable [2402, false];
	lbClear 1500;
	
	if ((lbCurSel 2100) != -1) then
	{
		_originObject = if ((typeName (GW_SERVICE_ORIGINS select (lbCurSel 2100))) == "ARRAY") then {(GW_SERVICE_ORIGINS select (lbCurSel 2100)) select 0} else {(GW_SERVICE_ORIGINS select (lbCurSel 2100))};
		GW_SERVICE_UNITS_ACTUAL = [];
		GW_SERVICE_UNITS_SIDE = [];
		GW_SERVICE_UNITS = nearestObjects [(getPosATL _originObject), ["Car","Tank","Air","Ship","StaticWeapon"], GW_GVAR_SERVICE_DISTANCE];
		GW_SERVICE_UNITS = GW_SERVICE_UNITS - [_originObject]; //Don't want the origin repair unit in the objects list
		
		//Filter out all that aren't on your side
		{
			_vehSide = _x getVariable ["GW_SIDE", civ];
			_vehUID = _x getVariable ["GW_UNIQUEID", ""];
			if ((_vehSide != civ) && (_vehUID != "")) then {GW_SERVICE_UNITS_SIDE pushBack _x};
		} forEach GW_SERVICE_UNITS;
		
		//Build actual list we'll work off of
		{
			if ((alive _x) || (_x == GW_CVAR_MHQ && (GW_CVAR_COMMANDER == (vehicleVarName player)))) then
			{
				_vehicleIndex = [(_x getVariable "GW_UNIQUEID"), 11, GW_VEHICLES] Call fnc_shr_arrayGetIndex;
				lbAdd [1500, format["%1 - %2 - %3m",((GW_VEHICLES select _vehicleIndex) select 1),(mapGridPosition _x),round(_originObject distance _x)]];
				lbSetPicture [1500, _forEachIndex, (getText (configFile >> "CfgVehicles" >> typeOf(_x) >> "Picture"))];
				GW_SERVICE_UNITS_ACTUAL pushBack _x;
			};
		} forEach GW_SERVICE_UNITS_SIDE;
	};
};

//Refuel
fnc_service_refuelVehicle =
{
	private["_vehicle","_speed","_altitude"];
	_vehicle = _this select 0;
	
	_vehicle setFuel 1;
	
	systemChat "Vehicle refueled";
	playSound "UISuccess";
};

//Repair
fnc_service_repairVehicle =
{
	private["_vehicle","_speed","_altitude"];
	_vehicle = _this select 0;
	
	_vehicle setDamage 0;
	
	_vehicle setVectorUp [0,0,1];
	_vehicle setPosATL [(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, 0];  
	
	systemChat "Vehicle repaired";
	playSound "UISuccess";
};

//Rearm
fnc_service_rearmVehicle =
{
	private["_vehicle","_speed","_altitude","_vehUID","_loadoutArrIndex","_weaponArray","_magArray"];
	_vehicle = _this select 0;
	
	_vehicle setVehicleAmmo 1;
	{_vehicle removeMagazine _x} ForEach (magazines _vehicle);
	
	//Is there a custom loadout?
	_loadoutArrIndex = -1;
	_vehUID = _vehicle getVariable ["GW_UNIQUEID", ""];
	if (_vehUID != "") then
	{
		_vehIndex = [_vehUID, 11, GW_VEHICLES] Call fnc_shr_arrayGetIndex;
		if (_vehIndex != -1) then
		{
			_vehArray = GW_VEHICLES select _vehIndex;
			_loadoutArrIndex = ["CustomLoadout", 0, (_vehArray select 10)] Call fnc_shr_arrayGetIndex;
		};
	};
	
	//Perform rearming
	if (_loadoutArrIndex != -1) then
	{
		_weaponArray = ((_vehArray select 10) select _loadoutArrIndex) select 1;
		_magArray = ((_vehArray select 10) select _loadoutArrIndex) select 2;
		
		{_vehicle addMagazine _x} forEach _magArray;
		{_vehicle addWeapon _x} forEach _weaponArray;
	}
	else
	{
		_magazines = getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Turrets" >> "MainTurret" >> "Magazines");
		_magazines = _magazines + getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Magazines");

		{_vehicle addMagazine _x} forEach _magazines;
	};
	
	//Remove artillery mines
	//To-Do - move to custom loadout
	(vehicle _vehicle) removeMagazine "6Rnd_155mm_Mo_AT_mine";
	(vehicle _vehicle) removeMagazine "6Rnd_155mm_Mo_mine";
	
	reload _vehicle;
	
	systemChat "Vehicle rearmed";
	playSound "UISuccess";
};

//Get the initial list
_originsList = [] Spawn fnc_service_getOrigins;
waitUntil {scriptDone _originsList};

//Main Updater
while {dialog} do
{
	//If player dies, close dialog
	if (!alive player) exitWith {closeDialog 60007};
	
	//If origin picked, populate unit list
	if (GW_SERVICE_ORIGINSELECTED) then
	{
		GW_SERVICE_ORIGINSELECTED = false;
		_populateUnits = [] Spawn fnc_service_getUnitList;
		waitUntil {scriptDone _populateUnits};
		
		//Update map position
		_originObject = if ((typeName (GW_SERVICE_ORIGINS select (lbCurSel 2100))) == "ARRAY") then {(GW_SERVICE_ORIGINS select (lbCurSel 2100)) select 0} else {(GW_SERVICE_ORIGINS select (lbCurSel 2100))};
		_map CtrlMapAnimAdd [0.5, 0.05, (getPosATL _originObject)];
		CtrlMapAnimCommit _map;
	};
	
	//If unit selected, check actions
	if (GW_SERVICE_UNITSELECTED) then
	{
		GW_SERVICE_UNITSELECTED = false;
		_unit = GW_SERVICE_UNITS_ACTUAL select (lbCurSel 1500);
		if (!isNull _unit) then
		{
			//Get service prices
			GW_SERVICE_PRICES = ["GW_NETCALL_WAITING"];
			_servicePricesNetCall = ["GW_SERVICE_PRICES","units","serviceprices",[GW_CVAR_SIDE, _unit getVariable ["GW_UNIQUEID", ""]], true] Spawn fnc_clt_requestServerData;
			waitUntil {scriptDone _servicePricesNetCall};
			
			//Repair button
			_repairBtnCtrl = _display displayCtrl 2400;
			if (_unit == GW_CVAR_MHQ) then
			{
				_repairBtnCtrl ctrlSetText (format["Repair (S%1)", GW_SERVICE_PRICES select 0]);
			}
			else
			{
				_repairBtnCtrl ctrlSetText (format["Repair ($%1)", GW_SERVICE_PRICES select 0]);
			};
			_repairBtnCtrl ctrlEnable true;
			
			//Refuel button
			_refuelBtnCtrl = _display displayCtrl 2401;
			_refuelBtnCtrl ctrlSetText (format["Refuel ($%1)", GW_SERVICE_PRICES select 1]);
			_refuelBtnCtrl ctrlEnable true;
			
			//Rearm button
			_rearmBtnCtrl = _display displayCtrl 2402;
			_rearmBtnCtrl ctrlSetText (format["Rearm ($%1)", GW_SERVICE_PRICES select 2]);
			_rearmBtnCtrl ctrlEnable true;
			
			//Update map position
			_map CtrlMapAnimAdd [0.5, 0.05, (getPosATL _unit)];
			CtrlMapAnimCommit _map;
		}
		else
		{
			ctrlEnable [2400, false];
			ctrlEnable [2401, false];
			ctrlEnable [2402, false];
		};
	};
	
	//Repair
	if (GW_SERVICE_REPAIR) then
	{
		GW_SERVICE_REPAIR = false;
		
		_unit = GW_SERVICE_UNITS_ACTUAL select (lbCurSel 1500);
		
		diag_log text format["### DUMP GW_SERVICE_UNITS_ACTUAL: %1",GW_SERVICE_UNITS_ACTUAL];
		GW_SERVICE_UNITS_ACTUAL Call fnc_shr_dumpArray;
		diag_log text format["### DUMP VEH UID: %1",((vehicle _unit) getVariable ["GW_UNIQUEID", "NIL"])];
		
		GW_SERVICE_BUYNETCALLRETURN = ["GW_NETCALL_WAITING"];
		_buyNetCall = ["units","servicebuy",[(getPlayerUID player), "repair", (_unit getVariable ["GW_UNIQUEID", ""]), GW_CVAR_SIDE, _unit], "GW_SERVICE_BUYNETCALLRETURN"] Spawn fnc_clt_requestServerExec;
		waitUntil {scriptDone _buyNetCall};
		
		if (!(GW_SERVICE_BUYNETCALLRETURN select 0)) then
		{
			playSound "UIFail";
			systemChat format ["Unable to repair vehicle - %1",(GW_SERVICE_BUYNETCALLRETURN select 1)];
		}
		else
		{
			_repairUnit = [(vehicle _unit)] Spawn fnc_service_repairVehicle;
			//waitUntil {scriptDone _repairUnit};
		};
		
		_populateUnits = [] Spawn fnc_service_getUnitList;
		waitUntil {scriptDone _populateUnits};
	};
	
	//Refuel
	if (GW_SERVICE_REFUEL) then
	{
		GW_SERVICE_REFUEL = false;
		_unit = GW_SERVICE_UNITS_ACTUAL select (lbCurSel 1500);
		
		GW_SERVICE_BUYNETCALLRETURN = ["GW_NETCALL_WAITING"];
		_buyNetCall = ["units","servicebuy",[(getPlayerUID player), "refuel", (_unit getVariable ["GW_UNIQUEID", ""]), GW_CVAR_SIDE, _unit], "GW_SERVICE_BUYNETCALLRETURN"] Spawn fnc_clt_requestServerExec;
		waitUntil {scriptDone _buyNetCall};
		
		if (!(GW_SERVICE_BUYNETCALLRETURN select 0)) then
		{
			playSound "UIFail";
			systemChat format ["Unable to refuel vehicle - %1",(GW_SERVICE_BUYNETCALLRETURN select 1)];
		}
		else
		{
			_refuelUnit = [(vehicle _unit)] Spawn fnc_service_refuelVehicle;
			//waitUntil {scriptDone _refuelUnit};
		};
		
		_populateUnits = [] Spawn fnc_service_getUnitList;
		waitUntil {scriptDone _populateUnits};
	};
	
	//Rearm
	if (GW_SERVICE_REARM) then
	{
		GW_SERVICE_REARM = false;
		
		_unit = GW_SERVICE_UNITS_ACTUAL select (lbCurSel 1500);
		
		GW_SERVICE_BUYNETCALLRETURN = ["GW_NETCALL_WAITING"];
		_buyNetCall = ["units","servicebuy",[(getPlayerUID player), "rearm", ((vehicle _unit) getVariable ["GW_UNIQUEID", ""]), GW_CVAR_SIDE, (vehicle _unit)], "GW_SERVICE_BUYNETCALLRETURN"] Spawn fnc_clt_requestServerExec;
		waitUntil {scriptDone _buyNetCall};
		
		if (!(GW_SERVICE_BUYNETCALLRETURN select 0)) then
		{
			playSound "UIFail";
			systemChat format ["Unable to rearm vehicle - %1",(GW_SERVICE_BUYNETCALLRETURN select 1)];
		}
		else
		{
			_rearmUnit = [(vehicle _unit)] Spawn fnc_service_rearmVehicle;
		};
		
		_populateUnits = [] Spawn fnc_service_getUnitList;
		waitUntil {scriptDone _populateUnits};
	};

	sleep 0.1;
};
