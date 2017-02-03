//fnc_getEquipCfgClass
//Written by: GossamerSolid
//Will tell you if an inventory item is a weapon, mag, vehicle or glasses

_cfgClass = "";

if (isClass (configFile >> "CfgWeapons" >> _this)) then {_cfgClass = "CfgWeapons"};
if (_cfgClass == "") then
{
	if (isClass (configFile >> "CfgMagazines" >> _this)) then {_cfgClass = "CfgMagazines"};
};
if (_cfgClass == "") then
{
	if (isClass (configFile >> "CfgVehicles" >> _this)) then {_cfgClass = "CfgVehicles"};
};
if (_cfgClass == "") then
{
	if (isClass (configFile >> "CfgGlasses" >> _this)) then {_cfgClass = "CfgGlasses"};
};

_cfgClass 