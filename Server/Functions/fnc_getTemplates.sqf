private["_playerUID","_playerSide","_getPrices","_returnData"];

_playerUID = _this select 0;
_playerSide = _this select 1;
_getPrices = if (count(_this) > 2) then {_this select 2} else {false};
_returnData = [];

_containerVar = format["GW_SESSION_%1",_playerUID];
_plyContainer = missionNamespace getVariable _containerVar;
if (!isNil "_plyContainer") then
{
	//Last Purchase Template (can't delete)
	_lastPurchased = ["Last Purchased",false,(_plyContainer select 5),true];
	if (_getPrices) then
	{
		_price = (_plyContainer select 5) Call fnc_shr_getEquipmentCost;
		_lastPurchased pushBack _price;
	};
	_returnData pushBack _lastPurchased;

	//Team Default (can't delete)
	_teamDefault = ["Team Default",false,(Call Compile Format["GW_DATA_STARTEQUIP_%1",_playerSide]),false];
	if (_getPrices) then
	{
		_price = (Call Compile Format["GW_DATA_STARTEQUIP_%1",_playerSide]) Call fnc_shr_getEquipmentCost;
		_teamDefault pushBack _price;
	};
	_returnData pushBack _teamDefault;
	
	_playerTemplates = _plyContainer select 12;
	
	{
		if (_getPrices) then
		{
			_price = (_x select 2) Call fnc_shr_getEquipmentCost;
			_returnData pushBack [(_x select 0), true, (_x select 2), true, _price];
		}
		else
		{
			_returnData pushBack [(_x select 0), true, (_x select 2), true];
		};
	} forEach _playerTemplates;
};

_returnData 