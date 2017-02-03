//fnc_isResearched.sqf
//Written by: GossamerSolid
//See if a specified tech is researched for a specified team

private["_side", "_techName", "_isResearched", "_sideResearchArray", "_researchIndex"];

_side = _this select 0;
_techName = _this select 1;
_isResearched = false;

_sideResearchArray = Call Compile Format["GW_RESEARCH_%1",_side];
if (!isNil "_sideResearchArray") then
{
	_researchIndex = [_techName, 0, GW_RESEARCH] Call fnc_shr_arrayGetIndex;
	if (_researchIndex != -1) then
	{
		_isResearched = _sideResearchArray select _researchIndex;
	};
};

_isResearched 