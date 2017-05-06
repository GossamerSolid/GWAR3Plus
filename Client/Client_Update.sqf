//Client_Update.sqf
//Written by: GossamerSolid
//Handles updating client-side info about nearest territory, zone, establishment and resource
disableSerialization;

//Starting
private["_updateNearbyStructures","_updateDeadSquadMembers","_updateMarkedObjects","_updateVehicleCrew","_updateActions"];
private _updateNearbyStructures = 3;
private _updateDeadSquadMembers = 3;
private _updateMarkedObjects = 3;
private _updateVehicleCrew = 1;
private _updateActions = 1;

//Initial Calls
[] Spawn fnc_clt_getNearbyStructures;
[] Spawn fnc_clt_buildFriendlyMarkers;
["GW_CVAR_RANK_INFO","client","rankinfo",(getPlayerUID player), false] Spawn fnc_clt_requestServerData;

//Client logic loop
while {GW_GAMERUNNING} do
{
	//Reset distances
	if (GW_CVAR_TERRAIN_VD > GW_GVAR_VIEWDISTANCE) then {GW_CVAR_TERRAIN_VD = GW_GVAR_VIEWDISTANCE};
	if (GW_CVAR_OBJECT_VD > GW_GVAR_OBJVIEWDISTANCE) then {GW_CVAR_OBJECT_VD = GW_GVAR_OBJVIEWDISTANCE};
	if (GW_CVAR_SHADOW_VD > GW_GVAR_SHADOWDISTANCE) then {GW_CVAR_SHADOW_VD = GW_GVAR_SHADOWDISTANCE};
	
	//Enforce distances
	setTerrainGrid GW_GVAR_TERRAINGRID;
	setViewDistance GW_CVAR_TERRAIN_VD;
	setObjectViewDistance GW_CVAR_OBJECT_VD;
	setShadowDistance GW_CVAR_SHADOW_VD;
	
	//Prevent player from leaving team
	player addRating 999999;
	
	//Hold the player's position in a var so we don't have to recalc a bunch
	private _playerPos = getPosATL player;
	
	//Increase stamina regen when player is not moving
	if ((player getVariable ["GW_SPECIALIZATION", ""]) != "Special Forces") then
	{
		if ((speed player) == 0) then {player setFatigue (getFatigue player) - 0.007};
	};
	
	/* DISABLED FOR NOW, RETURN AS MISSION PARAMETER
	//If placing a structure, allow views
	_isInConstruction = false;
	if (!isNil "GW_CONSTRUCT_LOCALBUILDING") then
	{
		if (!isNull GW_CONSTRUCT_LOCALBUILDING) then {_isInConstruction = true};
	};
	if (!_isInConstruction) then
	{
		//Prevent 3rd person as infantry
		if (cameraView == "EXTERNAL" && ((vehicle player) == player)) then
		{
			_isUav = false;
			if (!isNull (getConnectedUAV player)) then
			{
				_connectedUAV = (getConnectedUAV player);
				_uavControlArray = UAVControl _connectedUAV;
				if ((_uavControlArray select 0) == player) then
				{
					if ((_uavControlArray select 1) != "") then
					{
						_isUav = true;
					};
				};
			};
			
			if (!_isUav) then {(vehicle player) switchCamera "INTERNAL"};
		};
		//Prevent commander view
		if (cameraView == "GROUP") then
		{
			(vehicle player) switchCamera "INTERNAL";
		};
	};
	*/
	
	//Map markers for artillery computer
	_artyMapCtrl = (findDisplay -1) displayCtrl 500;
	if (!isNull _artyMapCtrl) then
	{
		_artyMapCtrl ctrlRemoveAllEventHandlers "Draw";
		_artyMapCtrl ctrlAddEventHandler ["Draw",{[(_this select 0), true] Call fnc_clt_drawMapMarkers;}];
	};
	
	//Map markers for UAV Terminal
	_uavMapCtrl = (findDisplay 160) displayCtrl 51;
	if (!isNull _uavMapCtrl) then
	{
		_uavMapCtrl ctrlRemoveAllEventHandlers "Draw";
		_uavMapCtrl ctrlAddEventHandler ["Draw",{[(_this select 0), true] Call fnc_clt_drawMapMarkers;}];
	};
	
	//Group Number Assignments (Not sure if this is the best place for it, but it'll have to do)
	{
		if ((_x getVariable ["GW_GROUPNUM", ""]) == "") then {_x setVariable ["GW_GROUPNUM", str(((units (group player)) find _x) + 1)]};
	} forEach (units (group player));
	
	//Update player side
	player setVariable ["GW_SIDE", GW_CVAR_SIDE, true];
	
	//Recalc max render distance of mini map icons
	GW_CVAR_MINIMAP_DRAWDISTANCE = (GW_CVAR_MINIMAP_ZOOM / 0.3) * GW_CVAR_MINIMAP_MAXDISTANCE;
	
	//Get nearest zone
	_nearestZone = _playerPos Call fnc_shr_getNearestZone;
	if (_nearestZone != -1) then
	{
		//Request zone array from server
		_zoneNetCall = ["GW_CVAR_ZONE","zone","all",_nearestZone, false] Spawn fnc_clt_requestServerData;
		
		//Get nearest camp
		if ((count GW_CVAR_ZONE) > 1) then
		{
			_nearestCamp = [_playerPos, (GW_CVAR_ZONE select 2)] Call fnc_shr_getNearestCamp;
			if (_nearestCamp != -1) then
			{
				GW_CVAR_CAMP = (GW_CVAR_ZONE select 2) select _nearestCamp;
			} else {GW_CVAR_CAMP = []};
		};
	} else {GW_CVAR_ZONE = []; GW_CVAR_CAMP = []};
	
	//Update nearby structures
	if (_updateNearbyStructures < GW_CVAR_CLIENT_UPDATE) then
	{	
		[] Spawn fnc_clt_getNearbyStructures;
		_updateNearbyStructures = 3;
	} else {_updateNearbyStructures = _updateNearbyStructures - GW_CVAR_CLIENT_UPDATE};

	//Update marked objects
	if (_updateMarkedObjects < GW_CVAR_CLIENT_UPDATE) then
	{
		[] Spawn fnc_clt_updateMarkedObjects;
		_updateMarkedObjects = 3;
	} else {_updateMarkedObjects = _updateMarkedObjects - GW_CVAR_CLIENT_UPDATE};
	
	//Update Vehicle Crew
	if (_updateVehicleCrew < GW_CVAR_CLIENT_UPDATE) then
	{
		[] Spawn fnc_clt_getVehicleCrewUI;
		_updateVehicleCrew = 1;
	} else {_updateVehicleCrew = _updateVehicleCrew - GW_CVAR_CLIENT_UPDATE};
	
	uiSleep GW_CVAR_CLIENT_UPDATE;
};

GW_CVAR_ZONE = [];
GW_CVAR_CAMP = [];