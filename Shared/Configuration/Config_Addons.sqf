//Addon Configuration
//0 - Name of Addon (Make sure it matches CfgPatches entry)
//1 - Display name of addon (Something that makes sense if you see it)
//2 - Version of Addon required

if (GW_GWPLUS) then
{
	GW_DATA_ADDONS =
	[
		[
			"GWAR3_Buildings",
			"GWAR3 Buildings",
			0.2
		],
		
		[
			"GWAR3_Core",
			"GWAR3 Core",
			0.3
		],
		
		[
			"GWAR3_Images",
			"GWAR3 Images",
			0.2
		],
		
		[
			"GWAR3_Sounds",
			"GWAR3 Sounds",
			0.1
		],
		
		[
			"GWAR3_Vehicles",
			"GWAR3 Vehicles",
			0.1
		],
		
		[
			"asdg_jointrails",
			"ASDG Joint Rails",
			-1
		],
		
		[
			"hlcweapons_core",
			"HLC Core",
			-1
		],
		
		[
			"hlcweapons_aks",
			"HLC AK Pack",
			-1
		],
		
		[
			"hlcweapons_ar15",
			"HLC AR15 Pack",
			-1
		],
		
		[
			"hlcweapons_AUG",
			"HLC AUG Pack",
			-1
		],
		
		[
			"hlcweapons_falpocalypse",
			"HLC FAL Pack",
			-1
		],
		
		[
			"hlcweapons_g3",
			"HLC G3 Pack",
			-1
		],
		
		[
			"hlcweapons_m14",
			"HLC M14 Pack",
			-1
		],
		
		[
			"hlcweapons_m60e4",
			"HLC M60 Pack",
			-1
		],
		
		[
			"hlcweapons_mp5",
			"HLC MP5 Pack",
			-1
		]
	];
}
else
{
	GW_DATA_ADDONS = [];
};