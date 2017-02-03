_playerArg = _this select 0;
_function = _this select 1;
_subFunction = _this select 2;
_arguments = _this select 3;

if ((typeName _playerArg) == "OBJECT") then
{
	_attempts = 5;
	_sent = false;
	while {_attempts > 0 || _sent} do
	{
		if (alive _playerArg) then
		{
			GW_SERVER_FNC_EXEC = [_function, _subFunction, _arguments];
			(owner _playerArg) publicVariableClient "GW_SERVER_FNC_EXEC";
		}
		else
		{
			_attempts = _attempts - 1;
			sleep 1;
		};
	};
}
else
{
	GW_SERVER_FNC_EXEC = [_function, _subFunction, _arguments];
	_playerArg publicVariableClient "GW_SERVER_FNC_EXEC";
};