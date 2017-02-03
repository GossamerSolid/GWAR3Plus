private["_sideFor","_colType","_returnCol"];
_sideFor = toLower(str(_this select 0));
_colType = _this select 1;

_returnCol = "";

if (_colType == "Class") then
{
	_returnCol = "colorWhite";
	if (_sideFor == "west") then {_returnCol = "colorBLUFOR"};
	if (_sideFor == "east") then {_returnCol = "colorOPFOR"};
	if (_sideFor == "guer") then {_returnCol = "colorYellow"};
};
if (_colType == "Hex") then
{
	_returnCol = "#FFFFFF";
	if (_sideFor == "west") then {_returnCol = "#004c99"};
	if (_sideFor == "east") then {_returnCol = "#800000"};
	if (_sideFor == "guer") then {_returnCol = "#d9d900"};
};
if (_colType == "SquadHex") then
{
	_returnCol = "#FFFFFF";
	if (_sideFor == "west") then {_returnCol = "#004c99"};
	if (_sideFor == "east") then {_returnCol = "#800000"};
	if (_sideFor == "guer") then {_returnCol = "#d9d900"};
};
if (_colType == "RGB" || _colType == "RGBA") then
{
	_returnCol = [1,1,1];
	if (_sideFor == "west") then {_returnCol = [0,0.2980,0.6]};
	if (_sideFor == "east") then {_returnCol = [0.5019,0,0]};
	if (_sideFor == "guer") then {_returnCol = [0.8509,0.8509,0]};
	
	//Append on alpha if RGBA
	if (_colType == "RGBA") then {_returnCol set [count _returnCol, 1]};
};

_returnCol 