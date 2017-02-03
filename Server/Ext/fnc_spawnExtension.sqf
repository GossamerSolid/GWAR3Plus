//fnc_spawnExtension.sqf
//Written By: GossamerSolid
//This is the main entry point into GWAR3.dll
//Example call 
//GW_EXT_GENERATEUID = [];
//_extCall = ["GW_EXT_GENERATEUID",["uniqueid"],[]] Spawn fnc_srv_spawnExtension;
//waitUntil {!scriptDone _extCall};

if (!isServer) exitWith {diag_log text "###[GW ERROR] - Server\Ext\fnc_spawnExtension.sqf must only be called server-side."};

private["_callbackVar","_procedure","_arguments","_oldArguments","_return","_extString"];

_callbackVar = _this select 0;
_procedure = _this select 1;
_arguments = _this select 2;

//Build extension string
_fullArguments = [_procedure, _arguments] Call fnc_shr_mergeArrays;
_extString = "";
{
	if (_extString == "") then
	{
		_extString = format["%1",_x];
	}
	else
	{
		_extString = _extString + format["|$|%1",_x];
	};
} forEach _fullArguments;

//Run the extension
_extCall = (format["GWAR3Ext %1",_extString]);
_resultArray = call compile ("Arma2Net.Unmanaged" callExtension _extCall);

//Check the return of the extension call
switch (_resultArray select 0) do 
{
	//Error
    case -1: 
	{
		diag_log text format["###[GW ERROR] - spawnExtension returned an error - %1",_resultArray select 1];
		_return = "";
	};
	//Regular Return
    case 0: 
	{
		_return = _resultArray select 1;
	};
	//Return was too large - pull from file (TO-DO - FIX)
	case 1:
	{
		_return = loadFile (format["@GWAR3Server\buffer\%1",_resultArray select 1]);
		
		//Clean buffer file (Don't wait on this, we don't care of the return - errors are logged)
		["", ["bufferclean"], [_resultArray select 1]] Spawn fnc_srv_spawnExtension;
	};
    default 
	{ 
		diag_log text format["###[GW ERROR] - spawnExtension had an unexpected return - this should be reported to a developer - Arguments: %1",_this];
		_return = "";
	};
};

//Set the return to the callbackVar
if (_callBackVar != "") then
{
	Call Compile Format["%1 = Call Compile _return",_callBackVar];
};