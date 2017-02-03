//fnc_requestServerData.sqf
//Written by: GossamerSolid
//Requests data from the server
//@param clientGVar - the client-side global var that will have the value sent from the server stored in
//@param clientDType - data type requested

GW_CLIENT_DATA_REQUEST = [player, _this select 0, _this select 1, _this select 2, _this select 3];
publicVariableServer "GW_CLIENT_DATA_REQUEST";

/*
To use a synchronized call, you must initialize your global var (which has the data returned to it) like so:
GW_YOUR_GLOBAL = ["GW_NETCALL_WAITING"];
Additionally, you must assign a handle for this Spawned function and wait on it to be done:
_myNetCall = [args] Spawn fnc_clt_requestServerData;
waitUntil {scriptDone _myNetCall};
*/

_sync = if (count _this > 4) then {_this select 4} else {false};
if (_sync) then
{
	_timeout = GW_GVAR_NETWORK_SEVERRESPONSE_TIMEOUT;

	_gvar = [];
	_waiting = true;
	while {_waiting} do
	{
		sleep 0.1;
		_timeout = _timeout - 0.1;
		Call Compile Format ["_gvar = %1",_this select 0];
		if (_timeout <= 0) exitWith {_waiting = false};
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
		diag_log text format["###[GW ERROR] - Client\Networking\fnc_requestServerData.sqf did not get a response from the server! [%1, %2, %3, %4]",_this select 0, _this select 1, _this select 2, _this select 3];
	};
	//diag_log text format ["#### [CLIENT - FINISH] CLIENT REQUEST SERVER DATA - %1 - %2", time, _this];
};
 