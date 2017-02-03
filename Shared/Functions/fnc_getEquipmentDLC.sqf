private["_equipmentArray","_side","_isValid"];
_equipmentArray = _this select 0;
_side = _this select 1;
_isValid = true;
	
//Loop through the template and figure out if all gear is available for the team provided
{
	_className = "";
	if (typeName _x == "STRING") then
	{
		if (_x != "") then
		{
			_itemIndex = [_x, 0, GW_EQUIP_ALL] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then 
			{
				_dlcID = (GW_EQUIP_ALL select _itemIndex) select 6;
				if (_dlcID != "") then
				{
					if (!(_dlcID in (getDLCs 1))) exitWith {_isValid = false};
				};
			}
			else
			{
				_isValid = false;
			}
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
						_dlcID = (GW_EQUIP_ALL select _itemIndex) select 6;
						if (_dlcID != "") then
						{
							if (!(_dlcID in (getDLCs 1))) exitWith {_isValid = false};
						};
					}
					else
					{
						_isValid = false;
					}
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
							_dlcID = (GW_EQUIP_ALL select _itemIndex) select 6;
							if (_dlcID != "") then
							{
								if (!(_dlcID in (getDLCs 1))) exitWith {_isValid = false};
							};
						}
						else
						{
							_isValid = false;
						}
					};
				} forEach _x;
			};
		} forEach _x;
	};
	
	//Break out of loop as there's no point in checking more
	if (!_isValid) exitWith {};
} forEach _equipmentArray;

_isValid 