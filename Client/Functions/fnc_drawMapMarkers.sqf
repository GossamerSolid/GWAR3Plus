disableSerialization;
_mapControl = _this select 0;
_fullMap = _this select 1;

//Draw MHQ on map
if (_fullMap || (GW_CVAR_MINIMAP_DRAWDISTANCE >= player distance2D (ASLtoATL getPosASL GW_CVAR_MHQ))) then
{
	_mapControl drawIcon 
	[
		GW_MISSIONROOT + "Resources\images\struct_hq.paa",
		GW_CVAR_TEAM_COLOUR_RGBA,
		(ASLtoATL getPosASL GW_CVAR_MHQ),
		24,
		24,
		0,
		"",
		1,
		0.03,
		"PuristaMedium",
		"right"
	];
};

//Draw friendly markers
{
	if (_fullMap || (GW_CVAR_MINIMAP_DRAWDISTANCE >= (player distance2D (_x select 9)))) then
	{
		_mapControl drawIcon 
		[
			(_x select 1),
			(_x select 4),
			(_x select 0),
			24,
			24,
			(_x select 2),
			(_x select 3),
			1,
			0.035,
			"PuristaMedium",
			"right"
		];
	};
} forEach GW_CVAR_FRIENDLYMARKERS;

//Draw Zone & Camp markers
{
	switch (_x select 0) do
	{
		case "icon":
		{
			_mapControl drawIcon 
			[
				(_x select 1),
				(_x select 3),
				(_x select 5),
				(_x select 4) select 0,
				(_x select 4) select 1,
				0,
				(_x select 2),
				2,
				0.037,
				"PuristaMedium",
				"right"
			];
		};
		
		case "ellipse":
		{
			_mapControl drawEllipse
			[
				(_x select 4),
				(_x select 3),
				(_x select 3),
				0,
				(_x select 2),
				(_x select 1)
			];
		};
	};
} forEach GW_CVAR_ZONEMARKERS;

//Draw radar markers (This is updated every 15 seconds on the server)
if (GW_CVAR_COMMTOWER_INRANGE) then
{
	{
		if (_fullMap || (GW_CVAR_MINIMAP_DRAWDISTANCE >= (player distance2D (_x select 0)))) then
		{
			_mapControl drawIcon 
			[
				(_x select 1),
				(_x select 3),
				(_x select 0),
				24,
				24,
				(_x select 2),
				"",
				1,
				0.03,
				"PuristaMedium",
				"right"
			];
		};
	} forEach GW_CVAR_RADARMARKERS;
};

//Draw Base Structures
{
	if (_fullMap || (GW_CVAR_MINIMAP_DRAWDISTANCE >= (player distance2D _x))) then
	{
		_structUID = _x getVariable ["GW_STRUCTUID", ""];
		if (_structUID != "") then
		{
			_structIndex = [_structUID, 17, GW_CONSTRUCT_BASESTRUCT] Call fnc_shr_arrayGetIndex;
			if (_structIndex != -1) then
			{
				_structArray = GW_CONSTRUCT_BASESTRUCT select _structIndex;
				_icon = _structArray select 10;
				_mapControl drawIcon 
				[
					_icon,
					GW_CVAR_TEAM_COLOUR_RGBA,
					getPosASL _x,
					24,
					24,
					0,
					"",
					1,
					0.03,
					"PuristaMedium",
					"right"
				];
				
				//Draw radius of towers
				if ("Comm" in (_structArray select 21) || "Radar" in (_structArray select 21)) then
				{
					_rangeSize = _x getVariable ["GW_COMMRANGE", 0];
					if (_rangeSize > 0) then
					{
						_mapControl drawEllipse
						[
							getPosASL _x,
							_rangeSize,
							_rangeSize,
							0,
							[0,0,0,1],
							""
						];
					};
				};
			};
		};
	};
} forEach GW_CVAR_BUILDINGS_BASE;

//Draw Defensive Structures
{
	if (_fullMap || (GW_CVAR_MINIMAP_DRAWDISTANCE >= (player distance2D _x))) then
	{
		_structUID = _x getVariable ["GW_STRUCTUID", ""];
		if (_structUID != "") then
		{
			_structIndex = [_structUID, 17, GW_CONSTRUCT_DEFSTRUCT] Call fnc_shr_arrayGetIndex;
			if (_structIndex != -1) then
			{
				_structArray = GW_CONSTRUCT_DEFSTRUCT select _structIndex;
				_icon = getText(configFile >> "CfgVehicles" >> (typeOf (vehicle _x)) >> "Icon");
				_mapControl drawIcon 
				[
					_icon,
					GW_CVAR_TEAM_COLOUR_RGBA,
					getPosASL _x,
					24,
					24,
					(direction (vehicle _x)),
					(_structArray select 9),
					1,
					0.03,
					"PuristaMedium",
					"right"
				];
			};
		};
	};
} forEach GW_CVAR_BUILDINGS_DEF;