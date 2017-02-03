disableSerialization;
_display = _this select 0;
_map = _display DisplayCtrl 1200;
_map CtrlMapAnimAdd [0.5, 0.05, (getPosATL player)];
CtrlMapAnimCommit _map;

GW_MAPCLICK = -1;
GW_COMMREDEP_AVAILABLE = [];
GW_COMMREDEP_MARKERS = [];
GW_COMMREDEP_SELECTED = false;
GW_COMMREDEP_SELECTED_ARRAY = [];
GW_COMMREDEP_SELECTED_MARKER = "";
GW_COMMREDEP_DISTANCE = GW_CVAR_SIDE Call fnc_shr_getFrontlineDepDistance;
GW_COMMREDEP_POS = getPosATL player;
ctrlEnable [2400, false];

//Control to accept redeploy
_redeployBtn = _display displayCtrl 2400;
_redeployBtn = _display displayCtrl 2400;

//Render map icons
_mapIcons = _map ctrlAddEventHandler ["Draw",{[(_this select 0), true] Call fnc_clt_drawMapMarkers;}];

//Spin the deployment marker around
fnc_commRedep_animateDeploymentMarker =
{
	while{ dialog && (GW_COMMREDEP_SELECTED_MARKER != "")} do
	{
		GW_COMMREDEP_SELECTED_MARKER setMarkerColorLocal "ColorRed";
	};
};

//Build spawn locations
fnc_commRedep_buildAvailableSpawns =
{
	private["_localBuildArray","_localBuildIndex","_sideHasFrontline"];
	_localBuildArray = [];
	//Does the player's team have Frontline Deployment researched?
	_sideHasFrontline = [GW_CVAR_SIDE, "Frontline Deployment"] Call fnc_shr_isResearched;
	
	//MHQ (Doesn't matter if hostiles are present)
	_localBuildArray pushBack [GW_CVAR_MHQ, "MHQ"];
	
	//Base Buildings (Doesn't matter if hostiles are present)
	{
		_structIndex = [(_x getVariable "GW_STRUCTUID"), 17, GW_CONSTRUCT_BASESTRUCT] Call fnc_shr_arrayGetIndex;
		if (_structIndex != -1) then
		{
			_structArray = GW_CONSTRUCT_BASESTRUCT select _structIndex;
			if (_structArray select 14) then {_localBuildArray pushBack [_x, "Base", (_structArray select 1)]};
		};
	} forEach GW_CVAR_BUILDINGS_BASE;
	
	//Friendly players (Matters if hostiles are present)
	_sideMembers = [GW_CVAR_SIDE, "obj"] Call fnc_shr_getSideMembers;
	_sideMembers = _sideMembers - [player];
	{
		_hostiles = [GW_CVAR_SIDE, (getPosATL _x), 30] Call fnc_shr_getHostilesInArea;
		if (_hostiles == 0) then 
		{
			_localBuildIndex = [_x, 0, _localBuildArray] Call fnc_shr_arrayGetIndex;
			if (_localBuildIndex != -1) then {_localBuildArray pushBack [_x, "Player", (name _x)]};
		};
	} forEach _sideMembers;
	
	//Spawnable vehicles (Matters if hostiles are present, has to be close to player's current)
	{
		if ((GW_COMMREDEP_POS distance _x) < GW_COMMREDEP_DISTANCE) then
		{
			_hostiles = [GW_CVAR_SIDE, (getPosATL _x), 30] Call fnc_shr_getHostilesInArea;
			if (_hostiles == 0) then 
			{
				_localBuildIndex = [_x, 0, _localBuildArray] Call fnc_shr_arrayGetIndex;
				if (_localBuildIndex != -1) then {_localBuildArray pushBack [_x, "SpawnVeh"]};
			};
		};
	} forEach GW_CVAR_SPAWNVEH;
	
	//Zones & their camps
	{
		_currentZone = _x;
		
		//Zone itself (requires frontline deployment)
		if (_sideHasFrontline) then
		{
			if ((GW_COMMREDEP_POS distance (_currentZone select 0)) < GW_COMMREDEP_DISTANCE) then
			{
				_hostiles = [GW_CVAR_SIDE, (getPosATL (_currentZone select 0)), 100] Call fnc_shr_getHostilesInArea;
				if (_hostiles == 0) then {_localBuildArray pushBack [(_currentZone select 0), "Depot", (_currentZone select 3)]};
			};
		};
		
		//Camps
		{
			if ((_x select 3) == GW_CVAR_SIDE) then
			{
				if ((GW_COMMREDEP_POS distance (_x select 0)) < GW_COMMREDEP_DISTANCE) then
				{
					_hostiles = 0; //[GW_CVAR_SIDE, (getPosATL (_x select 0)), 20] Call fnc_shr_getHostilesInArea;
					if (_hostiles == 0) then {_localBuildArray pushBack [(_x select 0), "Camp", (_currentZone select 3)]};
				};
			};
		} forEach (_currentZone select 6);
	} forEach GW_ZONES_STUB;
	
	//Replace prior selections
	GW_COMMREDEP_AVAILABLE =+ _localBuildArray;
	{deleteMarkerLocal _x} forEach GW_COMMREDEP_MARKERS;
	GW_COMMREDEP_MARKERS = [];
	
	//Create new markers
	{
		_depMarker = createMarkerLocal [format["DeploymentMarker_%1",(_x select 0)], (getPosATL (_x select 0))];
		_depMarker setMarkerColorLocal "ColorYellow";
		_depMarker setMarkerTypeLocal "Select";
		_depMarker setMarkerSizeLocal [1, 1];
		_depMarker setMarkerAlphaLocal 1;
		GW_COMMREDEP_MARKERS pushBack _depMarker;
	} forEach GW_COMMREDEP_AVAILABLE;
};

