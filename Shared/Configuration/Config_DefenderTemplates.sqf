//Zone Defender Templates
//0 - Name of template
//1 - 1 or 3 templates - 1 signifies all teams share the squad - 3 signifies each team's separate squad
//2 - Minimum time elapsed before this template will be used (0 means available from start)
GW_DATA_DEFENDER_TEMPLATES =
[
	[
		"Rifles Squad",
		[
			//Bluefor
			[
				["Infantry","Rifleman"],
				["Infantry","Rifleman"],
				["Infantry","Grenadier"],
				["Infantry","Medic"],
				["Infantry","Automatic Rifleman"]
			],
			
			//Opfor
			[
				["Infantry","Rifleman"],
				["Infantry","Rifleman"],
				["Infantry","Grenadier"],
				["Infantry","Medic"],
				["Infantry","Machinegunner"]
			],
			
			//Resistance
			[
				["Infantry","Rifleman"],
				["Infantry","Rifleman"],
				["Infantry","Grenadier"],
				["Infantry","Medic"],
				["Infantry","Machinegunner"]
			]
		],
		0
	],

	[
		"Light AT Squad",
		[
			[
				["Infantry","Rifleman"],
				["Infantry","Rifleman"],
				["Infantry","Light AT"],
				["Infantry","Light AT"]
			]
		],
		0
	],
		
	[
		"Support Squad",
		[
			//Bluefor
			[
				["Infantry","Rifleman"],
				["Infantry","Medic"],
				["Infantry","Automatic Rifleman"],
				["Infantry","Marksman"]
			],
			
			//Opfor
			[
				["Infantry","Rifleman"],
				["Infantry","Medic"],
				["Infantry","Machinegunner"],
				["Infantry","Marksman"]
			],
			
			//Resistance
			[
				["Infantry","Rifleman"],
				["Infantry","Medic"],
				["Infantry","Machinegunner"],
				["Infantry","Marksman"]
			]
		],
		0
	],
		
	[
		"Heavy AT Squad",
		[
			[
				["Infantry","Rifleman"],
				["Infantry","Rifleman"],
				["Infantry","Heavy AT"],
				["Infantry","Heavy AT"]
			]
		],
		1200
	],
	
	[
		"AA Squad",
		[
			[
				["Infantry","Rifleman"],
				["Infantry","Rifleman"],
				["Infantry","Anti-Air"],
				["Infantry","Anti-Air"]
			]
		],
		1800
	],
	
	[
		"Vehicle Recon",
		[
			//Bluefor
			[
				["Vehicle","F1037B7FBC43D40960E73A683638F7C47C91FF91"]
			],
			
			//Opfor
			[
				["Vehicle","8E94BAEADE055A01E99168670A7C545359767DCC"]
			],
			
			//Resistance
			[
				["Vehicle","50C4581BBEDA1E21627EFA5386CED8C3F0D53024"]
			]
		],
		1800
	],
	
	[
		"Vehicle IFV",
		[
			//Bluefor
			[
				["Vehicle","96F371668DF44DF96BE99A6E3F3E08199376514C"]
			],
			
			//Opfor
			[
				["Vehicle","50090AB7F68D21CB6494E943F3D44C52C9074000"]
			],
			
			//Resistance
			[
				["Vehicle","F04A0A91F6BFBAD73AC2DFC125308BD20DF40622"]
			]
		],
		2700
	],
	
	[
		"Vehicle APC",
		[
			//Bluefor
			[
				["Vehicle","9E1E25549F015E74800DB943F11A5192BA359C13"]
			],
			
			//Opfor
			[
				["Vehicle","227FF17A71F3E0694FC08A2AF9D273B0C0E034C4"]
			],
			
			//Resistance
			[
				["Vehicle","3B525A2ECD954D85A2E3601C823CDF228B38DD4C"]
			]
		],
		2700
	],
	
	[
		"Vehicle Tank",
		[
			//Bluefor
			[
				["Vehicle","E9309785E1A8F1DAD13C96F11C58CDEE9CADE90F"]
			],
			
			//Opfor
			[
				["Vehicle","00B8604C14F03C5413DDA70828286ACAEC9E0CE0"]
			],
			
			//Resistance
			[
				["Vehicle","A90DFB6D8182937DE79382A34196009F32CDC5E1"]
			]
		],
		3600
	]
];
GW_DEFENDER_TEMPLATES = GW_DATA_DEFENDER_TEMPLATES;