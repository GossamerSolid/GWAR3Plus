private["_object","_side","_classname","_loadoutName","_baseCost","_cost","_vehArrayIndex","_uniqueID"];

_object = _this select 0;
_side = _this select 1;
_classname = typeOf _object;
_cost = 0;

//Infantry cost calculation
if (_classname isKindOf "Man") then
{
	_baseCost = (Call Compile Format["GW_GVAR_INFANTRY_BASECOST_%1",_side]);
	_loadoutName = _object getVariable ["GW_INFANTRYLOADOUT", ""];
	if (_loadoutName != "") then 
	{
		_cost = _baseCost + (([_loadoutName,_side] Call fnc_shr_getInfantryArray) select 1);
	}
	else
	{
		_cost = _baseCost;
	};
	
}
else
{
	_vehicleArrayIndex = -1;
	
	//Needs to use UniqueID or we'll get some bad shit
	_uniqueID = _object getVariable ["GW_UNIQUEID", ""];
	if (_uniqueID != "") then
	{	
		_vehArrayIndex = [_uniqueID, 11, GW_VEHICLES] Call fnc_shr_arrayGetIndex;
	};
	
	if (_vehArrayIndex != -1) then {_cost = (GW_VEHICLES select _vehArrayIndex) select 2};
};

_cost 