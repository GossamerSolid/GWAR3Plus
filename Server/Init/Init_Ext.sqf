//Init_Ext.sqf
//Written by: GossamerSolid
//Initializes all required extension components server side

if (!isServer) exitWith {diag_log text "###[GW ERROR] - Server\Init\Init_Ext.sqf must only be called server-side."};

fnc_srv_spawnExtension = CompileFinal preprocessFileLineNumbers format["%1\Ext\fnc_spawnExtension.sqf",GW_SERVERCODE];

//Initialize ArmA2Net
_ret = ("Arma2Net" callExtension "");
