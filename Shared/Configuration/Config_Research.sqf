//0 - Name
//1 - Supply Cost
//2 - Prerequisites
//3 - Formatted Description
//4 - Action script (Optional - Ran on server side)
//5 - Condition script (Optional - Ran on server side)
//6 - Data (Whatever you want to store extra)

GW_DATA_RESEARCH =
[
	[
		"Surplus Sales",
		1250,
		[],
		format["Excess supplies past the maximum amount will automatically be converted into money for the entire team."],
		"",
		"",
		[]
	],
	
	[
		"Broadcast Range",
		2500,
		[],
		format["Increases the communication tower and radar station ranges of any existing structures and future structures to a base range of %1m + %2m for each meter above sea level. Previously a base range of %3m + %4m for each meter above sea level.",GW_SERVER_COMMTOWER_BASE_RANGE_UPG,GW_SERVER_COMMTOWER_RANGE_MODIFIER_UPG,GW_SERVER_COMMTOWER_BASE_RANGE,GW_SERVER_COMMTOWER_RANGE_MODIFIER],
		"action_broadcast_range.sqf",
		"",
		[]
	],
	
	[
		"Supply Storage",
		2500,
		[],
		format["Increases the maximum supply a team can have from %1 to %2.",GW_GVAR_MAXSUPPLY,GW_GVAR_MAXSUPPLY_UPG],
		"",
		"",
		[]
	],
	
	[
		"Armored MHQ",
		4170,
		[],
		"Replaces the MHQ vehicle with an armored IFV. The MHQ will now able to defend against infantry using an LMG and gain amphibious properties.",
		"action_armored_mhq.sqf",
		"condition_armored_mhq.sqf",
		[]
	],
	
	[
		"Limited Mobilization",
		4170,
		[],
		format["Provides a %1 percent discount on vehicles and infantry as well as %2 percent faster recruitment times for infantry and %3 percent faster build times for vehicles",(GW_GVAR_MOBILIZATION_DISCOUNT * 100),(GW_GVAR_MOBILIZATION_INFTIME * 100),(GW_GVAR_MOBILIZATION_VEHTIME * 100)],
		"",
		"",
		[]
	],
	
	[
		"Full Mobilization",
		6250,
		["Limited Mobilization"],
		format["Players can now purchase equipment at Zone Depots (as long as there are not enemies with 100m). Provides an additional %1 percent discount on vehicles and infantry as well as an additional %2 percent faster recruitment times for infantry and an additional %3 percent faster build times for vehicles",(GW_GVAR_FULL_MOBILIZATION_DISCOUNT * 100),(GW_GVAR_FULL_MOBILIZATION_INFTIME * 100),(GW_GVAR_FULL_MOBILIZATION_VEHTIME * 100)],
		"",
		"",
		[]
	],
	
	[
		"Improved Radar Detection",
		5000,
		["Broadcast Range"],
		format["Radar Stations will now sweep for enemy aircraft and artillery every 5 seconds (previously every 15 seconds). Radars can now detect aircraft at 30m above terrain level (previously 50m above terrain level)."],
		"",
		"",
		[]
	],
	
	[
		"Helicopter MHQ",
		6250,
		["Armored MHQ"],
		"Replaces the MHQ vehicle with a helicopter. The MHQ will now be able to easily travel distances in short periods of time.",
		"action_helicopter_mhq.sqf",
		"condition_helicopter_mhq.sqf",
		[]
	],
	
	[
		"Frontline Deployment",
		6250,
		[],
		format["Players are now allowed to deploy at friendly Zone Depots (as long as there are no enemies within 100m). Allows players on the team to deploy at friendly Spawn point vehicles, Player Medics and Camps at a death distance of %1m rather than the default %2m",GW_GVAR_FRONTLINE_UPG_DISTANCE,GW_GVAR_FRONTLINE_DISTANCE],
		"",
		"",
		[]
	],
	
	[
		"Logistics",
		6250,
		[],
		format["Reduces the cost of service fees, all fees are based on the vehicle base price. Repair costs are now %1 percent (previously %2 percent). Rearm costs are now %3 percent (previously %4 percent). Refuel costs are now %5 percent (previously %6 percent).",(GW_SERVER_SERVICE_REPAIR_UPG * 100),(GW_SERVER_SERVICE_REPAIR * 100),(GW_SERVER_SERVICE_REARM_UPG * 100),(GW_SERVER_SERVICE_REARM * 100),(GW_SERVER_SERVICE_REFUEL_UPG * 100),(GW_SERVER_SERVICE_REFUEL * 100)],
		"",
		"",
		[]
	],

	[
		"Efficient Occupation",
		8340,
		[],
		format["Increases the supply and money income generated from friendly Zones. Rates are based off of a percentage of the zone's current strength. Supply income is now %1 percent (previously %2 percent). Money income is now %3 percent (previously %4 percent).",(GW_SERVER_ZONESUPPLYINCOME_UPG * 100), (GW_SERVER_ZONESUPPLYINCOME * 100), (GW_SERVER_ZONEMONEYINCOME_UPG * 100), (GW_SERVER_ZONEMONEYINCOME * 100)],
		"",
		"",
		[]
	],
	
	[
		"Blitzkrieg Deployment",
		12500,
		["Frontline Deployment"],
		format["Allows players on the team to deploy at friendly Spawn point vehicles, Player Medics and Camps at a death distance of %1m rather than the %2m provided by Frontline Deployment",GW_GVAR_FRONTLINE_UPG2_DISTANCE,GW_GVAR_FRONTLINE_UPG_DISTANCE],
		"",
		"",
		[]
	]
];

GW_RESEARCH = GW_DATA_RESEARCH;

		
	/*
	[
		"Satellite Access",
		20000,
		[],
		"",
		"",
		"",
		[]
	],
	
	[
		"HALO Deployment",
		15000,
		[],
		"",
		"",
		"",
		[]
	]
	*/