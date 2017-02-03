//Base classnames for each team
GW_DATA_INFANTRYCLASS_WEST = if (GW_GWPLUS) then {"GWAR3_B_Soldier_F"} else {"B_Soldier_F"};
GW_DATA_INFANTRYCLASS_EAST = if (GW_GWPLUS) then {"GWAR3_O_Soldier_F"} else {"O_Soldier_F"};
GW_DATA_INFANTRYCLASS_GUER = if (GW_GWPLUS) then {"GWAR3_I_Soldier_F"} else {"I_Soldier_F"};

//Loadouts used for certain purposes
GW_INFANTRY_DRIVER = "Rifleman";
GW_INFANTRY_CREW = "Crewman";
GW_INFANTRY_RPILOT = "Rotary-Wing Pilot";
GW_INFANTRY_FPILOT = "Fixed-Wing Pilot";
GW_INFANTRY_TURRET = "Rifleman";

//Base cost of infantry unit
GW_DATA_INFANTRY_BASECOST = 100;
GW_GVAR_INFANTRY_BASECOST_WEST = GW_DATA_INFANTRY_BASECOST;
GW_GVAR_INFANTRY_BASECOST_EAST = GW_DATA_INFANTRY_BASECOST;
GW_GVAR_INFANTRY_BASECOST_GUER = GW_DATA_INFANTRY_BASECOST;

//Cost of infantry modifiers
//TO-DO

