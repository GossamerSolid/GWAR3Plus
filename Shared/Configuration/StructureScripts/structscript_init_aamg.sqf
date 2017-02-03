//structscript_init_aamg.sqf
//Written by: GossamerSolid
//Initialize a AA MG Static

private ["_staticMGObj","_originalArgs","_side"];

_staticMGObj = _this select 0;
_originalArgs = _this select 1;
_side = _originalArgs select 0;

//Remove magazines and weapons
{_staticMGObj removeMagazine _x} forEach (magazines _staticMGObj);
{_staticMGObj removeWeapon _x} forEach (weapons _staticMGObj);

//Add AA MG
_staticMGObj addMagazine "680Rnd_35mm_AA_shells_Tracer_Red";
_staticMGObj addWeapon "autocannon_35mm";