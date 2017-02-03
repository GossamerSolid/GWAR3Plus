//GWAR3 Menu
GW_CVAR_ACTION_GWAR3MENU = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='Resources\images\action_menu.paa'
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Warfare Menu
	</t>",
	
	//Action Script
	{
		createDialog "UI_Menu";
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_GWAR3MENU
	'
];

//Unlock vehicle
GW_CVAR_ACTION_UNLOCKVEHICLE = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='Resources\images\unlock.paa'
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Unlock Vehicle
	</t>",
	
	//Action Script
	{
		_near = nearestObjects [(getPosATL player), ["Car","Tank","Air","Ship"], 7];
		if ((count _near) > 0) then 
		{
			_nearest = _near select 0;
			if (_nearest == GW_CVAR_MHQ) then
			{
				if (GW_CVAR_COMMANDER == (vehicleVarName player)) then {_nearest lock false};
			}
			else
			{
				_ownerUID = _nearest getVariable "GW_VEHOWNER";
				if (_ownerUID == getPlayerUID player) then {_nearest lock false};
			};
		};
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_UNLOCKVEHICLE
	'
];

//Lock vehicle
GW_CVAR_ACTION_LOCKVEHICLE = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='Resources\images\lock.paa'
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Lock Vehicle
	</t>",
	
	//Action Script
	{
		_near = nearestObjects [(getPosATL player), ["Car","Tank","Air","Ship"], 7];
		if ((count _near) > 0) then 
		{
			_nearest = _near select 0;
			if (_nearest == GW_CVAR_MHQ) then
			{
				if (GW_CVAR_COMMANDER == (vehicleVarName player)) then {_nearest lock true};
			}
			else
			{
				_ownerUID = _nearest getVariable "GW_VEHOWNER";
				if (_ownerUID == getPlayerUID player) then {_nearest lock true};
			};
		};
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_LOCKVEHICLE
	'
];

//Flip a vehicle
GW_CVAR_ACTION_FLIPVEHICLE = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='Resources\images\engineer.paa'
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Flip Vehicle
	</t>",
	
	//Action Script
	{
		_near = nearestObjects [(getPosATL player), ["Car","Tank","Ship"], 7];
		if ((count _near) > 0) then 
		{
			_nearest = _near select 0;
			_nearest setVectorUp [0,0,1];
			_nearest setPosATL [(getPosATL _nearest) select 0, (getPosATL _nearest) select 1, 0];  
		};
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_FLIPVEHICLE
	'
];

//Recruit from Town Defenses
GW_CVAR_ACTION_RECRUITDEFENDERS = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='Resources\images\squad_size.paa'
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Recruit Defender
	</t>",
	
	//Action Script
	{
		_near = nearestObjects [(getPosATL player), ["Air","Car","Tank","Ship",GW_DATA_INFANTRYCLASS_EAST,GW_DATA_INFANTRYCLASS_GUER,GW_DATA_INFANTRYCLASS_WEST], 7];
		if ((count _near) > 1 && ((player getVariable ["GW_SPECIALIZATION", ""]) == "Officer")) then 
		{
			_near deleteAt 0;
			_nearest = _near select 0;
			_squadCount = if (_nearest isKindOf "Man") then {1} else {count(crew(vehicle _nearest))};
			_squadSize = player Call fnc_shr_getSquadSize;
			if ((_squadSize + _squadCount) > GW_CVAR_MAXSQUADSIZE) then
			{
				playSound "UIFail";
				systemChat "Unable to recruit defender - Not enough room in squad";
			}
			else
			{
				playSound "UISuccess";
				if (_nearest isKindOf "Man") then
				{
					[_nearest] joinSilent (group player);
					_nearest setVariable ["GW_TOWNDEFENDER", nil, true];
				}
				else
				{
					{
						[_x] joinSilent (group player);
						_x setVariable ["GW_TOWNDEFENDER", nil, true];
					} forEach (crew _nearest);
					
					(vehicle _nearest) setVariable ["GW_TOWNDEFENDER", nil, true];
				};
			};
		};
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_RECRUITDEFENDERS
	'
];

