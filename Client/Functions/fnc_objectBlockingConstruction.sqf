private["_structureDisplay","_position","_gridPos"];

_structureDisplay = _this select 0;
_position = _this select 1;

_gridPos = mapGridPosition _position;

["notification",["GWAR_ObjectBlockingConstruction",[_structureDisplay, _gridPos]]] Spawn fnc_clt_messages;