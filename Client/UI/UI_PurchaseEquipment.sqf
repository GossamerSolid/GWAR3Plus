disableSerialization;
_display = _this select 0;

//Block UI for network call
_netBlockBGCTRL = _display displayCtrl 1110;
_netBlockBGCTRL ctrlShow true;
_netBlockTextCTRL = _display displayCtrl 1111;
_netBlockTextCTRL ctrlShow true;

//Vars
GW_PUREQUIP_CHANGEDCATEGORY = false;
GW_PUREQUIP_PRIMARYLISTCHANGED = false;
GW_PUREQUIP_CONTAINERCHANGED = false;
GW_PUREQUIP_PURCHASEEQUIPMENT = false;
GW_PUREQUIP_REDRAWINV = false;
GW_PUREQUIP_RECALC_TOTAL = false;
GW_PUREQUIP_RECALC_MASS = false;
GW_PUREQUIP_LOADTEMPLATE = false;
GW_PUREQUIP_GETTEMPLATES = false;
GW_PUREQUIP_UPDATETEMPLATE = false;
GW_PUREQUIP_DELETETEMPLATE = false;
GW_PUREQUIP_SAVENEWTEMPLATE = false;
GW_PUREQUIP_CONTAINERSEL = -1;
GW_PUREQUIP_TOTALCOST = 0;
GW_PUREQUIP_MAINLIST = [];
GW_PUREQUIP_SECONDLIST = [];
GW_PUREQUIP_ATTACHLIST = [];
GW_PUREQUIP_CURRENTTEMPLATE = [];
GW_PUREQUIP_TYPE_ITEM = 131072;
GW_PUREQUIP_UNIFORM_CURR = 0;
GW_PUREQUIP_UNIFORM_MAX = 0;
GW_PUREQUIP_VEST_CURR = 0;
GW_PUREQUIP_VEST_MAX = 0;
GW_PUREQUIP_BACKPACK_CURR = 0;
GW_PUREQUIP_BACKPACK_MAX = 0;

