//fnc_getSidevehicles.sqf
//Written by: GossamerSolid
//Gets an array of vehicles for a given side and type
//Doesn't return any vehicles with a research required of -1 (On purpose) and if the team doesn't have the research required for the unit

private["_sideFor","_vehicleType","_resultVehArray","_currentRecord","_sides","_vehType"];

_sideFor = _this select 0;
_vehicleType = _this select 1;

_resultVehArray = [];
{
	_currentRecord = _x;
	_vehTypes = _currentRecord select 3;
	_sides = _currentRecord select 4;
	_researches = _currentRecord select 6;
	if (!(-1 in _researches)) then
	{
		{
			_curSide = _x;
			{
				_research = _x;
				{
					_vehType = _x;
					if ((_curSide == _sideFor) && (_vehType == _vehicleType) && (true)) exitWith {_resultVehArray set [count _resultVehArray, _currentRecord]};
				} forEach _vehTypes;
			} forEach _researches;
		} forEach _sides;
	};
} forEach GW_VEHICLES;

_resultVehArray 