//Loadouts
//0 - Loadout Name (Must be unique on the selected side)
//1 - Loadout Cost
//2 - Side available (Only one side)
//3 - Loadout array (same as players)
//4 - time to build
if (GW_GWPLUS) then
{
	GW_DATA_INFANTRY_LOADOUTS =
	[
		//Bluefor Loadouts
		[
			"Rifleman", 
			100,
			west,
			[
				"H_HelmetB", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["FirstAidKit"]], //Uniform
				["V_PlateCarrier1_rgr",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["RH_M16A4_m",["","acc_pointer_IR","optic_Aco",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Grenadier",
			150,
			west,
			[
				"H_HelmetSpecB_blk", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["HandGrenade","FirstAidKit"]], //Uniform
				["V_PlateCarrierGL_rgr",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","SmokeShell"]], //Vest
				["",[]], //Backpack
				["RH_M16A4gl",["","acc_pointer_IR","optic_Aco",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Automatic Rifleman",
			200,
			west,
			[
				"H_HelmetB_snakeskin", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["FirstAidKit"]], //Uniform
				["V_PlateCarrier2_rgr",["RH_60Rnd_556x45_Mk318","RH_60Rnd_556x45_Mk318","RH_60Rnd_556x45_Mk318","RH_60Rnd_556x45_Mk318","RH_60Rnd_556x45_Mk318","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["RH_M27IAR",["","acc_pointer_IR","optic_Aco",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Marksman", 
			200,
			west,
			[
				"H_HelmetB_grass", //Helmet
				"", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam_vest",["16Rnd_9x21_Mag","16Rnd_9x21_Mag","FirstAidKit"]], //Uniform
				["V_PlateCarrier1_rgr",["RH_20Rnd_762x51_Mk319","RH_20Rnd_762x51_Mk319","RH_20Rnd_762x51_Mk319","RH_20Rnd_762x51_Mk319","RH_20Rnd_762x51_Mk319","RH_20Rnd_762x51_Mk319","RH_20Rnd_762x51_Mk319","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["RH_sr25ec",["","acc_pointer_IR","optic_Hamr",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["hgun_P07_F",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Light AT", 
			300,
			west,
			[
				"H_HelmetB_sand", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["FirstAidKit"]], //Uniform
				["V_PlateCarrier2_rgr",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_AssaultPack_rgr",["NLAW_F","NLAW_F"]], //Backpack
				["RH_M16A4_m",["","acc_pointer_IR","optic_Aco",""]], //Primary Weapon
				["launch_NLAW_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Heavy AT", 
			400,
			west,
			[
				"H_HelmetSpecB_paint1", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["FirstAidKit"]], //Uniform
				["V_PlateCarrierSpec_rgr",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_Kitbag_rgr",["Titan_AT","Titan_AT"]], //Backpack
				["RH_M4_ris_m",["","acc_pointer_IR","optic_Holosight",""]], //Primary Weapon
				["launch_B_Titan_short_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Anti-Air", 
			650,
			west,
			[
				"H_HelmetSpecB_paint2", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["FirstAidKit"]], //Uniform
				["V_PlateCarrierSpec_rgr",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_Kitbag_rgr",["Titan_AA","Titan_AA"]], //Backpack
				["RH_M4_ris_m",["","acc_pointer_IR","optic_Holosight",""]], //Primary Weapon
				["launch_B_Titan_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Sniper", 
			400,
			west,
			[
				"", //Helmet
				"", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_B_GhillieSuit",["16Rnd_9x21_Mag","16Rnd_9x21_Mag","FirstAidKit"]], //Uniform
				["V_Chestrig_rgr",["7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["srifle_LRR_F",["","","optic_SOS",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["hgun_P07_F",["muzzle_snds_L","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Medic", 
			400,
			west,
			[
				"H_HelmetB_light_desert", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam_tshirt",["FirstAidKit"]], //Uniform
				["V_PlateCarrierSpec_rgr",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","SmokeShell","SmokeShell"]], //Vest
				["B_AssaultPack_rgr",["Medikit"]], //Backpack
				["RH_M4_ris_m",["","acc_pointer_IR","optic_Aco",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Engineer", 
			300,
			west,
			[
				"H_HelmetB_desert", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam_vest",["FirstAidKit"]], //Uniform
				["V_Chestrig_rgr",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_Kitbag_mcamo",["Toolkit","MineDetector","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag"]], //Backpack
				["RH_M4_ris_m",["","acc_pointer_IR","optic_Aco",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Crewman", 
			50,
			west,
			[
				"H_HelmetCrew_B", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam_vest",["FirstAidKit"]], //Uniform
				["V_BandollierB_rgr",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["RH_M4_ris_m",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Rotary-Wing Pilot", 
			50,
			west,
			[
				"H_PilotHelmetHeli_B", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_HeliPilotCoveralls",["FirstAidKit"]], //Uniform
				["V_TacVest_blk",["RH_32Rnd_9mm_HP","RH_32Rnd_9mm_HP","RH_32Rnd_9mm_HP","SmokeShell"]], //Vest
				["",[]], //Backpack
				["RH_sbr9",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Fixed-Wing Pilot", 
			50,
			west,
			[
				"H_PilotHelmetFighter_B", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_PilotCoveralls",["RH_32Rnd_9mm_HP","RH_32Rnd_9mm_HP","RH_32Rnd_9mm_HP","SmokeShell","FirstAidKit"]], //Uniform
				["",[]], //Vest
				["B_Parachute",[]], //Backpack
				["RH_sbr9",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Officer", 
			50,
			west,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam_vest",["16Rnd_9x21_Mag","16Rnd_9x21_Mag","FirstAidKit"]], //Uniform
				["",[]], //Vest
				["",[]], //Backpack
				["",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["hgun_P07_F",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Special Forces Operator", 
			400,
			west,
			[
				"H_Beret_02", //Helmet
				"G_Bandanna_beast", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_I_G_Story_Protagonist_F",["FirstAidKit"]], //Uniform
				["V_PlateCarrierGL_rgr",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["RH_M4_ris_m",["RH_fa556","acc_pointer_IR","optic_Hamr",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Special Forces AT", 
			600,
			west,
			[
				"H_Beret_02", //Helmet
				"G_Bandanna_beast", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_I_G_Story_Protagonist_F",["FirstAidKit"]], //Uniform
				["V_PlateCarrierGL_rgr",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_Kitbag_rgr",["Titan_AT","Titan_AT"]], //Backpack
				["RH_M4_ris_m",["RH_fa556","acc_pointer_IR","optic_Hamr",""]], //Primary Weapon
				["launch_B_Titan_short_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Special Forces Marksman", 
			600,
			west,
			[
				"H_Beret_02", //Helmet
				"G_Bandanna_beast", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_I_G_Story_Protagonist_F",["FirstAidKit"]], //Uniform
				["V_PlateCarrierGL_rgr",["RH_20Rnd_762x51_Mk319","RH_20Rnd_762x51_Mk319","RH_20Rnd_762x51_Mk319","RH_20Rnd_762x51_Mk319","RH_20Rnd_762x51_Mk319","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["RH_SR25EC",["RH_fa762","acc_pointer_IR","optic_Hamr",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],

		//OPFOR Loadouts
		[
			"Rifleman", 
			100,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["hlc_rifle_ak12",["","acc_pointer_IR","optic_ACO_grn",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Grenadier",
			150,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_HarnessOGL_brn",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_VOG25_AK","hlc_VOG25_AK","hlc_VOG25_AK","hlc_VOG25_AK","hlc_VOG25_AK","SmokeShell"]], //Vest
				["",[]], //Backpack
				["hlc_rifle_ak12GL",["","acc_pointer_IR","optic_ACO_grn",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Automatic Rifleman",
			200,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["RH_18Rnd_9x19_gsh","RH_18Rnd_9x19_gsh","FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["hlc_45Rnd_545x39_t_rpk","hlc_45Rnd_545x39_t_rpk","hlc_45Rnd_545x39_t_rpk","hlc_45Rnd_545x39_t_rpk","hlc_45Rnd_545x39_t_rpk","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["hlc_rifle_RPK12",["","acc_pointer_IR","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["RH_gsh18",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Machinegunner",
			225,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["RH_18Rnd_9x19_gsh","RH_18Rnd_9x19_gsh","FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["150Rnd_762x51_Box","150Rnd_762x51_Box","150Rnd_762x51_Box","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["LMG_Zafir_F",["","acc_pointer_IR","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["RH_gsh18",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Marksman", 
			200,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["RH_18Rnd_9x19_gsh","RH_18Rnd_9x19_gsh","FirstAidKit"]], //Uniform
				["V_TacVest_khk",["10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["srifle_DMR_01_F",["","","optic_DMS",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["RH_gsh18",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Light AT", 
			300,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_TacVest_khk",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_FieldPack_ocamo",["RPG32_F","RPG32_F","RPG32_HE_F","RPG32_HE_F"]], //Backpack
				["hlc_rifle_ak12",["","","optic_ACO_grn",""]], //Primary Weapon
				["launch_RPG32_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Heavy AT", 
			400,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_TacVest_khk",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_FieldPack_cbr",["Titan_AT","Titan_AT"]], //Backpack
				["hlc_rifle_aku12",["","acc_pointer_IR","optic_ACO_grn",""]], //Primary Weapon
				["launch_O_Titan_short_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Anti-Air", 
			650,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_TacVest_khk",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","HandGrenade"]], //Vest
				["B_FieldPack_ocamo",["Titan_AA","Titan_AA"]], //Backpack
				["hlc_rifle_aku12",["","acc_pointer_IR","optic_ACO_grn",""]], //Primary Weapon
				["launch_O_Titan_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Sniper", 
			400,
			east,
			[
				"", //Helmet
				"", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_O_GhillieSuit",["RH_18Rnd_9x19_gsh","RH_18Rnd_9x19_gsh","FirstAidKit"]], //Uniform
				["V_Chestrig_khk",["5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["srifle_GM6_F",["","","optic_LRPS",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["RH_gsh18",["muzzle_snds_L","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Medic", 
			400,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_TacVest_khk",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","SmokeShell","SmokeShell"]], //Vest
				["B_FieldPack_ocamo",["Medikit"]], //Backpack
				["hlc_rifle_ak12",["","acc_pointer_IR","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Engineer", 
			300,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_Carryall_ocamo",["Toolkit","MineDetector","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag"]], //Backpack
				["hlc_rifle_aku12",["","acc_pointer_IR","optic_ACO_grn",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Crewman", 
			50,
			east,
			[
				"H_HelmetCrew_O", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_BandollierB_khk",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["hlc_rifle_aku12",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Rotary-Wing Pilot", 
			50,
			east,
			[
				"H_PilotHelmetHeli_O", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_PilotCoveralls",["FirstAidKit"]], //Uniform
				["V_TacVest_khk",["30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag","SmokeShell"]], //Vest
				["",[]], //Backpack
				["SMG_02_F",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Fixed-Wing Pilot", 
			50,
			east,
			[
				"H_PilotHelmetFighter_O", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_PilotCoveralls",["30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag","SmokeShell","FirstAidKit"]], //Uniform
				["",[]], //Vest
				["B_Parachute",[]], //Backpack
				["SMG_02_F",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Officer", 
			50,
			east,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_OfficerUniform_ocamo",["RH_18Rnd_9x19_gsh","RH_18Rnd_9x19_gsh","FirstAidKit"]], //Uniform
				["",[]], //Vest
				["",[]], //Backpack
				["",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["RH_gsh18",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Assistant Mortarman", 
			100,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_Chestrig_khk",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["O_Mortar_01_support_F",[]], //Backpack
				["hlc_rifle_aku12",["","acc_pointer_IR","optic_ACO_grn",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Special Forces Operator", 
			400,
			east,
			[
				"H_Beret_blk", //Helmet
				"G_Bandanna_aviator", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_O_OfficerUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["hlc_rifle_aku12",["hlc_muzzle_545SUP_AK","acc_pointer_IR","optic_Arco",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Special Forces AT", 
			600,
			east,
			[
				"H_Beret_blk", //Helmet
				"G_Bandanna_aviator", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_O_OfficerUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_FieldPack_cbr",["Titan_AT","Titan_AT"]], //Backpack
				["hlc_rifle_aku12",["hlc_muzzle_545SUP_AK","acc_pointer_IR","optic_Arco",""]], //Primary Weapon
				["launch_O_Titan_short_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Special Forces Marksman", 
			600,
			east,
			[
				"H_Beret_blk", //Helmet
				"G_Bandanna_aviator", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_O_OfficerUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["hlc_rifle_ak12",["hlc_muzzle_545SUP_AK","acc_pointer_IR","optic_DMS",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		
		
		
		//MILITIA Loadout
		//Don't bother with face, helmet or uniform customization, a script randomly picks an option
		[
			"Rifleman", 
			100,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_Chestrig_oli",["hlc_30Rnd_545x39_B_AK","hlc_30Rnd_545x39_B_AK","hlc_30Rnd_545x39_B_AK","hlc_30Rnd_545x39_B_AK","hlc_30Rnd_545x39_B_AK","HandGrenade"]], //Vest
				["",[]], //Backpack
				["hlc_rifle_ak74_dirty",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Grenadier",
			110,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_Chestrig_blk",["hlc_30Rnd_762x39_b_ak","hlc_30Rnd_762x39_b_ak","hlc_30Rnd_762x39_b_ak","hlc_30Rnd_762x39_b_ak","hlc_30Rnd_762x39_b_ak","hlc_VOG25_AK","hlc_VOG25_AK","hlc_VOG25_AK"]], //Vest
				["",[]], //Backpack
				["hlc_rifle_akmgl",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Medic", 
			160,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_TacVest_blk",["hlc_30Rnd_9x19_B_MP5","hlc_30Rnd_9x19_B_MP5","hlc_30Rnd_9x19_B_MP5","hlc_30Rnd_9x19_B_MP5","hlc_30Rnd_9x19_B_MP5"]], //Vest
				["B_TacticalPack_blk",["Medikit"]], //Backpack
				["hlc_smg_mp5a2",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Machinegunner",
			120,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_TacVest_blk",["hlc_100Rnd_762x51_B_M60E4","hlc_100Rnd_762x51_B_M60E4","hlc_100Rnd_762x51_B_M60E4"]], //Vest
				["",[]], //Backpack
				["hlc_lmg_m60",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Light AT", 
			120,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_TacVest_blk",["hlc_30Rnd_545x39_B_AK","hlc_30Rnd_545x39_B_AK","hlc_30Rnd_545x39_B_AK","hlc_30Rnd_545x39_B_AK","hlc_30Rnd_545x39_B_AK"]], //Vest
				["B_TacticalPack_blk",["RPG32_F","RPG32_F"]], //Backpack
				["hlc_rifle_aks74u",["","","",""]], //Primary Weapon
				["launch_RPG32_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Heavy AT", 
			140,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_TacVest_blk",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318"]], //Vest
				["B_TacticalPack_blk",["Titan_AT","Titan_AT"]], //Backpack
				["RH_m4",["","","",""]], //Primary Weapon
				["launch_I_Titan_short_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Anti-Air", 
			180,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_TacVest_blk",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318"]], //Vest
				["B_TacticalPack_blk",["Titan_AA","Titan_AA"]], //Backpack
				["RH_M16A2",["","","",""]], //Primary Weapon
				["launch_I_Titan_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Marksman", 
			110,
			guer,
			[
				"", //Helmet
				"", //Face
				"Binocular", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_BandollierB_khk",["16Rnd_9x21_Mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag"]], //Vest
				["",[]], //Backpack
				["srifle_DMR_06_olive_F",["","","optic_KHS_old",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		]
	];
}
else
{
	GW_DATA_INFANTRY_LOADOUTS =
	[
		//Bluefor Loadouts
		[
			"Rifleman", 
			100,
			west,
			[
				"H_HelmetB", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["FirstAidKit"]], //Uniform
				["V_PlateCarrier1_rgr",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["arifle_MX_F",["","acc_pointer_IR","optic_Aco",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Grenadier",
			150,
			west,
			[
				"H_HelmetSpecB_blk", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["HandGrenade","FirstAidKit"]], //Uniform
				["V_PlateCarrierGL_rgr",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","SmokeShell"]], //Vest
				["",[]], //Backpack
				["arifle_MX_GL_F",["","acc_pointer_IR","optic_Aco",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Automatic Rifleman",
			200,
			west,
			[
				"H_HelmetB_snakeskin", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["FirstAidKit"]], //Uniform
				["V_PlateCarrier2_rgr",["100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["arifle_MX_SW_F",["","acc_pointer_IR","optic_Aco","bipod_01_F_snd"]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Machinegunner",
			350,
			west,
			[
				"H_HelmetB_snakeskin", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["FirstAidKit"]], //Uniform
				["V_PlateCarrier2_rgr",["HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_TacticalPack_mcamo",["130Rnd_338_Mag","130Rnd_338_Mag","130Rnd_338_Mag","130Rnd_338_Mag"]], //Backpack
				["MMG_02_black_F",["","acc_pointer_IR","optic_Aco","bipod_01_F_blk"]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Marksman", 
			200,
			west,
			[
				"H_HelmetB_grass", //Helmet
				"", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam_vest",["16Rnd_9x21_Mag","16Rnd_9x21_Mag","FirstAidKit"]], //Uniform
				["V_PlateCarrier1_rgr",["20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["srifle_EBR_F",["","acc_pointer_IR","optic_Hamr","bipod_01_F_snd"]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["hgun_P07_F",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Light AT", 
			300,
			west,
			[
				"H_HelmetB_sand", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["FirstAidKit"]], //Uniform
				["V_PlateCarrier2_rgr",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_AssaultPack_rgr",["NLAW_F","NLAW_F"]], //Backpack
				["arifle_MX_F",["","acc_pointer_IR","optic_Aco",""]], //Primary Weapon
				["launch_NLAW_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Heavy AT", 
			400,
			west,
			[
				"H_HelmetSpecB_paint1", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["FirstAidKit"]], //Uniform
				["V_PlateCarrierSpec_rgr",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_Kitbag_rgr",["Titan_AT","Titan_AT"]], //Backpack
				["arifle_MXC_F",["","acc_pointer_IR","optic_Holosight",""]], //Primary Weapon
				["launch_B_Titan_short_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Anti-Air", 
			650,
			west,
			[
				"H_HelmetSpecB_paint2", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam",["FirstAidKit"]], //Uniform
				["V_PlateCarrierSpec_rgr",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_Kitbag_rgr",["Titan_AA","Titan_AA"]], //Backpack
				["arifle_MXC_F",["","acc_pointer_IR","optic_Holosight",""]], //Primary Weapon
				["launch_B_Titan_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Sniper", 
			400,
			west,
			[
				"", //Helmet
				"", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_B_GhillieSuit",["16Rnd_9x21_Mag","16Rnd_9x21_Mag","FirstAidKit"]], //Uniform
				["V_Chestrig_rgr",["7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["srifle_LRR_F",["","","optic_SOS","bipod_01_F_blk"]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["hgun_P07_F",["muzzle_snds_L","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Medic", 
			400,
			west,
			[
				"H_HelmetB_light_desert", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam_tshirt",["FirstAidKit"]], //Uniform
				["V_PlateCarrierSpec_rgr",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","SmokeShell","SmokeShell"]], //Vest
				["B_AssaultPack_rgr",["Medikit"]], //Backpack
				["arifle_MXC_F",["","acc_pointer_IR","optic_Aco",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Engineer", 
			300,
			west,
			[
				"H_HelmetB_desert", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam_vest",["FirstAidKit"]], //Uniform
				["V_Chestrig_rgr",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_Kitbag_mcamo",["Toolkit","MineDetector","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag"]], //Backpack
				["arifle_MXC_F",["","acc_pointer_IR","optic_Aco",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Crewman", 
			50,
			west,
			[
				"H_HelmetCrew_B", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam_vest",["FirstAidKit"]], //Uniform
				["V_BandollierB_rgr",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["arifle_MXC_F",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Rotary-Wing Pilot", 
			50,
			west,
			[
				"H_PilotHelmetHeli_B", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_HeliPilotCoveralls",["FirstAidKit"]], //Uniform
				["V_TacVest_blk",["30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01","SmokeShell"]], //Vest
				["",[]], //Backpack
				["SMG_01_F",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Fixed-Wing Pilot", 
			50,
			west,
			[
				"H_PilotHelmetFighter_B", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_PilotCoveralls",["30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01","SmokeShell","FirstAidKit"]], //Uniform
				["",[]], //Vest
				["B_Parachute",[]], //Backpack
				["SMG_01_F",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Officer", 
			50,
			west,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_B_CombatUniform_mcam_vest",["16Rnd_9x21_Mag","16Rnd_9x21_Mag","FirstAidKit"]], //Uniform
				["",[]], //Vest
				["",[]], //Backpack
				["",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["hgun_P07_F",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Special Forces Operator", 
			400,
			west,
			[
				"H_Beret_02", //Helmet
				"G_Bandanna_beast", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_I_G_Story_Protagonist_F",["FirstAidKit"]], //Uniform
				["V_PlateCarrierGL_rgr",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["arifle_MXC_F",["muzzle_snds_H","acc_pointer_IR","optic_Hamr",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Special Forces AT", 
			600,
			west,
			[
				"H_Beret_02", //Helmet
				"G_Bandanna_beast", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_I_G_Story_Protagonist_F",["FirstAidKit"]], //Uniform
				["V_PlateCarrierGL_rgr",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_Kitbag_rgr",["Titan_AT","Titan_AT"]], //Backpack
				["arifle_MXC_F",["muzzle_snds_H","acc_pointer_IR","optic_Hamr",""]], //Primary Weapon
				["launch_B_Titan_short_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Special Forces Marksman", 
			600,
			west,
			[
				"H_Beret_02", //Helmet
				"G_Bandanna_beast", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_I_G_Story_Protagonist_F",["FirstAidKit"]], //Uniform
				["V_PlateCarrierGL_rgr",["10Rnd_338_Mag","10Rnd_338_Mag","10Rnd_338_Mag","10Rnd_338_Mag","10Rnd_338_Mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["srifle_DMR_02_F",["muzzle_snds_338_black","acc_pointer_IR","optic_AMS","bipod_01_F_blk"]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],

		//OPFOR Loadouts
		[
			"Rifleman", 
			100,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["arifle_Katiba_F",["","acc_pointer_IR","optic_ACO_grn",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Grenadier",
			150,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_HarnessOGL_brn",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","SmokeShell"]], //Vest
				["",[]], //Backpack
				["arifle_Katiba_GL_F",["","acc_pointer_IR","optic_ACO_grn",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Automatic Rifleman",
			200,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["16Rnd_9x21_Mag","16Rnd_9x21_Mag","FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["150Rnd_762x54_Box","150Rnd_762x54_Box","150Rnd_762x54_Box","150Rnd_762x54_Box","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["LMG_Zafir_F",["","acc_pointer_IR","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["hgun_Rook40_F",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Machinegunner",
			350,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["16Rnd_9x21_Mag","16Rnd_9x21_Mag","FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["HandGrenade","SmokeShell"]], //Vest
				["B_FieldPack_cbr",["150Rnd_93x64_Mag","150Rnd_93x64_Mag","150Rnd_93x64_Mag"]], //Backpack
				["MMG_01_tan_F",["","acc_pointer_IR","","bipod_02_F_tan"]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["hgun_Rook40_F",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Marksman", 
			200,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["16Rnd_9x21_Mag","16Rnd_9x21_Mag","FirstAidKit"]], //Uniform
				["V_TacVest_khk",["10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","10Rnd_762x54_Mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["srifle_DMR_01_F",["","","optic_DMS",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["hgun_Rook40_F",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Light AT", 
			300,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_TacVest_khk",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_FieldPack_ocamo",["RPG32_F","RPG32_F","RPG32_HE_F","RPG32_HE_F"]], //Backpack
				["arifle_Katiba_F",["","","optic_ACO_grn",""]], //Primary Weapon
				["launch_RPG32_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Heavy AT", 
			400,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_TacVest_khk",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_FieldPack_cbr",["Titan_AT","Titan_AT"]], //Backpack
				["arifle_Katiba_C_F",["","acc_pointer_IR","optic_ACO_grn",""]], //Primary Weapon
				["launch_O_Titan_short_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Anti-Air", 
			650,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_TacVest_khk",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","HandGrenade"]], //Vest
				["B_FieldPack_ocamo",["Titan_AA","Titan_AA"]], //Backpack
				["arifle_Katiba_C_F",["","acc_pointer_IR","optic_ACO_grn",""]], //Primary Weapon
				["launch_O_Titan_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Sniper", 
			400,
			east,
			[
				"", //Helmet
				"", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_O_GhillieSuit",["16Rnd_9x21_Mag","16Rnd_9x21_Mag","FirstAidKit"]], //Uniform
				["V_Chestrig_khk",["5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["srifle_GM6_F",["","","optic_LRPS",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["hgun_Rook40_F",["muzzle_snds_L","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Medic", 
			400,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_TacVest_khk",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","SmokeShell","SmokeShell"]], //Vest
				["B_FieldPack_ocamo",["Medikit"]], //Backpack
				["arifle_Katiba_F",["","acc_pointer_IR","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Engineer", 
			300,
			east,
			[
				"H_HelmetO_ocamo", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_Carryall_ocamo",["Toolkit","MineDetector","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag"]], //Backpack
				["arifle_Katiba_C_F",["","acc_pointer_IR","optic_ACO_grn",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			15
		],
		[
			"Crewman", 
			50,
			east,
			[
				"H_HelmetCrew_O", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_CombatUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_BandollierB_khk",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["arifle_Katiba_C_F",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Rotary-Wing Pilot", 
			50,
			east,
			[
				"H_PilotHelmetHeli_O", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_PilotCoveralls",["FirstAidKit"]], //Uniform
				["V_TacVest_khk",["30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag","SmokeShell"]], //Vest
				["",[]], //Backpack
				["SMG_02_F",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Fixed-Wing Pilot", 
			50,
			east,
			[
				"H_PilotHelmetFighter_O", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_PilotCoveralls",["30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag","SmokeShell","FirstAidKit"]], //Uniform
				["",[]], //Vest
				["B_Parachute",[]], //Backpack
				["SMG_02_F",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Officer", 
			50,
			east,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["U_O_OfficerUniform_ocamo",["16Rnd_9x21_Mag","16Rnd_9x21_Mag","FirstAidKit"]], //Uniform
				["",[]], //Vest
				["",[]], //Backpack
				["",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["hgun_Rook40_F",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			10
		],
		[
			"Special Forces Operator", 
			400,
			east,
			[
				"H_Beret_blk", //Helmet
				"G_Bandanna_aviator", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_O_OfficerUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["arifle_Katiba_C_F",["muzzle_snds_H","acc_pointer_IR","optic_Arco",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Special Forces AT", 
			600,
			east,
			[
				"H_Beret_blk", //Helmet
				"G_Bandanna_aviator", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_O_OfficerUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["B_FieldPack_cbr",["Titan_AT","Titan_AT"]], //Backpack
				["arifle_Katiba_C_F",["muzzle_snds_H","acc_pointer_IR","optic_Arco",""]], //Primary Weapon
				["launch_O_Titan_short_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		[
			"Special Forces Marksman", 
			600,
			east,
			[
				"H_Beret_blk", //Helmet
				"G_Bandanna_aviator", //Face
				"Rangefinder", //Binocs
				"", //NVGs
				["U_O_OfficerUniform_ocamo",["FirstAidKit"]], //Uniform
				["V_HarnessO_brn",["10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","HandGrenade","HandGrenade","SmokeShell"]], //Vest
				["",[]], //Backpack
				["srifle_DMR_05_blk_F",["muzzle_snds_93mmg","acc_pointer_IR","optic_KHS_blk","bipod_02_F_blk"]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			20
		],
		
		
		
		//MILITIA Loadout
		//Don't bother with face, helmet or uniform customization, a script randomly picks an option
		[
			"Rifleman", 
			100,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_Chestrig_oli",["30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","HandGrenade"]], //Vest
				["",[]], //Backpack
				["arifle_TRG21_F",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Grenadier",
			110,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_Chestrig_blk",["30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell"]], //Vest
				["",[]], //Backpack
				["arifle_Mk20_GL_F",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Medic", 
			160,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_TacVest_blk",["30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag"]], //Vest
				["B_TacticalPack_blk",["Medikit"]], //Backpack
				["hgun_PDW2000_F",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Machinegunner",
			120,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_TacVest_blk",["200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box"]], //Vest
				["",[]], //Backpack
				["LMG_Mk200_F",["","","",""]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Light AT", 
			120,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_TacVest_blk",["30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"]], //Vest
				["B_TacticalPack_blk",["RPG32_F","RPG32_F"]], //Backpack
				["arifle_TRG20_F",["","","",""]], //Primary Weapon
				["launch_RPG32_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Heavy AT", 
			140,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_TacVest_blk",["30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"]], //Vest
				["B_TacticalPack_blk",["Titan_AT","Titan_AT"]], //Backpack
				["arifle_Mk20C_F",["","","",""]], //Primary Weapon
				["launch_I_Titan_short_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Anti-Air", 
			180,
			guer,
			[
				"", //Helmet
				"", //Face
				"", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_TacVest_blk",["30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"]], //Vest
				["B_TacticalPack_blk",["Titan_AA","Titan_AA"]], //Backpack
				["arifle_TRG20_F",["","","",""]], //Primary Weapon
				["launch_I_Titan_F",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		],
		[
			"Marksman", 
			110,
			guer,
			[
				"", //Helmet
				"", //Face
				"Binocular", //Binocs
				"", //NVGs
				["",[]], //Uniform
				["V_BandollierB_khk",["20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag"]], //Vest
				["",[]], //Backpack
				["srifle_DMR_06_olive_F",["","","optic_KHS_old","bipod_03_F_oli"]], //Primary Weapon
				["",["","","",""]], //Secondary Weapon
				["",["","","",""]], //Sidearm
				["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
			],
			5
		]
	];
};

//Parse it out
GW_INFANTRY_LOADOUTS = [];
{
	_preSave = _x;
	
	//If development, make build times 1 second
	if (GW_DEVMODE) then {_preSave set [4, 1]};

	//Add to array
	GW_INFANTRY_LOADOUTS pushBack _preSave;
} forEach GW_DATA_INFANTRY_LOADOUTS;