//Redraw template inventory
fnc_purequip_redrawInventory =
{
	private["_parentDisplay"];
	disableSerialization;
	_parentDisplay = _this select 0;
	
	_uniformCTRL = _parentDisplay displayCtrl 1200;
	_vestCTRL = _parentDisplay displayCtrl 1201;
	_backpackCTRL = _parentDisplay displayCtrl 1202;
	_headgearCTRL = _parentDisplay displayCtrl 1203;
	_faceCTRL = _parentDisplay displayCtrl 1204;
	_nvgCTRL = _parentDisplay displayCtrl 1205;
	_binocsCTRL = _parentDisplay displayCtrl 1206;
	_mapCTRL = _parentDisplay displayCtrl 1222;
	_gpsCTRL = _parentDisplay displayCtrl 1223;
	_radioCTRL = _parentDisplay displayCtrl 1224;
	_compassCTRL = _parentDisplay displayCtrl 1225;
	_watchCTRL = _parentDisplay displayCtrl 1226;
	_primaryCTRL = _parentDisplay displayCtrl 1207;
	_primaryMuzCTRL = _parentDisplay displayCtrl 1210;
	_primarySideCTRL = _parentDisplay displayCtrl 1211;
	_primaryTopCTRL = _parentDisplay displayCtrl 1208;
	_primaryBipodCTRL = _parentDisplay displayCtrl 1209;
	_secondaryCTRL = _parentDisplay displayCtrl 1212;
	_secondaryMuzCTRL = _parentDisplay displayCtrl 1213;
	_secondarySideCTRL = _parentDisplay displayCtrl 1214;
	_secondaryTopCTRL = _parentDisplay displayCtrl 1215;
	_secondaryBipodCTRL = _parentDisplay displayCtrl 1216;
	_handgunCTRL = _parentDisplay displayCtrl 1217;
	_handgunMuzCTRL = _parentDisplay displayCtrl 1218;
	_handgunSideCTRL = _parentDisplay displayCtrl 1219;
	_handgunTopCTRL = _parentDisplay displayCtrl 1220;
	_handgunBipodCTRL = _parentDisplay displayCtrl 1221;
	_removeUniformCTRL = _parentDisplay displayCtrl 1606;
	_removeVestCTRL = _parentDisplay displayCtrl 1607;
	_removeBackpackCTRL = _parentDisplay displayCtrl 1608;
	
	//Uniform
	_uniformPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_uniform_gs.paa";
	_uniformTT = "No Uniform";
	_uniformClass = (GW_PUREQUIP_CURRENTTEMPLATE select 4) select 0;
	if (_uniformClass != "") then 
	{
		_uniformPic = getText (configFile >> "CfgWeapons" >> _uniformClass >> "Picture");
		_uniformTT = getText (configFile >> "CfgWeapons" >> _uniformClass >> "DisplayName");
		_itemIndex = [_uniformClass, 0, GW_EQUIP_UNIFORMS] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_uniformTT = _uniformTT + format[" - $%1",(GW_EQUIP_UNIFORMS select _itemIndex) select 1]};
		_removeUniformCTRL ctrlShow true;
	} else {_removeUniformCTRL ctrlShow false};
	_uniformCTRL ctrlSetText _uniformPic;
	_uniformCTRL ctrlSetTooltip _uniformTT;
	
	//Vest
	_vestPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_vest_gs.paa";
	_vestTT = "No Vest";
	_vestClass = (GW_PUREQUIP_CURRENTTEMPLATE select 5) select 0;
	if (_vestClass != "") then 
	{
		_vestPic = getText (configFile >> "CfgWeapons" >> _vestClass >> "Picture");
		_vestTT = getText (configFile >> "CfgWeapons" >> _vestClass >> "DisplayName");
		_itemIndex = [_vestClass, 0, GW_EQUIP_VESTS] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_vestTT = _vestTT + format[" - $%1",(GW_EQUIP_VESTS select _itemIndex) select 1]};
		_removeVestCTRL ctrlShow true;
	} else {_removeVestCTRL ctrlShow false};
	_vestCTRL ctrlSetText _vestPic;
	_vestCTRL ctrlSetTooltip _vestTT;
	
	//Backpack
	_backpackPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_backpack_gs.paa";
	_backpackTT = "No Backpack";
	_backClass = (GW_PUREQUIP_CURRENTTEMPLATE select 6) select 0;
	if (_backClass != "") then 
	{
		_backpackPic = getText (configFile >> "CfgVehicles" >> _backClass >> "Picture");
		_backpackTT = getText (configFile >> "CfgVehicles" >> _backClass >> "DisplayName");
		_itemIndex = [_backClass, 0, GW_EQUIP_BACKPACKS] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_backpackTT = _backpackTT + format[" - $%1",(GW_EQUIP_BACKPACKS select _itemIndex) select 1]};
		_removeBackpackCTRL ctrlShow true;
	} else {_removeBackpackCTRL ctrlShow false};
	_backpackCTRL ctrlSetText _backpackPic;
	_backpackCTRL ctrlSetTooltip _backpackTT;
	
	//Headgear
	_headgearPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_helmet_gs.paa";
	_headgearTT = "No Headgear";
	_headClass = GW_PUREQUIP_CURRENTTEMPLATE select 0;
	if (_headClass != "") then 
	{
		_headgearPic = getText (configFile >> "CfgWeapons" >> _headClass >> "Picture");
		_headgearTT = getText (configFile >> "CfgWeapons" >> _headClass >> "DisplayName");
		_itemIndex = [_headClass, 0, GW_EQUIP_HEADGEAR] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_headgearTT = _headgearTT + format[" - $%1",(GW_EQUIP_HEADGEAR select _itemIndex) select 1]};
	};
	_headgearCTRL ctrlSetText _headgearPic;
	_headgearCTRL ctrlSetTooltip _headgearTT;
	
	//Facewear
	_facePic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_glasses_gs.paa";
	_faceTT = "No Facewear";
	_faceClass = GW_PUREQUIP_CURRENTTEMPLATE select 1;
	if (_faceClass != "") then 
	{
		_facePic = getText (configFile >> "CfgGlasses" >> _faceClass >> "Picture");
		_faceTT = getText (configFile >> "CfgGlasses" >> _faceClass >> "DisplayName");
		_itemIndex = [_faceClass, 0, GW_EQUIP_FACEWEAR] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_faceTT = _faceTT + format[" - $%1",(GW_EQUIP_FACEWEAR select _itemIndex) select 1]};
	};
	_faceCTRL ctrlSetText _facePic;
	_faceCTRL ctrlSetTooltip _faceTT;
	
	//NVG
	_nvgPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_nvg_gs.paa";
	_nvgTT = "No Head Mounted Display";
	_nvgClass = GW_PUREQUIP_CURRENTTEMPLATE select 3;
	if (_nvgClass != "") then 
	{
		_nvgPic = getText (configFile >> "CfgWeapons" >> _nvgClass >> "Picture");
		_nvgTT = getText (configFile >> "CfgWeapons" >> _nvgClass >> "DisplayName");
		_itemIndex = [_nvgClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_nvgTT = _nvgTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
	};
	_nvgCTRL ctrlSetText _nvgPic;
	_nvgCTRL ctrlSetTooltip _nvgTT;
	
	//Binoculars
	_binocsPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_binocular_gs.paa";
	_binocsTT = "No Binocular";
	_binocClass = GW_PUREQUIP_CURRENTTEMPLATE select 2;
	if (_binocClass != "") then 
	{
		_binocsPic = getText (configFile >> "CfgWeapons" >> _binocClass >> "Picture");
		_binocsTT = getText (configFile >> "CfgWeapons" >> _binocClass >> "DisplayName");
		_itemIndex = [_binocClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_binocsTT = _binocsTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
	};
	_binocsCTRL ctrlSetText _binocsPic;
	_binocsCTRL ctrlSetTooltip _binocsTT;
	
	//Map
	_mapPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_map_gs.paa";
	_mapTT = "No Map";
	_mapClass = (GW_PUREQUIP_CURRENTTEMPLATE select 10) select 2;
	if (_mapClass != "") then
	{
		_mapPic = getText (configFile >> "CfgWeapons" >> _mapClass >> "Picture");
		_mapTT = getText (configFile >> "CfgWeapons" >> _mapClass >> "DisplayName");
		_itemIndex = [_mapClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_mapTT = _mapTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
	};
	_mapCTRL ctrlSetText _mapPic;
	_mapCTRL ctrlSetTooltip _mapTT;
	
	//GPS
	_gpsPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_gps_gs.paa";
	_gpsTT = "No GPS";
	_gpsClass = (GW_PUREQUIP_CURRENTTEMPLATE select 10) select 1;
	if (_gpsClass != "") then
	{
		_gpsPic = getText (configFile >> "CfgWeapons" >> _gpsClass >> "Picture");
		_gpsTT = getText (configFile >> "CfgWeapons" >> _gpsClass >> "DisplayName");
		_itemIndex = [_gpsClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_gpsTT = _gpsTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
	};
	_gpsCTRL ctrlSetText _gpsPic;
	_gpsCTRL ctrlSetTooltip _gpsTT;
	
	//Radio
	_radioPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_radio_gs.paa";
	_radioTT = "No Radio";
	_radioClass = (GW_PUREQUIP_CURRENTTEMPLATE select 10) select 3;
	if (_radioClass != "") then
	{
		_radioPic = getText (configFile >> "CfgWeapons" >> _radioClass >> "Picture");
		_radioTT = getText (configFile >> "CfgWeapons" >> _radioClass >> "DisplayName");
		_itemIndex = [_radioClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_radioTT = _radioTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
	};
	_radioCTRL ctrlSetText _radioPic;
	_radioCTRL ctrlSetTooltip _radioTT;
	
	//Compass
	_compassPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_compass_gs.paa";
	_compassTT = "No Compass";
	_compassClass = (GW_PUREQUIP_CURRENTTEMPLATE select 10) select 0;
	if (_compassClass != "") then
	{
		_compassPic = getText (configFile >> "CfgWeapons" >> _compassClass >> "Picture");
		_compassTT = getText (configFile >> "CfgWeapons" >> _compassClass >> "DisplayName");
		_itemIndex = [_compassClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_compassTT = _compassTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
	};
	_compassCTRL ctrlSetText _compassPic;
	_compassCTRL ctrlSetTooltip _compassTT;
	
	//Watch
	_watchPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_watch_gs.paa";
	_watchTT = "No Watch";
	_watchClass = (GW_PUREQUIP_CURRENTTEMPLATE select 10) select 4;
	if (_watchClass != "") then
	{
		_watchPic = getText (configFile >> "CfgWeapons" >> _watchClass >> "Picture");
		_watchTT = getText (configFile >> "CfgWeapons" >> _watchClass >> "DisplayName");
		_itemIndex = [_watchClass, 0, GW_EQUIP_OTHERS] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_watchTT = _watchTT + format[" - $%1",(GW_EQUIP_OTHERS select _itemIndex) select 1]};
	};
	_watchCTRL ctrlSetText _watchPic;
	_watchCTRL ctrlSetTooltip _watchTT;
	
	//Primary Weapon
	_primaryPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_primary_gs.paa";
	_primaryTT = "No Primary Weapon";
	_primaryMuzPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa";
	_primaryMuzTT = "No Muzzle Attachment";
	_primarySidePic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_side_gs.paa";
	_primarySideTT = "No Side Attachment";
	_primaryTopPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_top_gs.paa";
	_primaryTopTT = "No Optic Attachment";
	_primaryBipodPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_bipod_gs.paa";
	_primaryBipodTT = "No Bipod Attachment";
	_primaryClass = (GW_PUREQUIP_CURRENTTEMPLATE select 7) select 0;
	if (_primaryClass != "") then
	{
		_primaryPic = getText (configFile >> "CfgWeapons" >> _primaryClass >> "Picture");
		_primaryTT = getText (configFile >> "CfgWeapons" >> _primaryClass >> "DisplayName");
		_itemIndex = [_primaryClass, 0, GW_EQUIP_WEAP_PRIMARY] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_primaryTT = _primaryTT + format[" - $%1",(GW_EQUIP_WEAP_PRIMARY select _itemIndex) select 1]};
		
		_primaryAttach = (GW_PUREQUIP_CURRENTTEMPLATE select 7) select 1;
		if (_primaryAttach select 0 != "") then
		{
			_primaryMuzPic = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 0) >> "Picture");
			_primaryMuzTT = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 0) >> "DisplayName");
			_itemIndex = [(_primaryAttach select 0), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_primaryMuzTT = _primaryMuzTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
		};
		if (_primaryAttach select 1 != "") then
		{
			_primarySidePic = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 1) >> "Picture");
			_primarySideTT = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 1) >> "DisplayName");
			_itemIndex = [(_primaryAttach select 1), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_primarySideTT = _primarySideTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
		};
		if (_primaryAttach select 2 != "") then
		{
			_primaryTopPic = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 2) >> "Picture");
			_primaryTopTT = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 2) >> "DisplayName");
			_itemIndex = [(_primaryAttach select 2), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_primaryTopTT = _primaryTopTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
		};
		if ((_primaryAttach select 3) != "") then
		{
			_primaryBipodPic = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 3) >> "Picture");
			_primaryBipodTT = getText (configFile >> "CfgWeapons" >> (_primaryAttach select 3) >> "DisplayName");
			_itemIndex = [(_primaryAttach select 3), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_primaryBipodTT = _primaryBipodTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
		};
	};
	_primaryCTRL ctrlSetText _primaryPic;
	_primaryCTRL ctrlSetTooltip _primaryTT;
	_primaryMuzCTRL ctrlSetText _primaryMuzPic;
	_primaryMuzCTRL ctrlSetTooltip _primaryMuzTT;
	_primarySideCTRL ctrlSetText _primarySidePic;
	_primarySideCTRL ctrlSetTooltip _primarySideTT;
	_primaryTopCTRL ctrlSetText _primaryTopPic;
	_primaryTopCTRL ctrlSetTooltip _primaryTopTT;
	_primaryBipodCTRL ctrlSetText _primaryBipodPic;
	_primaryBipodCTRL ctrlSetTooltip _primaryBipodTT;
	
	//Secondary Weapon
	_secondaryPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_secondary_gs.paa";
	_secondaryTT = "No Secondary Weapon";
	_secondaryMuzPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa";
	_secondaryMuzTT = "No Muzzle Attachment";
	_secondarySidePic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_side_gs.paa";
	_secondarySideTT = "No Side Attachment";
	_secondaryTopPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_top_gs.paa";
	_secondaryTopTT = "No Optic Attachment";
	_secondaryBipodPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_bipod_gs.paa";
	_secondaryBipodTT = "No Bipod Attachment";
	_secondaryClass = (GW_PUREQUIP_CURRENTTEMPLATE select 8) select 0;
	if (_secondaryClass != "") then
	{
		_secondaryPic = getText (configFile >> "CfgWeapons" >> _secondaryClass >> "Picture");
		_secondaryTT = getText (configFile >> "CfgWeapons" >> _secondaryClass >> "DisplayName");
		_itemIndex = [_secondaryClass, 0, GW_EQUIP_WEAP_SECONDARY] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_secondaryTT = _secondaryTT + format[" - $%1",(GW_EQUIP_WEAP_SECONDARY select _itemIndex) select 1]};
		
		_secondaryAttach = (GW_PUREQUIP_CURRENTTEMPLATE select 8) select 1;
		if ((_secondaryAttach select 0) != "") then
		{
			_secondaryMuzPic = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 0) >> "Picture");
			_secondaryMuzTT = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 0) >> "DisplayName");
			_itemIndex = [(_secondaryAttach select 0), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_secondaryMuzTT = _secondaryMuzTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
		};
		if ((_secondaryAttach select 1) != "") then
		{
			_secondarySidePic = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 1) >> "Picture");
			_secondarySideTT = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 1) >> "DisplayName");
			_itemIndex = [(_secondaryAttach select 1), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_secondarySideTT = _secondarySideTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
		};
		if ((_secondaryAttach select 2) != "") then
		{
			_secondaryTopPic = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 2) >> "Picture");
			_secondaryTopTT = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 2) >> "DisplayName");
			_itemIndex = [(_secondaryAttach select 2), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_secondaryTopTT = _secondaryTopTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
		};
		if ((_secondaryAttach select 3) != "") then
		{
			_secondaryBipodPic = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 3) >> "Picture");
			_secondaryBipodTT = getText (configFile >> "CfgWeapons" >> (_secondaryAttach select 3) >> "DisplayName");
			_itemIndex = [(_secondaryAttach select 3), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_secondaryBipodTT = _secondaryBipodTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
		};
	};
	_secondaryCTRL ctrlSetText _secondaryPic;
	_secondaryCTRL ctrlSetTooltip _secondaryTT;
	_secondaryMuzCTRL ctrlSetText _secondaryMuzPic;
	_secondaryMuzCTRL ctrlSetTooltip _secondaryMuzTT;
	_secondarySideCTRL ctrlSetText _secondarySidePic;
	_secondarySideCTRL ctrlSetTooltip _secondarySideTT;
	_secondaryTopCTRL ctrlSetText _secondaryTopPic;
	_secondaryTopCTRL ctrlSetTooltip _secondaryTopTT;
	_secondaryBipodCTRL ctrlSetText _secondaryBipodPic;
	_secondaryBipodCTRL ctrlSetTooltip _secondaryBipodTT;
	
	//Handgun
	_handgunPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_hgun_gs.paa";
	_handgunTT = "No Handgun";
	_handgunMuzPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa";
	_handgunMuzTT = "No Muzzle Attachment";
	_handgunSidePic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_side_gs.paa";
	_handgunSideTT = "No Side Attachment";
	_handgunTopPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_top_gs.paa";
	_handgunTopTT = "No Optic Attachment";
	_handgunBipodPic = "\A3\ui_f\data\gui\Rsc\RscDisplayGear\ui_gear_bipod_gs.paa";
	_handgunBipodTT = "No Bipod Attachment";
	_handgunClass = (GW_PUREQUIP_CURRENTTEMPLATE select 9) select 0;
	if (_handgunClass != "") then
	{
		_handgunPic = getText (configFile >> "CfgWeapons" >> _handgunClass >> "Picture");
		_handgunTT = getText (configFile >> "CfgWeapons" >> _handgunClass >> "DisplayName");
		_itemIndex = [_handgunClass, 0, GW_EQUIP_WEAP_SIDEARM] Call fnc_shr_arrayGetIndex;
		if (_itemIndex != -1) then {_handgunTT = _handgunTT + format[" - $%1",(GW_EQUIP_WEAP_SIDEARM select _itemIndex) select 1]};
		
		_handgunAttach = (GW_PUREQUIP_CURRENTTEMPLATE select 9) select 1;
		if ((_handgunAttach select 0) != "") then
		{
			_handgunMuzPic = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 0) >> "Picture");
			_handgunMuzTT = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 0) >> "DisplayName");
			_itemIndex = [(_handgunAttach select 0), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_handgunMuzTT = _handgunMuzTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
		};
		if ((_handgunAttach select 1) != "") then
		{
			_handgunSidePic = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 1) >> "Picture");
			_handgunSideTT = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 1) >> "DisplayName");
			_itemIndex = [(_handgunAttach select 1), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_handgunSideTT = _handgunSideTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
		};
		if ((_handgunAttach select 2) != "") then
		{
			_handgunTopPic = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 2) >> "Picture");
			_handgunTopTT = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 2) >> "DisplayName");
			_itemIndex = [(_handgunAttach select 2), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_handgunTopTT = _handgunTopTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
		};
		if ((_handgunAttach select 3) != "") then
		{
			_handgunBipodPic = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 3) >> "Picture");
			_handgunBipodTT = getText (configFile >> "CfgWeapons" >> (_handgunAttach select 3) >> "DisplayName");
			_itemIndex = [(_handgunAttach select 3), 0, GW_EQUIP_ATTACHMENTS] Call fnc_shr_arrayGetIndex;
			if (_itemIndex != -1) then {_handgunBipodTT = _handgunBipodTT + format[" - $%1",(GW_EQUIP_ATTACHMENTS select _itemIndex) select 1]};
		};
	};
	_handgunCTRL ctrlSetText _handgunPic;
	_handgunCTRL ctrlSetTooltip _handgunTT;
	_handgunMuzCTRL ctrlSetText _handgunMuzPic;
	_handgunMuzCTRL ctrlSetTooltip _handgunMuzTT;
	_handgunSideCTRL ctrlSetText _handgunSidePic;
	_handgunSideCTRL ctrlSetTooltip _handgunSideTT;
	_handgunTopCTRL ctrlSetText _handgunTopPic;
	_handgunTopCTRL ctrlSetTooltip _handgunTopTT;
	_handgunBipodCTRL ctrlSetText _handgunBipodPic;
	_handgunBipodCTRL ctrlSetTooltip _handgunBipodTT;
};

