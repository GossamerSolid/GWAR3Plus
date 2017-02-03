private["_weapClassname","_side","_fullMagsArray","_equipArrNetCall","_resultMagsArray"];

_weapClassname = _this select 0;
_side = _this select 1;

_configMagsArray = GetArray (configFile >> "CfgWeapons" >> _weapClassname >> "magazines");
_fullMagsArray = [];
_resultMagsArray = [];

//Server can grab directly, client has to ask server for data
if (isServer) then
{
	_fullMagsArray = GW_EQUIP_MAGAZINES;
}
else
{
	//Request magazine array from server
	_equipArrNetCall = ["GW_EQUIP_MAGAZINES","equipment","magazines",nil,true] Spawn fnc_clt_requestServerData;
	waitUntil {scriptDone _equipArrNetCall};
	_fullMagsArray = Call Compile Format["%1","GW_EQUIP_MAGAZINES"];
};

//Go through each of our mission config magazines against the config magazines for the gun
{
	_cfgMagsClass = _x;
	{
		if ((_x select 0) == _cfgMagsClass) exitWith {_resultMagsArray set [count _resultMagsArray, _x]};
	} forEach _fullMagsArray;
} forEach _configMagsArray;

_resultMagsArray