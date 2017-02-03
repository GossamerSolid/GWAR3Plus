private["_side","_groupType","_group"];

_side = _this select 0;
_groupType = _this select 1;
_group = grpNull;

_group = Call Compile Format["GW_%1GROUP_%2",_groupType, _side];
if (isNull _group) then 
{
	Call Compile Format["GW_%1GROUP_%2 = createGroup %2",_groupType, _side];
	_group = Call Compile Format["GW_%1GROUP_%2",_groupType, _side];
};

_group 