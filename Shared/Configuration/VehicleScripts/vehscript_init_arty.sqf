//vehscript_init_arty.sqf
//Written by: GossamerSolid
//Vehicle script executed for artillery units which keeps track of when they last fired as to mark them on the radar

private ["_vehObj", "_unitObj"];

_vehObj = _this select 0;

_vehObj addEventHandler ["Fired", 
{
	_unitObj = _this select 0;
	
	_unitObj setVariable ["GW_ARTYLASTFIRED", time];
}];