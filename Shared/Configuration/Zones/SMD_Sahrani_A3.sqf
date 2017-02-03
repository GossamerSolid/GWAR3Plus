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
		"Paraiso",
		[Zone_0_0, Zone_0_1, Zone_0_2, Zone_0_3],
		550,
		"Zone_0_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_1,
		"Bagango",
		[Zone_1_0, Zone_1_1, Zone_1_2, Zone_1_3],
		400,
		"Zone_1_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_2,
		"North Corazol",
		[Zone_2_0, Zone_2_1, Zone_2_2],
		300,
		"Zone_2_Detect",
		0,
		0,
		guer,
		[0]
	],
	
	[
		Zone_3,
		"South Corazol",
		[Zone_3_0, Zone_3_1, Zone_3_2],
		300,
		"Zone_3_Detect",
		0,
		0,
		guer,
		[0]
	]
];