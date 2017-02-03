private["_display","_sliderTerrainVD","_sliderObjVD","_editTerrainVD","_editObjVD","_btnMiniMapToggle","_sliderMMZoom","_editMMZoom","_btn3dMarkerToggle","_editShadowVD","_sliderShadowVD","_editMarkerUpdate","_slider3DMarkerAlpha","_edit3dMarkerAlpha"];
disableSerialization;
_display = _this select 0;

GW_CLIENTSETTINGS_TOGGLEMM = false;
GW_CLIENTSETTINGS_TOGGLEONSCREEN = false;

//Set up the view distance sliders
_sliderTerrainVD = _display displayCtrl 1900;
_sliderTerrainVD sliderSetRange [500, GW_GVAR_VIEWDISTANCE];
_sliderTerrainVD sliderSetPosition GW_CVAR_TERRAIN_VD;
_sliderTerrainVD sliderSetSpeed [100, 0.5];
_sliderObjVD = _display displayCtrl 1901;
_sliderObjVD sliderSetRange [500, GW_GVAR_OBJVIEWDISTANCE];
_sliderObjVD sliderSetPosition GW_CVAR_OBJECT_VD;
_sliderObjVD sliderSetSpeed [100, 0.5];
_sliderShadowVD = _display displayCtrl 1903;
_sliderShadowVD sliderSetRange [0, GW_GVAR_SHADOWDISTANCE];
_sliderShadowVD sliderSetPosition GW_CVAR_SHADOW_VD;
_sliderShadowVD sliderSetSpeed [10, 0.5];
_sliderMarkerUpdate = _display displayCtrl 1904;
_sliderMarkerUpdate sliderSetRange [0.1, 1];
_sliderMarkerUpdate sliderSetPosition GW_CVAR_MARKERUPDATE_RATE;
_sliderMarkerUpdate sliderSetSpeed [0.001, 0.5];

//Edit boxes
_editTerrainVD = _display displayCtrl 1400;
_editObjVD = _display displayCtrl 1401;
_editShadowVD = _display displayCtrl 1403;
_editMarkerUpdate = _display displayCtrl 1404;

//Minimap toggle
_btnMiniMapToggle = _display displayCtrl 2400;
_editMMZoom = _display displayCtrl 1402;

//Minimap zoom
_sliderMMZoom = _display displayCtrl 1902;
_sliderMMZoom sliderSetRange [0, 0.3];
_sliderMMZoom sliderSetPosition GW_CVAR_MINIMAP_ZOOM;

//3d Marker Toggle
_btn3dMarkerToggle = _display displayCtrl 2401;

_slider3DMarkerAlpha = _display displayCtrl 1905;
_slider3DMarkerAlpha sliderSetRange [0.1, 1];
_slider3DMarkerAlpha sliderSetPosition GW_CVAR_3DMARKER_ALPHA;
_slider3DMarkerAlpha sliderSetSpeed [0.1, 0.5];

_edit3dMarkerAlpha = _display displayCtrl 1405;


//Main Updater
while {dialog} do
{
	//If player dies, close dialog
	if (!alive player || isNull (findDisplay 60014)) exitWith {closeDialog 60014};
	
	//Update cvars based off of sliders
	GW_CVAR_TERRAIN_VD = ceil(sliderPosition _sliderTerrainVD);
	GW_CVAR_OBJECT_VD = ceil(sliderPosition _sliderObjVD);
	GW_CVAR_SHADOW_VD = ceil(sliderPosition _sliderShadowVD);
	GW_CVAR_MINIMAP_ZOOM = sliderPosition _sliderMMZoom;
	GW_CVAR_MARKERUPDATE_RATE = sliderPosition _sliderMarkerUpdate;
	GW_CVAR_3DMARKER_ALPHA = sliderPosition _slider3DMarkerAlpha;
	
	//Update edit boxes
	_editTerrainVD ctrlSetText format["%1",GW_CVAR_TERRAIN_VD];
	_editObjVD ctrlSetText format["%1",GW_CVAR_OBJECT_VD];
	_editShadowVD ctrlSetText format["%1",GW_CVAR_SHADOW_VD];
	_editMMZoom ctrlSetText format["%1",GW_CVAR_MINIMAP_ZOOM];
	_editMarkerUpdate ctrlSetText format["%1",GW_CVAR_MARKERUPDATE_RATE];
	_edit3dMarkerAlpha ctrlSetText format["%1",GW_CVAR_3DMARKER_ALPHA];
	
	//Toggle MiniMap
	if (GW_CVAR_MINIMAP_SHOW) then {_btnMiniMapToggle ctrlSetText "Turn Off Mini Map"} else {_btnMiniMapToggle ctrlSetText "Turn On Mini Map"};
	if (GW_CLIENTSETTINGS_TOGGLEMM) then 
	{
		GW_CLIENTSETTINGS_TOGGLEMM = false;
		GW_CVAR_MINIMAP_SHOW = if (GW_CVAR_MINIMAP_SHOW) then {false} else {true};
	};
	
	//Toggle On Screen Markers
	if (GW_CVAR_3DMARKERS) then {_btn3dMarkerToggle ctrlSetText "Turn Off OnScreen Markers"} else {_btn3dMarkerToggle ctrlSetText "Turn On OnScreen Markers"};
	if (GW_CLIENTSETTINGS_TOGGLEONSCREEN) then
	{
		GW_CLIENTSETTINGS_TOGGLEONSCREEN = false;
		GW_CVAR_3DMARKERS = if (GW_CVAR_3DMARKERS) then {false} else {true};
	};
	
	sleep 0.1;
};