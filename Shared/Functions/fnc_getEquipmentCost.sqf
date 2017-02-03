private["_equipmentArray","_totalCost","_cacheArray","_itemPrice","_itemIndex","_headgearClass","_faceClass","_binocClass","_nvgClass","_uniformClass","_vestClass","_backpackClass","_primaryClass","_secondaryClass","_currentClass","_found"];
_equipmentArray =+ _this;

_totalCost = 0;

//Headgear
_headgearClass = _equipmentArray select 0;
if (_headgearClass != "") then
{
	_itemIndex = [_headgearClass, 0, GW_EQUIP_HEADGEAR] Call fnc_shr_arrayGetIndex;
	if (_itemIndex != -1) then
	{
		_itemPrice = (GW_EQUIP_HEADGEAR select _itemIndex) select 1;
		_totalCost = _totalCost + _itemPrice;
	};
};

//Face
_faceClass = _equipmentArray select 1;
if (_faceClass != "") then
{
	_itemIndex = [_faceClass, 0, GW_EQUIP_FACEWEAR] Call fnc_shr_arrayGetIndex;
	if (_itemIndex != -1) then
	{
		_itemPrice = (GW_EQUIP_FACEWEAR select _itemIndex) select 1;
		_totalCost = _totalCost + _itemPrice;
	};
};

//Binocs
_binocClass = _equipmentArray select 2;
if (_binocClass != "") then
{
	_itemIndex = [_binocClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
	if (_itemIndex != -1) then
	{
		_itemPrice = (GW_EQUIP_OTHERS select _itemIndex) select 1;
		_totalCost = _totalCost + _itemPrice;
	};
};

//NVGs
_nvgClass = _equipmentArray select 3;
if (_nvgClass != "") then
{
	_itemIndex = [_nvgClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
	if (_itemIndex != -1) then
	{
		_itemPrice = (GW_EQUIP_OTHERS select _itemIndex) select 1;
		_totalCost = _totalCost + _itemPrice;
	};
};

//Uniform
_uniformClass = (_equipmentArray select 4) select 0;
if (_uniformClass != "") then
{
	_itemIndex = [_uniformClass, 0, GW_EQUIP_UNIFORMS] Call fnc_shr_arrayGetIndex;
	if (_itemIndex != -1) then
	{
		_itemPrice = (GW_EQUIP_UNIFORMS select _itemIndex) select 1;
		_totalCost = _totalCost + _itemPrice;
	};
	
	//Uniform contents
	_cacheArray = [];
	{
		_currentClass = _x;
		_found = false;
		
		//Search cache array first
		_itemIndex = [_currentClass, 0, _cacheArray] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then 
		{
			_itemPrice = (_cacheArray select _itemIndex) select 1;
			_found = true;
		};
		
		//Fall back to planned out equipment arrays (Loop in order of most likely to least likely)
		if (!_found) then
		{
			{
				_itemIndex = [_currentClass, 0, _x] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) exitWith 
				{
					_itemPrice = (_x select _itemIndex) select 1;
					_cacheArray pushBack [_currentClass, _itemPrice];
					_found = true;
				};
			} forEach [GW_EQUIP_MAGAZINES, GW_EQUIP_ATTACHMENTS, GW_EQUIP_OTHERS, GW_EQUIP_WEAP_SIDEARM, GW_EQUIP_HEADGEAR, GW_EQUIP_FACEWEAR, GW_EQUIP_WEAP_SECONDARY, GW_EQUIP_WEAP_PRIMARY, GW_EQUIP_UNIFORMS, GW_EQUIP_VESTS, GW_EQUIP_BACKPACKS];
		};
		
		_totalCost = _totalCost + _itemPrice;
	} forEach ((_equipmentArray select 4) select 1);
};

//Vest
_vestClass = (_equipmentArray select 5) select 0;
if (_vestClass != "") then
{
	_itemIndex = [_vestClass, 0, GW_EQUIP_VESTS] Call fnc_shr_arrayGetIndex;
	if (_itemIndex != -1) then
	{
		_itemPrice = (GW_EQUIP_VESTS select _itemIndex) select 1;
		_totalCost = _totalCost + _itemPrice;
	};
	
	//Vest contents
	_cacheArray = [];
	{
		_currentClass = _x;
		_found = false;
		
		//Search cache array first
		_itemIndex = [_currentClass, 0, _cacheArray] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then 
		{
			_itemPrice = (_cacheArray select _itemIndex) select 1;
			_found = true;
		};
		
		//Fall back to planned out equipment arrays (Loop in order of most likely to least likely)
		if (!_found) then
		{
			{
				_itemIndex = [_currentClass, 0, _x] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) exitWith 
				{
					_itemPrice = (_x select _itemIndex) select 1;
					_cacheArray pushBack [_currentClass, _itemPrice];
					_found = true;
				};
			} forEach [GW_EQUIP_MAGAZINES, GW_EQUIP_ATTACHMENTS, GW_EQUIP_OTHERS, GW_EQUIP_WEAP_SIDEARM, GW_EQUIP_HEADGEAR, GW_EQUIP_FACEWEAR, GW_EQUIP_WEAP_SECONDARY, GW_EQUIP_WEAP_PRIMARY, GW_EQUIP_UNIFORMS, GW_EQUIP_VESTS, GW_EQUIP_BACKPACKS];
		};
		
		_totalCost = _totalCost + _itemPrice;
	} forEach ((_equipmentArray select 5) select 1);
};

