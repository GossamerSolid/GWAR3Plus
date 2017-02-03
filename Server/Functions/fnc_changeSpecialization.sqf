/*
Script: fnc_changeSpecialization.sqf
Written by: GossamerSolid

Change's a player's specialization
*/

_playerUID = _this select 0;
_newSpecialization = _this select 1;
_bypass = if (count _this > 2) then {_this select 2} else {false};
_returnData = [true, ""];

_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
if (!isNil "_sessionContainer") then
{
	//Check rank (must be Sergeant or higher)
	_currentRank = _sessionContainer select 9;
	_rankIndex = [_currentRank, 0, GW_RANKS] Call fnc_shr_arrayGetIndex;
	if (_rankIndex >= 2) then
	{
		//Calculate what the specialization fee isNil
		_specFee = round(GW_GVAR_SPECALIZATION_INITIAL + (GW_GVAR_SPECALIZATION_INITIAL * (_sessionContainer select 15)));
		
		//Check Money
		_currentMoney = _sessionContainer select 0;
		if (_currentMoney >= _specFee || _bypass) then
		{
			//Get the player object
			_playerObj = _playerUID Call fnc_shr_getObjFromUID;
			
			//Take the fee and increment the amount of times the player has specialized
			if (!_bypass) then 
			{
				[_playerUID, "-", _specFee] Call fnc_srv_changeMoney;
				
				_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
				_newAmountOfSpec = (_sessionContainer select 15) + 1;
				_sessionContainer set [15, _newAmountOfSpec];
				missionNamespace setVariable [format["GW_SESSION_%1",_playerUID], _sessionContainer];
				
				GW_CVAR_SPECIALIZE_AMOUNT = _newAmountOfSpec;
				(owner _playerObj) publicVariableClient "GW_CVAR_SPECIALIZE_AMOUNT";
			};
			
			//What was the prev specialization
			_prevSpecialization = _sessionContainer select 13;
			
			//Update Vars
			_playerObj setVariable ["GW_SPECIALIZATION", _newSpecialization, true];
			_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
			_sessionContainer set [13, _newSpecialization];
			missionNamespace setVariable [format["GW_SESSION_%1",_playerUID], _sessionContainer];
			
			//Reset squad size to match rank
			_currentCommander = Call Compile Format["GW_COMMANDER_%1",(side _playerObj)];
			_rankIndex = if (vehicleVarName _playerObj != _currentCommander) then {[(_sessionContainer select 9), 0, GW_RANKS] Call fnc_shr_arrayGetIndex} else {["General", 0, GW_RANKS] Call fnc_shr_arrayGetIndex};
			_sessionContainer = missionNamespace getVariable(format["GW_SESSION_%1",_playerUID]);
			_currSquadSize = (GW_RANKS select _rankIndex) select 2;
			
			//Remove old bonuses depending on specialization
			switch (toLower(_prevSpecialization)) do
			{
				case "officer":
				{	
				};
				
				case "special forces":
				{
					[[owner _playerObj], "specialization", "remove", "special forces"] Spawn fnc_srv_requestClientExec;
				};
				
				case "pilot":
				{
				};
			};
			
			//Grant new bonuses depending on specialization
			switch (toLower(_newSpecialization)) do
			{
				case "officer":
				{	
					_currSquadSize = _currSquadSize + 4;
				};
				
				case "special forces":
				{
					[[owner _playerObj], "specialization", "add", "special forces"] Spawn fnc_srv_requestClientExec;
					
					//8 max squad size limitation
					_currSquadSize = _currSquadSize min 8;
				}; 
				
				case "pilot":
				{
					//3 max squad size limitation
					_currSquadSize = _currSquadSize min 3;
				};
			};
			
			//Update the player's max squad size
			_sessionContainer set [10, _currSquadSize];
			missionNamespace setVariable [format["GW_SESSION_%1",_playerUID], _sessionContainer];
			GW_CVAR_MAXSQUADSIZE = (_sessionContainer select 10);
			(owner _playerObj) publicVariableClient "GW_CVAR_MAXSQUADSIZE";
			
			//Tell player about the new specialization
			if (!_bypass) then
			{	
				_specIndex = [_newSpecialization, 0, GW_SPECIALIZATIONS] Call fnc_shr_arrayGetIndex;
				_specName = (GW_SPECIALIZATIONS select _specIndex) select 0;
				_specImage = (GW_SPECIALIZATIONS select _specIndex) select 2;
				[[owner _playerObj], "messages", "", ["blueChat",["GWAR3_SpecializationChosen",[_specImage, _specName]]]] Spawn fnc_srv_requestClientExec;
			};
		}
		else
		{
			_returnData = [false, "You need $10000 to pick a specialization!"];
		};
		
	}
	else
	{
		_returnData = [false, "Your rank must be Sergeant or higher!"];
	};
}
else
{
	_returnData = [false, "Unexpected Error"];	
};

_returnData 