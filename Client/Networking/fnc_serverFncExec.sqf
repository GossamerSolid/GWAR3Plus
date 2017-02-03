//fnc_serverFncExec.sqf
//Written by: GossamerSolid
//Used for allowing the server to ask the client to execute code
//Since this executes dynamic code, the parameters will be searched for malicious strings (prevent unauthorized execution of code)

private["_dataType", "_dataRequest", "_dataArguments"];
_dataType = _this select 0;
_dataRequest = _this select 1;
_dataArguments = _this select 2;

//Check for malicious intent on behalf of the server (Never know why, but it might happen)
_maliciousIntent = false;
_badStrings = [";", "[", "]", "{", "}", "Spawn", "Call", "Exec", "ExecVM", "set"];
{
	_currentParam = _x;
	{
		_found = [_x,_currentParam] Call fnc_shr_inString;
		if (_found) exitWith {_maliciousIntent = true};
	} forEach _badStrings;
	if (_maliciousIntent) exitWith {};
} forEach [_dataType, _dataRequest, _dataArguments];

if (!_maliciousIntent) then
{
	switch (_dataType) do
	{
		//Messages
		case "messages":
		{	
			_dataArguments Spawn fnc_clt_messages;
		};
		
		//Marked objects
		case "markedobjects":
		{
			private["_markedArray", "_prevMarkedObjs", "_objectIndex"];
			_markedArray =+ _dataArguments;
			
			//Prevent duplicate objects
			{
				_objectIndex = [(_x select 0), 0, GW_CVAR_MARKEDOBJECTS] Call fnc_shr_arrayGetIndex;
				if (_objectIndex == -1) then 
				{
					_x set [4, time];
					GW_CVAR_MARKEDOBJECTS pushBack _x;
					(group player) reveal [(_x select 0), 4]; 
				}
				else
				{
					_preSave =+ GW_CVAR_MARKEDOBJECTS select _objectIndex;
					_preSave set [4, time];
					GW_CVAR_MARKEDOBJECTS set [_objectIndex, _preSave];
					(group player) reveal [(_x select 0), 4]; 
				};
			} forEach _markedArray;
		};
		
		//Get an infantry in your group
		//NOTE: This used to work perfectly fine on the server, but for some reason as of the last patch, it needs to APPARENTLY be done client side - FUCK SAKES
		case "createInfantry":
		{
			private["_loadoutName", "_infSide", "_buildPos", "_unitClassname", "_infantryArray", "_infantryLoadout", "_unit", "_unitEquipScript"];
			_loadoutName = _dataArguments select 0;
			_infSide = _dataArguments select 1;
			_buildPos = _dataArguments select 2;
			
			//Get the unit classname
			_unitClassname = (Call Compile Format ["GW_DATA_INFANTRYCLASS_%1", _infSide]);
			
			//Get the loadout array
			_infantryArray = [_loadoutName, _infSide] Call fnc_shr_getInfantryArray;
			_infantryLoadout = _infantryArray select 3;
			
			//Create the unit
			_unit = (group player) createUnit [_unitClassname, _buildPos, [], 0, "FORM"];
			_unit setVariable ["GW_SIDE", GW_CVAR_SIDE, true];
			
			//Put on ground
			_unit setPosATL [_buildPos select 0, _buildPos select 1, 0];
			
			//Equip
			_unitEquipScript = [_unit, _infantryLoadout] spawn fnc_shr_equipUnit;
			waitUntil{scriptDone _unitEquipScript};
			
			//Add killed EH
			if (GW_CVAR_SIDE == west) then {_unit addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, west] Call fnc_srv_unitKilled;};}]};
			if (GW_CVAR_SIDE == east) then {_unit addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, east] Call fnc_srv_unitKilled;};}]};
			if (GW_CVAR_SIDE == guer) then {_unit addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, guer] Call fnc_srv_unitKilled;};}]};
			
			//Engage at will
			_unit setCombatMode "RED";

			//Put loadout var on object
			_unit setVariable ["GW_INFANTRYLOADOUT", _infantryArray select 0, true];
			
			//Make less godly
			_unit setSkill ["aimingAccuracy", 0.55];
		};
		
		//Fill purchased vehicle with crew
		case "fillVehicle":
		{
			private["_vehObj", "_crewSelectArray", "_vehicleArray", "_vehUID"];
			_vehObj = _dataArguments select 0;
			_crewSelectArray = _dataArguments select 1;
			_vehicleArray = [];
			
			//Get vehicle array
			_vehUID = _vehObj getVariable ["GW_UNIQUEID", ""];
			if (_vehUID != "") then
			{
				_vehIndex = [_vehUID, 11, GW_VEHICLES] Call fnc_shr_arrayGetIndex;
				if (_vehIndex != -1) then
				{
					_vehicleArray = GW_VEHICLES select _vehIndex;
				};
			};
			if ((count _vehicleArray) == 0) exitWith {systemChat format ["Failed to crew vehicle - Unable to get Vehicle's UID"]};
			
			//Build Crew
			{
				if (_x) then
				{
					//Get loadout of crewmen
					_crewClass = (Call Compile Format ["GW_INFANTRY_%1",(_vehicleArray select 13)]);
					_infantryArray = [_crewClass, GW_CVAR_SIDE] Call fnc_shr_getInfantryArray;
					_infantryLoadout = _infantryArray select 3;
						
					//Get the unit classname
					_unitClassname = (Call Compile Format ["GW_DATA_INFANTRYCLASS_%1",GW_CVAR_SIDE]);

					//Create the crew member
					_crew = (group player) createUnit [_unitClassname, [0,0,500 + random(3000)], [], 0, "FORM"];
					_crew setVariable ["GW_SIDE",GW_CVAR_SIDE, true];
					if (GW_CVAR_SIDE == west) then {_crew addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, west] Call fnc_srv_unitKilled};}]};
					if (GW_CVAR_SIDE == east) then {_crew addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, east] Call fnc_srv_unitKilled};}]};
					if (GW_CVAR_SIDE == guer) then {_crew addMPEventHandler ["MPKilled",{if (isServer) then {[_this select 0, _this select 1, guer] Call fnc_srv_unitKilled};}]};
					_equipScript = [_crew, _infantryLoadout] Spawn fnc_shr_equipUnit;
					waitUntil {scriptDone _equipScript};
					_crew setCombatMode "RED";
					
					//Put loadout var on object
					_crew setVariable ["GW_INFANTRYLOADOUT", _infantryArray select 0, true];
					
					//Make less godly
					_crew setSkill ["aimingAccuracy", 0.55];
					
					//Put crew inside of vehicle
					switch (_forEachIndex) do
					{
						case 0: {_crew action ["getInDriver", _vehObj]; _crew assignAsDriver _vehObj;};
						case 1: {_crew action ["getInGunner", _vehObj]; _crew assignAsGunner _vehObj;};
						case 2: {_crew action ["getInCommander", _vehObj]; _crew assignAsCommander _vehObj;};
						case 3: {_crew action ["getInTurret", _vehObj, [0]]; _crew assignAsTurret [_vehObj, [0]];};
					};
				};
			} forEach _crewSelectArray;
		};
		
		//Local Marker
		case "marker":
		{
			_markerObjRef = _dataArguments select 0; //Pass this if you want the marker to be bound to an object
			_markerPos = _dataArguments select 1;
			_markerSize = _dataArguments select 2;
			_markerLook = _dataArguments select 3; //["Shape","Ellipse","Border"] or ["Class","GWAR3_StructBlah"]
			_markerColor = _dataArguments select 4;
			_markerDirection = _dataArguments select 5;
			_markerAlpha = _dataArguments select 6;
			_markerText = _dataArguments select 7;
			_markerTimeout = _dataArguments select 8; //Set to -1 for no timeout
			_markerSound = _dataArguments select 9; //"" for no sound

			//If we have a marker name passed, check for duplicate
			_isDuplicate = false;
			if (!isNull _markerObjRef) then
			{
				//Duplicate Marker
				_dupMarkerName = format["MarkerLocal_%1",_markerObjRef];
				_dupMarkerPos = getMarkerPos _dupMarkerName;
				
				if ((_dupMarkerPos select 0) != 0) then {_isDuplicate = true};
			};

			if (!_isDuplicate) then
			{
				_markerName = if (!isNull _markerObjRef) then {format["MarkerLocal_%1",_markerObjRef]} else {format["MarkerLocal_Pos_%1",round(random(100000))]};
				_newMarker = createMarkerLocal [_markerName, _markerPos];
				_newMarker setMarkerSizeLocal _markerSize;
				_newMarker setMarkerColorLocal _markerColor;
				_newMarker setMarkerAlphaLocal _markerAlpha;
				_newMarker setMarkerDirLocal _markerDirection;
				
				if ((_markerLook select 0) == "Shape") then
				{
					_newMarker setMarkerShapeLocal (_markerLook select 1);
					_newMarker setMarkerBrushLocal (_markerLook select 2);
				}
				else
				{
					_newMarker setMarkerTypeLocal (_markerLook select 1);
				};
				
				if (_markerText != "") then
				{
					_newMarker setMarkerTextLocal _markerText;
				};
				
				if (_markerSound != "") then
				{
					playSound _markerSound;
				};
				
				//Update the marker
				if (!isNull _markerObjRef) then
				{
					[_markerObjRef, _markerTimeout, _newMarker] Spawn
					{
						private["_timeout", "_objPos"];
						//If there is a timeout
						_timeout = if ((_this select 1) != -1) then {_this select 1} else {-1};
						
						//Update
						while {true} do
						{
							//Update every second
							sleep 1;
							if (_timeout != -1) then {_timeout = _timeout - 1};
							
							//Stop drawing if object doesn't exist or is dead or the time is up
							if (isNull (_this select 0)) exitWith {deleteMarkerLocal (_this select 2)};
							if (!alive (_this select 0)) exitWith {deleteMarkerLocal (_this select 2)};
							if (_timeout == 0) exitWith {deleteMarkerLocal (_this select 2)};
							
							//Update marker pos and dir
							_objPos = getPosASL (_this select 0);
							(_this select 2) setMarkerPosLocal [_objPos select 0, _objPos select 1];
							(_this select 2) setMarkerDirLocal (getDir (_this select 0));
						};
						
						
					};
				}
				else
				{
					if (_markerTimeout != -1) then
					{
						[_markerName, _markerTimeout] Spawn
						{
							sleep (_this select 1);
							deleteMarkerLocal (_this select 0);
						};
					};
				};
			};
		};
		
		//Specialization change
		case "specialization":
		{
			switch (_dataRequest) do
			{
				case "add":
				{
					switch (_dataArguments) do
					{
						case "special forces":
						{
							player setFatigue 0;
							player enableFatigue false;
						};
					};
				};
				
				case "remove":
				{
					switch (_dataArguments) do
					{
						case "special forces":
						{
							player enableFatigue true;
						};
					};
				};
			};
		};
		
		//Team
		case "team":
		{	
			switch (_dataRequest) do
			{
				case "commvotestart":
				{
					_dataArguments Spawn fnc_clt_commanderVoteStart;
				};
				
				case "commvoted":
				{
					_dataArguments Spawn fnc_clt_commanderVoted;
				};
				
				case "commdisconnect":
				{
					_dataArguments Spawn fnc_clt_commanderDisconnected;
				};
			};
		};
		
		//Gamestate
		case "gamestate":
		{	
			switch (_dataRequest) do
			{
				case "endgame":
				{
					_dataArguments Spawn fnc_clt_endGame;
				};
			};
		};
		
		//Structure
		case "structure":
		{	
			switch (_dataRequest) do
			{
				case "created":
				{
					_dataArguments Spawn fnc_clt_structureCreated;
				};
				
				case "destroyed":
				{
					_dataArguments Spawn fnc_clt_structureDestroyed;
				};
				
				case "damaged":
				{
					_dataArguments Spawn fnc_clt_structureDamaged;
				};
				
				case "teamkilled":
				{
					_dataArguments Spawn fnc_clt_structureTeamkilled;
				};
				
				case "productionblocked":
				{
					_dataArguments Spawn fnc_clt_objectBlockingConstruction;
				};
				
				case "commtowerinit":
				{
					_dataArguments Spawn fnc_clt_commTowerBuilt;
				};
				
				case "commtowerdestroyed":
				{
					_dataArguments Spawn fnc_clt_commTowerDestroyed;
				};
			};
		};
		
		//Zone
		case "zone":
		{
			switch (_dataRequest) do
			{
				case "captured":
				{
					_dataArguments Spawn fnc_clt_zoneCaptured;
				};
			};
		};
		
		//Camp
		case "camp":
		{
			switch (_dataRequest) do
			{
				case "captured":
				{
					_dataArguments Spawn fnc_clt_campCaptured;
				};
			};
		};
	};
};