//Draw Distances & Qualities
GW_GVAR_VIEWDISTANCE = 3000;
GW_GVAR_OBJVIEWDISTANCE = 1500;
GW_GVAR_SHADOWDISTANCE = 100;
GW_GVAR_TERRAINGRID = 10;

//How many seconds the client will wait for a synchronized call response
GW_GVAR_NETWORK_SEVERRESPONSE_TIMEOUT = 300; //5 Minutes

//How many seconds till a client update (Might have to fiddle with this)
GW_CVAR_CLIENT_UPDATE = 0.5; //500ms

//Capture radius of a camp
GW_GVAR_CAMP_CAPTURE_RADIUS = 10;
//Capture radius of a depot
GW_GVAR_DEPOT_CAPTURE_RADIUS = 20;

//How close do you have to be to build off of MHQ or support vehicle
GW_GVAR_MHQ_BUILD_DISTANCE = 50; //50 meters

//How close to build off of a structure
GW_GVAR_STRUCT_BUILD_DISTANCE = 50; //50 Meters

//How close to service off of a service point
GW_GVAR_SERVICE_DISTANCE = 50; //50 meters
//Maximum speed of vehicle trying to be serviced
GW_GVAR_SERVICE_MAXSPEED = 5; //5Km/h
//Lowest speed of vehicle trying to be serviced
GW_GVAR_SERVICE_MINSPEED = -5; //-5Km/h

//Timeout in between special forces unit call ins
GW_GVAR_SPECIALFORCES_TIMEOUT = 600;

//Initial cost of picking a specialization
GW_GVAR_SPECALIZATION_INITIAL = 7500;

//Distance between each team's spawn point
GW_SPAWNDISTANCE = 3000; //3KM

//Amount of time that a zone is locked down after capture (in seconds)
GW_SERVER_LOCKDOWN_TIME = 900; //Lockdown for 15 minutes
GW_SERVER_LOCKDOWN_DEFEND_TIME = 600; //Attackers have 10 minutes to take a zone or it goes into lockdown
GW_SERVER_LOCKDOWN_BONUS = 300; //If the attackers take a camp, they get 5 minutes added to the clock. If a defender takes a camp back, they remove 5 minutes from the clock

//Max amount of strength points you can capture a zone at
GW_SERVER_MAX_CAPTURE_STRENGTH = 5;

//Zone inactive timeout (no enemies in the detection radius)
GW_SERVER_ZONE_TIMEOUT = 90;

//Commander Voting Wait (After a commander vote, you must wait this time before another starts)
GW_SERVER_COMMVOTE_WAIT = if (GW_DEVMODE) then {1} else {180}; //3 minutes
//Commander Voting Length (How long a vote goes on for)
GW_SERVER_COMMVOTE_TIME = if (GW_DEVMODE) then {10} else {60}; //1 Minute

//Starting Resources
GW_SERVER_START_MONEY = if (GW_DEVMODE) then {500000} else {GW_PARAM_MC_STARTING_MONEY};
GW_SERVER_START_SUPPLY = if (GW_DEVMODE) then {500000} else {GW_PARAM_MC_STARTING_SUPPLIES};

//Maximum supply allowed
GW_GVAR_MAXSUPPLY = 10000;
GW_GVAR_MAXSUPPLY_UPG = 20000;

//Timers for updater logic (in seconds)
//Update income
GW_SERVER_UPDATE_INCOME = 60; //1 Minute
//Update Income calculation
GW_SERVER_UPDATE_INCOME_CALC = 1; // 1 Minute
//Update garbage collection
GW_SERVER_UPDATE_GARBAGE = 10; //10 Seconds
//Main Update Thread time
GW_SERVER_UPDATE_MAIN = 1; //1 Second
//Zone update thread time
GW_SERVER_UPDATE_ZONES = 1; //1 Second
//Check for victory conditions
GW_SERVER_UPDATE_VICTORYCONDITIONS = 5; //5 Seconds

//Max concurrent network calls (Any higher amount will have to wait)
GW_SERVER_MAX_NETWORK_CALLS = 2048;
//Max amount of time that the network calls can be congested (in seconds)
GW_SERVER_MAX_NETWORK_TIMEOUT = 1;