//Populate list depending on category selected
fnc_purequip_populateGearList =
{
	private["_categoryIndex","_parentDisp","_equipPopulateNetCall","_equipPopulateNetCall"];
	disableSerialization;
	_categoryIndex = _this select 0;
	_parentDisp = _this select 1;
	
	//Clear lists
	lbClear 1500;
	lbClear 1501;
	lbClear 1505;
	GW_PUREQUIP_SECONDLIST = [];
	GW_PUREQUIP_ATTACHLIST = [];
	
	//What array should we work with
	GW_PUREQUIP_MAINLIST = Call Compile Format["GW_PUREQUIP_%1",lbData[2100, _categoryIndex]];
	
	//Populate the main list
	{
		lbAdd [1500, format["$%1 - %2",_x select 1,(getText (configFile >> (_x select 3) >> (_x select 0) >> "DisplayName"))]];
		lbSetPicture [1500, _forEachIndex, (getText (configFile >> (_x select 3) >> (_x select 0) >> "Picture"))];
		lbSetData [1500, _forEachIndex, (_x select 0)];
	} forEach GW_PUREQUIP_MAINLIST;
	
	if ((count GW_PUREQUIP_MAINLIST) > 0) then {lbSetCurSel [1500, 0]};
	
	//If a primary entry is selected, attempt to populate related magazines
	if ((lbCurSel 1500) > -1) then {GW_PUREQUIP_PRIMARYLISTCHANGED = true};
};

//Populate the magazine list depending on what weapon is selected
fnc_purequip_populateMagazineList =
{	
	private["_currentSelectedPrimary","_weapClassname","_configMagsArray"];
	_currentSelectedPrimary = _this select 0;
	
	//Clear list
	lbClear 1501;
	
	//Figure out what classname of weapon is selected in the main list
	_weapClassname = (GW_PUREQUIP_MAINLIST select _currentSelectedPrimary) select 0;
	
	//Get a list of magazines the gun can use from the config (Safe to hardcode CfgWeapons)
	_configMagsArray = GetArray (configFile >> "CfgWeapons" >> _weapClassname >> "magazines");
	_allConfigMagsArray = _configMagsArray;
	
	//Check for magazines under muzzles
	_muzzlesCfg = GetArray (configFile >> "CfgWeapons" >> _weapClassname >> "muzzles");
	_muzzleMags = [];
	{
		if (_x != "this") then 
		{
			_muzMagList = GetArray (configFile >> "CfgWeapons" >> _weapClassname >> _x >> "magazines");
			_allConfigMagsArray = [_allConfigMagsArray, _muzMagList] Call fnc_shr_mergeArrays;
		};
	} forEach _muzzlesCfg;
	
	//Parse out magazines list
	GW_PUREQUIP_SECONDLIST = [];
	{
		_cfgMagsClass = _x;
		{
			if ((_x select 0) == _cfgMagsClass) exitWith {GW_PUREQUIP_SECONDLIST set [count GW_PUREQUIP_SECONDLIST, _x]};
		} forEach GW_PUREQUIP_MAGAZINES;
	} forEach _allConfigMagsArray;
	
	//Populate the second list
	{
		lbAdd [1501, format["$%1 - %2",_x select 1,(getText (configFile >> (_x select 3) >> (_x select 0) >> "DisplayName"))]];
		lbSetPicture [1501, _forEachIndex, (getText (configFile >> (_x select 3) >> (_x select 0) >> "Picture"))];
		lbSetData [1501, _forEachIndex, (_x select 0)];
	} forEach GW_PUREQUIP_SECONDLIST;
};

//Populate attachments list depending on what weapon is selected
fnc_purequip_populateAttachmentList =
{
	private["_currentSelectedPrimary","_weapClassname","_configCows","_configMuzzle","_configPointer","_configAttach"];
	_currentSelectedPrimary = _this select 0;
	
	//Clear list
	lbClear 1505;
	
	//Figure out what classname of weapon is selected in the main list
	_weapClassname = (GW_PUREQUIP_MAINLIST select _currentSelectedPrimary) select 0;
	
	_configAttach = [];
	{
		configProperties 
		[
			configFile >> "CfgWeapons" >> _weapClassname >> "WeaponSlotsInfo" >> _x >> "compatibleItems", 
			"_configAttach pushBack (configName _x)", 
			true
		];
	} forEach ["CowsSlot", "MuzzleSlot", "PointerSlot", "UnderBarrelSlot"];
	
	//Parse out attachments list
	GW_PUREQUIP_ATTACHLIST = [];
	{
		_cfgAttachClass = _x;
		{
			if ((_x select 0) == _cfgAttachClass) exitWith {GW_PUREQUIP_ATTACHLIST set [count GW_PUREQUIP_ATTACHLIST, _x]};
		} forEach GW_PUREQUIP_ATTACHMENTS;
	} forEach _configAttach;

	//Populate the attachment list
	{
		lbAdd [1505, format["$%1 - %2",_x select 1,(getText (configFile >> (_x select 3) >> (_x select 0) >> "DisplayName"))]];
		lbSetPicture [1505, _forEachIndex, (getText (configFile >> (_x select 3) >> (_x select 0) >> "Picture"))];
		lbSetData [1505, _forEachIndex, (_x select 0)];
	} forEach GW_PUREQUIP_ATTACHLIST;
};

