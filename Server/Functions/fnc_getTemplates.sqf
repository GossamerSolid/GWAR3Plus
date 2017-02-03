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
	
	//Player's Saved Templates (These can either be DB stored or on the session)
	if (GW_DATABASE) then
	{
		_dbRequest = "GetPlayerTemplates";
		if (GW_GWPLUS) then {_dbRequest = "GetPlayerTemplates+"};
		Call Compile Format["GW_TEMPLATES_DB_%1 = []", _playerUID];
		_extGetTemplates = [format["GW_TEMPLATES_DB_%1", _playerUID], ["db"], [GW_SERVERKEY, _dbRequest, _playerUID, _playerSide]] Spawn fnc_srv_spawnExtension;
		waitUntil {scriptDone _extGetTemplates};
		
		_dbTemplates = Call Compile(((Call Compile Format["GW_TEMPLATES_DB_%1", _playerUID]) select 0) select 1);
		_plyContainer set [12, _dbTemplates];
	};
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