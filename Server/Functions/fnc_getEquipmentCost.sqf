private["_equipmentArray","_totalCost"];
_equipmentArray = _this;

_totalCost = 0;
	
//Loop through the template and figure out the costs
{
	_className = "";
	if (typeName _x == "STRING") then
	{
		if (_x != "") then
		{
			_itemIndex = [_x, 0, GW_EQUIP_ALL] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then 
			{
				_itemPrice = (GW_EQUIP_ALL select _itemIndex) select 1;
				_totalCost = _totalCost + _itemPrice;
			};
		};
	};
	if (typeName _x == "ARRAY") then
	{	
		{
			if (typeName _x == "STRING") then
			{
				if (_x != "") then
				{
					_itemIndex = [_x, 0, GW_EQUIP_ALL] Call fnc_shr_arrayGetIndex;
					if (_itemIndex != -1) then 
					{
						_itemPrice = (GW_EQUIP_ALL select _itemIndex) select 1;
						_totalCost = _totalCost + _itemPrice;
					};
				};
			};
			if (typeName _x == "ARRAY") then
			{
				{
					if (_x != "") then
					{
						_itemIndex = [_x, 0, GW_EQUIP_ALL] Call fnc_shr_arrayGetIndex;
						if (_itemIndex != -1) then 
						{
							_itemPrice = (GW_EQUIP_ALL select _itemIndex) select 1;
							_totalCost = _totalCost + _itemPrice;
						};
					};
				} forEach _x;
			};
		} forEach _x;
	};
	
} forEach _equipmentArray;

_totalCost 