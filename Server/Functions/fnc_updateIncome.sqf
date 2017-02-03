private ["_performUpdate"];

_performUpdate = _this;

//For each playable side
{
	private ["_newSupply", "_newCash", "_sideUIDs", "_zoneCurrentStrength", "_zoneOwner", "_currTeam", "_payout", "_teamList", "_zoneMoneyIncome", "_zoneSupplyIncome"];
	_newSupply = 0;
	_newCash = 0;
	_currTeam = _x;
	
	//Figure out income rates
	_zoneMoneyIncome = GW_SERVER_ZONEMONEYINCOME;
	_zoneSupplyIncome = GW_SERVER_ZONESUPPLYINCOME;
	if ([_currTeam, "Efficient Occupation"] Call fnc_shr_isResearched) then
	{
		_zoneMoneyIncome = GW_SERVER_ZONEMONEYINCOME_UPG;
		_zoneSupplyIncome = GW_SERVER_ZONESUPPLYINCOME_UPG;
	};
	
	//Go through every zone (There should be a better way to handle this)
	{
		_zoneOwner = _x select 7;
		if (_zoneOwner == _currTeam) then
		{
			_payout = _x select 6;

			_newCash = _newCash + round(_payout * _zoneMoneyIncome);
			_newSupply = _newSupply + round(_payout * _zoneSupplyIncome);
			
			//Sudden death doubles income rates
			if (GW_SERVER_SUDDENDEATH) then
			{
				_newCash = _newCash * 2;
				_newSupply = _newSupply * 2;
			};
		};
	} forEach GW_ZONES;
	
	//Update Supply for Team
	if (_performUpdate) then
	{
		[_currTeam, "+", _newSupply] Spawn fnc_srv_changeSupply;
	}
	else
	{
		//Send income value to team
		GW_CVAR_TEAMSUPPLY_INCOME = _newSupply;
		_teamList = [_currTeam, "netid"] Call fnc_shr_getSideMembers;
		{
			_x publicVariableClient "GW_CVAR_TEAMSUPPLY_INCOME";
		} forEach _teamList;
	};
	
	//Update Cash for players on team
	if (_performUpdate) then
	{
		_sideUIDs = [_currTeam, "uid"] Call fnc_shr_getSideMembers;
		{
			[_x, "+", _newCash] Spawn fnc_srv_changeMoney;
			
			//Add 3 rank points to each player
			[_x, "+", GW_RANK_REGULAR_POINTS] Spawn fnc_srv_changeRankPoints;
		} forEach _sideUIDs;
	}
	else
	{
		//Send income value to team
		GW_CVAR_MONEY_INCOME = _newCash;
		_teamList = [_currTeam, "netid"] Call fnc_shr_getSideMembers;
		{
			_x publicVariableClient "GW_CVAR_MONEY_INCOME";
		} forEach _teamList;
	};
} forEach GW_TEAMS;