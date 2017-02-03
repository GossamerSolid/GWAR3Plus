private["_varName","_displayName"];

_varName = _this;
if (_varName == "nil") then
{
	["notification",["GWAR3_CommVoteResultsNil",[]]] Spawn fnc_clt_messages;
}
else
{
	_displayName = name(missionNamespace getVariable _varName);
	["notification",["GWAR3_CommVoteResults",[_displayName]]] Spawn fnc_clt_messages;
};


