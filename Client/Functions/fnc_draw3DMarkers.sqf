private["_icon","_distance","_icon","_iconSize","_textSize","_colourMod","_currentMarkerEntry","_visualPos"];

if (GW_CVAR_3DMARKERS) then
{
	//Draw friendly markers
	{
		_currentMarkerEntry =+ _x;
		
		_distance = GW_CVAR_WATCHPOS distance (_currentMarkerEntry select 5);
		if ((_distance <= GW_CVAR_OBJECT_VD) && !(_currentMarkerEntry select 8)) then
		{
			_icon = _currentMarkerEntry select 1;
			if ((_currentMarkerEntry select 6) != "") then {_icon = _currentMarkerEntry select 6};
			
			_iconSize = 1;
			_textSize = 0.04;
			//if (!(_currentMarkerEntry select 7)) then
			//{
				if (_distance > 25 && _distance <= 75) then {_iconSize = 0.9; _textSize = 0.0375};
				if (_distance > 75 && _distance <= 150) then {_iconSize = 0.8; _textSize = 0.035};
				if (_distance > 150 && _distance <= 250) then {_iconSize = 0.7; _textSize = 0.0325};
				if (_distance > 250 && _distance <= 350) then {_iconSize = 0.6; _textSize = 0.03};
				if (_distance > 350) then {_iconSize = 0.5; _textSize = 0.0275};
			//};
			
			//Modify alpha based off of client settings
			_colourMod = _currentMarkerEntry select 4;
			_colourMod set [3, GW_CVAR_3DMARKER_ALPHA];
			
			//Visual Position
			_visualPos = getPosATLVisual (_x select 9);
			_visualPos set [2, (_visualPos select 2) + 1];
			
			drawIcon3D
			[
				_icon,
				_colourMod,
				_visualPos,
				_iconSize,
				_iconSize,
				0,
				(_currentMarkerEntry select 3),
				2,
				_textSize,
				"PuristaMedium"
			];
		};
	} forEach GW_CVAR_FRIENDLYMARKERS;
};