//Populate inventory container list
fnc_purequip_populateContainerList =
{
	private["_containerIndex","_containerContents"];
	_containerIndex = _this select 0;
	
	//Clear list
	lbClear 1504;
	
	_containerContents = (GW_PUREQUIP_CURRENTTEMPLATE select _containerIndex) select 1;
	{
		_classname = _x;
		_cfgClass = _x Call fnc_shr_getEquipCfgClass;
		
		//Get the price of the item (we don't know what category it's in, so unfortunately we need to search the entire equipment array)
		_price = 0;
		_classNameIndex = [_classname, 0, GW_PUREQUIP_FULLLIST] Call fnc_shr_arrayGetIndex;
		if (_classNameIndex != -1) then {_price = (GW_PUREQUIP_FULLLIST select _classNameIndex) select 1};

		_displayString = format["$%1 - %2",_price,(getText (configFile >> _cfgClass >> _classname >> "DisplayName"))];
		lbAdd [1504, _displayString];
		lbSetTooltip [1504, _forEachIndex, _displayString];
		lbSetPicture [1504, _forEachIndex, (getText (configFile >> _cfgClass >> _classname >> "Picture"))];
	} forEach _containerContents;
};

//Can an item fit in a specified container
fnc_purequip_canFitInContainer =
{
	private["_itemClass","_container","_cfgClass","_canFit","_classType","_allowedSlots"];
	_itemClass = _this select 0;
	_container = _this select 1;
	_canFit = false;
	
	//Make sure the container actually exists in the template
	if (_container != "") then
	{
		if (_container == "Uniform") then {if (((GW_PUREQUIP_CURRENTTEMPLATE select 4) select 0) != "") then {_canFit = true}};
		if (_container == "Vest") then {if (((GW_PUREQUIP_CURRENTTEMPLATE select 5) select 0) != "") then {_canFit = true}};
		if (_container == "Backpack") then {if (((GW_PUREQUIP_CURRENTTEMPLATE select 6) select 0) != "") then {_canFit = true}};
	};
	
	//Check if the item can fit inside the container
	if (_itemClass != "" && _canFit) then
	{
		_cfgClass = _itemClass Call fnc_shr_getEquipCfgClass;
		if (_cfgClass == "CfgWeapons") then
		{
			_classType = getNumber(configFile >> _cfgClass >> _itemClass >> "type");
			if (_classType == GW_PUREQUIP_TYPE_ITEM) then 
			{
				_configsProperties = [];
				configProperties [configFile >> _cfgClass >> _itemClass >> "ItemInfo", "_configsProperties pushBack (configName _x); true", true];
				if ("allowedSlots" in _configsProperties) then
				{
					_allowedSlots = getArray(configFile >> _cfgClass >> _itemClass >> "ItemInfo" >> "allowedSlots");
					if ((_container == "Uniform") && (801 in _allowedSlots)) then {_canFit = true} else {_canFit = false};
					if ((_container == "Vest") && (701 in _allowedSlots)) then {_canFit = true} else {_canFit = false};
					if ((_container == "Backpack") && (901 in _allowedSlots)) then {_canFit = true} else {_canFit = false};
				}
				else
				{
					_canFit = true;
				};
			}
			else
			{
				_allowedSlots = getArray(configFile >> _cfgClass >> _itemClass >> "WeaponSlotsInfo" >> "allowedSlots");
				if ((_container == "Uniform") && (801 in _allowedSlots)) then {_canFit = true} else {_canFit = false};
				if ((_container == "Vest") && (701 in _allowedSlots)) then {_canFit = true} else {_canFit = false};
				if ((_container == "Backpack") && (901 in _allowedSlots)) then {_canFit = true} else {_canFit = false};
			};
		};
		if (_cfgClass == "CfgGlasses") then {_canFit = true};
		if (_cfgClass == "CfgMagazines") then 
		{
			_allowedSlots = getArray(configFile >> _cfgClass >> _itemClass >> "allowedSlots");
			if (count _allowedSlots == 0) then
			{
				_canFit = true;
			}
			else
			{
				if ((_container == "Uniform") && (801 in _allowedSlots)) then {_canFit = true} else {_canFit = false};
				if ((_container == "Vest") && (701 in _allowedSlots)) then {_canFit = true} else {_canFit = false};
				if ((_container == "Backpack") && (901 in _allowedSlots)) then {_canFit = true} else {_canFit = false};
			};
		};
	};
	
	_canFit
};

//Get item's mass
fnc_purequip_getItemMass =
{
	private["_mass","_cfgClass","_classType"];
	_mass = 0;
	
	if (_this != "") then
	{
		_cfgClass = _this Call fnc_shr_getEquipCfgClass;
		if (_cfgClass == "CfgWeapons") then
		{
			_classType = getNumber(configFile >> _cfgClass >> _this >> "type");
			_mass = if (_classType == GW_PUREQUIP_TYPE_ITEM) then {getNumber(configFile >> _cfgClass >> _this >> "ItemInfo" >> "mass")} else {getNumber(configFile >> _cfgClass >> _this >> "WeaponSlotsInfo" >> "mass")};
		}
		else
		{
			_mass = getNumber(configFile >> _cfgClass >> _this >> "mass");
		};
	};
	
	_mass
};

//Get a specific container's current mass
fnc_purequip_getContainerCurrentMass =
{
	private["_currentMass","_containerArray","_itemMass"];
	_currentMass = 0;
	
	_containerArray = [];
	if (_this == "Uniform" && (((GW_PUREQUIP_CURRENTTEMPLATE select 4) select 0) != "")) then
	{
		_containerArray = ((GW_PUREQUIP_CURRENTTEMPLATE select 4) select 1);
	};
	if (_this == "Vest" && (((GW_PUREQUIP_CURRENTTEMPLATE select 5) select 0) != "")) then
	{
		_containerArray = ((GW_PUREQUIP_CURRENTTEMPLATE select 5) select 1);
	};
	if (_this == "Backpack" && (((GW_PUREQUIP_CURRENTTEMPLATE select 6) select 0) != "")) then
	{
		_containerArray = ((GW_PUREQUIP_CURRENTTEMPLATE select 6) select 1);
	};
	
	//Go through container's contents
	{
		_itemMass = _x Call fnc_purequip_getItemMass;
		_currentMass = _currentMass + _itemMass;
	} forEach _containerArray;
	
	_currentMass
};

//Get a specific container's max mass
fnc_purequip_getContainerMaxMass =
{
	private["_maxMass","_cfgClass","_containerClass"];
	_maxMass = 0;
	_containerClassName = "";
	
	if (_this == "Uniform") then {_containerClassName = (GW_PUREQUIP_CURRENTTEMPLATE select 4) select 0};
	if (_this == "Vest") then {_containerClassName = (GW_PUREQUIP_CURRENTTEMPLATE select 5) select 0};
	if (_this == "Backpack") then {_containerClassName = (GW_PUREQUIP_CURRENTTEMPLATE select 6) select 0};
	
	if (_containerClassName != "") then
	{
		_cfgClass = _containerClassName Call fnc_shr_getEquipCfgClass;
		
		if (_cfgClass == "CfgVehicles") then 
		{
			_maxMass = getNumber(configFile >> "CfgVehicles" >> _containerClassName >> "maximumLoad");
		};
		if (_cfgClass == "CfgWeapons") then
		{
			_containerClass = getText(configFile >> "CfgWeapons" >> _containerClassName >> "ItemInfo" >> "containerClass");
			_maxMass = getNumber(configFile >> "CfgVehicles" >> _containerClass >> "maximumLoad");
		};
	};
	
	_maxMass
};

