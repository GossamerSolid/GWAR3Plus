diag_log text format ["### Start Dumping Array"];
{
	diag_log format ["%1 - %2", _forEachIndex, _x];
} forEach _this;
diag_log text format ["### Done Dumping Array"];