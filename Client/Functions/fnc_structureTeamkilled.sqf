private["_structObjPos","_structDisplay","_structIcon","_sideAttacker","_structMarker"];

_structObjPos = _this select 0;
_sideAttacker = _this select 1;
_nameAttacker = _this select 2;
_structDisplay = _this select 3;
_structIcon = _this select 4;

//Notification
["notification",["GWAR3_StructureTeamkilled",[_nameAttacker, _structDisplay, _structObjPos, _structIcon]]] Spawn fnc_clt_messages;
