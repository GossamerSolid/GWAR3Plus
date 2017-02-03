private["_playerUID","_side","_countInfantry","_teamStructures","_structure","_buildQueue","_unitArray"];

_playerUID = _this select 0;
_side = _this select 1;
_countInfantry = 0;

_teamStructures = Call Compile Format["GW_BUILDINGS_BASE_%1",_side];
{
	_structure = _x;
	if (!isNull _structure) then
	{
		_buildQueue = _structure getVariable "GW_CONSTRUCTION_QUEUE";
		{
			//Only count queue for the player
			_queueUID = _x select 0;
			if (_queueUID == _playerUID) then
			{
				_unitArray = _x select 2;
				if ((_unitArray select 0) == "Infantry") then
				{
					_countInfantry = _countInfantry + 1;
				}
				else
				{
					{if (_x) then {_countInfantry = _countInfantry + 1};} forEach (_unitArray select 3);
				};
			};
		} forEach _buildQueue;
	};
} forEach _teamStructures;

_countInfantry 