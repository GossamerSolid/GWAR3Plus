private["_side","_mhqObj"];

_side = _this select 0;
_mhqObj = objNull;

//Server can access directly, client has to request from server
if (isServer) then
{
	_mhqObj = Call Compile Format["GW_MHQ_%1",_side];
}
else
{
	_mhqObjNetCall = [format["GW_MHQ_NETCALL_%1",_side],"mhq",_side,nil,true] Spawn fnc_clt_requestServerData;
	waitUntil {scriptDone _mhqObjNetCall};
	_mhqObj = Call Compile Format["GW_MHQ_NETCALL_%1",_side];
};

_mhqObj;