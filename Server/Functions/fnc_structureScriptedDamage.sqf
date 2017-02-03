private["_structureObj", "_selectionName", "_damageAmt", "_attackingObj", "_projectileClass", "_structureSide", "_structureHealth", "_damageTimer", "_structUID", "_structIndex", "_structureArray", "_defenderClientList"];

_structureObj = (_this select 0) select 0;
_selectionName = (_this select 0) select 1;
_attackingObj = (_this select 0) select 3;
_projectileClass = (_this select 0) select 4;
_structureSide = _this select 1;

//If we don't know what caused the damage, we can't figure out how much damage it did
if (_projectileClass != "") then
{
	//If the selection has to do with glass, fuck off because it'll fucking kill the building for no good reason
	if (((_selectionName find "glass") == -1) && ((_selectionName find "Glass") == -1)) then
	{
		//Get structure's current health
		_structureHealth = _structureObj getVariable ["GW_BUILDINGHEALTH", 0];

		//Get how much damage it gave the building using the hit value in the ammo class
		_damageAmt = getNumber (configFile >> "CfgAmmo" >> _projectileClass >> "hit");

		//Ignore small damage amounts as we assume it's a small calibre
		if (_damageAmt > 15) then
		{
			//Get the fuck out of here if it's already dead!
			if (_structureHealth > 0) then
			{
				//Warning about being under attack
				if (_structureHealth > _damageAmt) then
				{
					_damageTimer = _structureObj getVariable "GW_DAMAGE_TIMEOUT";
					if (!isNil "_damageTimer") then
					{
						//Warn team that their structure is under attack
						if (_damageTimer == -1 || ((time - _damageTimer) > GW_GVAR_STRUCTURE_DAMAGE_WARN)) then
						{
							_structUID = _structureObj getVariable "GW_STRUCTUID";
							_structIndex = [_structUID, 17, GW_STRUCTURES] Call fnc_shr_arrayGetIndex;
							if (_structIndex != -1) then
							{
								_structureArray = GW_STRUCTURES select _structIndex;
								
								//Alert owner team that their zone is under attack
								_defenderClientList = [_structureSide, "netid"] Call fnc_shr_getSideMembers;
								[_defenderClientList, "messages", "", ["notification",["GWAR3_StructureAttacked",[(_structureArray select 1),( mapGridPosition _structureObj), (_structureArray select 10)]]]] Spawn fnc_srv_requestClientExec;
								
								_structureObj setVariable ["GW_DAMAGE_TIMEOUT", time];
							};
						};
					};
				};

				//Damage shouldn't be applied to self
				if (_structureObj != _attackingObj) then
				{
					//Apply damage
					_structureHealth = _structureHealth - _damageAmt;
					_structureObj setVariable ["GW_BUILDINGHEALTH", _structureHealth, true];
					
					//If the structure has 0 health, it's dead
					if (_structureHealth <= 0) then
					{
						[_structureObj, _attackingObj, _structureSide] Call fnc_srv_structureKilled;
						deleteVehicle _structureObj;
					};
				};
			};
		};
	};
};

//Return 0 as we don't want to follow through with ArmA Damage System (We handle it in this script)
0 