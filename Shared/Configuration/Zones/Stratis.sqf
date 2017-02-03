//Zone definitions
//Data Structure
//0 - Depot Object Name
//1 - Display Name
//2 - Array of Camps Object Names
//3 - Detection Radius
//4 - Detection Center Point Marker (Leave as empty quotes and it'll use the depot as a reference instead)
//5 - Maximum Supply Output - Set to 0 if you want it to auto calculate
//6 - Starting capture strength - Set to 0 if you want it to auto calculate (don't put this higher than maximum)
//7 - Starting Owner
//8 - Layout Array - What layouts should this zone configuration entry be used in?

GW_DATA_ZONES =
[
	[
		Zone_0,
		"Air Base",
		[Zone_0_0, Zone_0_1, Zone_0_2],
		300,
		"Zone_0_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_1,
		"Agia Marina",
		[Zone_1_0, Zone_1_1, Zone_1_2],
		300,
		"Zone_1_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_2,
		"Camp Rogain",
		[Zone_2_0, Zone_2_1],
		250,
		"Zone_2_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_3,
		"Kamino Range",
		[Zone_3_0, Zone_3_1],
		250,
		"Zone_3_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_4,
		"Mike 26",
		[Zone_4_0, Zone_4_1],
		250,
		"Zone_4_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_5,
		"Camp Maxwell",
		[Zone_5_0, Zone_5_1],
		250,
		"Zone_5_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_6,
		"Camp Tempest",
		[Zone_6_0, Zone_6_1],
		250,
		"Zone_6_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_7,
		"Girna",
		[Zone_7_0, Zone_7_1],
		250,
		"Zone_7_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_8,
		"Agios Cephas",
		[Zone_8_0, Zone_8_1],
		250,
		"Zone_8_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_9,
		"Kill Farm",
		[Zone_9_0, Zone_9_1],
		250,
		"Zone_9_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_10,
		"Relay Station",
		[Zone_10_0, Zone_10_1],
		250,
		"Zone_10_Detect",
		0,
		0,
		guer,
		[0]
	]
]