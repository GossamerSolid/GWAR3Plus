//vehscript_init_blackfoot.sqf
//Written by: GossamerSolid
//Vehicle script executed for the AH-99 blackfoot

private ["_vehObj","_originalArgs","_side"];

_vehObj = _this select 0;
_originalArgs = _this select 1;
_side = _originalArgs select 4;

_vehObj removeWeapon "missiles_ASRAAM";
_vehObj addMagazine "2Rnd_LG_scalpel";
_vehObj addMagazine "2Rnd_LG_scalpel";
_vehObj addWeapon "missiles_SCALPEL";