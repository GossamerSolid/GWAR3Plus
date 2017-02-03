disableSerialization;
_display = _this select 0;

//Disable action buttons
ctrlEnable [2400, false];

//Setup camera
_startPos = getPosASL GW_ATTACH_ORIGINVEH;
GW_ATTACH_CAMERA = "camera" camCreate [(_startPos select 0) - 10, _startPos select 1, 10];
GW_ATTACH_CAMERA setDir 0; 
GW_ATTACH_CAMERA camSetTarget GW_ATTACH_ORIGINVEH;
GW_ATTACH_CAMERA cameraEffect ["Internal", "Back"];
GW_CVAR_CLIENTCAMERA camSetPos [(_startPos select 0) - 10, _startPos select 1, 10];
showCinemaBorder false;
GW_ATTACH_CAMERA camCommit 0;

//Vars
GW_ATTACH_OBJSELECTED = false;
GW_ATTACH_PERFORMATTACH = false;
GW_ATTACH_ELIGIBLELIST = [];
GW_ATTACH_POSITION = [];
GW_ATTACH_OBJLIST = [];

//Figure out information we need based off of what our towing object is
_vehUID = GW_ATTACH_ORIGINVEH getVariable ["GW_UNIQUEID", ""];
if (_vehUID != "") then
{
	_vehArrayIndex = [_vehUID, 11, GW_VEHICLES] Call fnc_shr_arrayGetIndex;
	if (_vehArrayIndex != -1) then
	{
		_vehArray = GW_VEHICLES select _vehArrayIndex;
		_attachIndex = ["Attaching", 0, (_vehArray select 10)] Call fnc_shr_arrayGetIndex;
		if (_attachIndex != -1) then
		{
			GW_ATTACH_POSITION = ((_vehArray select 10) select _attachIndex) select 1;
			GW_ATTACH_ELIGIBLELIST = ((_vehArray select 10) select _attachIndex) select 2;
		};
	};
};
if (((count GW_ATTACH_POSITION) == 0) || ((count GW_ATTACH_ELIGIBLELIST) == 0)) then
{
	systemChat "This vehicle cannot attach things - how the fuck did you get here?";
	closeDialog 600013;
};

//Get objects eligible for attaching (must be within 10m radius of attacher)
fnc_attach_getObjList =
{
	disableSerialization;
	private["_parentDisplay", "_nearObjects", "_vehicleIndex"];
	_parentDisplay = _this select 0;
	
	_attachBtnCtrl = _parentDisplay displayCtrl 2400;
	
	//Get data
	GW_ATTACH_OBJLIST = [];
	_nearObjects = nearestObjects [GW_ATTACH_ORIGINVEH, GW_ATTACH_ELIGIBLELIST, 20];
	_nearObjects = _nearObjects - [GW_ATTACH_ORIGINVEH]; //Can't have self in list
	{
		if (alive _x) then
		{
			_vehicleIndex = [(_x getVariable ["GW_UNIQUEID", ""]), 11, GW_VEHICLES] Call fnc_shr_arrayGetIndex;
			if (_vehicleIndex != -1) then
			{
				GW_ATTACH_OBJLIST pushBack _x;
			};
		};
	} forEach _nearObjects;
	
	//Populate list
	lbClear 1500;
	{
		_vehicleIndex = [(_x getVariable ["GW_UNIQUEID", ""]), 11, GW_VEHICLES] Call fnc_shr_arrayGetIndex;
		lbAdd [1500, format["%1 - %2 - %3m",((GW_VEHICLES select _vehicleIndex) select 1),(mapGridPosition _x),round(GW_ATTACH_ORIGINVEH distance _x)]];
		lbSetPicture [1500, _forEachIndex, (getText (configFile >> "CfgVehicles" >> typeOf(_x) >> "Picture"))];
	} forEach GW_ATTACH_OBJLIST;
	
	if ((count GW_ATTACH_OBJLIST) == 0) then {_attachBtnCtrl ctrlEnable false};
};

