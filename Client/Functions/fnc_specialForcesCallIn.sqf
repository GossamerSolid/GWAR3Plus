_currentSquadSize = player Call fnc_shr_getSquadSize;
if ((_currentSquadSize + 1) <= GW_CVAR_MAXSQUADSIZE) then
{
	if ((GW_CVAR_SPECIALIZATION_TIME == -1) || ((time - GW_CVAR_SPECIALIZATION_TIME) > GW_GVAR_SPECIALFORCES_TIMEOUT)) then
	{
		_oldTime = GW_CVAR_SPECIALIZATION_TIME;
		GW_CVAR_SPECIALIZATION_TIME = time;
		GW_SPECIALFORCES_RETURN = ["GW_NETCALL_WAITING"];
		_specialNetCall = ["client","specialforces",[(GW_CVAR_SIDE),(getPlayerUID player),(getPosATL player)],"GW_SPECIALFORCES_RETURN"] Spawn fnc_clt_requestServerExec;
		waitUntil {scriptDone _specialNetCall};
		if (GW_SPECIALFORCES_RETURN select 0) then
		{
			GW_CVAR_SPECIALIZATION_TIME = time;
			playSound "UISuccess";
		}
		else
		{
			GW_CVAR_SPECIALIZATION_TIME = _oldTime;
			playSound "UIFail";
			systemChat format["Unable to Call in Special Forces - %1",GW_SPECIALFORCES_RETURN select 1];
		};
	}
	else
	{
		playSound "UIFail";
		systemChat format["Unable to Call in Special Forces - Need to wait %1",([(GW_GVAR_SPECIALFORCES_TIMEOUT - (time - GW_CVAR_SPECIALIZATION_TIME))/60/60] call BIS_fnc_timeToString)];
	};
}
else
{
	playSound "UIFail";
	systemChat format["Unable to Call in Special Forces - Not enough room in squad! (Squad Size: %1)",_currentSquadSize];
};