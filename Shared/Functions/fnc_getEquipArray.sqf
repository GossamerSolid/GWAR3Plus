private["_unitObj","_equipArray"];

_unitObj = if ((typeName _this) == "OBJECT") then {_this} else {_this select 0};
_equipPurFormat = if ((typeName _this) == "ARRAY") then {_this select 1} else {false}; //Use this for initial population of equipment purchasing template
_equipArray = [];

//Make sure our unit object isn't null
if (!isNull _unitObj) then
{
	//Get headgear
	_helmetClass = headgear _unitObj;
	
	//Get facewear
	_faceClass = goggles _unitObj;
	
	//Binocs and NVGS
	_binocsClass = binocular _unitObj;
	_nvgClass = hmd _unitObj;
	
	//Get the uniform and what's in the uniform
	_uniformClass = uniform _unitObj;
	_uniformArray = [];
	if (_uniformClass != "") then
	{
		_uniformItemsClasses = itemCargo (uniformContainer _unitObj);
		_uniformMagazinesClasses = magazineCargo (uniformContainer _unitObj);
		_uniformWeaponsClasses = weaponCargo (uniformContainer _unitObj);
		
		_uniformArray = [_uniformItemsClasses, _uniformMagazinesClasses, _uniformWeaponsClasses] Call fnc_shr_mergeArrays;
	};
	
	//Get the vest and what's in the vest
	_vestClass = vest _unitObj;
	_vestArray = [];
	if (_vestClass != "") then
	{
		_vestItemsClasses = itemCargo (vestContainer _unitObj);
		_vestMagazinesClasses = magazineCargo  (vestContainer _unitObj);
		_vestWeaponsClasses = weaponCargo (vestContainer _unitObj);
		
		_vestArray = [_vestItemsClasses, _vestMagazinesClasses, _vestWeaponsClasses] Call fnc_shr_mergeArrays;
	};
	
	//Get the backpack and what's in the backpack
	_backpackClass = backpack _unitObj;
	_backpackArray = [];
	if (_backpackClass != "") then
	{
		_backpackItemsClasses = itemCargo (backpackContainer _unitObj);
		_backpackMagazinesClasses = magazineCargo  (backpackContainer _unitObj);
		_backpackWeaponsClasses = weaponCargo (backpackContainer _unitObj);
		
		_backpackArray = [_backpackItemsClasses, _backpackMagazinesClasses, _backpackWeaponsClasses] Call fnc_shr_mergeArrays;
	};
	
	//Get the weapons and their attachments/magazine
	_weaponsItems = weaponsItems _unitObj;
	_equippedMags = [];
	
	//Primary Weapon
	_primaryClass = primaryWeapon _unitObj;
	_primaryAttach = ["","","",""];
	if (_primaryClass != "") then 
	{
		_primaryAttach = primaryWeaponItems _unitObj;
		if (!isNil "_weaponsItems") then
		{
			if ((count _weaponsItems) > 0) then
			{
				_weapIndex = [_primaryClass, 0, _weaponsItems] Call fnc_shr_arrayGetIndex;
				if (_weapIndex != -1) then
				{
					_primaryItems = _weaponsItems select _weapIndex;
					if (count(_primaryItems select 4) > 0) then
					{
						_maxAmmoCount = getNumber(configFile >> "CfgMagazines" >> ((_primaryItems select 4) select 0) >> "count");
						_currAmmoCount = (_primaryItems select 4) select 1;
						if (_currAmmoCount != 0) then {_equippedMags pushBack ((_primaryItems select 4) select 0)};
					};
				};
			};
		};
	};

	//Secondary Weapon
	_secondaryClass = secondaryWeapon _unitObj;
	_secondaryAttach = ["","","",""];
	if (_secondaryClass != "") then 
	{
		_secondaryAttach = secondaryWeaponItems _unitObj;
		if (!isNil "_weaponsItems") then
		{
			if ((count _weaponsItems) > 0) then
			{
				_weapIndex = [_secondaryClass, 0, _weaponsItems] Call fnc_shr_arrayGetIndex;
				if (_weapIndex != -1) then
				{
					_secondaryItems = _weaponsItems select _weapIndex;
					if (count(_secondaryItems select 4) > 0) then
					{
						_maxAmmoCount = getNumber(configFile >> "CfgMagazines" >> ((_secondaryItems select 4) select 0) >> "count");
						_currAmmoCount = (_secondaryItems select 4) select 1;
						if (_currAmmoCount != 0) then {_equippedMags pushBack ((_secondaryItems select 4) select 0)};
					};
				};
			};
		};
	};

	//Sidearm
	_sidearmClass = handgunWeapon _unitObj;
	_sidearmAttach = ["","","",""];
	if (_sidearmClass != "") then 
	{
		_sidearmAttach = handgunItems _unitObj;
		if (!isNil "_weaponsItems") then
		{
			if ((count _weaponsItems) > 0) then
			{
				_weapIndex = [_sidearmClass, 0, _weaponsItems] Call fnc_shr_arrayGetIndex;
				if (_weapIndex != -1) then
				{
					_sidearmItems = _weaponsItems select _weapIndex;
					if (count(_sidearmItems select 4) > 0) then
					{
						_maxAmmoCount = getNumber(configFile >> "CfgMagazines" >> ((_sidearmItems select 4) select 0) >> "count");
						_currAmmoCount = (_sidearmItems select 4) select 1;
						if (_currAmmoCount != 0) then {_equippedMags pushBack ((_sidearmItems select 4) select 0)};
					};
				};
			};
		};
	};
	
	//Get the assigned items (map, gps, etc)
	_assignedItems = assignedItems _unitObj;
	
	//Create equip array
	_equipArray set [0, _helmetClass];
	_equipArray set [1, _faceClass];
	_equipArray set [2, _binocsClass];
	_equipArray set [3, _nvgClass];
	_equipArray set [4, [_uniformClass, _uniformArray]];
	_equipArray set [5, [_vestClass, _vestArray]];
	_equipArray set [6, [_backpackClass, _backpackArray]];
	_equipArray set [7, [_primaryClass, _primaryAttach]];
	_equipArray set [8, [_secondaryClass, _secondaryAttach]];
	_equipArray set [9, [_sidearmClass, _sidearmAttach]];
	_equipArray set [10, _assignedItems];
	if (!_equipPurFormat) then {_equipArray set [11, _equippedMags]}; //Magazines loaded into weapons
	
	//Extra work required if the return needs to be used for the initial template in the equipment purchase menu
	if (_equipPurFormat) then
	{
		//Parse out the assigned items
		_prevAssignedItems = _assignedItems;
		_assignedItems = ["", "", "", "", ""];
		{
			_compassIndex = GW_EQUIP_COMPASS_ITEMS find _x;
			if (_compassIndex != -1) then {_assignedItems set [0, _x]};
			
			_gpsIndex = GW_EQUIP_GPS_ITEMS find _x;
			if (_gpsIndex != -1) then {_assignedItems set [1, _x]};
			
			_mapIndex = GW_EQUIP_MAP_ITEMS find _x;
			if (_mapIndex != -1) then {_assignedItems set [2, _x]};
			
			_radarIndex = GW_EQUIP_RADIO_ITEMS find _x;
			if (_radarIndex != -1) then {_assignedItems set [3, _x]};
			
			_watchIndex = GW_EQUIP_WATCH_ITEMS find _x;
			if (_watchIndex != -1) then {_assignedItems set [4, _x]};
		} forEach _prevAssignedItems;
		_equipArray set [10, _assignedItems];
		
		//Equipped mags need to be put into a container (Backpack -> Vest -> Uniform)
		{
			if (((_equipArray select _x) select 0) != "") exitWith
			{
				_containerArray = (_equipArray select _x) select 1;
				{
					_containerArray pushBack _x;
				} forEach _equippedMags;
				
				_equipArray set [_x, [((_equipArray select _x) select 0), _containerArray]];
			};
		} forEach [6,5,4];
	};
};

_equipArray 