//Update all container's masses
fnc_purequip_updateMasses = 
{
	private["_parentDisp"];
	disableSerialization;
	_parentDisp = _this select 0;
	
	GW_PUREQUIP_UNIFORM_CURR = "Uniform" Call fnc_purequip_getContainerCurrentMass;
	GW_PUREQUIP_UNIFORM_MAX = "Uniform" Call fnc_purequip_getContainerMaxMass;
	_BGUniformMassCtrl = _parentDisp displayCtrl 1102;
	_BarUniformMassCtrl = _parentDisp displayCtrl 1105;
	if (GW_PUREQUIP_UNIFORM_MAX == 0) then
	{
		_BGUniformMassCtrl ctrlShow false;
		_BarUniformMassCtrl ctrlShow false;
	}
	else
	{
		_BGUniformMassCtrl ctrlShow true;
		_BarUniformMassCtrl ctrlShow true;
		_BGUniformMassMaxWidth = (CtrlPosition _BGUniformMassCtrl select 2) - 0.02;
		_BarUniformMassCurPos = CtrlPosition _BarUniformMassCtrl;
		_BarUniformMassCurPos set [2, _BGUniformMassMaxWidth * (GW_PUREQUIP_UNIFORM_CURR / GW_PUREQUIP_UNIFORM_MAX)];
		_BarUniformMassCtrl CtrlSetPosition _BarUniformMassCurPos;
		_BarUniformMassCtrl CtrlCommit 0;
	};
	
	GW_PUREQUIP_VEST_CURR = "Vest" Call fnc_purequip_getContainerCurrentMass;
	GW_PUREQUIP_VEST_MAX = "Vest" Call fnc_purequip_getContainerMaxMass;
	_BGVestMassCtrl = _parentDisp displayCtrl 1103;
	_BarVestMassCtrl = _parentDisp displayCtrl 1106;
	if (GW_PUREQUIP_VEST_MAX == 0) then
	{
		_BGVestMassCtrl ctrlShow false;
		_BarVestMassCtrl ctrlShow false;
	}
	else
	{
		_BGVestMassCtrl ctrlShow true;
		_BarVestMassCtrl ctrlShow true;
		_BGVestMassMaxWidth = (CtrlPosition _BGVestMassCtrl select 2) - 0.02;
		_BarVestMassCurPos = CtrlPosition _BarVestMassCtrl;
		_BarVestMassCurPos set [2, _BGVestMassMaxWidth * (GW_PUREQUIP_VEST_CURR / GW_PUREQUIP_VEST_MAX)];
		_BarVestMassCtrl CtrlSetPosition _BarVestMassCurPos;
		_BarVestMassCtrl CtrlCommit 0;
	};
	
	GW_PUREQUIP_BACKPACK_CURR = "Backpack" Call fnc_purequip_getContainerCurrentMass;
	GW_PUREQUIP_BACKPACK_MAX = "Backpack" Call fnc_purequip_getContainerMaxMass;
	_BGBackpackMassCtrl = _parentDisp displayCtrl 1104;
	_BarBackpackMassCtrl = _parentDisp displayCtrl 1107;
	if (GW_PUREQUIP_BACKPACK_MAX == 0) then
	{
		_BGBackpackMassCtrl ctrlShow false;
		_BarBackpackMassCtrl ctrlShow false;
	}
	else
	{
		_BGBackpackMassCtrl ctrlShow true;
		_BarBackpackMassCtrl ctrlShow true;
		_BGBackpackMassMaxWidth = (CtrlPosition _BGBackpackMassCtrl select 2) - 0.02;
		_BarBackpackMassCurPos = CtrlPosition _BarBackpackMassCtrl;
		_BarBackpackMassCurPos set [2, _BGBackpackMassMaxWidth * (GW_PUREQUIP_BACKPACK_CURR / GW_PUREQUIP_BACKPACK_MAX)];
		_BarBackpackMassCtrl CtrlSetPosition _BarBackpackMassCurPos;
		_BarBackpackMassCtrl CtrlCommit 0;
	};
};

//Get the value of the current template
fnc_purequip_updateCost =
{
	private["_parentDisp","_totalCost"];
	disableSerialization;
	_parentDisp = _this select 0;
	_equipArray = _this select 1;
	
	_totalCost = 0;
	
	//Get the value of the current template
	_templateCost = GW_PUREQUIP_CURRENTTEMPLATE Call fnc_shr_getEquipmentCost;
	
	//Get the value of what's on the player
	_playerEquip = player Call fnc_shr_getEquipArray;
	_playerCost = _playerEquip Call fnc_shr_getEquipmentCost;

	//Difference between them (Can't refund, $0 is minimum)
	_totalCost = (_templateCost - _playerCost) max 0;
	
	_textColor = if (_totalCost <= GW_CVAR_MONEY) then {"#269024"} else {"#c75454"};
	if (_totalCost <= GW_CVAR_MONEY) then {ctrlEnable [1604, true]} else {ctrlEnable [1604, true]};
	_totalCostCTRL = _parentDisp displayCtrl 1109;
	_totalCostCTRL ctrlSetStructuredText (parseText format ["Total Cost of Equipment: <t color='%1'>$%2</t>",_textColor, _totalCost]);
	GW_PUREQUIP_TOTALCOST = _totalCost;
};

//Remove item from equipment
fnc_purequip_removeItem =
{
	private["_itemSlotArray","_invQuery","_preSaveArray","_innerPreSaveArray"];
	_itemSlotArray = _this;
	_invQuery = "";
	
	//Helmet, Facewear, Binocs, NVGs
	if (count _itemSlotArray == 1) then 
	{	
		_preSaveArray =+ GW_PUREQUIP_CURRENTTEMPLATE;
		_preSaveArray set [_itemSlotArray select 0, ""];
		GW_PUREQUIP_CURRENTTEMPLATE = _preSaveArray;
	};
	
	//Primary Weapon, Secondary Weapon, Sidearm or Assigned Items
	if (count _itemSlotArray == 2) then 
	{
		_preSaveArray =+ GW_PUREQUIP_CURRENTTEMPLATE select (_itemSlotArray select 0);
		_preSaveArray set [_itemSlotArray select 1, ""];
		
		//Removed weapon, be sure to remove attachments as well
		if (((_itemSlotArray select 0) == 7) || ((_itemSlotArray select 0) == 8) || ((_itemSlotArray select 0) == 9)) then
		{
			if ((_preSaveArray select 0) == "") then {_preSaveArray set [1, ["","","",""]]};
		};
		GW_PUREQUIP_CURRENTTEMPLATE set [_itemSlotArray select 0, _preSaveArray];
	};
	
	//Weapon Attachments
	if (count _itemSlotArray == 3) then 
	{
		_preSaveArray =+ GW_PUREQUIP_CURRENTTEMPLATE select (_itemSlotArray select 0);
		_innerPreSaveArray = _preSaveArray select (_itemSlotArray select 1);
		_innerPreSaveArray set [_itemSlotArray select 2, ""];
		
		_preSaveArray set [(_itemSlotArray select 1), _innerPreSaveArray];
		GW_PUREQUIP_CURRENTTEMPLATE set [_itemSlotArray select 0, _preSaveArray];
	};
	
	//Call for update of inv
	GW_PUREQUIP_RECALC_TOTAL = true;
	GW_PUREQUIP_REDRAWINV = true;
};

//Remove a given index from the selected container
fnc_purequip_removeContainerItem =
{
	private["_itemIndex","_refresh","_preSaveArray","_innerPreSaveArray","_item"];
	_itemIndex = _this select 0;
	_refresh = _this select 1;
	
	//Don't do anything if there's no container selected (shouldn't ever happen)
	if (GW_PUREQUIP_CONTAINERSEL == -1) exitWith {};
	
	//Remove specified item
	_preSaveArray =+ GW_PUREQUIP_CURRENTTEMPLATE select GW_PUREQUIP_CONTAINERSEL;
	_innerPreSaveArray = _preSaveArray select 1;
	_innerPreSaveArray set [_itemIndex, "REMOVE"];
	_innerPreSaveArray = _innerPreSaveArray - ["REMOVE"];
	_preSaveArray set [1, _innerPreSaveArray];
	GW_PUREQUIP_CURRENTTEMPLATE set [GW_PUREQUIP_CONTAINERSEL, _preSaveArray];
	
	//Call for update of inv (Set this to false if emptying entire container, then redraw once at end)
	if (_refresh) then
	{
		GW_PUREQUIP_RECALC_TOTAL = true;
		GW_PUREQUIP_RECALC_MASS = true;
		_containerPop = [GW_PUREQUIP_CONTAINERSEL] Spawn fnc_purequip_populateContainerList;
		waitUntil {scriptDone _containerPop};
	};
};

//Remove container
fnc_purequip_removeContainer =
{
	private["_containerIndex", "_preSaveArray"];
	_containerIndex = _this select 0;
	
	_preSaveArray =+ (GW_PUREQUIP_CURRENTTEMPLATE select _containerIndex);
	if (_preSaveArray select 0 != "") then
	{
		//If the container previously selected matches our removed one, update container selected logic
		if (GW_PUREQUIP_CONTAINERSEL == _containerIndex) then {GW_PUREQUIP_CONTAINERSEL = -1; GW_PUREQUIP_CONTAINERCHANGED = true};
		
		//Update template
		_preSaveArray set [0, ""];
		_preSaveArray set [1, []];
		GW_PUREQUIP_CURRENTTEMPLATE set [_containerIndex, _preSaveArray];
		
		//Request redraw
		GW_PUREQUIP_REDRAWINV = true;
		GW_PUREQUIP_RECALC_TOTAL = true;
		GW_PUREQUIP_RECALC_MASS = true;
	};
};

//Empty container
fnc_purequip_emptyContainer =
{
	private["_containerIndex"];
	_containerIndex = _this select 0;
	
	//Update template
	_preSaveArray =+ (GW_PUREQUIP_CURRENTTEMPLATE select _containerIndex);
	_preSaveArray set [1, []];
	GW_PUREQUIP_CURRENTTEMPLATE set [_containerIndex, _preSaveArray];
	
	//Request redraw
	GW_PUREQUIP_RECALC_TOTAL = true;
	GW_PUREQUIP_RECALC_MASS = true;
	_containerPop = [GW_PUREQUIP_CONTAINERSEL] Spawn fnc_purequip_populateContainerList;
	waitUntil {scriptDone _containerPop};
};

