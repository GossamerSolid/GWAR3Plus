//Init_Common.sqf
//Written by: GossamerSolid
//Initializes all required components that are shared between both client and server side

diag_log text "###[GW LOG] - Shared initialization started";

//Figure out mission parameters
//NOTE - For Map Layouts, make sure the variable is named GW_PARAM_ML_&WORLDNAME& or it will fail
GW_PARAM_VC_ZONES = ("VC_CaptureAllZones" call BIS_fnc_getParamValue) == 1;
GW_PARAM_VC_DESTRUCTION = ("VC_DestroyBases" call BIS_fnc_getParamValue) == 1;
GW_PARAM_VC_DESTRUCTION_SETTING = "VC_DestroyBases_Setting" call BIS_fnc_getParamValue;
GW_PARAM_VC_TICKETS = ("VC_Tickets" call BIS_fnc_getParamValue) == 1;
GW_PARAM_VC_TICKETS_CALC = "VC_Tickets_TicketBleed_Calculation" call BIS_fnc_getParamValue;
GW_PARAM_VC_TICKETS_FREQUENCY = "VC_Tickets_TicketBleed_Frequency" call BIS_fnc_getParamValue;
GW_PARAM_VC_TICKETS_MINTIME = "VC_Tickets_MinTimeBeforeBleed" call BIS_fnc_getParamValue;
GW_PARAM_VC_TICKETS_BLUEFOR = "VC_Tickets_NumberTickets_Bluefor" call BIS_fnc_getParamValue;
GW_PARAM_VC_TICKETS_REDFOR = "VC_Tickets_NumberTickets_Redfor" call BIS_fnc_getParamValue;
GW_PARAM_VC_SUDDENDEATH = ("VC_SuddenDeath" call BIS_fnc_getParamValue) == 1;
GW_PARAM_VC_SUDDENDEATH_TIME = "VC_SuddenDeath_Time" call BIS_fnc_getParamValue;
GW_PARAM_VC_TIMELIMIT = ("VC_Timelimit" call BIS_fnc_getParamValue) == 1;
GW_PARAM_VC_TIMELIMIT_LIMIT = "VC_Timelimit_Time" call BIS_fnc_getParamValue;
GW_PARAM_VC_TIMELIMIT_DECIDER = "VC_Timelimit_Decider" call BIS_fnc_getParamValue;
GW_PARAM_MC_STARTING_MONEY = "MC_Starting_Money" call BIS_fnc_getParamValue;
GW_PARAM_MC_STARTING_SUPPLIES = "MC_Starting_Supplies" call BIS_fnc_getParamValue;
GW_PARAM_MC_QUICKTIME = ("MC_QuickTime" call BIS_fnc_getParamValue) == 1;
//GW_PARAM_MC_ZONEVISIBILITY = "MC_ZoneVisibility" call BIS_fnc_getParamValue;
GW_PARAM_ML_ALTIS = "ML_Altis" call BIS_fnc_getParamValue;
GW_PARAM_ML_STRATIS = "ML_Stratis" call BIS_fnc_getParamValue;
GW_PARAM_ML_SMD_SAHRANI_A3 = "ML_Sahrani" call BIS_fnc_getParamValue;
GW_PARAM_ML_CHERNARUS = "ML_Chernarus" call BIS_fnc_getParamValue;

