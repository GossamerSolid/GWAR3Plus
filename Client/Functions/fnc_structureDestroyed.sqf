private["_structObjPos","_structDisplay","_structIcon","_sideAttacker","_structMarker"];

_structObjPos = _this select 0;
_sideAttacker = _this select 1;
_nameAttacker = _this select 2;
_structDisplay = _this select 3;
_structIcon = _this select 4;

//Notification
if ((GW_CVAR_SIDE) == _sideAttacker) then
{
	["notification",["GWAR3_StructureDestroyed",[_nameAttacker, _structDisplay, _structObjPos, _structIcon]]] Spawn fnc_clt_messages;
}
else
{
	["notification",["GWAR3_StructureLost",[_nameAttacker, _structDisplay, _structObjPos, _structIcon]]] Spawn fnc_clt_messages;
};