//Can an attachment work on the weapon
fnc_purequip_attachmentFits =
{
	private["_attachClass","_weaponClass","_configAttach","_newAttachClasses","_oldAttachClasses"];
	_attachClass = _this select 0;
	_weaponClass = _this select 1;
	_attachmentFits = false;
	
	_configAttach = [];
	{
		configProperties 
		[
			configFile >> "CfgWeapons" >> _weaponClass >> "WeaponSlotsInfo" >> _x >> "compatibleItems", 
			"_configAttach pushBack (configName _x)", 
			true
		];
	} forEach ["CowsSlot", "MuzzleSlot", "PointerSlot", "UnderBarrelSlot"];

	//Search for our attachment
	{
		if (_x == _attachClass) exitWith {_attachmentFits = true};
	} forEach _configAttach;

	_attachmentFits 
};

//Add item to template
fnc_purequip_addItem =
{
	private["_ctrl","_clickIndex","_itemIndex","_itemSlotArray","_itemClassName","_itemSlotArray"];
	disableSerialization;
	_ctrl = _this select 0;
	_clickIndex = _this select 1;

	_itemIndex = [(lbData[_ctrl, _clickIndex]), 0, GW_PUREQUIP_FULLLIST] Call fnc_shr_arrayGetIndex;
	if (_itemIndex != -1) then
	{
		_itemClassName = (GW_PUREQUIP_FULLLIST select _itemIndex) select 0;
		_itemSlotArray = (GW_PUREQUIP_FULLLIST select _itemIndex) select 4;

		//Helmet, Facewear, Binocs, NVGs
		if ((count _itemSlotArray) == 1) then 
		{	
			_preSaveArray =+ GW_PUREQUIP_CURRENTTEMPLATE;
			
			//Equipable item
			if ((_itemSlotArray select 0) != -1) then
			{
				if ((_preSaveArray select (_itemSlotArray select 0)) == "") then
				{
					_preSaveArray set [_itemSlotArray select 0, _itemClassName];
					GW_PUREQUIP_CURRENTTEMPLATE = _preSaveArray;
				}
				else
				{
					if (GW_PUREQUIP_CONTAINERSEL != -1) then
					{
						_containerName = "";
						_containerMassCurrent = 0;
						_containerMassMax = 0;
						if (GW_PUREQUIP_CONTAINERSEL == 4) then {_containerName = "Uniform"; _containerMassCurrent = GW_PUREQUIP_UNIFORM_CURR; _containerMassMax = GW_PUREQUIP_UNIFORM_MAX};
						if (GW_PUREQUIP_CONTAINERSEL == 5) then {_containerName = "Vest"; _containerMassCurrent = GW_PUREQUIP_VEST_CURR; _containerMassMax = GW_PUREQUIP_VEST_MAX};
						if (GW_PUREQUIP_CONTAINERSEL == 6) then {_containerName = "Backpack"; _containerMassCurrent = GW_PUREQUIP_BACKPACK_CURR; _containerMassMax = GW_PUREQUIP_BACKPACK_MAX};
						_canFit = [_itemClassName, _containerName] Call fnc_purequip_canFitInContainer;
						if (_canFit) then
						{
							_itemMass = _itemClassName Call fnc_purequip_getItemMass;

							if ((_containerMassCurrent + _itemMass) <= _containerMassMax) then
							{
								_innerPreSaveArray = _preSaveArray select GW_PUREQUIP_CONTAINERSEL;
								_innerSubPreSaveArray = _innerPreSaveArray select 1;
								_innerSubPreSaveArray pushBack _itemClassName;
								_innerPreSaveArray set [1, _innerSubPreSaveArray];
								_preSaveArray set [GW_PUREQUIP_CONTAINERSEL, _innerPreSaveArray];
								GW_PUREQUIP_CURRENTTEMPLATE = _preSaveArray;
								GW_PUREQUIP_CONTAINERCHANGED = true;
							};
						};
					};
				};
			}
			else //Only fits in a container
			{
				if (GW_PUREQUIP_CONTAINERSEL != -1) then
				{
					_containerName = "";
					_containerMassCurrent = 0;
					_containerMassMax = 0;
					if (GW_PUREQUIP_CONTAINERSEL == 4) then {_containerName = "Uniform"; _containerMassCurrent = GW_PUREQUIP_UNIFORM_CURR; _containerMassMax = GW_PUREQUIP_UNIFORM_MAX};
					if (GW_PUREQUIP_CONTAINERSEL == 5) then {_containerName = "Vest"; _containerMassCurrent = GW_PUREQUIP_VEST_CURR; _containerMassMax = GW_PUREQUIP_VEST_MAX};
					if (GW_PUREQUIP_CONTAINERSEL == 6) then {_containerName = "Backpack"; _containerMassCurrent = GW_PUREQUIP_BACKPACK_CURR; _containerMassMax = GW_PUREQUIP_BACKPACK_MAX};
					_canFit = [_itemClassName, _containerName] Call fnc_purequip_canFitInContainer;
					if (_canFit) then
					{
						_itemMass = _itemClassName Call fnc_purequip_getItemMass;

						if ((_containerMassCurrent + _itemMass) <= _containerMassMax) then
						{
							_innerPreSaveArray = _preSaveArray select GW_PUREQUIP_CONTAINERSEL;
							_innerSubPreSaveArray = _innerPreSaveArray select 1;
							_innerSubPreSaveArray pushBack _itemClassName;
							_innerPreSaveArray set [1, _innerSubPreSaveArray];
							_preSaveArray set [GW_PUREQUIP_CONTAINERSEL, _innerPreSaveArray];
							GW_PUREQUIP_CURRENTTEMPLATE = _preSaveArray;
							GW_PUREQUIP_CONTAINERCHANGED = true;
						};
					};
				};
			};
		};
		
		
		//Primary Weapon, Secondary Weapon, Sidearm or Assigned Items
		if ((count _itemSlotArray) == 2) then 
		{
			_preSaveArray =+ GW_PUREQUIP_CURRENTTEMPLATE select (_itemSlotArray select 0);
			
			//No current item
			if ((_preSaveArray select (_itemSlotArray select 1)) == "") then
			{
				_preSaveArray set [(_itemSlotArray select 1), _itemClassName];
				GW_PUREQUIP_CURRENTTEMPLATE set [(_itemSlotArray select 0), _preSaveArray];
			}
			else //Current item is already populated, try to put in container
			{
				if (GW_PUREQUIP_CONTAINERSEL != -1) then
				{
					_containerName = "";
					_containerMassCurrent = 0;
					_containerMassMax = 0;
					if (GW_PUREQUIP_CONTAINERSEL == 4) then {_containerName = "Uniform"; _containerMassCurrent = GW_PUREQUIP_UNIFORM_CURR; _containerMassMax = GW_PUREQUIP_UNIFORM_MAX};
					if (GW_PUREQUIP_CONTAINERSEL == 5) then {_containerName = "Vest"; _containerMassCurrent = GW_PUREQUIP_VEST_CURR; _containerMassMax = GW_PUREQUIP_VEST_MAX};
					if (GW_PUREQUIP_CONTAINERSEL == 6) then {_containerName = "Backpack"; _containerMassCurrent = GW_PUREQUIP_BACKPACK_CURR; _containerMassMax = GW_PUREQUIP_BACKPACK_MAX};
					_canFit = [_itemClassName, _containerName] Call fnc_purequip_canFitInContainer;
					if (_canFit) then
					{
						_itemMass = _itemClassName Call fnc_purequip_getItemMass;

						if ((_containerMassCurrent + _itemMass) <= _containerMassMax) then
						{
							_preSaveArray =+ GW_PUREQUIP_CURRENTTEMPLATE;
							_innerPreSaveArray = _preSaveArray select GW_PUREQUIP_CONTAINERSEL;
							_innerSubPreSaveArray = _innerPreSaveArray select 1;
							_innerSubPreSaveArray pushBack _itemClassName;
							_innerPreSaveArray set [1, _innerSubPreSaveArray];
							_preSaveArray set [GW_PUREQUIP_CONTAINERSEL, _innerPreSaveArray];
							GW_PUREQUIP_CURRENTTEMPLATE = _preSaveArray;
							GW_PUREQUIP_CONTAINERCHANGED = true;
						};
					};
				};
			};
		};
		
		//Weapon Attachments
		if (count _itemSlotArray == 3) then 
		{
			_equipSlot = (_itemSlotArray select 0);
			_preSaveIndex = -1;
			if (typeName _equipSlot == "ARRAY") then 
			{
				_gunIndex = 7;
				if ((lbCurSel 2100) == 1) then {_gunIndex = 8};
				if ((lbCurSel 2100) == 2) then {_gunIndex = 9};
				
				if (_gunIndex in _equipSlot) then 
				{
					_preSaveIndex = _gunIndex;
				};
			} 
			else 
			{
				_preSaveIndex = _equipSlot;
			};
			
			_preSaveArray = [];
			_gunClass = "";
			_attachmentSlot = "";
			_attachmentFits = false;
			
			//If we found a suitable slot to equip
			if (_preSaveIndex != -1) then
			{
				_preSaveArray =+ GW_PUREQUIP_CURRENTTEMPLATE select _preSaveIndex;
				
				//Does it fit on the weapon?
				_gunClass = (_preSaveArray select 0);
				_attachmentSlot = ((_preSaveArray select (_itemSlotArray select 1)) select (_itemSlotArray select 2));
				_attachmentFits = if (_gunClass != "") then {[_itemClassName, _gunClass] Call fnc_purequip_attachmentFits} else {false};
			};
			
			//Has a weapon for the attachment type
			if (_gunClass != "" && _attachmentSlot == "" && _attachmentFits) then
			{
				_innerPreSaveArray = _preSaveArray select (_itemSlotArray select 1);
				_innerPreSaveArray set [(_itemSlotArray select 2), _itemClassName];
				_preSaveArray set [(_itemSlotArray select 1), _innerPreSaveArray];
				GW_PUREQUIP_CURRENTTEMPLATE set [_preSaveIndex, _preSaveArray];
			}
			else //Current item is already populated, try to put in container
			{
				if (GW_PUREQUIP_CONTAINERSEL != -1) then
				{
					_containerName = "";
					_containerMassCurrent = 0;
					_containerMassMax = 0;
					if (GW_PUREQUIP_CONTAINERSEL == 4) then {_containerName = "Uniform"; _containerMassCurrent = GW_PUREQUIP_UNIFORM_CURR; _containerMassMax = GW_PUREQUIP_UNIFORM_MAX};
					if (GW_PUREQUIP_CONTAINERSEL == 5) then {_containerName = "Vest"; _containerMassCurrent = GW_PUREQUIP_VEST_CURR; _containerMassMax = GW_PUREQUIP_VEST_MAX};
					if (GW_PUREQUIP_CONTAINERSEL == 6) then {_containerName = "Backpack"; _containerMassCurrent = GW_PUREQUIP_BACKPACK_CURR; _containerMassMax = GW_PUREQUIP_BACKPACK_MAX};
					_canFit = [_itemClassName, _containerName] Call fnc_purequip_canFitInContainer;
					if (_canFit) then
					{
						_itemMass = _itemClassName Call fnc_purequip_getItemMass;

						if ((_containerMassCurrent + _itemMass) <= _containerMassMax) then
						{
							_preSaveArray =+ GW_PUREQUIP_CURRENTTEMPLATE;
							_innerPreSaveArray = _preSaveArray select GW_PUREQUIP_CONTAINERSEL;
							_innerSubPreSaveArray = _innerPreSaveArray select 1;
							_innerSubPreSaveArray pushBack _itemClassName;
							_innerPreSaveArray set [1, _innerSubPreSaveArray];
							_preSaveArray set [GW_PUREQUIP_CONTAINERSEL, _innerPreSaveArray];
							GW_PUREQUIP_CURRENTTEMPLATE = _preSaveArray;
							GW_PUREQUIP_CONTAINERCHANGED = true;
						};
					};
				};
			};
		};
		
		//Request redraw
		GW_PUREQUIP_REDRAWINV = true;
		GW_PUREQUIP_RECALC_TOTAL = true;
		GW_PUREQUIP_RECALC_MASS = true;
	};
};

