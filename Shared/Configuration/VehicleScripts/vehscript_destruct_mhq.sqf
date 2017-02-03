//vehscript_destruct_mhq.sqf
//Written by: GossamerSolid
//Vehicle script executed for the MHQ when it is destroyed

private ["_vehObj","_killerObj","_sideVictim","_sideKiller","_killerName"];

_vehObj = _this select 0;
_killerObj = _this select 1;
_sideVictim = _this select 2;
_sideKiller = _this select 3;

//Figure out what name to display on the killed message (should either be a player name or a side name)
_killerName = "";
if (!isNull _killerObj) then 
{
	//Get the leader (this should return the player)
	_leaderObj = leader (group _killerObj);
	if (!isNull _leaderObj) then
	{
		_killerName = name _leaderObj;
	}
	else
	{
		_killerName = _sideKiller Call fnc_shr_getSideName;
	};
} 
else 
{
	_killerName = _sideKiller Call fnc_shr_getSideName;
};

if (_sideVictim != _sideKiller) then
{
	_sideMHQMembers = [_sideVictim, "netid"] Call fnc_shr_getSideMembers;
	[_sideMHQMembers, "messages", "", ["notification",["GWAR_MHQDestroyed",[_killerName]]]] Spawn fnc_srv_requestClientExec;
	
	_sideKillerMembers = [_sideKiller, "netid"] Call fnc_shr_getSideMembers;
	[_sideKillerMembers, "messages", "", ["notification",["GWAR_MHQKilled",[_killerName]]]] Spawn fnc_srv_requestClientExec;
}
else
{
	_sideMHQMembers = [_sideVictim, "netid"] Call fnc_shr_getSideMembers;
	[_sideMHQMembers, "messages", "", ["notification",["GWAR_MHQTeamkilled",[_killerName]]]] Spawn fnc_srv_requestClientExec;
};