//Select an object
fnc_attach_selectObj =
{
	disableSerialization;
	private["_parentDisplay", "_attachBtnCtrl", "_curSel", "_objectSelected", "_objText", "_vehicleIndex"];
	
	_parentDisplay = _this select 0;
	_attachBtnCtrl = _parentDisplay displayCtrl 2400;
	
	_curSel = lbCurSel 1500;
	if (_curSel != -1) then
	{
		_objectSelected = GW_ATTACH_OBJLIST select _curSel;
		
		//Update camera
		GW_ATTACH_CAMERA camSetTarget _objectSelected;
		GW_ATTACH_CAMERA camCommit 1;
		
		//Update button text
		_objText = "Object";
		_vehicleIndex = [(_objectSelected getVariable "GW_UNIQUEID"), 11, GW_VEHICLES] Call fnc_shr_arrayGetIndex;
		if (_vehicleIndex != -1) then {_objText = (GW_VEHICLES select _vehicleIndex) select 1};
		_attachBtnCtrl ctrlSetText (format["Attach %1",_objText]);
		_attachBtnCtrl ctrlEnable true;
	}
	else
	{
		_attachBtnCtrl ctrlEnable false;
	};
};

fnc_attach_performAttach =
{
	disableSerialization;
	private["_parentDisplay", "_curSel", "_objectSelected", "_boundingBoxReal", "_maxLength", "_attachPos"];
	
	_parentDisplay = _this select 0;
	_curSel = lbCurSel 1500;
	if (_curSel != -1) then
	{
		_objectSelected = GW_ATTACH_OBJLIST select _curSel;
		
		//Set to same direction
		_objectSelected setDir (getDir GW_ATTACH_ORIGINVEH);
		
		//Get max length of vehicle to be attached
		_boundingBoxReal = boundingBoxReal _objectSelected;
		_maxLength = (((_boundingBoxReal select 1) select 1) - ((_boundingBoxReal select 0) select 1)) * -1;
		
		//Attach to required position (Attach pos Y is relative to the vehicle to be attached's max length to begin with)
		_attachPos = [(GW_ATTACH_POSITION select 0), (GW_ATTACH_POSITION select 1) + _maxLength, (GW_ATTACH_POSITION select 2)];
		_objectSelected attachTo [GW_ATTACH_ORIGINVEH, _attachPos]; 
		
		//Close the dialog
		_objText = getText (configFile >> "CfgVehicles" >> (typeOf _objectSelected) >> "displayName");
		_vehicleIndex = [(_objectSelected getVariable "GW_UNIQUEID"), 11, GW_VEHICLES] Call fnc_shr_arrayGetIndex;
		if (_vehicleIndex != -1) then {_objText = (GW_VEHICLES select _vehicleIndex) select 1};
		playSound "UISuccess";
		systemChat format["Attached %1", _objText]; 
		closeDialog 60013;
	}
	else
	{
		playSound "UIFail";
		systemChat format["Unable to attach object - nothing selected"]; 
	};
};

//Main update
while {dialog} do
{
	//If player dies, close dialog
	if (!alive player) exitWith {closeDialog 60013};
	
	//Update eligible list
	_buildList = [_display] Spawn fnc_attach_getObjList;
	waitUntil {scriptDone _buildList};
		
	if (GW_ATTACH_OBJSELECTED) then
	{
		GW_ATTACH_OBJSELECTED = false;
		_performSelect = [_display] Spawn fnc_attach_selectObj;
		waitUntil {scriptDone _performSelect};
	};
	
	if (GW_ATTACH_PERFORMATTACH) then
	{
		GW_ATTACH_PERFORMATTACH = false;
		_performAttach = [_display] Spawn fnc_attach_performAttach;
		waitUntil {scriptDone _performAttach};
	};
	sleep 0.1;
};