private["_unit","_uniformsArray","_uniform","_helmArray","_helmet","_facewearArray","_facewear"];

_unit = _this;

//Uniform
_uniformsArray = [guer, "UNIFORMS"] Call fnc_shr_getSideEquipment;
_uniform = (_uniformsArray select (floor(random((count _uniformsArray) - 1)))) select 0;

//Helmet
_helmArray = [guer, "HEADGEAR"] Call fnc_shr_getSideEquipment;
_helmArray pushBack "none";
_helmet = (_helmArray select (floor(random((count _helmArray) - 1)))) select 0;

//Facewear
_facewearArray = [guer, "FACEWEAR"] Call fnc_shr_getSideEquipment;
_facewearArray pushBack "none";
_facewear = (_facewearArray select (floor(random((count _facewearArray) - 1)))) select 0;

removeUniform _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit forceAddUniform _uniform;
if (_helmet != "none") then {_unit addHeadgear _helmet};
if (_facewear != "none") then {_unit addGoggles _facewear};