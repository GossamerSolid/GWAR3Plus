disableSerialization;
waitUntil {!isNull (findDisplay 46)}; 

//Attach
(findDisplay 46) displayAddEventHandler ["KeyDown", 
{
	_keyPressed = _this select 1;
	_shift = _this select 2;
	_ctrl = _this select 3;
	_alt = _this select 4;
	_dontPerformKeyStroke = false;

	//Minimap Zoom In (CTRL + Z)
	if (_ctrl && (_keyPressed == 44)) then
	{
		if (_shift) then {GW_CVAR_MINIMAP_ZOOM = GW_CVAR_MINIMAP_ZOOM - 0.005} else {GW_CVAR_MINIMAP_ZOOM = GW_CVAR_MINIMAP_ZOOM - 0.001};
		if (GW_CVAR_MINIMAP_ZOOM <= 0) then {GW_CVAR_MINIMAP_ZOOM = 0};
		_dontPerformKeyStroke = true;
	};
	
	//Minimap Zoom Out (CTRL + X)
	if (_ctrl && (_keyPressed == 45)) then
	{
		if (_shift) then {GW_CVAR_MINIMAP_ZOOM = GW_CVAR_MINIMAP_ZOOM + 0.005} else {GW_CVAR_MINIMAP_ZOOM = GW_CVAR_MINIMAP_ZOOM + 0.001};
		if (GW_CVAR_MINIMAP_ZOOM >= 0.3) then {GW_CVAR_MINIMAP_ZOOM = 0.3};
		_dontPerformKeyStroke = true;
	};
	
	//Minimap Show/Hide (CTRL + C)
	if (_ctrl && (_keyPressed == 46)) then
	{
		if (GW_CVAR_MINIMAP_SHOW) then {GW_CVAR_MINIMAP_SHOW = false} else {GW_CVAR_MINIMAP_SHOW = true};
		_dontPerformKeyStroke = true;
	};
	
	//Mark location (Key assigned for RevealTarget) 
	if (_keyPressed in (actionKeys "RevealTarget")) then
	{		
		_markPosition = screenToWorld [0.5, 0.5];
		_markPosition set [2, 0];
		if (!isNull cursorTarget) then {_markPosition = getPos cursorTarget};

		["client","playermarker",[(GW_CVAR_SIDE), (getPlayerUID player), _markPosition, 25]] Spawn fnc_clt_requestServerExec;
		
		_dontPerformKeyStroke = true;
	};
	
	//Action related
	if (count GW_CVAR_ACTION > 0) then
	{
		//Cancel current action (ESC)
		if (_keyPressed == 1) then
		{
			_dontPerformKeyStroke = true;
			GW_CVAR_ACTION = [];
		};
		
		//Don't allow moving when action is occuring
		if ((_keyPressed in (actionKeys "MoveForward")) || 
		    (_keyPressed in (actionKeys "MoveBack")) || 
			(_keyPressed in (actionKeys "EvasiveLeft")) || 
			(_keyPressed in (actionKeys "EvasiveRight")) ||
			(_keyPressed in (actionKeys "TurnLeft")) ||
			(_keyPressed in (actionKeys "TurnRight"))) then
		{
			_dontPerformKeyStroke = true;
		};
	};
	
	//Construction Menu Related
	if (!isNil "GW_CONSTRUCT_LOCALBUILDING") then
	{
		if (!isNull GW_CONSTRUCT_LOCALBUILDING) then
		{
			//Original position
			_buildPos = getPosATL GW_CONSTRUCT_LOCALBUILDING;
			
			//Raise Structure (CTRL + UP ARROW)
			if ((_this select 3) && ((_this select 1) == 200)) then 
			{
				_upAdd = if (_this select 2) then {0.25} else {0.1};
				if ((GW_CONSTRUCT_HEIGHT_MOD + _upAdd) <= (GW_CONSTRUCT_STRUCTARR_HEIGHTMOD select 1)) then
				{
					_buildPos set [2, (_buildPos select 2) + _upAdd];
					GW_CONSTRUCT_HEIGHT_MOD = GW_CONSTRUCT_HEIGHT_MOD + _upAdd;
				}
				else
				{
					_buildPos set [2, (GW_CONSTRUCT_STRUCTARR_HEIGHTMOD select 1)];
					GW_CONSTRUCT_HEIGHT_MOD = (GW_CONSTRUCT_STRUCTARR_HEIGHTMOD select 1);
				};
				_dontPerformKeyStroke = true;
			};
			//Lower Structure (CTRL + DOWN ARROW)
			if ((_this select 3) && ((_this select 1) == 208)) then 
			{
				_downSub = if (_this select 2) then {0.25} else {0.1};
				if ((GW_CONSTRUCT_HEIGHT_MOD - _downSub) >= (GW_CONSTRUCT_STRUCTARR_HEIGHTMOD select 0)) then
				{
					_buildPos set [2, (_buildPos select 2) - _downSub];
					GW_CONSTRUCT_HEIGHT_MOD = GW_CONSTRUCT_HEIGHT_MOD - _downSub;
				}
				else
				{
					_buildPos set [2, (GW_CONSTRUCT_STRUCTARR_HEIGHTMOD select 0)];
					GW_CONSTRUCT_HEIGHT_MOD = (GW_CONSTRUCT_STRUCTARR_HEIGHTMOD select 0);
				};
				_dontPerformKeyStroke = true;
			};
			//Rotate Structure Left (CTRL + LEFT ARROW)
			if ((_this select 3) && ((_this select 1) == 203)) then 
			{
				if (_this select 2) then
				{
					GW_CONSTRUCT_DIRECTION = GW_CONSTRUCT_DIRECTION - 10;
				}
				else
				{
					GW_CONSTRUCT_DIRECTION = GW_CONSTRUCT_DIRECTION - 1;
				};
				_dontPerformKeyStroke = true;
			};
			//Rotate Structure Right (CTRL + RIGHT ARROW)
			if ((_this select 3) && ((_this select 1) == 205)) then 
			{
				if (_this select 2) then
				{
					GW_CONSTRUCT_DIRECTION = GW_CONSTRUCT_DIRECTION + 10;
				}
				else
				{
					GW_CONSTRUCT_DIRECTION = GW_CONSTRUCT_DIRECTION + 1;
				};
				_dontPerformKeyStroke = true;
			};
			//Cancel Current Building Selection (ESCAPE)
			if ((_this select 1) == 1) then
			{
				deleteVehicle GW_CONSTRUCT_LOCALBUILDING;
				GW_CONSTRUCT_LOCALBUILDING = nil;
				if (!isNull GW_CONSTRUCT_LOCALBUILDING_HELPER) then
				{
					deleteVehicle GW_CONSTRUCT_LOCALBUILDING_HELPER;
					GW_CONSTRUCT_LOCALBUILDING_HELPER = nil;
				};
				_dontPerformKeyStroke = true;
				createDialog "UI_Construction";
			};
			
			//Update position
			GW_CONSTRUCT_LOCALBUILDING setPosATL _buildPos;
		};
	};
	
	_dontPerformKeyStroke
}];