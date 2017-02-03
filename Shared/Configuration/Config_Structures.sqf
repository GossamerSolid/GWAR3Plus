//0 - Classname [GWAR Vanilla, GWAR+] (If it's a string, assumed to be the same for both)
//1 - Display name (Leave empty quotes if you want to pull it from the config)
//2 - Base Cost
//3 - Category (Base, Defenses, Other)
//4 - Sides
//5 - Height modification range [Min, Max] (Empty array means height can never be modified)
//6 - Spacing away from objects in meters (0 means the object has no collision prevention)
//7 - Research required (empty array means available from the start - array of one index of -1 means never available)
//8 - Initialization Script (A file that will be compiled and ran at structure creation - relative to Shared\Configuration\StructureScripts\)
//9 - Map Marker (Not used for "Other" category - Should be a class inside CfgMarkers)
//10 - On Screen Icon (Not used for "Other" category - Should be a file path from an addon)
//11 - Structure count limitations (0 means infinite of given structure)
//12 - Building Menu Picture
//13 - Unit types provided (Light, Heavy, Air, Infantry) - only used for "Base" category
//14 - Can be spawned on - only used for "Base" category
//15 - Counts towards victory - only used for "Base" category
//16 - time required to build - only used for "Base" category
//17 - Unique identifier (Leave this blank, it gets generated at init)
//18 - Starting position relative to commander
//19 - Death Script (A file that will be compiled and ran at structure destruction - relative to Shared\Configuration\StructureScripts\)
//20 - Unit build position - only used for non-infantry unit building (This is relative to the model position)
//21 - Additional properties (2D Array with extra properties)
//22 - Can structure's build location be obstructed?
//23 - Structure's Max Health (Only affects base structures)
//24 - Rewards/Punishment for Killing (Only affects base structures and defensive structures)

GW_DATA_ZONEDEPOT_CLASS = if (GW_GWPLUS) then {"GWAR3_ZoneDepot"} else {"Land_Cargo_Tower_V1_F"};