//Select a deployment point by checking the user's click position on the map to the nearest deployment marker
fnc_commRedep_selectSpawn =
{
	private ["_clickPos", "_spawnPosSorted", "_nearest"];
	_clickPos = _this;
	
	_spawnPosSorted = [_clickPos, GW_COMMREDEP_AVAILABLE, 0] Call fnc_shr_sortArrayByDistance;
	if ((count _spawnPosSorted) > 0) then
	{
		_nearest = _spawnPosSorted select 0;
		if ((_clickPos distance (_nearest select 0)) <= 200) then
		{
			GW_COMMREDEP_SELECTED_ARRAY = _nearest;
			GW_COMMREDEP_SELECTED_MARKER setMarkerColorLocal "ColorYellow";
			GW_COMMREDEP_SELECTED_MARKER = format["DeploymentMarker_%1",(_nearest select 0)];
	        playSound "UISuccess"; 
		}
		else
		{
			GW_COMMREDEP_SELECTED_ARRAY = [];
			GW_COMMREDEP_SELECTED_MARKER setMarkerColorLocal "ColorYellow";
			GW_COMMREDEP_SELECTED_MARKER = "";
			playSound "UIFail";
		};
	}
	else
	{
		GW_COMMREDEP_SELECTED_ARRAY = [];
		GW_COMMREDEP_SELECTED_MARKER setMarkerColorLocal "ColorYellow";
		GW_COMMREDEP_SELECTED_MARKER = "";
		playSound "UIFail";
	};
	
	[] Spawn fnc_commRedep_animateDeploymentMarker;
};

//Verify spawn location is still valid
fnc_commRedep_verifySelection =
{
	if ((count GW_COMMREDEP_SELECTED_ARRAY) > 0) then
	{
		_availIndex = [(GW_COMMREDEP_SELECTED_ARRAY select 0), 0, GW_COMMREDEP_AVAILABLE] Call fnc_shr_arrayGetIndex;
		if (_availIndex == -1) then
		{
			GW_COMMREDEP_SELECTED_ARRAY = [];
			GW_COMMREDEP_SELECTED_MARKER setMarkerColorLocal "ColorYellow";
			GW_COMMREDEP_SELECTED_MARKER = "";
			playSound "UIFail";
		};
	};
};

