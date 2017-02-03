while {GW_GAMERUNNING} do
{
	//GWAR3 Menu
	GW_CVAR_ACTION_GWAR3MENU = if (alive player) then {true} else {false};

	//Unlock Vehicle
	private["_near","_nearest","_ownerUID"];
	GW_CVAR_ACTION_UNLOCKVEHICLE = false;
	_near = nearestObjects [(getPosATL player), ["Car","Tank","Air","Ship"], 7];
	if ((count _near) > 0) then 
	{
		_nearest = _near select 0;
		if (_nearest == GW_CVAR_MHQ) then
		{
			if (((locked _nearest) == 2) && (GW_CVAR_COMMANDER == (vehicleVarName player))) then {GW_CVAR_ACTION_UNLOCKVEHICLE = true};
		}
		else
		{
			_ownerUID = _nearest getVariable ["GW_VEHOWNER",""];
			if (((locked _nearest) == 2) && (_ownerUID == getPlayerUID player) && (!(_nearest getVariable ["GW_UAV", false]))) then {GW_CVAR_ACTION_UNLOCKVEHICLE = true};
		};
	};

	//Lock Vehicle
	private["_near","_nearest","_ownerUID"];
	GW_CVAR_ACTION_LOCKVEHICLE = false;
	_near = nearestObjects [(getPosATL player), ["Car","Tank","Air","Ship"], 7];
	if ((count _near) > 0) then 
	{
		_nearest = _near select 0;
		if (_nearest == GW_CVAR_MHQ) then
		{
			if (((locked _nearest) == 1) && (GW_CVAR_COMMANDER == (vehicleVarName player))) then {GW_CVAR_ACTION_LOCKVEHICLE = true};
		}
		else
		{
			_ownerUID = _nearest getVariable ["GW_VEHOWNER",""];
			if (((locked _nearest) == 1) && (_ownerUID == getPlayerUID player) && (!(_nearest getVariable ["GW_UAV", false]))) then {GW_CVAR_ACTION_LOCKVEHICLE = true};
		};
	};

	//Flip Vehicle
	private["_near"];
	GW_CVAR_ACTION_FLIPVEHICLE = false;
	if ((vehicle player) == player) then
	{
		_near = nearestObjects [(getPosATL player), ["Car","Tank","Ship"], 7];
		if ((count _near) > 0) then 
		{
			GW_CVAR_ACTION_FLIPVEHICLE = true;
		};
	};

	//Recruit Zone Defenders
	private["_near","_nearest"];
	GW_CVAR_ACTION_RECRUITDEFENDERS = false;
	_near = nearestObjects [(getPosATL player), ["Air","Car","Tank","Ship",GW_DATA_INFANTRYCLASS_EAST,GW_DATA_INFANTRYCLASS_GUER,GW_DATA_INFANTRYCLASS_WEST], 7];
	if ((count _near) > 1 && ((player getVariable ["GW_SPECIALIZATION", ""]) == "Officer")) then 
	{
		_near deleteAt 0;
		_nearest = _near select 0;
		if (((_nearest getVariable ["GW_SIDE", civ]) == GW_CVAR_SIDE) && (_nearest getVariable ["GW_TOWNDEFENDER", false])) then {GW_CVAR_ACTION_RECRUITDEFENDERS = true};
	};

	//Call in Special Forces
	GW_CVAR_ACTION_SPECIALFORCES = false;
	if ((player getVariable ["GW_SPECIALIZATION", ""]) == "Special Forces") then 
	{
		if ((GW_CVAR_SPECIALIZATION_TIME == -1) || ((time - GW_CVAR_SPECIALIZATION_TIME) > GW_GVAR_SPECIALFORCES_TIMEOUT)) then {GW_CVAR_ACTION_SPECIALFORCES = true};
	};

	//Heal Self
	private["_near","_nearest","_playerItems"];
	GW_CVAR_ACTION_HEALSELF = false;
	if ((count GW_CVAR_ACTION) == 0) then
	{
		if ((vehicle player) == player) then
		{
			if (damage player > 0) then
			{
				//If player is a medic they can always heal
				if ((player getVariable ["GW_SPECIALIZATION", ""]) == "Medic") then 
				{
					GW_CVAR_ACTION_HEALSELF = true;
				}
				else
				{
					//Check for medical truck
					_near = nearestObjects [(getPosATL player), ["Car","Tank","Ship"], 7];
					if ((count _near) > 0) then 
					{
						_nearest = _near select 0;
						if (((_nearest isKindOf GW_DATA_MEDICALTRUCK_WEST) || (_nearest isKindOf GW_DATA_MEDICALTRUCK_EAST)) && alive _nearest) then {GW_CVAR_ACTION_HEALSELF = true};
					};
					
					//Inventory items for healing
					if (!GW_CVAR_ACTION_HEALSELF) then
					{
						_playerItems = items player;
						if ((("FirstAidKit" in _playerItems) || ("Medikit" in _playerItems))) then {GW_CVAR_ACTION_HEALSELF = true};
					};
				};
			};
		};
	};

	//Heal Friendly
	private["_playerItems"];
	GW_CVAR_ACTION_HEALFRIENDLY = false;	
	if ((count GW_CVAR_ACTION) == 0) then
	{
		if ((vehicle player) == player) then
		{
			if (alive cursorTarget) then
			{
				if ((damage cursorTarget) > 0) then
				{
					//Medic can always perform heal
					if ((player getVariable ["GW_SPECIALIZATION", ""]) == "Medic") then
					{
						GW_CVAR_ACTION_HEALFRIENDLY = true;
					}
					else
					{
						_playerItems = items player;
						if (("FirstAidKit" in _playerItems) || ("Medikit" in _playerItems)) then
						{
							if (((player distance cursorTarget) <= 3) && ((cursorTarget getVariable ["GW_SIDE", civ]) == GW_CVAR_SIDE) && (cursorTarget isKindOf "Man")) then {GW_CVAR_ACTION_HEALFRIENDLY = true};
						};
					};
				};
			};
		};
	};

	//Repair Vehicle
	private["_playerItems"];
	GW_CVAR_ACTION_REPAIRVEHICLE = false;
	if ((count GW_CVAR_ACTION) == 0) then
	{
		if ((vehicle player) == player) then
		{
			if ((alive cursorTarget) && ((player distance cursorTarget) <= 7)) then
			{
				//Engineer can always repair
				if ((player getVariable ["GW_SPECIALIZATION", ""]) == "Engineer") then
				{
					GW_CVAR_ACTION_REPAIRVEHICLE = true;
				}
				else
				{
					_playerItems = items player;
					if ("ToolKit" in _playerItems) then
					{
						if ((player distance cursorTarget) <= 7) then
						{
							if ((cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Tank") || (cursorTarget isKindOf "Air") || (cursorTarget isKindOf "Ship")) then {GW_CVAR_ACTION_REPAIRVEHICLE = true};
						};
					};
				};
			};
		};
	};

	//Salvage Vehicle
	private["_playerItems"];
	GW_CVAR_ACTION_SALVAGEVEHICLE = false;
	if (((count GW_CVAR_ACTION) == 0) && ((player getVariable ["GW_SPECIALIZATION", ""]) == "Engineer")) then
	{
		if ((vehicle player) == player) then
		{
			if (!(alive cursorTarget)) then
			{
				_playerItems = items player;
				if ("ToolKit" in _playerItems) then
				{
					if ((player distance cursorTarget) <= 10 && (cursorTarget != GW_CVAR_MHQ)) then
					{
						if ((cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Tank") || (cursorTarget isKindOf "Air") || (cursorTarget isKindOf "Ship")) then {_ret = true};
					};
				};
			};
		};
	};

	//Commander Redeploy
	private["_commObj"];
	GW_CVAR_ACTION_COMMANDERREDEPLOY = false;
	if (GW_CVAR_COMMANDER != "nil") then
	{
		_commObj = missionNamespace getVariable GW_CVAR_COMMANDER;
		if (_commObj == player) then {GW_CVAR_ACTION_COMMANDERREDEPLOY = true};
	};

	//Construction
	private["_canBuild","_canBuildSupport"];
	GW_CVAR_ACTION_CONSTRUCTION = false;	
	_canBuild = player Call fnc_clt_canBuild;
	if (_canBuild select 0) then 
	{
		if ((vehicle player) == player) then {GW_CVAR_ACTION_CONSTRUCTION = true};
	}
	else
	{
		_canBuildSupport = player Call fnc_clt_canBuildSupport;
		if (_canBuildSupport select 0) then 
		{
			if ((vehicle player) == player) then {GW_CVAR_ACTION_CONSTRUCTION = true};
		};
	};

	//Attach
	GW_CVAR_ACTION_ATTACH = false;		
	if ((count GW_CVAR_ACTION) == 0) then
	{
		if ((vehicle player) != player) then
		{
			if ((vehicle player) getVariable ["GW_ATTACHING", false]) then
			{
				if (((vehicle player) getVariable ["GW_VEHOWNER", ""]) == getPlayerUID player) then
				{
					if ((count (attachedObjects (vehicle player))) <= 0) then
					{
						GW_CVAR_ACTION_ATTACH = true;
					};
				};
			};
		};
	};

	//Detach
	GW_CVAR_ACTION_DETACH = false;		
	if ((count GW_CVAR_ACTION) == 0) then
	{
		if ((vehicle player) != player) then
		{
			if ((vehicle player) getVariable ["GW_ATTACHING", false]) then
			{
				if (((vehicle player) getVariable ["GW_VEHOWNER", ""]) == getPlayerUID player) then
				{
					if ((count (attachedObjects (vehicle player))) > 0) then
					{
						GW_CVAR_ACTION_DETACH = true;
					};
				};
			};
		};
	};
	
	//100ms in between updates
	uiSleep 0.1;
};