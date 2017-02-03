private["_baseStructNetCall"];

//Reset vars
GW_CVAR_HQ_INRANGE = false;
GW_CVAR_BARRACKS_INRANGE = false;
GW_CVAR_NAVAL_INRANGE = false;
GW_CVAR_LIGHT_INRANGE = false;
GW_CVAR_HEAVY_INRANGE = false;
GW_CVAR_AIR_INRANGE = false;
GW_CVAR_COMMTOWER_INRANGE = false;
GW_CVAR_SERVICE_INRANGE = false;
GW_CVAR_RESEARCH_INRANGE = false;
GW_CVAR_CAMP_INRANGE = false;
GW_CVAR_DEPOT_INRANGE = false;
GW_CVAR_SUPPORT_INRANGE = false;

//HQ (special case)
GW_CVAR_HQ_INRANGE = ((player distance GW_CVAR_MHQ) <= GW_GVAR_MHQ_BUILD_DISTANCE);
GW_CVAR_HQ_PIC = GW_MISSIONROOT + "Resources\images\struct_hq.paa";

//Parse list
{
	_structUID = _x getVariable "GW_STRUCTUID";
	_structIndex = [_structUID, 17, GW_CONSTRUCT_BASESTRUCT] Call fnc_shr_arrayGetIndex;
	if (_structIndex != -1) then
	{
		_structureArray = GW_CONSTRUCT_BASESTRUCT select _structIndex;
		if (("Comm" in (_structureArray select 21)) && (!GW_CVAR_COMMTOWER_INRANGE)) then
		{
			GW_CVAR_COMMTOWER_PIC = _structureArray select 10;
			_commDistance = player distance _x;
			_commRange = _x getVariable ["GW_COMMRANGE", 0];
			if (_commDistance <= _commRange) then {GW_CVAR_COMMTOWER_INRANGE = true};
		};
		if ("Barracks" in (_structureArray select 21) && (!GW_CVAR_BARRACKS_INRANGE)) then
		{
			GW_CVAR_BARRACKS_PIC = _structureArray select 10;
			_barracksDistance = player distance _x;
			if (_barracksDistance <= GW_GVAR_STRUCT_BUILD_DISTANCE) then {GW_CVAR_BARRACKS_INRANGE = true};
		};
		if ("Naval" in (_structureArray select 21) && (!GW_CVAR_NAVAL_INRANGE)) then
		{
			GW_CVAR_NAVAL_PIC = _structureArray select 10;
			_navalDistance = player distance _x;
			if (_navalDistance <= GW_GVAR_STRUCT_BUILD_DISTANCE) then {GW_CVAR_NAVAL_INRANGE = true};
		};
		if ("Light" in (_structureArray select 21) && (!GW_CVAR_LIGHT_INRANGE)) then
		{
			GW_CVAR_LIGHT_PIC = _structureArray select 10;
			_lightDistance = player distance _x;
			if (_lightDistance <= GW_GVAR_STRUCT_BUILD_DISTANCE) then {GW_CVAR_LIGHT_INRANGE = true};
		};
		if ("Heavy" in (_structureArray select 21) && (!GW_CVAR_HEAVY_INRANGE)) then
		{
			GW_CVAR_HEAVY_PIC = _structureArray select 10;
			_heavyDistance = player distance _x;
			if (_heavyDistance <= GW_GVAR_STRUCT_BUILD_DISTANCE) then {GW_CVAR_HEAVY_INRANGE = true};
		};
		if ("Air" in (_structureArray select 21) && (!GW_CVAR_AIR_INRANGE)) then
		{
			GW_CVAR_AIR_PIC = _structureArray select 10;
			_airDistance = player distance _x;
			if (_airDistance <= GW_GVAR_STRUCT_BUILD_DISTANCE) then {GW_CVAR_AIR_INRANGE = true};
		};
		if ("Service" in (_structureArray select 21) && (!GW_CVAR_SERVICE_INRANGE)) then
		{
			GW_CVAR_SERVICE_PIC = _structureArray select 10;
			_serviceDistance = player distance _x;
			if (_serviceDistance <= GW_GVAR_SERVICE_DISTANCE) then {GW_CVAR_SERVICE_INRANGE = true};
		};
		if ("Research" in (_structureArray select 21) && (!GW_CVAR_RESEARCH_INRANGE)) then
		{
			GW_CVAR_RESEARCH_PIC = _structureArray select 10;
			_researchDistance = player distance _x;
			if (_researchDistance <= GW_GVAR_STRUCT_BUILD_DISTANCE) then {GW_CVAR_RESEARCH_INRANGE = true};
		};
	};
} forEach GW_CVAR_BUILDINGS_BASE;

//Camp within range
if (count(GW_CVAR_CAMP) > 0) then 
{
	if ((GW_CVAR_CAMP select 3) == GW_CVAR_SIDE) then {GW_CVAR_CAMP_INRANGE = true};
};

//Depot within range
if (count(GW_CVAR_ZONE) > 1) then
{
	_depotObj = missionNameSpace getVariable (GW_CVAR_ZONE select 0);
	_depotSide = GW_CVAR_ZONE select 7;
	if (((player distance _depotObj) <= GW_GVAR_STRUCT_BUILD_DISTANCE) && (_depotSide == GW_CVAR_SIDE)) then {GW_CVAR_DEPOT_INRANGE = true};
};

//Officers are always in comm tower range
if (!GW_CVAR_COMMTOWER_INRANGE) then
{
	GW_CVAR_COMMTOWER_PIC = GW_MISSIONROOT + "Resources\images\struct_communications.paa"; //Dirty workaround
	if ((player getVariable ["GW_SPECIALIZATION", ""]) == "Officer") then {GW_CVAR_COMMTOWER_INRANGE = true};
};