//Backpack
_backpackClass = (_equipmentArray select 6) select 0;
if (_backpackClass != "") then
{
	_itemIndex = [_backpackClass, 0, GW_EQUIP_BACKPACKS] Call fnc_shr_arrayGetIndex;
	if (_itemIndex != -1) then
	{
		_itemPrice = (GW_EQUIP_BACKPACKS select _itemIndex) select 1;
		_totalCost = _totalCost + _itemPrice;
	};
	
	//Backpack contents
	_cacheArray = [];
	{
		_currentClass = _x;
		_found = false;
		
		//Search cache array first
		_itemIndex = [_currentClass, 0, _cacheArray] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then 
		{
			_itemPrice = (_cacheArray select _itemIndex) select 1;
			_found = true;
		};
		
		//Fall back to planned out equipment arrays (Loop in order of most likely to least likely)
		if (!_found) then
		{
			{
				_itemIndex = [_currentClass, 0, _x] Call fnc_shr_arrayGetIndex;
				if (_itemIndex != -1) exitWith 
				{
					_itemPrice = (_x select _itemIndex) select 1;
					_cacheArray pushBack [_currentClass, _itemPrice];
					_found = true;
				};
			} forEach [GW_EQUIP_MAGAZINES, GW_EQUIP_ATTACHMENTS, GW_EQUIP_OTHERS, GW_EQUIP_WEAP_SIDEARM, GW_EQUIP_HEADGEAR, GW_EQUIP_FACEWEAR, GW_EQUIP_WEAP_SECONDARY, GW_EQUIP_WEAP_PRIMARY, GW_EQUIP_UNIFORMS, GW_EQUIP_VESTS, GW_EQUIP_BACKPACKS];
		};
		
		_totalCost = _totalCost + _itemPrice;
	} forEach ((_equipmentArray select 6) select 1);
};

//Primary Weapon
_primaryClass = (_equipmentArray select 7) select 0;
if (_primaryClass != "") then
{
	_itemIndex = [_primaryClass, 0, GW_EQUIP_WEAP_PRIMARY] Call fnc_shr_arrayGetIndex;
	if (_itemIndex != -1) then
	{
		_itemPrice = (GW_EQUIP_WEAP_PRIMARY select _itemIndex) select 1;
		_totalCost = _totalCost + _itemPrice;
	};
	
	//Primary Weapon Attachments
	{
		if (_x != "") then
		{
			_itemIndex = [_x, 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then 
			{
				_itemPrice = (GW_EQUIP_ATTACHMENTS select _itemIndex) select 1;
				_totalCost = _totalCost + _itemPrice;
			};
		};
	} forEach ((_equipmentArray select 7) select 1);
};

//Secondary Weapon
_secondaryClass = (_equipmentArray select 8) select 0;
if (_secondaryClass != "") then
{
	_itemIndex = [_secondaryClass, 0, GW_EQUIP_WEAP_SECONDARY] Call fnc_shr_arrayGetIndex;
	if (_itemIndex != -1) then
	{
		_itemPrice = (GW_EQUIP_WEAP_SECONDARY select _itemIndex) select 1;
		_totalCost = _totalCost + _itemPrice;
	};
	
	//Secondary Weapon Attachments
	{
		if (_x != "") then
		{
			_itemIndex = [_x, 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then 
			{
				_itemPrice = (GW_EQUIP_ATTACHMENTS select _itemIndex) select 1;
				_totalCost = _totalCost + _itemPrice;
			};
		};
	} forEach ((_equipmentArray select 8) select 1);
};

//Sidearm Weapon
_sidearmClass = (_equipmentArray select 9) select 0;
if (_sidearmClass != "") then
{
	_itemIndex = [_sidearmClass, 0, GW_EQUIP_WEAP_SIDEARM] Call fnc_shr_arrayGetIndex;
	if (_itemIndex != -1) then
	{
		_itemPrice = (GW_EQUIP_WEAP_SIDEARM select _itemIndex) select 1;
		_totalCost = _totalCost + _itemPrice;
	};
	
	//Sidearm Weapon Attachments
	{
		if (_x != "") then
		{
			_itemIndex = [_x, 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then 
			{
				_itemPrice = (GW_EQUIP_ATTACHMENTS select _itemIndex) select 1;
				_totalCost = _totalCost + _itemPrice;
			};
		};
	} forEach ((_equipmentArray select 9) select 1);
};

//Assigned items
{
	if (_x != "") then
	{
		_itemIndex = [_x, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then 
		{
			_itemPrice = (GW_EQUIP_OTHERS select _itemIndex) select 1;
			_totalCost = _totalCost + _itemPrice;
		};
	};
} forEach (_equipmentArray select 10);

//Equipped mags
if ((count _equipmentArray) > 11) then
{
	{
		if (_x != "") then
		{
			_itemIndex = [_x, 0, GW_EQUIP_MAGAZINES] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then 
			{
				_itemPrice = (GW_EQUIP_MAGAZINES select _itemIndex) select 1;
				_totalCost = _totalCost + _itemPrice;
			};
		};
	} forEach (_equipmentArray select 11);
};
	
_totalCost 