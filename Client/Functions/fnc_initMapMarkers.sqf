((findDisplay 12) displayCtrl 51) ctrlRemoveAllEventHandlers "Draw";
_mapIcons = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",{[(_this select 0), true] Call fnc_clt_drawMapMarkers;}];
((["gwar3hud"] Call fnc_clt_getGUI) displayCtrl 1200) ctrlRemoveAllEventHandlers "Draw";
_gpsIcons = ((["gwar3hud"] Call fnc_clt_getGUI) displayCtrl 1200) ctrlAddEventHandler ["Draw",{[(_this select 0), false] Call fnc_clt_drawMapMarkers;}];