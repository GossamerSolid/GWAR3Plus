/*
fnc_equipUnit.sqf
Written by: GossamerSolid

IMPORTANT: You have to call this where the unit object is local (Example - to equip a player, their client has to run this)

_unitObj Spawn fnc_shr_equipUnit;
[_unitObj, _equipArray] Spawn fnc_shr_equipUnit;
*/
private["_prevAnim","_inputArg","_unitObj","_side","_equipArray"];
_inputArg = _this;

_unitObj = objNull;
_side = "";
_equipArray = [];

if (typeName _inputArg == "OBJECT") then
{
	_unitObj = _inputArg;
	_side = side _unitObj;
};
if (typeName _inputArg == "ARRAY") then
{
	_unitObj = _inputArg select 0;
	_side = side _unitObj;
	_equipArray = _inputArg select 1;
};

//Get previous animation
_prevAnim = animationState _unitObj;

//Strip previous equipment
removeAllContainers _unitObj;
removeGoggles _unitObj;
removeHeadgear _unitObj;
removeAllAssignedItems _unitObj;
removeAllWeapons _unitObj;

//Didn't pass in an equip array, gotta build a random one
if ((count _equipArray) < 1) then
{
	_weapon = "";
	_secondaryWeapon = "";
	_magazine = "";
	_secondaryMag = "";
	
	_weaponsArray = [_side, "WEAP_PRIMARY"] Call fnc_shr_getSideEquipment;
	_weapon = (_weaponsArray select (round(random((count _weaponsArray) - 1)))) select 0;
	
	_weaponMagazines = GetArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
	_magazine = _weaponMagazines select 0;
		
	_uniformsArray = [_side, "UNIFORMS"] Call fnc_shr_getSideEquipment;
	_uniform = (_uniformsArray select (round(random((count _uniformsArray) - 1)))) select 0;
	
	_vestArray = [_side, "VESTS"] Call fnc_shr_getSideEquipment;
	_vest = (_vestArray select (round(random((count _vestArray) - 1)))) select 0;
	
	_headArray = [_side, "HEADGEAR"] Call fnc_shr_getSideEquipment;
	_head = (_headArray select (round(random((count _headArray) - 1)))) select 0;
	
	_unitObj forceAddUniform _uniform;
	_unitObj addVest _vest;
	_unitObj addHeadgear _head;
	_unitObj addMagazines [_magazine, round(random(5))];
	_unitObj addWeapon _weapon;
}
else
{
	//Read out the equip array
	_helmet = _equipArray select 0;
	_face = _equipArray select 1;
	_binocs = _equipArray select 2;
	_nvgs = _equipArray select 3;
	_uniform = _equipArray select 4;
	_vest = _equipArray select 5;
	_backpack = _equipArray select 6;
	_primary = _equipArray select 7;
	_secondary = _equipArray select 8;
	_sidearm = _equipArray select 9;
	_assignedItems = _equipArray select 10;
	
	//Parse it into useable pieces
	_vestClass = _vest select 0;
	_vestContainer = _vest select 1;
	_uniformClass = _uniform select 0;
	_uniformContainer = _uniform select 1;
	_backpackClass = _backpack select 0;
	_backpackContainer = _backpack select 1;
	_primaryClass = _primary select 0;
	_primaryAttach = _primary select 1;
	_secondaryClass = _secondary select 0;
	_secondaryAttach = _secondary select 1;
	_sidearmClass = _sidearm select 0;
	_sidearmAttach = _sidearm select 1;
	
	//Perform the equiping
	if (_helmet != "") then {_unitObj addHeadgear _helmet};
	if (_face != "") then {_unitObj addGoggles _face};
	if (_nvgs != "") then {_unitObj linkItem _nvgs};
	if (_binocs != "") then {_unitObj addWeapon _binocs};
	if (_vestClass != "") then 
	{
		_unitObj addVest _vestClass;
		{
			if ((typeName _x) == "ARRAY") then {_unitObj addItemToVest (_x select 0)} else {_unitObj addItemToVest _x};
		} forEach _vestContainer;
	};
	if (_uniformClass != "") then 
	{
		_unitObj forceAddUniform _uniformClass;
		{
			if ((typeName _x) == "ARRAY") then {_unitObj addItemToUniform (_x select 0)} else {_unitObj addItemToUniform _x};
		} forEach _uniformContainer;
	};
	if (_backpackClass != "") then 
	{
		_unitObj addBackpack _backpackClass;
		{
			if ((typeName _x) == "ARRAY") then {_unitObj addItemToBackpack (_x select 0)} else {_unitObj addItemToBackpack _x};
		} forEach _backpackContainer;
	};
	if (_primaryClass != "") then 
	{
		_unitObj addWeapon _primaryClass;
		{
			if (_x != "") then {_unitObj addPrimaryWeaponItem _x};
		} forEach _primaryAttach;
	};
	if (_secondaryClass != "") then 
	{
		_unitObj addWeapon _secondaryClass;
		{
			if (_x != "") then {_unitObj addSecondaryWeaponItem _x};
		} forEach _secondaryAttach;
	};
	if (_sidearmClass != "") then 
	{
		_unitObj addWeapon _sidearmClass;
		{
			if (_x != "") then {_unitObj addHandgunItem _x};
		} forEach _sidearmAttach;
	};
	{
		_unitObj linkItem _x;
	} forEach _assignedItems;
	
	//Militia infantry have random uniform/helmet/facewear
	if (_side == guer) then {_unitObj Spawn fnc_srv_guerRandomEquip};
};

//Prevent weapon switching animation
_unitObj switchMove _prevAnim;

