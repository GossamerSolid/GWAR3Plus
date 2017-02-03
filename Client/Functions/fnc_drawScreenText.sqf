disableSerialization;
private["_template","_inputText","_cfgTemplate","_cfgDefault","_cfgDescription","_description","_posModifyX","_posModifyY","_posModifyW","_posModifyH","_textSize","_idc","_notification","_timer"];

_template = _this select 0;
_inputText = _this select 1;

_templateIndex = [_template, 0, GW_CVAR_ONSCREENTEXTS] Call fnc_shr_arrayGetIndex;
if (_templateIndex != -1) then
{
	_templateText = (GW_CVAR_ONSCREENTEXTS select _templateIndex) select 1;

	//Try to space them out so they don't collide
	sleep random(0.5);

	_posModifyX = (0.293477 * safezoneW + safezoneX);
	_posModifyY = (0.775 * safezoneH + safezoneY);
	_posModifyW = (0.413045 * safezoneW);
	_posModifyH = (0.033 * safezoneH);
	_textSize = 1.25;
	_idc = round(random(100000));

	_notification = (["gwar3hud"] call fnc_clt_getGUI) ctrlCreate ["RscStructuredText",_idc];
	_notification ctrlSetStructuredText (parseText format["<t size='1.15' align='center' font='PuristaMedium'>%1",format[_templateText,_inputText]]);
	_notification ctrlSetPosition [_posModifyX,
								   _posModifyY,
								   _posModifyW,
								   _posModifyH];
	_notification ctrlCommit 0;

	_timer = 3;
	while {_timer > 0} do
	{
		_posModifyY = _posModifyY - 0.01;
		_textSize = _textSize - 0.05;
		
		_notification ctrlSetPosition [_posModifyX,
									   _posModifyY,
									   _posModifyW,
									   _posModifyH];
	   _notification ctrlSetStructuredText (parseText format["<t size='%1' align='center' font='PuristaMedium'>%2",_textSize,format[_templateText,_inputText]]); 
	   _notification ctrlCommit 0;

		_timer = _timer - 0.012;
		sleep 0.01;
	};

	ctrlDelete ((["gwar3hud"] call fnc_clt_getGUI) displayCtrl _idc);
};