private["_structure","_attacker","_damage","_damageTimer","_side"];
_structure = _this select 0;
_attacker = _this select 1;
_damage = _this select 2;
_side = _this select 3;

if (_damage < 1) then
{
	_damageTimer = _structure getVariable "GW_DAMAGE_TIMEOUT";
	if (!isNil "_damageTimer") then
	{
		//Warn team that their structure is under attack
		if (_damageTimer == -1 || ((time - _damageTimer) > GW_GVAR_STRUCTURE_DAMAGE_WARN)) then
		{
			_structUID = _structure getVariable "GW_STRUCTUID";
			_structIndex = [_structUID, 17, GW_STRUCTURES] Call fnc_shr_arrayGetIndex;
			if (_structIndex != -1) then
			{
				_structureArray = GW_STRUCTURES select _structIndex;
				
				//Alert owner team that their zone is under attack
				_defenderClientList = [_side, "netid"] Call fnc_shr_getSideMembers;
				[_defenderClientList, "messages", "", ["notification",["GWAR3_StructureAttacked",[(_structureArray select 1),( mapGridPosition _structure), (_structureArray select 10)]]]] Spawn fnc_srv_requestClientExec;
				
				_structure setVariable ["GW_DAMAGE_TIMEOUT", time];
			};
		};
	};
};