//0 - Classname
//1 - Base Cost
//2 - Sides
//3 - Config Class (CfgWeapons, CfgMagazines, etc)
//4 - Slot within Template ([-1] = only containers, [1] = template select 1, [1,2] = (template select 1) select 2, [1,2,3] = ((template select 1) select 2) select 3
//5 - Only available in GWAR+ (true or false)
//6 - DLC AppID (Steam AppID of the related DLC - leave empty if it's base A3 content)

//Primary Weapons
GW_DATA_WEAP_PRIMARY =
[

/*ASSAULT RIFLES*/
	["hlc_rifle_ak47", 50, [guer], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_akm", 110, [east, guer], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_akmgl", 150, [east, guer], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_ak74_dirty", 75, [guer], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_ak74", 75, [guer], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_aks74", 80, [east, guer], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_aks74_GL", 125, [east, guer], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_aks74u", 95, [east, guer], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_aek971", 100, [east], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_ak12", 100, [east], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_aku12", 120, [east], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_ak12GL", 150, [east], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_saiga12k", 75, [east], "CfgWeapons", [7,0], true, ""],
	["RH_m16a6", 100, [west], "CfgWeapons", [7,0], true, ""],
	["RH_m4a6", 120, [west], "CfgWeapons", [7,0], true, ""],
	["RH_m16a4_m", 60, [west], "CfgWeapons", [7,0], true, ""],
	["RH_m16a4gl", 110, [west], "CfgWeapons", [7,0], true, ""],
	["RH_m4_ris_m", 80, [west], "CfgWeapons", [7,0], true, ""],
	["RH_m4a1_ris_m203", 125, [west], "CfgWeapons", [7,0], true, ""],
	["RH_Hk416s", 95, [west], "CfgWeapons", [7,0], true, ""],
	["RH_hb", 120, [west], "CfgWeapons", [7,0], true, ""],
	["arifle_Mk20_F", 60, [guer], "CfgWeapons", [7,0], false, ""],
	["arifle_Mk20_GL_F", 110, [guer], "CfgWeapons", [7,0], false, ""],
	["arifle_Mk20C_F", 80, [guer], "CfgWeapons", [7,0], false, ""],
	["arifle_Mk20_plain_F", 60, [east, west, guer], "CfgWeapons", [7,0], false, ""],
	["arifle_Mk20_GL_plain_F", 110, [east, west, guer], "CfgWeapons", [7,0], false, ""],
	["arifle_Mk20C_plain_F", 80, [east, west, guer], "CfgWeapons", [7,0], false, ""],
	["hlc_rifle_auga3", 80, [west], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_auga3_GL", 130, [west], "CfgWeapons", [7,0], true, ""],
	["arifle_SDAR_F", 40, [west, east, guer], "CfgWeapons", [7,0], false, ""],
	["arifle_TRG21_F", 60, [east, guer, west], "CfgWeapons", [7,0], false, ""],
	["arifle_TRG20_F", 80, [east, guer, west], "CfgWeapons", [7,0], false, ""],
	["arifle_TRG21_GL_F", 110, [east, guer, west], "CfgWeapons", [7,0], false, ""],
	["arifle_Katiba_F", 100, [east], "CfgWeapons", [7,0], false, ""],
	["arifle_Katiba_C_F", 120, [east], "CfgWeapons", [7,0], false, ""],
	["arifle_Katiba_GL_F", 150, [east], "CfgWeapons", [7,0], false, ""],
	["arifle_MX_F", 100, [west], "CfgWeapons", [7,0], false, ""],
	["arifle_MX_GL_F", 150, [west], "CfgWeapons", [7,0], false, ""],
	["arifle_MXC_F", 120, [west], "CfgWeapons", [7,0], false, ""],
	
/*BATTLE RIFLES*/
	["hlc_rifle_STG58F", 125, [guer, west], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_falosw", 150, [guer, west], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_osw_GL", 175, [guer, west], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_hk51", 150, [east], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_g3ka4", 150, [east, guer], "CfgWeapons", [7,0], true, ""],
	["HLC_Rifle_g3ka4_GL", 175, [east, guer], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_m14sopmod", 175, [west, guer], "CfgWeapons", [7,0], true, ""],
	["srifle_EBR_F", 175, [west], "CfgWeapons", [7,0], false, ""],
	["srifle_DMR_06_olive_F", 150, [west, guer], "CfgWeapons", [7,0], false, "332350"],
	
/*LMGs and SAWs*/
	["arifle_MX_SW_F", 300, [west], "CfgWeapons", [7,0], false, ""],
	["RH_m27iar", 230, [west], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_rpk", 225, [east, guer], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_RPK12", 275, [east], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_auga2lsw", 300, [west], "CfgWeapons", [7,0], true, ""],
	["hlc_lmg_m60", 350, [west, guer], "CfgWeapons", [7,0], true, ""],
	["hlc_lmg_M60E4", 375, [west, guer], "CfgWeapons", [7,0], true, ""],
	["LMG_Mk200_F", 400, [west, guer], "CfgWeapons", [7,0], false, ""],
	["LMG_Zafir_F", 450, [east], "CfgWeapons", [7,0], false, ""],
	["MMG_01_tan_F", 550, [east], "CfgWeapons", [7,0], false, "332350"],
	["MMG_02_black_F", 600, [west], "CfgWeapons", [7,0], false, "332350"],
	
/*SMGs and PDWs*/
	["hlc_smg_mp5k_PDW", 25, [west, east, guer], "CfgWeapons", [7,0], true, ""],
	["hlc_smg_mp5a4", 25, [west, east, guer], "CfgWeapons", [7,0], true, ""],
	["hlc_smg_9mmar", 30, [west, east, guer], "CfgWeapons", [7,0], true, ""],
	["hlc_smg_mp510", 35, [west, east, guer], "CfgWeapons", [7,0], true, ""],
	["hlc_smg_mp5sd6", 100, [west, east, guer], "CfgWeapons", [7,0], true, ""],
	["RH_sbr9", 50, [west], "CfgWeapons", [7,0], true, ""],
	["hlc_rifle_auga2para", 60, [west], "CfgWeapons", [7,0], true, ""],
	["SMG_01_F", 50, [west], "CfgWeapons", [7,0], false, ""],
	["SMG_02_F", 30, [east, guer], "CfgWeapons", [7,0], false, ""],
	["hgun_PDW2000_F", 30, [west, guer], "CfgWeapons", [7,0], false, ""],
	
/*DMRs and LRRs*/
	["srifle_DMR_01_F", 150, [east], "CfgWeapons", [7,0], false, ""],
	["RH_sr25ec", 165, [west], "CfgWeapons", [7,0], true, ""],
	["arifle_MXM_F", 175, [west], "CfgWeapons", [7,0], false, ""],
	["hlc_rifle_g3sg1", 175, [east], "CfgWeapons", [7,0], true, ""],
	["srifle_DMR_03_F", 200, [west], "CfgWeapons", [7,0], false, "332350"],
	["srifle_DMR_05_blk_F", 300, [east], "CfgWeapons", [7,0], false, "332350"],
	["hlc_rifle_psg1", 700, [west, east], "CfgWeapons", [7,0], true, ""],
	["srifle_DMR_02_F", 700, [west], "CfgWeapons", [7,0], false, "332350"],
	["srifle_GM6_F", 950, [east], "CfgWeapons", [7,0], false, ""],
	["srifle_LRR_F", 950, [west], "CfgWeapons", [7,0], false, ""],
	["srifle_DMR_04_F", 1050, [east], "CfgWeapons", [7,0], false, "332350"]
];
GW_EQUIP_WEAP_PRIMARY = [];
{
	if (GW_GWPLUS) then
	{
		GW_EQUIP_WEAP_PRIMARY pushBack _x;
	}
	else
	{
		if (!(_x select 5)) then {GW_EQUIP_WEAP_PRIMARY pushBack _x};
	};
} forEach GW_DATA_WEAP_PRIMARY;

//Secondary Weapons
GW_DATA_WEAP_SECONDARY =
[
	["launch_B_Titan_F", 1500, [west], "CfgWeapons", [8,0], false, ""],
	["launch_B_Titan_short_F", 1000, [west], "CfgWeapons", [8,0], false, ""],
	["launch_O_Titan_F", 1500, [east], "CfgWeapons", [8,0], false, ""],
	["launch_O_Titan_short_F", 1000, [east], "CfgWeapons", [8,0], false, ""],
	["launch_I_Titan_F", 100, [guer], "CfgWeapons", [8,0], false, ""],
	["launch_I_Titan_short_F", 100, [guer], "CfgWeapons", [8,0], false, ""],
	["launch_NLAW_F", 500, [west], "CfgWeapons", [8,0], false, ""],
	["launch_RPG32_F", 300, [east, guer], "CfgWeapons", [8,0], false, ""]
];
GW_EQUIP_WEAP_SECONDARY = [];
{
	if (GW_GWPLUS) then
	{
		GW_EQUIP_WEAP_SECONDARY pushBack _x;
	}
	else
	{
		if (!(_x select 5)) then {GW_EQUIP_WEAP_SECONDARY pushBack _x};
	};
} forEach GW_DATA_WEAP_SECONDARY;

//Sidearms
GW_DATA_WEAP_SIDEARM =
[
	["hgun_Rook40_F", 5, [east], "CfgWeapons", [9,0], false, ""],
	["hgun_P07_F", 5, [west], "CfgWeapons", [9,0], false, ""],
	["RH_cz75", 5, [west], "CfgWeapons", [9,0], true, ""],
	["RH_gsh18", 5, [east], "CfgWeapons", [9,0], true, ""],
	["RH_vp70", 7, [west], "CfgWeapons", [9,0], true, ""],
	["RH_kimber_nw", 10, [west, guer], "CfgWeapons", [9,0], true, ""],
	["hgun_ACPC2_F", 10, [west, east, guer], "CfgWeapons", [9,0], false, ""], 
	["RH_tt33", 10, [east, guer], "CfgWeapons", [9,0], true, ""],
	["RH_python", 10, [west, guer], "CfgWeapons", [9,0], true, ""],
	["RH_mp412", 10, [east], "CfgWeapons", [9,0], true, ""],
	["hgun_Pistol_heavy_02_F", 10, [east], "CfgWeapons", [9,0], false, ""], 
	["RH_fnp45", 20, [west], "CfgWeapons", [9,0], true, ""],
	["hgun_Pistol_heavy_01_F", 20, [west], "CfgWeapons", [9,0], false, ""], 
	["RH_g18", 30, [west], "CfgWeapons", [9,0], true, ""],
	["RH_tec9", 30, [east], "CfgWeapons", [9,0], true, ""],
	["RH_vz61", 30, [east], "CfgWeapons", [9,0], true, ""],
	["RH_muzi", 30, [west], "CfgWeapons", [9,0], true, ""],
	["RH_bull", 30, [west, east], "CfgWeapons", [9,0], true, ""],
	["RH_Deaglem", 45, [west, east], "CfgWeapons", [9,0], true, ""]
];
GW_EQUIP_WEAP_SIDEARM = [];
{
	if (GW_GWPLUS) then
	{
		GW_EQUIP_WEAP_SIDEARM pushBack _x;
	}
	else
	{
		if (!(_x select 5)) then {GW_EQUIP_WEAP_SIDEARM pushBack _x};
	};
} forEach GW_DATA_WEAP_SIDEARM;

//Magazines
GW_DATA_MAGAZINES =
[
	//Sidearm Ammo
	["RH_16Rnd_9x19_CZ", 5, [west], "CfgMagazines", [-1], true, ""], 
	["RH_18Rnd_9x19_gsh", 5, [east], "CfgMagazines", [-1], true, ""], 
	["RH_18Rnd_9x19_VP", 5, [west], "CfgMagazines", [-1], true, ""],  
	["RH_7Rnd_45cal_m1911", 6, [west, guer], "CfgMagazines", [-1], true, ""],  
	["RH_6Rnd_357_Mag", 6, [west, east], "CfgMagazines", [-1], true, ""],
	["RH_8Rnd_762_tt33", 6, [east], "CfgMagazines", [-1], true, ""],
	["RH_15Rnd_45cal_fnp", 7, [west], "CfgMagazines", [-1], true, ""],
	["RH_20Rnd_32cal_vz61", 10, [east], "CfgMagazines", [-1], true, ""],
	["RH_30Rnd_9x19_UZI", 10, [west], "CfgMagazines", [-1], true, ""],
	["RH_33Rnd_9x19_g18", 10, [west], "CfgMagazines", [-1], true, ""],
	["RH_32Rnd_9x19_tec", 10, [east], "CfgMagazines", [-1], true, ""],
	["RH_6Rnd_454_Mag", 10, [west, east], "CfgMagazines", [-1], true, ""],
	["RH_7Rnd_50_AE", 10, [west, east], "CfgMagazines", [-1], true, ""],

	//Primary Ammo
	["hlc_30Rnd_545x39_T_AK", 4, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_30Rnd_545x39_EP_AK", 4, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_45Rnd_545x39_t_rpk", 4, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_10rnd_12g_buck_S12", 5, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_10rnd_12g_slug_S12", 5, [east, guer], "CfgMagazines", [-1], true, ""],
	["30Rnd_556x45_Stanag", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["30Rnd_556x45_Stanag_Tracer_Red", 5, [west, guer], "CfgMagazines", [-1], false, ""],
	["30Rnd_556x45_Stanag_Tracer_Green", 5, [east, guer], "CfgMagazines", [-1], false, ""],
	["30Rnd_556x45_Stanag_Tracer_Yellow", 5, [guer], "CfgMagazines", [-1], false, ""],
	["20Rnd_556x45_UW_mag", 5, [west, guer], "CfgMagazines", [-1], false, ""],
	["RH_30Rnd_556x45_Mk318", 5, [west, guer], "CfgMagazines", [-1], true, ""],
	["RH_60Rnd_556x45_Mk318", 10, [west, guer], "CfgMagazines", [-1], true, ""],
	["RH_30Rnd_68x43_FMJ", 8, [west, guer], "CfgMagazines", [-1], true, ""],
	["RH_20Rnd_762x51_Mk319", 20, [west, guer], "CfgMagazines", [-1], true, ""],
	["RH_30Rnd_762x35_FMJ", 15, [west, guer], "CfgMagazines", [-1], true, ""],
	["RH_30Rnd_762x35_MSB", 15, [west, guer], "CfgMagazines", [-1], true, ""],
	["hlc_30rnd_556x45_t_hk33", 5, [west], "CfgMagazines", [-1], true, ""],
	["hlc_30rnd_556x45_sost_hk33", 5, [west], "CfgMagazines", [-1], true, ""],
	["hlc_30rnd_556x45_SOST", 6, [west], "CfgMagazines", [-1], true, ""],
	["hlc_30Rnd_556x45_SOST_AUG", 6, [west], "CfgMagazines", [-1], true, ""],
	["hlc_30Rnd_556x45_T_AUG", 6, [west], "CfgMagazines", [-1], true, ""],
	["hlc_40Rnd_556x45_SOST_AUG", 8, [west], "CfgMagazines", [-1], true, ""],
	["30Rnd_65x39_caseless_mag", 10, [west, guer], "CfgMagazines", [-1], false, ""],
	["30Rnd_65x39_caseless_mag_Tracer", 10, [west, guer], "CfgMagazines", [-1], false, ""],
	["30Rnd_65x39_caseless_green", 10, [east, guer], "CfgMagazines", [-1], false, ""],
	["30Rnd_65x39_caseless_green_mag_Tracer", 10, [east, guer], "CfgMagazines", [-1], false, ""],
	["hlc_30Rnd_762x39_b_ak", 15, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_30Rnd_762x39_t_ak", 15, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_45Rnd_762x39_m_rpk", 20, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_75rnd_762x39_m_rpk", 25, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_20Rnd_762x51_barrier_G3", 20, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_20rnd_762x51_T_G3", 20, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_20rnd_762x51_S_G3", 20, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_50rnd_762x51_M_G3", 35, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_20Rnd_762x51_barrier_M14", 20, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_20rnd_762x51_T_M14", 20, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_20rnd_762x51_S_M14", 20, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_50rnd_762x51_M_M14", 35, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_20Rnd_762x51_barrier_fal", 20, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_20Rnd_762x51_t_fal", 20, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_20Rnd_762x51_S_fal", 25, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_50rnd_762x51_M_FAL", 35, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["20Rnd_762x51_Mag", 20, [west, guer], "CfgMagazines", [-1], false, ""],
	["10Rnd_762x54_Mag", 10, [east, guer], "CfgMagazines", [-1], false, ""],
	["10Rnd_93x64_DMR_05_Mag", 25, [east], "CfgMagazines", [-1], false, ""],
	["10Rnd_127x54_Mag", 50, [east], "CfgMagazines", [-1], false, ""],
	["5Rnd_127x108_Mag", 65, [east, guer], "CfgMagazines", [-1], false, ""],
	["5Rnd_127x108_APDS_Mag", 75, [east, guer], "CfgMagazines", [-1], false, ""],
	["10Rnd_338_Mag", 70, [west], "CfgMagazines", [-1], false, ""],
	["7Rnd_408_Mag", 90, [west, guer], "CfgMagazines", [-1], false, ""],
	["100Rnd_65x39_caseless_mag", 25, [west, guer], "CfgMagazines", [-1], false, ""],
	["100Rnd_65x39_caseless_mag_Tracer", 25, [west, guer], "CfgMagazines", [-1], false, ""],
	["hlc_100Rnd_762x51_M_M60E4", 35, [west, guer], "CfgMagazines", [-1], true, ""],
	["150Rnd_762x54_Box", 35, [east], "CfgMagazines", [-1], false, ""],
	["150Rnd_762x54_Box_Tracer", 35, [east], "CfgMagazines", [-1], false, ""],
	["130Rnd_338_Mag", 50, [west], "CfgMagazines", [-1], false, ""],
	["150Rnd_93x64_Mag", 50, [east], "CfgMagazines", [-1], false, ""],
	["200Rnd_65x39_cased_Box", 35, [west, guer], "CfgMagazines", [-1], false, ""],
	["200Rnd_65x39_cased_Box_Tracer", 35, [west, guer], "CfgMagazines", [-1], false, ""],
	["30Rnd_45ACP_Mag_SMG_01", 5, [west, guer], "CfgMagazines", [-1], false, ""],
	["30Rnd_45ACP_Mag_SMG_01_Tracer_Green", 5, [west, guer], "CfgMagazines", [-1], false, ""],
	["hlc_25Rnd_9x19mm_M882_AUG", 4, [west], "CfgMagazines", [-1], true, ""],
	["hlc_25Rnd_9x19mm_JHP_AUG", 4, [west], "CfgMagazines", [-1], true, ""],
	["hlc_25Rnd_9x19mm_subsonic_AUG", 4, [west], "CfgMagazines", [-1], true, ""],
	["hlc_30Rnd_9x19_B_MP5", 5, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_30Rnd_9x19_GD_MP5", 6, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_30Rnd_9x19_SD_MP5", 5, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_30Rnd_10mm_B_MP5", 6, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_30Rnd_10mm_JHP_MP5", 7, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["RH_32Rnd_9mm_HP", 6, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["RH_32Rnd_9mm_HPSB", 5, [west, east, guer], "CfgMagazines", [-1], true, ""],
	["30Rnd_9x21_Mag", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["9Rnd_45ACP_Mag", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["11Rnd_45ACP_Mag", 5, [west, guer], "CfgMagazines", [-1], false, ""],
	["6Rnd_45ACP_Cylinder", 5, [east, guer], "CfgMagazines", [-1], false, ""],
	["16Rnd_9x21_Mag", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["hlc_VOG25_AK", 20, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_GRD_White", 5, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_GRD_red", 5, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_GRD_green", 5, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_GRD_blue", 5, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_GRD_orange", 5, [east, guer], "CfgMagazines", [-1], true, ""],
	["hlc_GRD_purple", 5, [east, guer], "CfgMagazines", [-1], true, ""],
	["1Rnd_HE_Grenade_shell", 20, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["1Rnd_Smoke_Grenade_shell", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["1Rnd_SmokeRed_Grenade_shell", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["1Rnd_SmokeGreen_Grenade_shell", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["1Rnd_SmokeYellow_Grenade_shell", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["1Rnd_SmokePurple_Grenade_shell", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["1Rnd_SmokeBlue_Grenade_shell", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["1Rnd_SmokeOrange_Grenade_shell", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["MiniGrenade", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["HandGrenade", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["SmokeShell", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["SmokeShellRed", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["SmokeShellGreen", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["SmokeShellYellow", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["SmokeShellPurple", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["SmokeShellBlue", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["SmokeShellOrange", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["Chemlight_green", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["Chemlight_yellow", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["Chemlight_red", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["Chemlight_blue", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["UGL_FlareWhite_F", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["UGL_FlareGreen_F", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["UGL_FlareRed_F", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["UGL_FlareYellow_F", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["UGL_FlareCIR_F", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["ATMine_Range_Mag", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["APERSMine_Range_Mag", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["APERSBoundingMine_Range_Mag", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["SLAMDirectionalMine_Wire_Mag", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["APERSTripMine_Wire_Mag", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["ClaymoreDirectionalMine_Remote_Mag", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["SatchelCharge_Remote_Mag", 10, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["DemoCharge_Remote_Mag", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["Laserbatteries", 5, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["B_IR_Grenade", 5, [west], "CfgMagazines", [-1], false, ""],
	["O_IR_Grenade", 5, [east], "CfgMagazines", [-1], false, ""],
	["I_IR_Grenade", 5, [guer], "CfgMagazines", [-1], false, ""],
	["RPG32_F", 150, [east, guer], "CfgMagazines", [-1], false, ""],
	["RPG32_HE_F", 100, [east, guer], "CfgMagazines", [-1], false, ""],
	["NLAW_F", 350, [west, guer], "CfgMagazines", [-1], false, ""],
	["Titan_AT", 500, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["Titan_AP", 400, [west, east, guer], "CfgMagazines", [-1], false, ""],
	["Titan_AA", 750, [west, east, guer], "CfgMagazines", [-1], false, ""]
];
GW_EQUIP_MAGAZINES = [];
{
	if (GW_GWPLUS) then
	{
		GW_EQUIP_MAGAZINES pushBack _x;
	}
	else
	{
		if (!(_x select 5)) then {GW_EQUIP_MAGAZINES pushBack _x};
	};
} forEach GW_DATA_MAGAZINES;

//Attachments
GW_DATA_ATTACHMENTS =
[
/*Rail Attachments*/
	["acc_flashlight", 5, [west, east, guer], "CfgWeapons", [7,1,1], false, ""],
	["RH_SFM952V_tan", 5, [west, east, guer], "CfgWeapons", [7,1,1], true, ""],
	["acc_pointer_IR", 5, [west, east, guer], "CfgWeapons", [7,1,1], false, ""],
	["RH_peq15", 5, [west, east, guer], "CfgWeapons", [7,1,1], true, ""],
	["RH_peq15_top", 5, [west, east, guer], "CfgWeapons", [7,1,1], true, ""],
	
/*Bipods*/
	["bipod_01_F_blk", 100, [west], "CfgWeapons", [7,1,3], false, ""],
	["bipod_01_F_mtp", 100, [west], "CfgWeapons", [7,1,3], false, ""],
	["bipod_01_F_snd", 100, [west], "CfgWeapons", [7,1,3], false, ""],
	["bipod_02_F_blk", 100, [east], "CfgWeapons", [7,1,3], false, ""],
	["bipod_02_F_hex", 100, [east], "CfgWeapons", [7,1,3], false, ""],
	["bipod_02_F_tan", 100, [east], "CfgWeapons", [7,1,3], false, ""],
	["bipod_03_F_blk", 100, [guer], "CfgWeapons", [7,1,3], false, ""],
	["bipod_03_F_oli", 100, [guer], "CfgWeapons", [7,1,3], false, ""],
	
/*Silencers*/
	["muzzle_snds_acp", 250, [west, east, guer], "CfgWeapons", [[7,9],1,0], false, ""],
	["hlc_muzzle_snds_HK33", 250, [west, east], "CfgWeapons", [7,1,0], true, ""],
	["muzzle_snds_L", 120, [west, east, guer], "CfgWeapons", [[7,9],1,0], false, ""],
	["hlc_muzzle_Tundra", 120, [west, east, guer], "CfgWeapons", [[7,9],1,0], true, ""],
	["hlc_muzzle_Agendasix", 120, [west, east, guer], "CfgWeapons", [7,1,0], true, ""],
	["hlc_muzzle_Agendasix10mm", 130, [west, east, guer], "CfgWeapons", [7,1,0], true, ""],
	["muzzle_snds_B", 700, [west, east, guer], "CfgWeapons", [7,1,0], false, ""],
	["muzzle_snds_H", 500, [west, east, guer], "CfgWeapons", [7,1,0], false, ""],
	["hlc_muzzle_snds_G3", 500, [west, east, guer], "CfgWeapons", [7,1,0], true, ""],
	["hlc_muzzle_snds_fal", 500, [west, east, guer], "CfgWeapons", [7,1,0], true, ""],
	["hlc_muzzle_545SUP_AK", 500, [east, guer], "CfgWeapons", [7,1,0], true, ""],
	["hlc_muzzle_762SUP_AK", 500, [east, guer], "CfgWeapons", [7,1,0], true, ""],
	["hlc_muzzle_snds_AUG", 500, [west], "CfgWeapons", [7,1,0], true, ""],
	["hlc_muzzle_snds_a6AUG", 250, [west], "CfgWeapons", [7,1,0], true, ""],
	["RH_qdss_nt4", 500, [west], "CfgWeapons", [7,1,0], true, ""],
	["RH_saker", 500, [west], "CfgWeapons", [7,1,0], true, ""],
	["RH_Saker762", 500, [west], "CfgWeapons", [7,1,0], true, ""],
	["RH_fa556", 500, [west], "CfgWeapons", [7,1,0], true, ""],
	["RH_fa762", 500, [west], "CfgWeapons", [7,1,0], true, ""],
	["RH_spr_mbs", 500, [west], "CfgWeapons", [7,1,0], true, ""],
	["RH_tundra", 500, [west], "CfgWeapons", [7,1,0], true, ""],
	["RH_m110sd", 500, [west], "CfgWeapons", [7,1,0], true, ""],
	["RH_hbsd", 500, [west], "CfgWeapons", [7,1,0], true, ""],
	["muzzle_snds_H_MG", 700, [west, east, guer], "CfgWeapons", [7,1,0], false, ""],
	["muzzle_snds_H_SW", 700, [west, east, guer], "CfgWeapons", [7,1,0], false, ""],
	["muzzle_snds_M", 500, [west, east, guer], "CfgWeapons", [7,1,0], false, ""],
	["muzzle_snds_93mmg", 700, [east], "CfgWeapons", [7,1,0], false, "332350"],
	["muzzle_snds_338_black", 700, [west], "CfgWeapons", [7,1,0], false, "332350"],

/*Optics*/
	["optic_Aco", 50, [west, guer], "CfgWeapons", [7,1,2], false, ""],
	["optic_Aco_smg", 50, [west, guer], "CfgWeapons", [7,1,2], false, ""],
	["RH_compm4s", 50, [west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_compm2", 50, [west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_compm2l", 50, [west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_t1", 50, [west, guer, east], "CfgWeapons", [7,1,2], true, ""],
	["RH_barska_rds", 50, [guer, east], "CfgWeapons", [7,1,2], true, ""],
	["RH_cmore", 50, [west, guer, east], "CfgWeapons", [7,1,2], true, ""],
	["RH_reflex", 50, [west, guer], "CfgWeapons", [7,1,2], true, ""],
	["optic_Holosight", 50, [west, guer], "CfgWeapons", [7,1,2], false, ""],
	["optic_Holosight_smg", 50, [west, guer], "CfgWeapons", [7,1,2], false, ""],
	["optic_ACO_grn", 50, [east, guer], "CfgWeapons", [7,1,2], false, ""],
	["optic_ACO_grn_smg", 50, [east, guer], "CfgWeapons", [7,1,2], false, ""],
	["hlc_optic_kobra", 50, [east, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_eotech553", 50, [east, west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_eotech553mag", 250, [east, west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_eotexps3", 50, [east, west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_eothhs1", 250, [east, west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_LTdocter", 50, [east, west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_LTdocterl", 50, [east, west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_zpoint", 50, [east, west, guer], "CfgWeapons", [7,1,2], true, ""],
	["HLC_Optic_PSO1", 250, [east,guer], "CfgWeapons", [7,1,2], true, ""],
	["HLC_Optic_1p29", 300, [east,guer], "CfgWeapons", [7,1,2], true, ""],
	["optic_Arco", 350, [east, guer], "CfgWeapons", [7,1,2], false, ""],
	["optic_Hamr", 350, [west, guer], "CfgWeapons", [7,1,2], false, ""],
	["RH_ta01nsn", 350, [west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_ta31rmr", 350, [west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_ta648", 350, [west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_c79", 350, [west, guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_m145", 350, [west, guer], "CfgWeapons", [7,1,2], true, ""],
	["optic_MRCO", 350, [east, west, guer], "CfgWeapons", [7,1,2], false, ""],
	["RH_shortdot", 350, [east, west, guer], "CfgWeapons", [7,1,2], true, ""],
	["hlc_optic_suit", 350, [east, west, guer], "CfgWeapons", [7,1,2], true, ""],
	["HLC_Optic_ZFSG1", 900, [west,east,guer], "CfgWeapons", [7,1,2], true, ""],
	["hlc_optic_accupoint_g3", 700, [west,east,guer], "CfgWeapons", [7,1,2], true, ""],
	["RH_accupoint", 700, [west,east,guer], "CfgWeapons", [7,1,2], true, ""],
	["optic_DMS", 700, [east, west, guer], "CfgWeapons", [7,1,2], false, ""],
	["hlc_optic_artel_m14", 300, [west], "CfgWeapons", [7,1,2], true, ""],
	["optic_KHS_old", 800, [guer], "CfgWeapons", [7,1,2], false, ""],
	["optic_KHS_blk", 850, [east], "CfgWeapons", [7,1,2], false, ""],
	["optic_AMS", 850, [west], "CfgWeapons", [7,1,2], false, ""],
	["hlc_optic_LRT_m14", 1000, [west], "CfgWeapons", [7,1,2], true, ""],
	["RH_leu_mk4", 1000, [west], "CfgWeapons", [7,1,2], true, ""],
	["optic_LRPS", 1000, [east, west, guer], "CfgWeapons", [7,1,2], false, ""],
	["optic_SOS", 1200, [east, west, guer], "CfgWeapons", [7,1,2], false, ""],
	["hlc_optic_goshawk", 400, [east, guer], "CfgWeapons", [7,1,2], true, ""],
	["optic_NVS", 400, [east, west, guer], "CfgWeapons", [7,1,2], false, ""],
	["optic_tws", 2000, [east, west, guer], "CfgWeapons", [7,1,2], false, ""],
	["optic_tws_mg", 2100, [east, west, guer], "CfgWeapons", [7,1,2], false, ""],
	["optic_Nightstalker", 3000, [east], "CfgWeapons", [7,1,2], false, ""],
	["optic_MRD", 5, [west], "CfgWeapons", [9,1,2], false, ""],
	["optic_Yorris", 5, [west, east], "CfgWeapons", [9,1,2], false, ""]
];
GW_EQUIP_ATTACHMENTS = [];
{
	if (GW_GWPLUS) then
	{
		GW_EQUIP_ATTACHMENTS pushBack _x;
	}
	else
	{
		if (!(_x select 5)) then {GW_EQUIP_ATTACHMENTS pushBack _x};
	};
} forEach GW_DATA_ATTACHMENTS;

//Headgear
GW_DATA_HEADGEAR =
[
	["H_HelmetB", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_camo", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_paint", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_grass", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_snakeskin", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_desert", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_black", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_sand", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_plain_mcamo", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_plain_blk", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetSpecB", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetSpecB_paint1", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetSpecB_paint2", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetSpecB_blk", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_light", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_light_grass", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_light_snakeskin", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_light_desert", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_light_black", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetB_light_sand", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetO_ocamo", 10, [east], "CfgWeapons", [0], false, ""],
	["H_HelmetLeaderO_ocamo", 10, [east], "CfgWeapons", [0], false, ""],
	["H_HelmetO_oucamo", 10, [east], "CfgWeapons", [0], false, ""],
	["H_HelmetLeaderO_oucamo", 10, [east], "CfgWeapons", [0], false, ""],
	["H_HelmetSpecO_ocamo", 10, [east], "CfgWeapons", [0], false, ""],
	["H_HelmetSpecO_blk", 10, [east], "CfgWeapons", [0], false, ""],
	["H_HelmetIA", 10, [guer], "CfgWeapons", [0], false, ""],
	["H_HelmetCrew_B", 10, [west], "CfgWeapons", [0], false, ""],
	["H_HelmetCrew_O", 10, [east], "CfgWeapons", [0], false, ""],
	["H_PilotHelmetHeli_B", 10, [west], "CfgWeapons", [0], false, ""],
	["H_PilotHelmetHeli_O", 10, [east], "CfgWeapons", [0], false, ""],
	["H_PilotHelmetFighter_B", 10, [west], "CfgWeapons", [0], false, ""],
	["H_PilotHelmetFighter_O", 10, [east], "CfgWeapons", [0], false, ""],
	["H_Bandanna_camo", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Bandanna_cbr", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Bandanna_khk", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Bandanna_sgg", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Booniehat_tan", 5, [west, guer], "CfgWeapons", [0], false, ""],
	["H_Booniehat_khk", 5, [east, guer], "CfgWeapons", [0], false, ""],
	["H_Booniehat_mcamo", 5, [west, guer], "CfgWeapons", [0], false, ""],
	["H_Booniehat_indp", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Booniehat_dgtl", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Beret_red", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Cap_blk", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Cap_grn", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Cap_oli", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Cap_tan", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Watchcap_khk", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Watchcap_camo", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Watchcap_blk", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Hat_blue", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Hat_camo", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_Hat_checker", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_MilCap_ocamo", 5, [east, guer], "CfgWeapons", [0], false, ""],
	["H_MilCap_mcamo", 5, [west, guer], "CfgWeapons", [0], false, ""],
	["H_Shemag_olive", 5, [guer], "CfgWeapons", [0], false, ""],
	["H_ShemagOpen_tan", 5, [guer], "CfgWeapons", [0], false, ""]
];
GW_EQUIP_HEADGEAR = [];
{
	if (GW_GWPLUS) then
	{
		GW_EQUIP_HEADGEAR pushBack _x;
	}
	else
	{
		if (!(_x select 5)) then {GW_EQUIP_HEADGEAR pushBack _x};
	};
} forEach GW_DATA_HEADGEAR;

//Vests
GW_DATA_VESTS =
[
	["V_Rangemaster_belt", 5, [east, west, guer], "CfgWeapons", [5,0], false, ""],
	["V_BandollierB_oli", 10, [guer], "CfgWeapons", [5,0], false, ""],
	["V_BandollierB_khk", 10, [east, guer], "CfgWeapons", [5,0], false, ""],
	["V_BandollierB_blk", 10, [east, west, guer], "CfgWeapons", [5,0], false, ""],
	["V_BandollierB_rgr", 10, [west], "CfgWeapons", [5,0], false, ""],
	["V_PlateCarrier1_rgr", 125, [west], "CfgWeapons", [5,0], false, ""],
	["V_PlateCarrier2_rgr", 125, [west], "CfgWeapons", [5,0], false, ""],
	["V_PlateCarrierGL_blk", 175, [west], "CfgWeapons", [5,0], false, ""],
	["V_PlateCarrierGL_rgr", 175, [west], "CfgWeapons", [5,0], false, ""],
	["V_PlateCarrierGL_mtp", 175, [west], "CfgWeapons", [5,0], false, ""],
	["V_PlateCarrier1_blk", 125, [east, west, guer], "CfgWeapons", [5,0], false, ""],
	["V_PlateCarrierSpec_blk", 125, [west], "CfgWeapons", [5,0], false, ""],
	["V_PlateCarrierSpec_rgr", 125, [west], "CfgWeapons", [5,0], false, ""],
	["V_PlateCarrierSpec_mtp", 125, [west], "CfgWeapons", [5,0], false, ""],
	["V_PlateCarrierIAGL_oli", 125, [east], "CfgWeapons", [5,0], false, ""],
	["V_Chestrig_rgr", 100, [west], "CfgWeapons", [5,0], false, ""],
	["V_Chestrig_blk", 100, [east, west, guer], "CfgWeapons", [5,0], false, ""],
	["V_Chestrig_oli", 100, [guer], "CfgWeapons", [5,0], false, ""],
	["V_Chestrig_khk", 100, [east], "CfgWeapons", [5,0], false, ""],
	["V_TacVest_khk", 100, [east], "CfgWeapons", [5,0], false, ""],
	["V_TacVest_oli", 100, [guer], "CfgWeapons", [5,0], false, ""],
	["V_TacVest_blk", 100, [east, west, guer], "CfgWeapons", [5,0], false, ""],
	["V_TacVest_camo", 100, [guer], "CfgWeapons", [5,0], false, ""],
	["V_HarnessO_brn", 100, [east], "CfgWeapons", [5,0], false, ""],
	["V_HarnessOGL_brn", 90, [east], "CfgWeapons", [5,0], false, ""],
	["V_HarnessO_gry", 100, [east], "CfgWeapons", [5,0], false, ""],
	["V_HarnessOGL_gry", 90, [east], "CfgWeapons", [5,0], false, ""],
	["V_HarnessOSpec_brn", 135, [east], "CfgWeapons", [5,0], false, ""],
	["V_HarnessOSpec_gry", 135, [east], "CfgWeapons", [5,0], false, ""],
	["V_RebreatherB", 5, [west], "CfgWeapons", [5,0], false, ""],
	["V_RebreatherIR", 5, [east], "CfgWeapons", [5,0], false, ""]
];
GW_EQUIP_VESTS = [];
{
	if (GW_GWPLUS) then
	{
		GW_EQUIP_VESTS pushBack _x;
	}
	else
	{
		if (!(_x select 5)) then {GW_EQUIP_VESTS pushBack _x};
	};
} forEach GW_DATA_VESTS;

//Uniforms
GW_DATA_UNIFORMS =
[
	["U_B_CombatUniform_mcam", 5, [west], "CfgWeapons", [4,0], false, ""],
	["U_B_CombatUniform_mcam_tshirt", 5, [west], "CfgWeapons", [4,0], false, ""],
	["U_B_CombatUniform_mcam_vest", 5, [west], "CfgWeapons", [4,0], false, ""],
	["U_B_GhillieSuit", 50, [west], "CfgWeapons", [4,0], false, ""],
	["U_B_HeliPilotCoveralls", 5, [west], "CfgWeapons", [4,0], false, ""],
	["U_B_PilotCoveralls", 5, [west], "CfgWeapons", [4,0], false, ""],
	["U_B_Wetsuit", 5, [west], "CfgWeapons", [4,0], false, ""],
	["U_O_CombatUniform_ocamo", 5, [east], "CfgWeapons", [4,0], false, ""],
	["U_O_CombatUniform_oucamo", 5, [east], "CfgWeapons", [4,0], false, ""],
	["U_O_OfficerUniform_ocamo", 5, [east], "CfgWeapons", [4,0], false, ""],
	["U_O_GhillieSuit", 50, [east], "CfgWeapons", [4,0], false, ""],
	["U_O_PilotCoveralls", 5, [east], "CfgWeapons", [4,0], false, ""],
	["U_O_Wetsuit", 5, [east], "CfgWeapons", [4,0], false, ""],
	["U_I_G_resistanceLeader_F", 5, [guer], "CfgWeapons", [4,0], false, ""],
	["U_BG_Guerrilla_6_1", 5, [guer], "CfgWeapons", [4,0], false, ""],
	["U_BG_Guerilla1_1", 5, [guer], "CfgWeapons", [4,0], false, ""],
	["U_BG_Guerilla2_2", 5, [guer], "CfgWeapons", [4,0], false, ""],
	["U_BG_Guerilla2_1", 5, [guer], "CfgWeapons", [4,0], false, ""],
	["U_BG_Guerilla2_3", 5, [guer], "CfgWeapons", [4,0], false, ""],
	["U_BG_Guerilla3_1", 5, [guer], "CfgWeapons", [4,0], false, ""],
	["U_BG_leader", 5, [guer], "CfgWeapons", [4,0], false, ""],
	["U_C_Poor_2", 5, [guer], "CfgWeapons", [4,0], false, ""],
	["U_C_HunterBody_grn", 5, [guer], "CfgWeapons", [4,0], false, ""],
	["U_I_FullGhillie_ard", 65, [guer], "CfgWeapons", [4,0], false, ""],
	["U_I_FullGhillie_lsh", 65, [guer], "CfgWeapons", [4,0], false, ""],
	["U_I_FullGhillie_sard", 65, [guer], "CfgWeapons", [4,0], false, ""],
	["U_O_FullGhillie_ard", 65, [east], "CfgWeapons", [4,0], false, ""],
	["U_O_FullGhillie_lsh", 65, [east], "CfgWeapons", [4,0], false, ""],
	["U_O_FullGhillie_sard", 65, [east], "CfgWeapons", [4,0], false, ""],
	["U_B_FullGhillie_ard", 65, [west], "CfgWeapons", [4,0], false, ""],
	["U_B_FullGhillie_lsh", 65, [west], "CfgWeapons", [4,0], false, ""],
	["U_B_FullGhillie_sard", 65, [west], "CfgWeapons", [4,0], false, ""]
];
GW_EQUIP_UNIFORMS = [];
{
	if (GW_GWPLUS) then
	{
		GW_EQUIP_UNIFORMS pushBack _x;
	}
	else
	{
		if (!(_x select 5)) then {GW_EQUIP_UNIFORMS pushBack _x};
	};
} forEach GW_DATA_UNIFORMS;

//Backpack
GW_DATA_BACKPACKS =
[
	["B_AssaultPack_mcamo", 100, [west], "CfgVehicles", [6,0], false, ""],
	["B_AssaultPack_rgr", 100, [west], "CfgVehicles", [6,0], false, ""],
	["B_AssaultPack_blk", 100, [guer], "CfgVehicles", [6,0], false, ""],
	["B_FieldPack_ocamo", 110, [east], "CfgVehicles", [6,0], false, ""],
	["B_FieldPack_oucamo", 110, [east], "CfgVehicles", [6,0], false, ""],
	["B_FieldPack_cbr", 110, [east], "CfgVehicles", [6,0], false, ""],
	["B_FieldPack_oli", 110, [guer], "CfgVehicles", [6,0], false, ""],
	["B_TacticalPack_mcamo", 120, [west], "CfgVehicles", [6,0], false, ""],
	["B_TacticalPack_blk", 120, [guer], "CfgVehicles", [6,0], false, ""],
	["B_Kitbag_mcamo", 140, [west], "CfgVehicles", [6,0], false, ""],
	["B_Kitbag_rgr", 140, [west], "CfgVehicles", [6,0], false, ""],
	["B_Carryall_mcamo", 150, [west], "CfgVehicles", [6,0], false, ""],
	["B_Carryall_ocamo", 150, [east], "CfgVehicles", [6,0], false, ""],
	["B_Carryall_oucamo", 150, [east], "CfgVehicles", [6,0], false, ""],
	["B_Carryall_cbr", 150, [east], "CfgVehicles", [6,0], false, ""],
	["B_Parachute", 5, [east, west], "CfgVehicles", [6,0], false, ""]
];
GW_EQUIP_BACKPACKS = [];
{
	if (GW_GWPLUS) then
	{
		GW_EQUIP_BACKPACKS pushBack _x;
	}
	else
	{
		if (!(_x select 5)) then {GW_EQUIP_BACKPACKS pushBack _x};
	};
} forEach GW_DATA_BACKPACKS;

//Facewear
GW_DATA_FACEWEAR =
[
	["G_Aviator", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Balaclava_blk", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Balaclava_oli", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Balaclava_combat", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Balaclava_lowprofile", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Bandanna_aviator", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Bandanna_blk", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Bandanna_oli", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Bandanna_tan", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Bandanna_beast", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Bandanna_shades", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Bandanna_sport", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Combat", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_lowprofile", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Shades_Black", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Shades_Blue", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Shades_Green", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Shades_Red", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Spectacles", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Spectacles_Tinted", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Sport_Blackred", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Sport_BlackWhite", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Sport_Blackyellow", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Sport_Checkered", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Sport_Greenblack", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Sport_Red", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Squares", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Squares_Tinted", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Tactical_Black", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_Tactical_Clear", 5, [east, west, guer], "CfgGlasses", [1], false, ""],
	["G_B_Diving", 5, [west], "CfgGlasses", [1], false, ""],
	["G_O_Diving", 5, [west], "CfgGlasses", [1], false, ""]
];
GW_EQUIP_FACEWEAR = [];
{
	if (GW_GWPLUS) then
	{
		GW_EQUIP_FACEWEAR pushBack _x;
	}
	else
	{
		if (!(_x select 5)) then {GW_EQUIP_FACEWEAR pushBack _x};
	};
} forEach GW_DATA_FACEWEAR;

//Other Items
GW_DATA_OTHERS =
[
	["ItemWatch", 0, [east, west, guer], "CfgWeapons", [10,4], false, ""],
	["ItemCompass", 0, [east, west, guer], "CfgWeapons", [10,0], false, ""],
	["ItemRadio", 5, [east, west, guer], "CfgWeapons", [10,3], false, ""],
	["ItemMap", 5, [east, west, guer], "CfgWeapons", [10,2], false, ""],
	["MineDetector", 100, [east, west, guer], "CfgWeapons", [-1], false, ""],
	["Binocular", 50, [east, west, guer], "CfgWeapons", [2], false, ""],
	["Rangefinder", 75, [east, west, guer], "CfgWeapons", [2], false, ""],
	["Laserdesignator", 250, [east, west, guer], "CfgWeapons", [2], false, ""],
	["NVGoggles", 100, [west], "CfgWeapons", [3], false, ""],
	["NVGoggles_OPFOR", 100, [east], "CfgWeapons", [3], false, ""],
	["NVGoggles_INDEP", 100, [guer], "CfgWeapons", [3], false, ""],
	["FirstAidKit", 100, [east, west, guer], "CfgWeapons", [-1], false, ""],
	["Medikit", 500, [east, west, guer], "CfgWeapons", [-1], false, ""],
	["ToolKit", 500, [east, west, guer], "CfgWeapons", [-1], false, ""],
	["B_UavTerminal", 500, [west], "CfgWeapons", [10,1], false, ""],
	["O_UavTerminal", 500, [east], "CfgWeapons", [10,1], false, ""]
];
GW_EQUIP_OTHERS = [];
{
	if (GW_GWPLUS) then
	{
		GW_EQUIP_OTHERS pushBack _x;
	}
	else
	{
		if (!(_x select 5)) then {GW_EQUIP_OTHERS pushBack _x};
	};
} forEach GW_DATA_OTHERS;

//All equipment
GW_EQUIP_ALL = 
[
	GW_EQUIP_WEAP_PRIMARY,
	GW_EQUIP_WEAP_SECONDARY,
	GW_EQUIP_WEAP_SIDEARM,
	GW_EQUIP_MAGAZINES,
	GW_EQUIP_ATTACHMENTS,
	GW_EQUIP_HEADGEAR,
	GW_EQUIP_VESTS,
	GW_EQUIP_UNIFORMS,
	GW_EQUIP_BACKPACKS,
	GW_EQUIP_FACEWEAR,
	GW_EQUIP_OTHERS
] Call fnc_shr_mergeArrays;

//Categories for ease of use later
GW_EQUIP_COMPASS_ITEMS = [];
GW_EQUIP_GPS_ITEMS = [];
GW_EQUIP_MAP_ITEMS = [];
GW_EQUIP_RADIO_ITEMS = [];
GW_EQUIP_WATCH_ITEMS = [];
{
	if (count(_x select 4) > 1) then
	{
		if (((_x select 4) select 1) == 0) then {GW_EQUIP_COMPASS_ITEMS pushBack (_x select 0)};
		if (((_x select 4) select 1) == 1) then {GW_EQUIP_GPS_ITEMS pushBack (_x select 0)};
		if (((_x select 4) select 1) == 2) then {GW_EQUIP_MAP_ITEMS pushBack (_x select 0)};
		if (((_x select 4) select 1) == 3) then {GW_EQUIP_RADIO_ITEMS pushBack (_x select 0)};
		if (((_x select 4) select 1) == 4) then {GW_EQUIP_WATCH_ITEMS pushBack (_x select 0)};
	};
} forEach GW_EQUIP_OTHERS;

//Starting equipment for bluefor
if (GW_GWPLUS) then
{
	GW_DATA_STARTEQUIP_WEST =
	[
		"H_MilCap_mcamo", //Helmet
		"", //Face
		"", //Binocs
		"", //NVGs
		["U_B_CombatUniform_mcam_vest",["FirstAidKit"]], //Uniform
		["V_BandollierB_rgr",["RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","RH_30Rnd_556x45_Mk318","MiniGrenade"]], //Vest
		["",[]], //Backpack
		["RH_M4_ris_m",["","acc_flashlight","",""]], //Primary Weapon
		["",["","","",""]], //Secondary Weapon
		["",["","","",""]], //Sidearm
		["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
	];
}
else
{
	GW_DATA_STARTEQUIP_WEST =
	[
		"H_MilCap_mcamo", //Helmet
		"", //Face
		"", //Binocs
		"", //NVGs
		["U_B_CombatUniform_mcam_vest",["FirstAidKit"]], //Uniform
		["V_BandollierB_rgr",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","MiniGrenade"]], //Vest
		["",[]], //Backpack
		["arifle_MXC_F",["","acc_flashlight","",""]], //Primary Weapon
		["",["","","",""]], //Secondary Weapon
		["",["","","",""]], //Sidearm
		["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
	];
};
GW_STARTEQUIP_WEST = GW_DATA_STARTEQUIP_WEST;

//Starting equipment for redfor
if (GW_GWPLUS) then
{
	GW_DATA_STARTEQUIP_EAST =
	[
		"H_MilCap_ocamo", //Helmet
		"", //Face
		"", //Binocs
		"", //NVGs
		["U_O_OfficerUniform_ocamo",["FirstAidKit"]], //Uniform
		["V_BandollierB_khk",["hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","hlc_30Rnd_545x39_EP_AK","MiniGrenade"]], //Vest
		["",[]], //Backpack
		["hlc_rifle_aku12",["","acc_flashlight","",""]], //Primary Weapon
		["",["","","",""]], //Secondary Weapon
		["",["","","",""]], //Sidearm
		["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
	];
}
else
{
	GW_DATA_STARTEQUIP_EAST =
	[
		"H_MilCap_ocamo", //Helmet
		"", //Face
		"", //Binocs
		"", //NVGs
		["U_O_OfficerUniform_ocamo",["FirstAidKit"]], //Uniform
		["V_BandollierB_khk",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","MiniGrenade"]], //Vest
		["",[]], //Backpack
		["arifle_Katiba_C_F",["","acc_flashlight","",""]], //Primary Weapon
		["",["","","",""]], //Secondary Weapon
		["",["","","",""]], //Sidearm
		["ItemCompass", "", "ItemMap", "ItemRadio", "ItemWatch"] //Assigned Items
	];
};
GW_STARTEQUIP_EAST = GW_DATA_STARTEQUIP_EAST;


	
	