//Garbage collection times
GW_SERVER_GARBAGE_TIME = 300; //5 Minutes

//Inactive vehicle collection times
GW_SERVER_INACTIVE_TIME = 1800; //30 Minutes

//Comm tower base range (0m ASL)
GW_SERVER_COMMTOWER_BASE_RANGE = 5000; //5KM
GW_SERVER_COMMTOWER_BASE_RANGE_UPG = 7000; //7KM
//Comm tower range modifier by ASL
GW_SERVER_COMMTOWER_RANGE_MODIFIER = 20; //20 x Meters ASL
GW_SERVER_COMMTOWER_RANGE_MODIFIER_UPG = 25; //25 x Meters ASL

//Zone Supply Calculation
//Each zone's maximum supply value is calculated based on a few factors including wealth multiplier, base wealth, bonus camp wealth and radius wealth
//max supply = round((Base Wealth + (Amount of Camps * Camp Bonus Wealth) + (Detection Radius * Radius Wealth Multiplier)) * Wealth Level Multiplayer)

//Zone Wealth Supply Multipliers
//Poor zones pay out 60% - 80% of their max supply
//Average zones pay out 80% - 100% of their max supply
//Rich zones pay out 100% - 110% of their max supply
GW_SERVER_ZONE_WEALTH_CONST = [[0.6,0.8],[0.8,1.0],[1.0, 1.1]];

//How much wealth a zone is worth at a baseline
GW_SERVER_ZONE_BASE_WEALTH = 150;

//How much wealth a zone is worth for every camp
GW_SERVER_ZONE_CAMP_BONUS_WEALTH = 50;

//How much wealth a zone is worth via radius
GW_SERVER_ZONE_CAMP_RADIUS_WEALTH = 0.35; //35% of detection radius

//Service cost multipliers
GW_SERVER_SERVICE_REPAIR = 0.25; //25% of unit's cost
GW_SERVER_SERVICE_REPAIR_UPG = 0.15; //15% of unit's cost
GW_SERVER_SERVICE_REFUEL = 0.10; //10% of unit's cost
GW_SERVER_SERVICE_REFUEL_UPG = 0.05; //5% of unit's cost
GW_SERVER_SERVICE_REARM = 0.35; //35% of unit's cost
GW_SERVER_SERVICE_REARM_UPG = 0.20; //20% of unit's cost

//Percentage of zone strength as supply income
GW_SERVER_ZONESUPPLYINCOME = 0.30; //30% of a zone's strength
GW_SERVER_ZONESUPPLYINCOME_UPG = 0.50; //50% of a zone's strength
//Percentage of zone strenght as cash income
GW_SERVER_ZONEMONEYINCOME = 0.80; //80% of a zone's strength
GW_SERVER_ZONEMONEYINCOME_UPG = 1.00; //100% of a zone's strength

GW_GVAR_MOBILIZATION_DISCOUNT = 0.05; //5% off of vehicles and infantry
GW_GVAR_MOBILIZATION_INFTIME = 0.25; //25% faster recruitment times for infantry
GW_GVAR_MOBILIZATION_VEHTIME = 0.15; //15% faster vehicle build times

GW_GVAR_FULL_MOBILIZATION_DISCOUNT = 0.07; //5% off of vehicles and infantry
GW_GVAR_FULL_MOBILIZATION_INFTIME = 0.50; //50% faster recruitment times for infantry
GW_GVAR_FULL_MOBILIZATION_VEHTIME = 0.35; //35% faster vehicle build times

GW_SERVER_CAMP_CAPTURE_BONUS = 1000; //$1000 for capturing a camp
GW_SERVER_ZONE_CAPTURE_BONUS = 3000; //$3000 for capturing a zone base rate
GW_SERVER_ZONE_CAPTURE_BONUS_CAMPS = 350; //$350 per camp in the zone

GW_GVAR_STRUCTURE_DAMAGE_WARN = 30; //Structure under attack, warn every 30 seconds