//Purchase current template of gear
fnc_purequip_purchaseGear =
{
	GW_PUREQUIP_BUYNETCALLRETURN = ["GW_NETCALL_WAITING"];
	_buyNetCall = ["equipment","buy",[(getPlayerUID player), GW_PUREQUIP_CURRENTTEMPLATE, false, true], "GW_PUREQUIP_BUYNETCALLRETURN"] Spawn fnc_clt_requestServerExec;
	waitUntil {scriptDone _buyNetCall};
	
	if (!(GW_PUREQUIP_BUYNETCALLRETURN select 0)) then
	{
		playSound "UIFail";
		systemChat format ["Unable to purchase gear - %1",(GW_PUREQUIP_BUYNETCALLRETURN select 1)];
	}
	else
	{
		playSound "UISuccess";
		
		//Update last purchased template
		GW_CVAR_TEMPLATES set [0, ["Last Purchased", false, GW_PUREQUIP_CURRENTTEMPLATE, true, (GW_PUREQUIP_BUYNETCALLRETURN select 1)]];

		//Equip the player
		_unitEquipScript = [player, GW_PUREQUIP_CURRENTTEMPLATE] spawn fnc_shr_equipUnit;
		waitUntil{scriptDone _unitEquipScript};
		GW_PUREQUIP_RECALC_TOTAL = true;
	};
};

//Populate Templates List (Don't get array from server)
fnc_purequip_populateTemplates =
{
	private["_parentDisp"];
	disableSerialization;
	_parentDisp = _this select 0;
	
	//Populate the list
	lbClear 1502;
	{
		lbAdd [1502, format["%1",(_x select 0)]];
		if (_x select 1) then {lbSetColor [1502, _forEachIndex, [0,0.7490,1,1]]};
	} forEach GW_CVAR_TEMPLATES;
};

//Load template
fnc_purequip_loadTemplate =
{
	private["_index","_templateSelected"];
	_index = lbCurSel 1502;
	if (_index != -1) then
	{
		_templateSelected = GW_CVAR_TEMPLATES select _index;
		GW_PUREQUIP_CURRENTTEMPLATE =+ _templateSelected select 2;
		GW_PUREQUIP_REDRAWINV = true;
		GW_PUREQUIP_RECALC_TOTAL = true;
		GW_PUREQUIP_RECALC_MASS = true;
		GW_PUREQUIP_CONTAINERCHANGED = true;
	};
};

//Save new template
fnc_purequip_saveNewTemplate =
{
	private["_parentDisp"];
	disableSerialization;
	_parentDisp = _this select 0;
	
	//Get name of template
	_templateNameCTRL = _parentDisp displayCtrl 1400;
	_templateName = ctrlText _templateNameCTRL;
	if (_templateName != "") then
	{
		GW_PUREQUIP_TEMPLATE_ADD = ["GW_NETCALL_WAITING"];
		_templateNetCall = ["equipment","templatenew",[(getPlayerUID player), _templateName, GW_PUREQUIP_CURRENTTEMPLATE],"GW_PUREQUIP_TEMPLATE_ADD"] Spawn fnc_clt_requestServerExec;
		waitUntil {scriptDone _templateNetCall};
		
		if (!(GW_PUREQUIP_TEMPLATE_ADD select 0)) then
		{
			playSound "UIFail";
			systemChat format ["Unable to save new template - %1",(GW_PUREQUIP_TEMPLATE_ADD select 1)];
		}
		else
		{
			playSound "UISuccess";
			lbAdd [1502, format["%1",_templateName]];
			lbSetColor [1502, ((lbSize 1500) - 1), [0,0.7490,1,1]];
			GW_CVAR_TEMPLATES pushBack [_templateName, true, GW_PUREQUIP_CURRENTTEMPLATE, true, (GW_PUREQUIP_TEMPLATE_ADD select 1)];
			_templateNameCTRL ctrlSetText "";
		};
	}
	else
	{
		systemChat "Templates must have a unique name";
		playSound "UIFail";
	};
};

//Update template
fnc_purequip_updateTemplate =
{
	private["_parentDisp"];
	disableSerialization;
	_parentDisp = _this select 0;
	
	//Get name of template
	_templateName = if ((lbCurSel 1502) != -1) then {(GW_CVAR_TEMPLATES select (lbCurSel 1502)) select 0} else {""};
	_canModify = if ((lbCurSel 1502) != -1) then {(GW_CVAR_TEMPLATES select (lbCurSel 1502)) select 1} else {false};
	if (_templateName != "" && _canModify) then
	{
		GW_PUREQUIP_TEMPLATE_UPDATE = ["GW_NETCALL_WAITING"];
		_templateNetCall = ["equipment","templateupdate",[(getPlayerUID player), _templateName, GW_PUREQUIP_CURRENTTEMPLATE],"GW_PUREQUIP_TEMPLATE_UPDATE"] Spawn fnc_clt_requestServerExec;
		waitUntil {scriptDone _templateNetCall};
		
		if (!(GW_PUREQUIP_TEMPLATE_UPDATE select 0)) then
		{
			playSound "UIFail";
			systemChat format ["Unable to update template - %1",(GW_PUREQUIP_TEMPLATE_UPDATE select 1)];
		}
		else
		{
			playSound "UISuccess";
			GW_CVAR_TEMPLATES set[(lbCurSel 1502), [_templateName, true, GW_PUREQUIP_CURRENTTEMPLATE, true, (GW_PUREQUIP_TEMPLATE_UPDATE select 1)]];
		};
	}
	else
	{
		if (_templateName == "") then {systemChat "No template selected to delete"};
		if (!_canModify) then {systemChat "You can only modify templates you made"};
		playSound "UIFail";
	};
};

//Delete template
fnc_purequip_deleteTemplate =
{
	private["_parentDisp"];
	disableSerialization;
	_parentDisp = _this select 0;
	
	//Get name of template
	_templateName = if ((lbCurSel 1502) != -1) then {(GW_CVAR_TEMPLATES select (lbCurSel 1502)) select 0} else {""};
	_canModify = if ((lbCurSel 1502) != -1) then {(GW_CVAR_TEMPLATES select (lbCurSel 1502)) select 1} else {false};
	if (_templateName != "" && _canModify) then
	{
		GW_PUREQUIP_TEMPLATE_DELETE = ["GW_NETCALL_WAITING"];
		_templateNetCall = ["equipment","templatedelete",[(getPlayerUID player), _templateName],"GW_PUREQUIP_TEMPLATE_DELETE"] Spawn fnc_clt_requestServerExec;
		waitUntil {scriptDone _templateNetCall};
		
		if (!(GW_PUREQUIP_TEMPLATE_DELETE select 0)) then
		{
			playSound "UIFail";
			systemChat format ["Unable to delete template - %1",(GW_PUREQUIP_TEMPLATE_DELETE select 1)];
		}
		else
		{
			playSound "UISuccess";
			lbDelete [1502, (lbCurSel 1502)];
			GW_CVAR_TEMPLATES deleteAt ((lbCurSel 1502) + 1);
		};
	}
	else
	{
		if (_templateName == "") then {systemChat "No template selected to delete"};
		if (!_canModify) then {systemChat "You can only modify templates you made"};
		playSound "UIFail";
	};
};

