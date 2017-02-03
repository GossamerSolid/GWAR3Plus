//Init.sqf
//Writen by: GossamerSolid
//Used to determine what will be processed at initialization
disableSerialization;

//Developer mode enabled or not
GW_DEVMODE = true;

//Database Support Enabled or not
//DISABLED until further notice
GW_DATABASE = false; //("MC_DBSupport" call BIS_fnc_getParamValue) == 1;

//Server code location
GW_SERVERCODE = if (GW_DEVMODE) then {"Server"} else {"\GWAR3_Server"};
GW_GWPLUS = false;

//Get root dir of mission in order to use with commands like drawIcon/drawIcon3D
GW_MISSIONROOT = Call 
{
    private "_arr";
    _arr = toArray __FILE__;
    _arr resize (count _arr - 8);
    toString _arr
};

//Playerlist
if (isNil "GW_PLAYERLIST") then {GW_PLAYERLIST = []};

//Fix for making side constants work
guer = resistance;
civ = civilian;

//Disable raycast sensors (apparently meant to make client performance much better)
disableRemoteSensors true;

/*
//Do not allow localhosted play
//Scripts require a dedicated server to properly run
if (!GW_DEVMODE) then
{
	if (isServer && (!isDedicated)) exitWith
	{
		endMission "END1";
	};
};
*/

//Server initialization
if (isServer) then
{
	_serverInit = CompileFinal preprocessFileLineNumbers format["%1\Init\Init_Server.sqf",GW_SERVERCODE];
	[] Spawn _serverInit;	
};

//Client initialization
if ((!isDedicated)) then
{
	_clientInit = CompileFinal preprocessFileLineNumbers "Client\Init\Init_Client.sqf";
	[] Spawn _clientInit;
};

//Disable rodents and shit
waitUntil {time > 0};
enableEnvironment false;