GW_DATA_STRUCTURES =
[
	/*****************/
	/*NATO structures*/
	/*****************/
	[
		["Land_Cargo_House_V1_F", "GWAR3_Barracks_F_West"],
		"Barracks",
		500,
		"Base",
		[west],
		[0,1],
		2,
		[-1],
		"",
		"GWAR3_MarkerBarracks",
		GW_MISSIONROOT + "Resources\images\struct_barracks.paa",
		3,
		GW_MISSIONROOT + "Resources\images\struct_barracks.paa",
		["infantry"],
		true,
		false,
		30,
		"072ECE7B887E14D42860C544D7FC678B386371B0",
		[0,20,0],
		"",
		[0,-10,0],
		["Barracks"],
		[false, 0],
		1500
	],
	[
		["Land_Lighthouse_small_F", "Land_Lighthouse_small_F"],
		"Naval Factory",
		500,
		"Base",
		[west],
		[-1,0],
		2,
		[-1],
		"",
		"GWAR3_MarkerService",
		GW_MISSIONROOT + "Resources\images\struct_naval.paa",
		3,
		GW_MISSIONROOT + "Resources\images\struct_naval.paa",
		["naval"],
		true,
		false,
		30,
		"D360A444D54F952A727E3221BF0D6998B6ADD8C2",
		[0,20,0],
		"",
		[25,-3,0],
		["Naval"],
		[true, 10],
		1500
	],
	[
		["Land_i_Garage_V1_F", "GWAR3_LightFac_F_West"],
		"Light Factory",
		1500,
		"Base",
		[west],
		[0,1],
		2,
		[-1],
		"",
		"GWAR3_MarkerLight",
		GW_MISSIONROOT + "Resources\images\struct_light.paa",
		3,
		GW_MISSIONROOT + "Resources\images\struct_light.paa",
		["light"],
		true,
		true,
		30,
		"FD10D969B7357E6D7C5EE3AF31D406BF27504763",
		[0,20,0],
		"",
		[20,-3,0],
		["Light"],
		[true, 10],
		1500
	],
	[
		["Land_CarService_F", "GWAR3_HeavyFac_F_West"],
		"Heavy Factory",
		2500,
		"Base",
		[west],
		[0,1],
		2,
		[-1],
		"",
		"GWAR3_MarkerHeavy",
		GW_MISSIONROOT + "Resources\images\struct_heavy.paa",
		3,
		GW_MISSIONROOT + "Resources\images\struct_heavy.paa",
		["heavy"],
		true,
		true,
		30,
		"6E9C30AB8513090FEADA54E187CB65AC52789BF2",
		[0,20,0],
		"",
		[20,-3,0],
		["Heavy"],
		[true, 10],
		1500
	],
	[
		["Land_Airport_Tower_F", "GWAR3_AirFac_F_West"],
		"Aircraft Factory",
		9000,
		"Base",
		[west],
		[0,1],
		2,
		[-1],
		"",
		"GWAR3_MarkerAirfact",
		GW_MISSIONROOT + "Resources\images\struct_air.paa",
		3,
		GW_MISSIONROOT + "Resources\images\struct_air.paa",
		["air"],
		true,
		true,
		30,
		"A738CFAC24C22972302DD137A5A2D95F4B09948C",
		[0,20,0],
		"",
		[20,-3,0],
		["Air"],
		[true, 20],
		1500
	],
	[
		["Land_Communication_F", "GWAR3_CommTower_F_West"],
		"Communications Tower",
		500,
		"Base",
		[west],
		[0,1],
		2,
		[-1],
		"structscript_init_commtower.sqf",
		"GWAR3_MarkerCommunications",
		GW_MISSIONROOT + "Resources\images\struct_communications.paa",
		5,
		GW_MISSIONROOT + "Resources\images\struct_communications.paa",
		[""],
		false,
		false,
		30,
		"41A75973FEBFE3E6240218AD86C514149C615977",
		[0,20,0],
		"",
		[0,0,0],
		["Comm"],
		[false, 0],
		1500
	],
	[
		["Land_Radar_Small_F", "GWAR3_Radar_F_West"],
		"Radar Station",
		2000,
		"Base",
		[west],
		[0,1],
		2,
		[-1],
		"structscript_init_commtower.sqf",
		"GWAR3_MarkerRadar",
		GW_MISSIONROOT + "Resources\images\struct_radar.paa",
		2,
		GW_MISSIONROOT + "Resources\images\struct_radar.paa",
		[""],
		false,
		false,
		30,
		"0803147147D58B790476245123C9CB3A80F0232C",
		[0,20,0],
		"",
		[0,0,0],
		["Radar"],
		[false, 0],
		1500
	],
	[
		["Land_FuelStation_Build_F", "GWAR3_ServiceDepot_F_West"],
		"Service Depot",
		500,
		"Base",
		[west],
		[0,1],
		2,
		[-1],
		"",
		"GWAR3_MarkerService",
		GW_MISSIONROOT + "Resources\images\struct_service.paa",
		3,
		GW_MISSIONROOT + "Resources\images\struct_service.paa",
		[""],
		false,
		false,
		30,
		"8C1B7335CA4240064CAFCFA856B926C9EFCA825B",
		[0,20,0],
		"",
		[0,0,0],
		["Service"],
		[false, 0],
		1500
	],
	[
		"B_HMG_01_high_F",
		"Mk30 HMG",
		130,
		"Defenses",
		[west],
		[-1,1],
		2,
		[-1],
		"",
		"HMG",
		"",
		3,
		"",
		[],
		false,
		false,
		0,
		"67858DB72B0D7D90BF1A2B13C2129BDE785B4DB0",
		[0,5,0],
		"",
		[0,0,0],
		[],
		[false, 0],
		1500
	],
	
	[
		"B_GMG_01_high_F",
		"Mk32 GMG 20mm",
		156,
		"Defenses",
		[west],
		[-1,1],
		2,
		[-1],
		"",
		"GMG",
		"",
		3,
		"",
		[],
		false,
		false,
		0,
		"946B1F09F95F67C22B293874B9289CB0D7FA6375",
		[0,5,0],
		"",
		[0,0,0],
		[],
		[false, 0],
		1500
	],
	
	[
		"B_HMG_01_high_F",
		"Mk35 AA MG",
		1560,
		"Defenses",
		[west],
		[-1,1],
		2,
		[-1],
		"structscript_init_aamg.sqf",
		"AA MG",
		"",
		2,
		"",
		[],
		false,
		false,
		0,
		"DA614F02A7386565975FFEA884958F5E204491D3",
		[0,5,0],
		"",
		[0,0,0],
		[],
		[false, 0],
		1500
	],
	
	[
		"B_static_AT_F",
		"Titan Launcher (AT)",
		1950,
		"Defenses",
		[west],
		[-1,1],
		2,
		[-1],
		"",
		"AT",
		"",
		2,
		"",
		[],
		false,
		false,
		0,
		"EACAAB54CE385074669316AC678D27A360055745",
		[0,5,0],
		"",
		[0,0,0],
		[],
		[false, 0],
		1500
	],
	
	[
		"B_static_AA_F",
		"Titan Launcher (AA)",
		1820,
		"Defenses",
		[west],
		[-1,1],
		2,
		[-1],
		"",
		"AA",
		"",
		2,
		"",
		[],
		false,
		false,
		0,
		"A4373127B070BED109CFC4C2050F0099503A726D",
		[0,5,0],
		"",
		[0,0,0],
		[],
		[false, 0],
		1500
	],
	
	/*****************/
	/*CSAT structures*/
	/*****************/
	[
		["Land_Cargo_House_V3_F", "GWAR3_Barracks_F_East"],
		"Barracks",
		500,
		"Base",
		[east],
		[0,1],
		2,
		[-1],
		"",
		"GWAR3_MarkerBarracks",
		GW_MISSIONROOT + "Resources\images\struct_barracks.paa",
		3,
		GW_MISSIONROOT + "Resources\images\struct_barracks.paa",
		["infantry"],
		true,
		false,
		30,
		"08D2A2C72E37F8CB26A7D8B0707B99275675BA4F",
		[0,20,0],
		"",
		[0,-10,0],
		["Barracks"],
		[false, 0],
		1500
	],
	[
		["Land_Lighthouse_small_F", "Land_Lighthouse_small_F"],
		"Naval Factory",
		500,
		"Base",
		[east],
		[-1,0],
		2,
		[-1],
		"",
		"GWAR3_MarkerService",
		GW_MISSIONROOT + "Resources\images\struct_naval.paa",
		3,
		GW_MISSIONROOT + "Resources\images\struct_naval.paa",
		["naval"],
		true,
		false,
		30,
		"3098EBE586190A52B709F6F64A168829103DC850",
		[0,20,0],
		"",
		[25,-3,0],
		["Naval"],
		[true, 10],
		1500
	],
	[
		["Land_i_Garage_V1_F", "GWAR3_LightFac_F_East"],
		"Light Factory",
		1500,
		"Base",
		[east],
		[0,1],
		2,
		[-1],
		"",
		"GWAR3_MarkerLight",
		GW_MISSIONROOT + "Resources\images\struct_light.paa",
		3,
		GW_MISSIONROOT + "Resources\images\struct_light.paa",
		["light"],
		true,
		true,
		30,
		"C61A798BA22CD8FF03C885C5455A3EAEE7FD8655",
		[0,20,0],
		"",
		[20,-3,0],
		["Light"],
		[true, 10],
		1500
	],
	[
		["Land_CarService_F", "GWAR3_HeavyFac_F_East"],
		"Heavy Factory",
		2500,
		"Base",
		[east],
		[0,1],
		2,
		[-1],
		"",
		"GWAR3_MarkerHeavy",
		GW_MISSIONROOT + "Resources\images\struct_heavy.paa",
		3,
		GW_MISSIONROOT + "Resources\images\struct_heavy.paa",
		["heavy"],
		true,
		true,
		30,
		"0BF9862801E3BFB31DC22555FC411B95E12A2DD0",
		[0,20,0],
		"",
		[20,-3,0],
		["Heavy"],
		[true, 10],
		1500
	],
	[
		["Land_Airport_Tower_F", "GWAR3_AirFac_F_East"],
		"Aircraft Factory",
		9000,
		"Base",
		[east],
		[0,1],
		2,
		[-1],
		"",
		"GWAR3_MarkerAirfact",
		GW_MISSIONROOT + "Resources\images\struct_air.paa",
		3,
		GW_MISSIONROOT + "Resources\images\struct_air.paa",
		["air"],
		true,
		true,
		30,
		"058E2F17D56D70699EC43F84A9682F014104320C",
		[0,20,0],
		"",
		[20,-3,0],
		["Air"],
		[true, 20],
		1500
	],
	[
		["Land_Communication_F", "GWAR3_CommTower_F_East"],
		"Communications Tower",
		500,
		"Base",
		[east],
		[0,1],
		2,
		[-1],
		"structscript_init_commtower.sqf",
		"GWAR3_MarkerCommunications",
		GW_MISSIONROOT + "Resources\images\struct_communications.paa",
		5,
		GW_MISSIONROOT + "Resources\images\struct_communications.paa",
		[""],
		false,
		false,
		30,
		"5701E1ED57AE38C15070255896D8CF73F8DFC9F3",
		[0,20,0],
		"",
		[0,0,0],
		["Comm"],
		[false, 0],
		1500
	],
	[
		["Land_Radar_Small_F", "GWAR3_Radar_F_East"],
		"Radar Station",
		2000,
		"Base",
		[east],
		[0,1],
		2,
		[-1],
		"structscript_init_commtower.sqf",
		"GWAR3_MarkerRadar",
		GW_MISSIONROOT + "Resources\images\struct_radar.paa",
		2,
		GW_MISSIONROOT + "Resources\images\struct_radar.paa",
		[""],
		false,
		false,
		30,
		"72C9B52C50A11DFF016C253FCA0FFBCEF05B6F5A",
		[0,20,0],
		"",
		[0,0,0],
		["Radar"],
		[false, 0],
		1500
	],
	[
		["Land_FuelStation_Build_F", "GWAR3_ServiceDepot_F_East"],
		"Service Depot",
		500,
		"Base",
		[east],
		[0,1],
		2,
		[-1],    
		"",
		"GWAR3_MarkerService",
		GW_MISSIONROOT + "Resources\images\struct_service.paa",
		3,
		GW_MISSIONROOT + "Resources\images\struct_service.paa",
		[""],
		false,
		false,
		30,
		"ABB76A089DD1C93FEFA19656B56F5135096BE084",
		[0,20,0],
		"",
		[0,0,0],
		["Service"],
		[false, 0],
		1500
	],
	[
		"O_HMG_01_high_F",
		"Mk30 HMG",
		130,
		"Defenses",
		[east],
		[-1,1],
		2,
		[-1],
		"",
		"HMG",
		"",
		3,
		"",
		[],
		false,
		false,
		0,
		"A528E35313DBEDAD9043D2CC7E454AB22E78686D",
		[0,5,0],
		"",
		[0,0,0],
		[],
		[false, 0],
		1500
	],
	
	[
		"O_GMG_01_high_F",
		"Mk32 GMG 20mm",
		156,
		"Defenses",
		[east],
		[-1,1],
		2,
		[-1],
		"",
		"GMG",
		"",
		3,
		"",
		[],
		false,
		false,
		0,
		"3D6C9D2FF084B5768F347D2E82C0C45FBDBE8783",
		[0,5,0],
		"",
		[0,0,0],
		[],
		[false, 0],
		1500
	],
	
	[
		"O_HMG_01_high_F",
		"Mk35 AA MG",
		1560,
		"Defenses",
		[east],
		[-1,1],
		2,
		[-1],
		"structscript_init_aamg.sqf",
		"AA MG",
		"",
		2,
		"",
		[],
		false,
		false,
		0,
		"DE864EAEACC2C00DE56BD53E22F33D3E4955DB95",
		[0,5,0],
		"",
		[0,0,0],
		[],
		[false, 0],
		1500
	],
	
	[
		"O_static_AT_F",
		"Titan Launcher (AT)",
		1950,
		"Defenses",
		[east],
		[-1,1],
		2,
		[-1],
		"",
		"AT",
		"",
		2,
		"",
		[],
		false,
		false,
		0,
		"17CA34D79158B33538CD00B634C4B31CA6D2FA51",
		[0,5,0],
		"",
		[0,0,0],
		[],
		[false, 0],
		1500
	],
	
	[
		"O_static_AA_F",
		"Titan Launcher (AA)",
		1820,
		"Defenses",
		[east],
		[-1,1],
		2,
		[-1],
		"",
		"AA",
		"",
		2,
		"",
		[],
		false,
		false,
		0,
		"E1F8FCBF5FC0B3B05E03339EB640832EE6ED17DA",
		[0,5,0],
		"",
		[0,0,0],
		[],
		[false, 0],
		1500
	],
	
	/*******************/
	/******Others*******/
	/*******************/
	[
		"CamoNet_BLUFOR_open_F",
		"Camo Net Open",
		5,
		"Other",
		[west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"5724E4145E181B3A4AF3CC3873D395C08EC0477E",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],	
	
	[
		"CamoNet_OPFOR_open_F",
		"Camo Net Open",
		5,
		"Other",
		[east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"B51EE8DA68BA2D93A2BBE1E3A0EFC98B4C633FAF",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],	
	
	[
		"CamoNet_BLUFOR_F",
		"Camo Net",
		5,
		"Other",
		[west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"5C78E019251EAF21E5CBF13612A0E9F0B6CD5B30",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],	
	
	[
		"CamoNet_OPFOR_F",
		"Camo Net",
		5,
		"Other",
		[east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"9CB414C04EBB36460975BBFB370685121CB5C7B1",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],

	[
		"CamoNet_OPFOR_big_F",
		"Camo Net Vehicle",
		10,
		"Other",
		[east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"2D2A830CBEFD9410D948DDBD378574891DAA4CBF",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"CamoNet_BLUFOR_big_F",
		"Camo Net Vehicle",
		10,
		"Other",
		[west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"67D020B4D40E02182CD2F1F03AEEEE2C7CC271D4",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],	
	
	[
		"Land_Razorwire_F",
		"Razor Wire",
		5,
		"Other",
		[west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"2CB0434F745E558FFE8C0F7997AE2C1B2CD1EEE3",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],	

	[
		"Land_BagBunker_Tower_F",
		"Bunker Tower",
		10,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"B1E96D9B480343D1CD4696B0A4E9E5BF0746DABE",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_BagBunker_Large_F",
		"Bunker Low",
		10,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"D0C2FC9C99AED8740923D294A63316B224BF5240",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_BagBunker_Small_F",
		"Bunker Small",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"BC76E9A3201C07E6EE0348A01C08FEAADD515100",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_BagFence_Long_F",
		"Sandbag Wall Long",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"47373D9FC78E9C480FCFBE19633B201AE84DDC11",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_BagFence_Short_F",
		"Sandbag Wall Short",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"7B6B5C19782FA768F83F742D32DD7AE8EC22C12F",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_BagFence_Corner_F",
		"Sandbag Wall Corner",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"193BCE89C9D427EB170C1E5CEC52B8A1A9471DAA",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_BagFence_Round_F",
		"Sandbag Wall Round",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"58FFFFE73A859AAE30DC2A923904DB4D09BD97E9",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_BagFence_End_F",
		"Sandbag Wall End",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"8EBB5DC618D86F307971A3FDD22430B6DA4376AA",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_CncBarrier_F",
		"Conrete Wall Low",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"28D6ACE4D9AE5CF5A4C07D820176B3F5C62FC90C",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_CncBarrierMedium_F",
		"Conrete Wall",
		10,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"D477E7501796526D78C105C44753ABC22A43BCA2",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_CncBarrierMedium4_F",
		"Conrete Wall Long",
		20,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"D5A873A99ECBFF9E34874F392521E653197B3438",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_CncShelter_F",
		"Conrete Tunnel",
		20,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"B3CC94A21A8103BD7F177339B7171625F54FD461",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_CncWall1_F",
		"Conrete Wall High",
		20,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"5791A0EC7A74EB46B54444FF52AD6C485500D1A8",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_CncWall4_F",
		"Conrete Wall High Long",
		30,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"44B9BB55DA9C515C7A105CC0665FED085EF706CD",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_HBarrier_1_F",
		"HBar (1)",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"2B3D1B16C75D2B00E52A92B5FE9E2F1E6567A65F",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_HBarrier_3_F",
		"HBar (3)",
		10,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"152A4F63C7814AEA8C1FFB81ADDC359010B4BCC9",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_HBarrier_5_F",
		"HBar (5)",
		15,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"FA5C854226589E6F960ECB638E690A4F5DDFAF74",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_HBarrierBig_F",
		"HBar Big",
		30,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"C522850814ECA3A5D35420DC2A953A3F3CA95591",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_HBarrierWall6_F",
		"HBar Wall Long",
		30,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"0A865D4FE94233C1408A9310E1AF06A862171EFA",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],

	[
		"Land_HBarrierWall_corner_F",
		"HBar Wall Corner",
		30,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"DEB8806B2E26BB00AE72126787E96F6FABF89DD0",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_HBarrierWall_corridor_F",
		"HBar Wall Corridor",
		30,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"E70F1AB602F55ADA701A60A82104E2EDB1735C5A",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_HBarrierTower_F",
		"HBar Tower Bunker",
		30,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"3276EE3398AFC6F0C56BBD5F4D9458EB0ECB77FB",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Shoot_House_Wall_Long_F",
		"Plywood Wall Long",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"2E18D40F63E34D1434EBE27828370A72AC2A0FB9",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Shoot_House_Panels_F",
		"Plywood Wall",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"94AEF57313BCF011E29D9771576F2D1732677105",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Shoot_House_Tunnel_F",
		"Plywood Wall Tunnel",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"7DA88A2C5C9B9F4985220BF8DC4289B282CBDC93",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Shoot_House_Panels_Window_F",
		"Plywood Wall Window",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"1AFAA1F738C2E5747A20E9628C6C67D86DDCC748",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Shoot_House_Corner_F",
		"Plywood Wall Corner",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"B63FD79F0C1E90A8E59DBC2AC8A49E869710315D",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Shoot_House_Corner_F",
		"Plywood Wall Corner",
		5,
		"Other",
		[west,east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"0483E2661D834B1D6CBB97C97CB0128DA42086AC",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Cargo40_military_green_F",
		"Long Cargo Container",
		15,
		"Other",
		[west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"8ACEC7187A41644A58AB64F04BA74BFCE3587876",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Cargo40_sand_F",
		"Long Cargo Container",
		15,
		"Other",
		[east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"AE19732DED6BAB9D9517BF0ED012EB38035AEBDA",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Cargo20_military_green_F",
		"Cargo Container",
		10,
		"Other",
		[west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"E5D0584D9DA1C68B33AE99959802961BCC7940F6",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Cargo20_sand_F",
		"Cargo Container",
		10,
		"Other",
		[east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"5E10CB23F5956B9857AEFC54DE471B8FD27C04CB",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Cargo10_military_green_F",
		"Small Cargo Container",
		5,
		"Other",
		[west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"E7C71059647237BCA91A2198CED6422FD8FCE0FD",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Cargo10_military_green_F",
		"Small Cargo Container",
		5,
		"Other",
		[west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"54BC804E144902AB14E229F390672601661AD75B",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Cargo10_sand_F",
		"Small Cargo Container",
		5,
		"Other",
		[east],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"8D848BBD5C5E282F2B13B8329DC1C02F41C3D18A",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Dirthump_1_F",
		"Mound",
		5,
		"Other",
		[east,west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"20D0777B2AA9A1127F991164432C1EC01B294812",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Dirthump_2_F",
		"Large Mound",
		10,
		"Other",
		[east,west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"BE84653544A90F1434DBEFA0B0CB411C4506C68A",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Obstacle_Ramp_F",
		"Foot Ramp",
		5,
		"Other",
		[east,west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"C5D5AB6A044DACFF2C9327C869AECAB3D569DBBA",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Obstacle_Bridge_F",
		"Foot Ramp Bridge",
		5,
		"Other",
		[east,west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"4EFB15A89D91B89F35EBCFD86789DDE1E1A23D74",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	],
	
	[
		"Land_Obstacle_Climb_F",
		"Ladder Bridge",
		5,
		"Other",
		[east,west],
		[-1,3],
		0,
		[-1],
		"",
		"mil_box",
		GW_MISSIONROOT + "Resources\images\gwar3_logo.paa",
		0,
		"",
		[],
		false,
		false,
		0,
		"70A48C0BD32396F76E6E863BA356090A655BF5C3",
		[0,10,0],
		"",
		[0,0,0],
		[],
		false,
		1
	]
];

//Parse it out
GW_STRUCTURES = [];
{
	_preSave = _x;
	if ((_preSave select 1) == "") then {_preSave set [1, (GetText (configFile >> "CfgVehicles" >> (_preSave select 0) >> "displayName"))]};
	if ((_preSave select 9) == "") then {_preSave set [9, (GetText (configFile >> "CfgVehicles" >> (_preSave select 0) >> "icon"))]};
	if ((_preSave select 10) == "") then {_preSave set [10, (GetText (configFile >> "CfgVehicles" >> (_preSave select 0) >> "picture"))]};
	if ((_preSave select 12) == "") then {_preSave set [12, (_preSave select 10)]};
	
	//Get classname
	_classNameData = _preSave select 0;
	if ((typeName _classNameData) == "STRING") then {_preSave set [0, _classNameData]};
	if ((typeName _classNameData) == "ARRAY") then
	{
		if (GW_GWPLUS) then {_preSave set [0, (_classNameData select 1)]} else {_preSave set [0, (_classNameData select 0)]};
	};
	
	//Add to array
	GW_STRUCTURES pushBack _preSave;
} forEach GW_DATA_STRUCTURES;