//Button should be hidden by default
_emptyContainerCTRL = _display displayCtrl 1609;
_emptyContainerCTRL ctrlShow false;

//Fill the purchase categories combobox with all the categories
lbClear 2100;
lbAdd [2100, "Primary Weapons"];
lbSetData [2100, 0, "WEAP_PRIMARY"];
lbAdd [2100, "Secondary Weapons"];
lbSetData [2100, 1, "WEAP_SECONDARY"];
lbAdd [2100, "Sidearms"];
lbSetData [2100, 2, "WEAP_SIDEARM"];
lbAdd [2100, "Ammo & Ordnance"];
lbSetData [2100, 3, "MAGAZINES"];
lbAdd [2100, "Attachments"];
lbSetData [2100, 4, "ATTACHMENTS"];
lbAdd [2100, "Headgear"];
lbSetData [2100, 5, "HEADGEAR"];
lbAdd [2100, "Vests"];
lbSetData [2100, 6, "VESTS"];
lbAdd [2100, "Uniforms"];
lbSetData [2100, 7, "UNIFORMS"];
lbAdd [2100, "Backpacks"];
lbSetData [2100, 8, "BACKPACKS"];
lbAdd [2100, "Facewear"];
lbSetData [2100, 9, "FACEWEAR"];
lbAdd [2100, "Other Items"];
lbSetData [2100, 10, "OTHERS"];

//First template shown should be what the player currently has equipped
GW_PUREQUIP_CURRENTTEMPLATE = [player, true] Call fnc_shr_getEquipArray;
	
//Select primary weapons by default
lbSetCurSel [2100, 0];
GW_PUREQUIP_CHANGEDCATEGORY = true;

//Need to draw the inventory
_redrawUI = [_display] Spawn fnc_purequip_redrawInventory;
_recalcPrice = [_display] Spawn fnc_purequip_updateCost;
_recalcMass = [_display] Spawn fnc_purequip_updateMasses;
_templatePop = [_display] Spawn fnc_purequip_populateTemplates;

//Unblock UI for network call
_netBlockBGCTRL = _display displayCtrl 1110;
_netBlockBGCTRL ctrlShow false;
_netBlockTextCTRL = _display displayCtrl 1111;
_netBlockTextCTRL ctrlShow false;

//Main Updater
while {dialog} do
{
	//If player dies, close dialog
	if (!alive player) exitWith {closeDialog 60003};
	
	//Disable/Enable purchase button depending on if there are enemies near the player
	_hostiles = [GW_CVAR_SIDE, (getPosATL player), 100] Call fnc_shr_getHostilesInArea;
	if (_hostiles == 0) then {(_display displayCtrl 1604) ctrlEnable true} else {(_display displayCtrl 1604) ctrlEnable false};
	
	//User selected to load a template
	if (GW_PUREQUIP_LOADTEMPLATE) then
	{
		GW_PUREQUIP_LOADTEMPLATE = false;
		_templateLoad = [] Spawn fnc_purequip_loadTemplate;
		waitUntil {scriptDone _templateLoad};
	};
	
	//User selected purchase equipment
	if (GW_PUREQUIP_PURCHASEEQUIPMENT) then
	{
		GW_PUREQUIP_PURCHASEEQUIPMENT = false;
		_gearPurchase = [] Spawn fnc_purequip_purchaseGear;
		waitUntil {scriptDone _gearPurchase};
	};
	
	//Changed category (Need to halt execution to make sure it's done populating)
	if (GW_PUREQUIP_CHANGEDCATEGORY) then
	{
		GW_PUREQUIP_CHANGEDCATEGORY = false;
		_gearPopulate = [(lbCurSel 2100), _display] Spawn fnc_purequip_populateGearList;
		waitUntil {scriptDone _gearPopulate};
	};
	
	//Recalc Total of Template
	if (GW_PUREQUIP_RECALC_TOTAL) then
	{
		GW_PUREQUIP_RECALC_TOTAL = false;
		_recalcPrice = [_display] Spawn fnc_purequip_updateCost;
		waitUntil {scriptDone _recalcPrice};
	};
	
	//Figure out mass of containers
	if (GW_PUREQUIP_RECALC_MASS) then
	{
		GW_PUREQUIP_RECALC_MASS = false;
		_recalcMass = [_display] Spawn fnc_purequip_updateMasses;
		waitUntil {scriptDone _recalcMass};
	};
	
	//Changed primary selection (Only need to do this if we're on the weapons categories)
	if (GW_PUREQUIP_PRIMARYLISTCHANGED) then
	{
		GW_PUREQUIP_PRIMARYLISTCHANGED = false;
		_categorySelected = lbCurSel 2100;
		if (_categorySelected == 0 || _categorySelected == 1 || _categorySelected == 2) then
		{
			_currentSelectedPrimary = lbCurSel 1500;
			if (_currentSelectedPrimary != -1) then
			{
				//Make sure our selected index is a valid index within the new category
				if ((lbSize 1500) > _currentSelectedPrimary) then
				{
					_magsPopulate = [_currentSelectedPrimary] Spawn fnc_purequip_populateMagazineList;
					_attachPopulate = [_currentSelectedPrimary] Spawn fnc_purequip_populateAttachmentList;
					waitUntil {scriptDone _magsPopulate && scriptDone _attachPopulate};
				}
				else
				{
					//If there's at least 1 weapon in there, select that one
					if ((lbSize 1500) > 0) then
					{
						lbSetCurSel [1500, 0];
						_magsPopulate = [0] Spawn fnc_purequip_populateMagazineList;
						_attachPopulate = [0] Spawn fnc_purequip_populateAttachmentList;
						waitUntil {scriptDone _magsPopulate && scriptDone _attachPopulate};
					}
				}
			};
		};
	};
	
	//Container Changed
	if (GW_PUREQUIP_CONTAINERCHANGED) then
	{
		GW_PUREQUIP_CONTAINERCHANGED = false;
		if (GW_PUREQUIP_CONTAINERSEL != -1) then
		{
			_containerClass = (GW_PUREQUIP_CURRENTTEMPLATE select GW_PUREQUIP_CONTAINERSEL) select 0;
			if (_containerClass != "") then
			{
				_containerPop = [GW_PUREQUIP_CONTAINERSEL] Spawn fnc_purequip_populateContainerList;
				waitUntil {scriptDone _containerPop};
			}
			else
			{
				GW_PUREQUIP_CONTAINERSEL = -1;
			};
		};
		
		//Update container text
		if (GW_PUREQUIP_CONTAINERSEL == -1) then
		{
			lbClear 1504;
			_containerTextCTRL = _display displayCtrl 1108;
			_containerTextCTRL ctrlSetStructuredText (parseText format ["No Container Selected"]);
			_emptyContainerCTRL = _display displayCtrl 1609;
			_emptyContainerCTRL ctrlShow false;
		}
		else
		{
			_containerText = "";
			if (GW_PUREQUIP_CONTAINERSEL == 4) then {_containerText = "Uniform"};
			if (GW_PUREQUIP_CONTAINERSEL == 5) then {_containerText = "Vest"};
			if (GW_PUREQUIP_CONTAINERSEL == 6) then {_containerText = "Backpack"};
			_containerTextCTRL = _display displayCtrl 1108;
			_containerTextCTRL ctrlSetStructuredText (parseText format ["Contents of %1",_containerText]);
			_emptyContainerCTRL = _display displayCtrl 1609;
			_emptyContainerCTRL ctrlShow true;
		};
	};
	
	//Redraw requested
	if (GW_PUREQUIP_REDRAWINV) then
	{
		GW_PUREQUIP_REDRAWINV = false;
		_redrawUI = [_display] Spawn fnc_purequip_redrawInventory;
		waitUntil {scriptDone _redrawUI};
	};
	
	//Update selected template
	if (GW_PUREQUIP_UPDATETEMPLATE) then
	{
		GW_PUREQUIP_UPDATETEMPLATE = false;
		_templateUpdate = [_display] Spawn fnc_purequip_updateTemplate;
		waitUntil {scriptDone _templateUpdate};
	};
	
	//Delete selected template
	if (GW_PUREQUIP_DELETETEMPLATE) then
	{
		GW_PUREQUIP_DELETETEMPLATE = false;
		_templateDelete = [_display] Spawn fnc_purequip_deleteTemplate;
		waitUntil {scriptDone _templateDelete};
	};
	
	//Save new template
	if (GW_PUREQUIP_SAVENEWTEMPLATE) then
	{
		GW_PUREQUIP_SAVENEWTEMPLATE = false;
		_templateSaveNew = [_display] Spawn fnc_purequip_saveNewTemplate;
		waitUntil {scriptDone _templateSaveNew};
	};
	
	uiSleep 0.1;
};