private["_messageType", "_messageText", "_messageSound", "_cfgDefault", "_cfgTemplate", "_cfgTitle", "_cfgDescription", "_cfgSound", "_title", "_description", "_sound", "_parsedText"];
_messageType = _this select 0;
_messageText = _this select 1;
_messageSound = if ((count _this) > 2) then {_this select 2} else {""};

switch (_messageType) do
{
	case "system":
	{	
		player commandChat _messageText;
	};
	
	case "blueChat":
	{
		_cfgDefault = configFile >> "CfgNotifications" >> "Default";
		_cfgTemplate = [["CfgNotifications", (_messageText select 0)],_cfgDefault] call BIS_fnc_loadClass;
		
		_cfgTitle =	[_cfgDefault, _cfgTemplate] select (isText (_cfgTemplate >> "title"));
		_cfgDescription = [_cfgDefault, _cfgTemplate] select (isText (_cfgTemplate >> "description"));
		_cfgSound =	[_cfgDefault, _cfgTemplate] select (isText (_cfgTemplate >> "sound"));
		_title = getText (_cfgDescription >> "title");
		_description = getText (_cfgDescription >> "description");
		_sound = getText (_cfgSound >> "sound");

		//There's probably a better way to do this
		_parsedText = "format[_description";
		{
			_parsedText = _parsedText + format[",%1",str(_x)];
		} forEach (_messageText select 1);
		_parsedText = _parsedText + format["]"];
		
		[GW_CVAR_SIDE, "HQ"] sideChat (Call Compile _parsedText);
		if (_sound != "") then {playSound _sound};
	};
	
	case "yellowChat":
	{
		[GW_CVAR_SIDE, "HQ"] commandChat _messageText;
	};
	
	case "notification":
	{
		[_messageText select 0,_messageText select 1] Spawn fnc_clt_showNotification;
	};
	
	case "onscreen":
	{
		[_messageText select 0, _messageText select 1] Spawn fnc_clt_drawScreenText;

	};
};

//Play a sound if there's one attached
if (_messageSound != "") then {playSound _messageSound};
