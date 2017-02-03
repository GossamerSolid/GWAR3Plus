//fnc_requestServerExec.sqf
//Written by: GossamerSolid
//Requests a remote function to be executed on the client
//@param 0 - Array of client IDs to send to
//@param 1 - Function to execute
//@param 2 - Subfunction of function
//@param 3 - Array of parameters to pass to said function

if ((count (_this select 0)) > 0) then
{
	{
		[_x, _this select 1, _this select 2, _this select 3] Spawn fnc_srv_processClientExec;
	} forEach (_this select 0);
};