//Updater Loop
_updateAvailable = 0;
_updateDeploymentDistance = 3;
while {dialog} do
{
	//If player dies, close dialog
	if (!alive player) exitWith {closeDialog 60011};
	
	//Update available spawn locations
	if (_updateAvailable < 0.1) then
	{
		_buildAvail = [] Spawn fnc_commRedep_buildAvailableSpawns;
		waitUntil {scriptDone _buildAvail};
		
		_verifySelection = [] Spawn fnc_commRedep_verifySelection;
		waitUntil {scriptDone _verifySelection};
		
		_updateAvailable = 1;
	} else {_updateAvailable = _updateAvailable - 0.1};
	
	//Update deployment distance
	if (_updateDeploymentDistance < 0.1) then
	{
		GW_COMMREDEP_DISTANCE = GW_CVAR_SIDE Call fnc_shr_getFrontlineDepDistance;
		_updateDeploymentDistance = 3;
	} else {_updateDeploymentDistance = _updateDeploymentDistance - 0.1};
	
	//Update Marker Positions (Only for MHQ, Medics and Spawn vehicles as they are the only ones that can move)
	{
		if ((_x select 1 == "MHQ") || (_x select 1 == "Medic") || (_x select 1 == "SpawnVeh")) then
		{
			_depMarker = format ["DeploymentMarker_%1",(_x select 0)];
			if (!isNil "_depMarker") then {_depMarker setMarkerPosLocal (getPosATL (_x select 0))};
		};
	} forEach GW_COMMREDEP_AVAILABLE;
	
	//Map Clicked (Choosing a deployment location)
	if (GW_MAPCLICK == 0) then
	{
		GW_MAPCLICK = -1;
		
		//Select a spawn
		_clickPos = _map PosScreenToWorld[GW_MOUSEX, GW_MOUSEY];
		_deploymentSelect = _clickPos Spawn fnc_commRedep_selectSpawn;
	};
	
	//Update spawn text and button
	_spawnTextCTRL = _display displayCtrl 1102;
	if ((count GW_COMMREDEP_SELECTED_ARRAY) > 0) then
	{
		_redeployBtn ctrlEnable true;
		switch(GW_COMMREDEP_SELECTED_ARRAY select 1) do
		{
			case "MHQ":
			{
				_spawnTextCTRL ctrlSetStructuredText (parseText format ["Deploy on Mobile Headquarters"]);
			};
			
			case "Base":
			{
				_spawnTextCTRL ctrlSetStructuredText (parseText format ["Deploy on Base Structure - %1",(GW_COMMREDEP_SELECTED_ARRAY select 2)]);
			};
			
			case "SpawnVeh":
			{
				_spawnTextCTRL ctrlSetStructuredText (parseText format ["Deploy on Mobile Spawn - %1",getText (configFile >> "CfgVehicles" >> (typeOf (GW_COMMREDEP_SELECTED_ARRAY select 0)) >> "displayName")]);
			};
			
			case "Camp":
			{
				_spawnTextCTRL ctrlSetStructuredText (parseText format ["Deploy on Camp in %1",(GW_COMMREDEP_SELECTED_ARRAY select 2)]);
			};
			
			case "Player":
			{
				_spawnTextCTRL ctrlSetStructuredText (parseText format ["Deploy on Player - %1",(GW_COMMREDEP_SELECTED_ARRAY select 2)]);
			};
		};
	}
	else
	{
		_redeployBtn ctrlEnable false;
		_spawnTextCTRL ctrlSetStructuredText (parseText format ["No Deployment Selected"]);
	};
	
	//Deploy button clicked
	if (GW_COMMREDEP_SELECTED) then
	{
		GW_COMMREDEP_SELECTED = false;

		//Close the dialog
		closeDialog 60002;
		
		//Begin action
		GW_COMMREDEP_SELECTED_ARRAY Spawn
		{
			GW_CVAR_ACTION = ["Redeploying", 5, 5];
			
			_completed = true;
			while {true} do
			{
				//Fail Conditions
				if (!alive player) exitWith {_completed = false};
				if ((count GW_CVAR_ACTION) <= 0) exitWith {_completed = false};
				
				//Success Condition
				if (GW_CVAR_ACTION select 1 <= 0) exitWith {_completed = true};
				
				//Update
				GW_CVAR_ACTION set [1, (GW_CVAR_ACTION select 1) - 0.05];
				sleep 0.05;
			};
			
			GW_CVAR_ACTION = [];
			
			if (_completed) then
			{
				/*
				GW_COMMREDEPLOY_RETURN = ["GW_NETCALL_WAITING"];
				_commRedeployNetCall = ["team","commredeploy",(GW_CVAR_SIDE),"GW_COMMREDEPLOY_RETURN"] Spawn fnc_clt_requestServerExec;
				waitUntil {scriptDone _commRedeployNetCall};
				*/
				GW_COMMREDEPLOY_RETURN = [true,""];
				
				if (GW_COMMREDEPLOY_RETURN select 0) then
				{
					_putInside = false;
					if ((_this select 1) == "SpawnVeh") then
					{
						//Try to put player inside
						player action ["GetInCargo", (_this select 0)];
						
						//Give it 1 second before reverting back to old logic
						_timeout = 1;
						while {_timeout > 0} do
						{
							if (player in (crew (_this select 0))) exitWith {_putInside = true};
							uiSleep 1;
							_timeout = _timeout - 1;
						};
					};
					
					if (!_putInside) then
					{
						_spawnPos = getPosATL (_this select 0);
						_randomPos = [_spawnPos, random(35 * 0.25), 35, false, (typeOf player)] Call fnc_shr_getRandPos;
						while {(_randomPos select 0) == -1} do
						{
							_randomPos = [_spawnPos, random(35 * 0.25), 35, false, (typeOf player)] Call fnc_shr_getRandPos;
						};
						_randomPos set [2, 0];
						player setPosATL _randomPos;
						player setDir (random 360);
					};
					
					playSound "UISuccess";
				}
				else
				{
					playSound "UIFail";
					systemChat format["Unable to Redeploy - %1",GW_COMMREDEPLOY_RETURN select 1];
				};
			}
			else
			{
				systemChat "Action not completed!";
			};
		};
	};
	
	sleep 0.1;
};

//Delete Markers
{deleteMarkerLocal _x} forEach GW_COMMREDEP_MARKERS;
GW_COMMREDEP_MARKERS = [];
