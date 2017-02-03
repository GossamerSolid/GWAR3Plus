/*
fnc_getCampName.sqf
Written by: GossamerSolid
Get the short or long name designation for a camp's index within the zone's camp array
Only supports up to 6 camps
*/

private["_campIndex","_nameLength","_campName"];

_campIndex = _this select 0;
_nameLength = _this select 1;
_campName = "";

switch (_campIndex) do
{
	case 0: {_campName = if (_nameLength == "short") then {"A"} else {"Alpha"};};
	case 1: {_campName = if (_nameLength == "short") then {"B"} else {"Bravo"};};
	case 2: {_campName = if (_nameLength == "short") then {"C"} else {"Charlie"};};
	case 3: {_campName = if (_nameLength == "short") then {"D"} else {"Delta"};};
	case 4: {_campName = if (_nameLength == "short") then {"E"} else {"Echo"};};
	case 5: {_campName = if (_nameLength == "short") then {"F"} else {"Foxtrot"};};
};

_campName 