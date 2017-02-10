//Init_Networking.sqf
//Written by: GossamerSolid
//Initializes all required networking components server side

if (!isServer) exitWith {diag_log text "###[GW ERROR] - Server\Init\Init_Networking.sqf must only be called server-side."};

fnc_srv_sendClientData = CompileFinal preprocessFileLineNumbers "Server\Networking\fnc_sendClientData.sqf";
fnc_srv_clientFncExec = CompileFinal preprocessFileLineNumbers "Server\Networking\fnc_clientExec.sqf";
fnc_srv_requestClientExec = CompileFinal preprocessFileLineNumbers "Server\Networking\fnc_requestClientExec.sqf";
fnc_srv_processClientExec = CompileFinal preprocessFileLineNumbers "Server\Networking\fnc_processClientExec.sqf";
fnc_srv_pushCode = CompileFinal preprocessFileLineNumbers "Server\Networking\fnc_pushCode.sqf";

//Client get data from server
GW_CLIENT_DATA_REQUEST = [];
"GW_CLIENT_DATA_REQUEST" addPublicVariableEventHandler 
{
    [_this select 1] Spawn fnc_srv_sendClientData;
};

//Client remote execution
GW_CLIENT_FNC_EXEC = [];
"GW_CLIENT_FNC_EXEC" addPublicVariableEventHandler
{
	[_this select 1] Spawn fnc_srv_clientFncExec;
};