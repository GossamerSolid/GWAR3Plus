//fnc_getServerQuality.sqf
//Written by: GossamerSolid
//Given a framerate, say how good the server is performing
//NOTE - This only checks server framterate, it cannot account for server bandwidth performance

_frameRate = _this select 0;
_qualityStr = (GW_SERVER_FRAMERATE_LEVELS select 0) select 1;

{
	_frameRateBound = _x select 0;
	_qualString = _x select 1;
	_qualDescString = _x select 2;

	if (_frameRate >= _frameRateBound) exitWith
	{
		_qualityStr = _qualString;
	};
} forEach GW_SERVER_FRAMERATE_LEVELS;

_qualityStr