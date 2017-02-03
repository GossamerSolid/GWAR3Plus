private["_playerUID","_containerVar","_plyContainer","_maxSize","_playerObj","_playerSide","_commanderVarName","_rankIndex"];

_playerUID = _this;
_maxSize = 0;

_containerVar = format["GW_SESSION_%1",_playerUID];
_plyContainer = missionNamespace getVariable _containerVar;
if (!isNil "_plyContainer") then
{
	_maxSize = _plyContainer select 10;
};

//Bonuses from being commander + specializations
_playerObj = _playerUID Call fnc_shr_getObjFromUID;
_playerSide = _playerObj getVariable ["GW_SIDE", civilian];

_commanderVarName = Call Compile Format["GW_COMMANDER_%1",_playerSide];
if (_commanderVarName == (vehicleVarName _playerObj)) then
{
	_rankIndex = ["General", 0, GW_RANKS] Call fnc_shr_arrayGetIndex;
	_maxSize = (GW_RANKS select _rankIndex) select 2;
};

if ((_playerObj getVariable ["GW_SPECIALIZATION", ""]) == "Officer") then {_maxSize = _maxSize + 4};
if ((_playerObj getVariable ["GW_SPECIALIZATION", ""]) == "Special Forces") then {_maxSize = _maxSize min 8};
if ((_playerObj getVariable ["GW_SPECIALIZATION", ""]) == "Pilot") then {_maxSize = _maxSize min 3};



_maxSize 