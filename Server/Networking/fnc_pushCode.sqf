//fnc_pushCode.sqf
//Written by: GossamerSolid
//This will allow a developer to push code from client-side to any machine.
//This script will only work if the game is set in dev mode
//@param 0 - Array of client IDs to send to
//@param 1 - String of code to be dynamically executed

if (!isServer || !GW_DEVMODE) exitWith {diag_log text "###[GW ERROR] - Server\Networking\fnc_pushCode.sqf must only be called server-side and in development mode."};

if ((count (_this select 0)) > 0) then
{
	GW_SERVER_PUSH_EXEC = _this select 1;
	{
		_x publicVariableClient "GW_SERVER_PUSH_EXEC";
	} forEach (_this select 0);
};