//How far the player needs to be from medics, spawnable vehicles, camps, etc to spawn at them
GW_GVAR_FRONTLINE_DISTANCE = 1500;
GW_GVAR_FRONTLINE_UPG_DISTANCE = 5000;
GW_GVAR_FRONTLINE_UPG2_DISTANCE = 10000;

//Altis Specifics
if (worldName == "Altis") then
{
	//Default Layout
	if (GW_PARAM_ML_ALTIS == 0) then
	{
		//Percentage of zone strength as supply income
		GW_SERVER_ZONESUPPLYINCOME = 0.55; //55% of a zone's strength
		GW_SERVER_ZONESUPPLYINCOME_UPG = 0.70; //70% of a zone's strength
		//Percentage of zone strenght as cash income
		GW_SERVER_ZONEMONEYINCOME = 1.00; //100% of a zone's strength
		GW_SERVER_ZONEMONEYINCOME_UPG = 1.20; //120% of a zone's strength
	};
	
	//Right Side only Layout
	if (GW_PARAM_ML_ALTIS == 1) then
	{
		//Percentage of zone strength as supply income
		GW_SERVER_ZONESUPPLYINCOME = 0.85; //85% of a zone's strength
		GW_SERVER_ZONESUPPLYINCOME_UPG = 1.05; //105% of a zone's strength
		//Percentage of zone strenght as cash income
		GW_SERVER_ZONEMONEYINCOME = 1.45; //145% of a zone's strength
		GW_SERVER_ZONEMONEYINCOME_UPG = 1.85; //185% of a zone's strength
	};
	
	//Classic Layout
	if (GW_PARAM_ML_ALTIS == 2) then
	{
		//Percentage of zone strength as supply income
		GW_SERVER_ZONESUPPLYINCOME = 0.35; //35% of a zone's strength
		GW_SERVER_ZONESUPPLYINCOME_UPG = 0.55; //55% of a zone's strength
		//Percentage of zone strenght as cash income
		GW_SERVER_ZONEMONEYINCOME = 0.80; //80% of a zone's strength
		GW_SERVER_ZONEMONEYINCOME_UPG = 1.00; //100% of a zone's strength
	};
};

//Stratis Specifics
if (worldName == "Stratis") then
{
	GW_SERVER_ZONESUPPLYINCOME = 1; //100% of a zone's strength
	GW_SERVER_ZONESUPPLYINCOME_UPG = 1.2; //120% of a zone's strength
	GW_SERVER_ZONEMONEYINCOME = 1.8; //180% of a zone's strength
	GW_SERVER_ZONEMONEYINCOME_UPG = 2.0; //200% of a zone's strength
	GW_SPAWNDISTANCE = 8000; //8KM

	//Comm tower base range (0m ASL)
	GW_SERVER_COMMTOWER_BASE_RANGE = 3000; //3KM
	GW_SERVER_COMMTOWER_BASE_RANGE_UPG = 4000; //4KM
	//Comm tower range modifier by ASL
	GW_SERVER_COMMTOWER_RANGE_MODIFIER = 5; //5 x Meters ASL
	GW_SERVER_COMMTOWER_RANGE_MODIFIER_UPG = 8; //8 x Meters ASL
};

//Sahrani Specifics
if (worldName == "SMD_Sahrani_A3") then
{
	GW_SERVER_ZONESUPPLYINCOME = 0.5; //100% of a zone's strength
	GW_SERVER_ZONESUPPLYINCOME_UPG = 1; //120% of a zone's strength
	GW_SERVER_ZONEMONEYINCOME = 1.2; //180% of a zone's strength
	GW_SERVER_ZONEMONEYINCOME_UPG = 1.7; //200% of a zone's strength
	GW_SPAWNDISTANCE = 12000; //12KM
	
	//Comm tower base range (0m ASL)
	GW_SERVER_COMMTOWER_BASE_RANGE = 3500; //4KM
	GW_SERVER_COMMTOWER_BASE_RANGE_UPG = 5500; //6KM
	//Comm tower range modifier by ASL
	GW_SERVER_COMMTOWER_RANGE_MODIFIER = 15; //20 x Meters ASL
	GW_SERVER_COMMTOWER_RANGE_MODIFIER_UPG = 20; //25 x Meters ASL
};