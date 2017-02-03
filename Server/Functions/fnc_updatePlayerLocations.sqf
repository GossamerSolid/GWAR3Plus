private ["_playerSide","_respawnMarker","_obj", "_layoutParameter", "_objPos"];
_layoutParameter = (Call Compile Format ["GW_PARAM_ML_%1",worldName]);

//Go through each player
{
	if (isPlayer _x) then
	{
		_playerSide = _x Call fnc_shr_getObjSide;
		_respawnMarker = format["respawn_%1",_playerSide];
		_objPos = getPosASL _x;
		if ((_x distance (getMarkerPos _respawnMarker)) > 300) then
		{
			["", ["db"], [GW_SERVERKEY, "AddPlayerLocation", (getPlayerUID _x), GW_MATCHID, _playerSide, worldName, _layoutParameter, _objPos]] Spawn fnc_srv_spawnExtension;
		};
	};
} forEach playableUnits;