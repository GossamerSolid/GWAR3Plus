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
		"Athira",
		[Zone_0_0, Zone_0_1, Zone_0_2, Zone_0_3],
		450,
		"Zone_0_Detect",
		0,
		0,
		guer,
		[0,2]
	],
	
	[
		Zone_1,
		"Sofia",
		[Zone_1_0, Zone_1_1, Zone_1_2],
		400,
		"Zone_1_Detect",
		0,
		0,
		guer,
		[0,1,2]
	],
	
	[
		Zone_2,
		"Kavala",
		[Zone_2_0, Zone_2_1, Zone_2_2],
		325,
		"Zone_2_Detect",
		0,
		0,
		guer,
		[0,2]
	],
	
	[
		Zone_3,
		"Pyrgos",
		[Zone_3_0, Zone_3_1, Zone_3_2],
		400,
		"Zone_3_Detect",
		0,
		0,
		guer,
		[0,1,2]
	],
	
	[
		Zone_4,
		"Zaros",
		[Zone_4_0, Zone_4_1, Zone_4_2],
		400,
		"Zone_4_Detect",
		0,
		0,
		guer,
		[0,2]
	],
	
	[
		Zone_5,
		"Agios Dionysios",
		[Zone_5_0, Zone_5_1, Zone_5_2],
		325,
		"Zone_5_Detect",
		0,
		0,
		guer,
		[0,2]
	],
	
	[
		Zone_6,
		"Charkia",
		[Zone_6_0, Zone_6_1, Zone_6_2],
		350,
		"Zone_6_Detect",
		0,
		0,
		guer,
		[0,1,2]
	],
	
	[
		Zone_7,
		"Paros",
		[Zone_7_0, Zone_7_1, Zone_7_2],
		350,
		"Zone_7_Detect",
		0,
		0,
		guer,
		[0,1,2]
	],
	
	[
		Zone_8,
		"Neochori",
		[Zone_8_0, Zone_8_1, Zone_8_2],
		325,
		"Zone_8_Detect",
		0,
		0,
		guer,
		[0,2]
	],
	
	[
		Zone_9,
		"Panagia",
		[Zone_9_0, Zone_9_1],
		250,
		"Zone_9_Detect",
		0,
		0,
		guer,
		[0,1,2]
	],

	[
		Zone_11,
		"Syrta",
		[Zone_11_0, Zone_11_1],
		275,
		"Zone_11_Detect",
		0,
		0,
		guer,
		[0,2]
	],
	
	[
		Zone_12,
		"Molos",
		[Zone_12_0, Zone_12_1],
		325,
		"Zone_12_Detect",
		0,
		0,
		guer,
		[0,1,2]
	],
	
	[
		Zone_13,
		"Telos",
		[Zone_13_0, Zone_13_1, Zone_13_2, Zone_13_3],
		450,
		"Zone_13_Detect",
		0,
		0,
		guer,
		[2]
	],
	
	[
		Zone_14,
		"Negades",
		[Zone_14_0, Zone_14_1],
		250,
		"Zone_14_Detect",
		0,
		0,
		guer,
		[0,2]
	],
	
	[
		Zone_15,
		"Chalkeia",
		[Zone_15_0, Zone_15_1, Zone_15_2],
		350,
		"Zone_15_Detect",
		0,
		0,
		guer,
		[0,1,2]
	],
	
	[
		Zone_16,
		"Panochori",
		[Zone_16_0, Zone_16_1],
		325,
		"Zone_16_Detect",
		0,
		0,
		guer,
		[0,2]
	],
	
	[
		Zone_17,
		"Abdera",
		[Zone_17_0, Zone_17_1],
		250,
		"Zone_17_Detect",
		0,
		0,
		guer,
		[0,2]
	],
	
	[
		Zone_19,
		"Rodopoli",
		[Zone_19_0, Zone_19_1, Zone_19_2],
		350,
		"Zone_19_Detect",
		0,
		0,
		guer,
		[0,1,2]
	],
	
	[
		Zone_20,
		"Lakka",
		[Zone_20_0, Zone_20_1],
		300,
		"Zone_20_Detect",
		0,
		0,
		guer,
		[0,2]
	],
	
	[
		Zone_21,
		"Poliakko",
		[Zone_21_0, Zone_21_1],
		300,
		"Zone_21_Detect",
		0,
		0,
		guer,
		[2]
	],
	
	[
		Zone_22,
		"Kalochori",
		[Zone_22_0, Zone_22_1],
		300,
		"Zone_22_Detect",
		0,
		0,
		guer,
		[1,2]
	],
	
	[
		Zone_23,
		"Feres",
		[Zone_23_0, Zone_23_1],
		250,
		"Zone_23_Detect",
		0,
		0,
		guer,
		[1,2]
	],
	
	[
		Zone_24,
		"Selakano",
		[Zone_24_0, Zone_24_1],
		250,
		"Zone_24_Detect",
		0,
		0,
		guer,
		[0,1,2]
	],
	
	[
		Zone_25,
		"Dorida",
		[Zone_25_0, Zone_25_1, Zone_25_2],
		300,
		"Zone_25_Detect",
		0,
		0,
		guer,
		[1,2]
	],
	
	[
		Zone_26,
		"Anthrakia",
		[Zone_26_0, Zone_26_1],
		250,
		"Zone_26_Detect",
		0,
		0,
		guer,
		[2]
	],
	
	[
		Zone_27,
		"Kore",
		[Zone_27_0, Zone_27_1],
		250,
		"Zone_27_Detect",
		0,
		0,
		guer,
		[2]
	],
	
	[
		Zone_28,
		"Galati",
		[Zone_28_0, Zone_28_1],
		250,
		"Zone_28_Detect",
		0,
		0,
		guer,
		[2]
	],
	
	[
		Zone_29,
		"Frini",
		[Zone_29_0, Zone_29_1],
		250,
		"Zone_29_Detect",
		0,
		0,
		guer,
		[2]
	],
	
	[
		Zone_30,
		"Neri",
		[Zone_30_0, Zone_30_1],
		250,
		"Zone_30_Detect",
		0,
		0,
		guer,
		[2]
	],
	
	[
		Zone_31,
		"Gravia",
		[Zone_31_0, Zone_31_1],
		250,
		"Zone_31_Detect",
		0,
		0,
		guer,
		[2]
	],
	
	[
		Zone_32,
		"Aggelochori",
		[Zone_32_0, Zone_32_1],
		300,
		"Zone_32_Detect",
		0,
		0,
		guer,
		[2]
	],
	
	[
		Zone_33,
		"Ioannina",
		[Zone_33_0, Zone_33_1],
		300,
		"Zone_33_Detect",
		0,
		0,
		guer,
		[0,1,2]
	],
	
	[
		Zone_34,
		"Kalithea",
		[Zone_34_0, Zone_34_1],
		250,
		"Zone_34_Detect",
		0,
		0,
		guer,
		[2]
	]
];