//fnc_requestServerExec.sqf
//Written by: GossamerSolid
//Requests a remote function to be executed on the server
//@param 0 - Function to execute
//@param 1 - Subfunction of function
//@param 2 - Array of parameters to pass to said function
//@param 3 - Name of GVAR used to store return result (OPTIONAL - assumed to be a synched call if defined)

if (count _this <= 3) then
{
	GW_CLIENT_FNC_EXEC = [player, _this select 0, _this select 1, _this select 2];
	publicVariableServer "GW_CLIENT_FNC_EXEC";
}
else
{
	GW_CLIENT_FNC_EXEC = [player, _this select 0, _this select 1, _this select 2, _this select 3];
	publicVariableServer "GW_CLIENT_FNC_EXEC";
};
 
/*
To use a synchronized call, you must initialize your global var (which has the data returned to it) like so:
GW_YOUR_GLOBAL = ["GW_NETCALL_WAITING"];
Additionally, you must assign a handle for this Spawned function and wait on it to be done:
_myNetCall = [args] Spawn fnc_clt_requestServerData;
waitUntil {scriptDone _myNetCall};
*/

_sync = if (count _this > 3) then {true} else {false};
if (_sync) then
{
	_timeout = GW_GVAR_NETWORK_SEVERRESPONSE_TIMEOUT;
	_gvar = [];
	_waiting = true;
	while {_waiting} do
	{
		sleep 0.1;
		_timeout = _timeout - 0.1;
		Call Compile Format ["_gvar = %1",_this select 3];
		if (_timeout <= 0) then {_waiting = false};
		if (count _gvar == 0) exitWith {_waiting = false};
		if ((typeName (_gvar select 0)) == "STRING") then
		{
			if ((_gvar select 0) != "GW_NETCALL_WAITING") then
			{
				_waiting = false;
			};
		}
		else
		{
			_waiting = false;
		};
	};
	
	if (_timeout <= 0) then
	{
		diag_log text format["###[GW ERROR] - Client\Networking\fnc_requestServerExec.sqf did not get a response from the server! [%1, %2, %3, %4]",_this select 0, _this select 1, _this select 2, _this select 3];
	};
};