//Compile Shared Functions (Always use CompileFinal)
fnc_shr_getEquipArray = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getEquipArray.sqf";
fnc_shr_getFlagTex = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getFlagTex.sqf";
fnc_shr_getNearestZone = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getNearestZone.sqf";
fnc_shr_getNearestCamp = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getNearestCamp.sqf";
fnc_shr_getRandPos = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getRandPos.sqf";
fnc_shr_getSideColour = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getSideColour.sqf";
fnc_shr_getSideCount = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getSideCount.sqf";
fnc_shr_getSideMembers = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getSideMembers.sqf";
fnc_shr_getObjFromUID = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getObjFromUID.sqf";
fnc_shr_equipUnit = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_equipUnit.sqf";
fnc_shr_getSideEquipment = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getSideEquipment.sqf";
fnc_shr_getSideName = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getSideName.sqf";
fnc_shr_getUnitCost = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getUnitCost.sqf";
fnc_shr_getMHQ = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getMHQ.sqf";
fnc_shr_inString = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_inString.sqf";
fnc_shr_mergeArrays = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_mergeArrays.sqf";
fnc_shr_expandCargoArray = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_expandCargoArray.sqf";
fnc_shr_arrayGetIndex = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_arrayGetIndex.sqf";
fnc_shr_getEquipCfgClass = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getEquipCfgClass.sqf";
fnc_shr_getSquadSize = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getSquadSize.sqf";
fnc_shr_dumpArray = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_dumpArray.sqf";
fnc_shr_shuffleArray = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_shuffleArray.sqf";
fnc_shr_sortArrayByDistance = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_sortArrayByDistance.sqf";
fnc_shr_getSideVehicles = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getSideVehicles.sqf";
fnc_shr_getInfantryArray = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getInfantryLoadoutArray.sqf";
fnc_shr_getSideStructures = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getSideStructures.sqf";
fnc_shr_getHostilesInArea = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getHostilesInArea.sqf";
fnc_shr_isResearched = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_isResearched.sqf";
fnc_shr_getFrontlineDepDistance = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getFrontlineDepDistance.sqf"; 
fnc_shr_getEquipmentCost = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getEquipmentCost.sqf";
fnc_shr_getEquipmentValid = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getEquipmentValid.sqf";
fnc_shr_getDLCName = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getDLCName.sqf";
fnc_shr_getObjSide = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getObjSide.sqf";
fnc_shr_getCampName = CompileFinal preprocessFileLineNumbers "Shared\Functions\fnc_getCampName.sqf";

//Load Mission configs
_sharedGeneralConfig = CompileFinal preprocessFileLineNumbers "Shared\Configuration\Config_SharedGeneral.sqf";
_vehiclesConfig = CompileFinal preprocessFileLineNumbers "Shared\Configuration\Config_Vehicles.sqf";
_equipmentConfig = CompileFinal preprocessFileLineNumbers "Shared\Configuration\Config_Equipment.sqf";
_infantryConfig = CompileFinal preprocessFileLineNumbers "Shared\Configuration\Config_Infantry.sqf";
_structuresConfig = CompileFinal preprocessFileLineNumbers "Shared\Configuration\Config_Structures.sqf";
_defenderTemplatesConfig = CompileFinal preprocessFileLineNumbers "Shared\Configuration\Config_DefenderTemplates.sqf";
_ranksConfig = CompileFinal preprocessFileLineNumbers "Shared\Configuration\Config_Ranks.sqf";
_specsConfig = CompileFinal preprocessFileLineNumbers "Shared\Configuration\Config_Specializations.sqf";
_addonsConfig = CompileFinal preprocessFileLineNumbers "Shared\Configuration\Config_Addons.sqf";
_researchConfig = CompileFinal preprocessFileLineNumbers "Shared\Configuration\Config_Research.sqf";
[] Call _sharedGeneralConfig;
[] Call _vehiclesConfig;
[] Call _equipmentConfig;
[] Call _infantryConfig;
[] Call _structuresConfig;
[] Call _defenderTemplatesConfig;
[] Call _ranksConfig;
[] Call _specsConfig;
[] Call _addonsConfig;
[] Call _researchConfig;

_zoneConfig = Compile preprocessFileLineNumbers (format["Shared\Configuration\Zones\%1.sqf", worldName]);
if (!isNil "_zoneConfig") then 
{
	[] Call _zoneConfig;
}
else
{
	diag_log text format["###[GW ERROR] - init_shared.sqf could not find the zones config for %1 (%2)",worldName,(format["Shared\Configuration\Zones\%1.sqf", worldName])];
};

_startingLocConfig = Compile preprocessFileLineNumbers (format["Shared\Configuration\StartingLocations\%1.sqf", worldName]);
if (!isNil "_startingLocConfig") then 
{
	[] Call _startingLocConfig;
}
else
{
	diag_log text format["###[GW ERROR] - init_shared.sqf could not find the starting locations config for %1 (%2)",worldName,(format["Shared\Configuration\StartingLocations\%1.sqf", worldName])];
};

//Server is done initialization
GW_SHAREDINIT = true;
diag_log text "###[GW LOG] - Shared initialization completed";