//Special Forces
GW_CVAR_ACTION_SPECIALFORCES = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='Resources\images\squad_size.paa'
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Call in Special Forces
	</t>",
	
	//Action Script
	{
		[] Spawn fnc_clt_specialForcesCallIn;
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_SPECIALFORCES
	'
];

//Heal Self
GW_CVAR_ACTION_HEALSELF = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='Resources\images\heal.paa'
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Heal Self
	</t>",
	
	//Action Script
	{
		player Spawn fnc_clt_healUnit;
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_HEALSELF
	'
];

//Heal Friendly
GW_CVAR_ACTION_HEALFRIENDLY = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='Resources\images\heal.paa'
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Heal Friendly
	</t>",
	
	//Action Script
	{
		cursorTarget Spawn fnc_clt_healUnit;
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_HEALFRIENDLY
	'
];

//Repair Vehicle
GW_CVAR_ACTION_REPAIRVEHICLE = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='Resources\images\wrench.paa'
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Repair Vehicle
	</t>",
	
	//Action Script
	{
		cursorTarget Spawn fnc_clt_repairVehicle;
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_REPAIRVEHICLE
	'
];

//Salvage Vehicle
GW_CVAR_ACTION_SALVAGEVEHICLE = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='Resources\images\wrench.paa'
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Salvage Vehicle
	</t>",
	
	//Action Script
	{
		cursorTarget Spawn fnc_clt_salvageVehicle;
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_SALVAGEVEHICLE
	'
];

//Commander Redeploy
GW_CVAR_ACTION_COMMANDERREDEPLOY = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='\a3\ui_f\data\gui\cfg\Ranks\general_gs.paa'
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Commander Redeploy
	</t>",
	
	//Action Script
	{
		createDialog "UI_CommanderRedeploy";
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_COMMANDERREDEPLOY
	'
];

//Construction
GW_CVAR_ACTION_CONSTRUCTION = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='" + GW_MISSIONROOT + "Resources\images\engineer.paa'" + "
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Construction
	</t>",
	
	//Action Script
	{
		_canBuild = player Call fnc_clt_canBuild;
		if (_canBuild select 0) then 
		{
			GW_CONSTRUCT_ORIGINTYPE = "MHQ";
		}
		else
		{
			_canBuildSupport = player Call fnc_clt_canBuildSupport;
			if (_canBuildSupport select 0) then {GW_CONSTRUCT_ORIGINTYPE = "SUPPORT"};
		};
		
		createDialog "UI_Construction";
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_CONSTRUCTION
	'
];

//Attaching System - Attach an object to our towing vehicle
GW_CVAR_ACTION_ATTACH = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='" + GW_MISSIONROOT + "Resources\images\attach.paa'" + "
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Attach
	</t>",
	
	//Action Script
	{
		GW_ATTACH_ORIGINVEH = vehicle player;
		createDialog "UI_Attach";
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_ATTACH
	'
];

//Attaching System - Detach object attached to our towing vehicle
GW_CVAR_ACTION_DETACH = false;
player addAction 
[
	//Display Text
	"<img 
		size='1' 
		color='#FFFFFF' 
		shadow='1' 
		image='" + GW_MISSIONROOT + "Resources\images\detach.paa'" + "
	/>
	<t
		size='1'
		color='#3299CC'
		shadow='2'
	>Detach
	</t>",
	
	//Action Script
	{
		(vehicle player) Spawn fnc_clt_detachVehicle;
	},
	
	//?
	"",
	
	//Action Menu Priority
	1,
	
	//?
	false,
	
	//Hide on usage
	true,
	
	//?
	"",
	
	//Conditional Script (Must return a boolean)
	'
		GW_CVAR_ACTION_DETACH
	'
];