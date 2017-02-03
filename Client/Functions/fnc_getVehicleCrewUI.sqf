GW_CVAR_VEHICLECREW_TEXT = "";
if (player != (vehicle player)) then
{
	_crewText = "<t align='right' font='PuristaMedium' color='#FFFFFF'>";
	_vehicleCrew = fullCrew (vehicle player);
	{
		if (alive (_x select 0)) then
		{
			_roleImg = "";
			_crewName = "";
			
			if (isPlayer (_x select 0)) then
			{
				_crewName = name (_x select 0);
			}
			else
			{
				if ((group (_x select 0)) == (group player)) then
				{
					_crewName = format["AI - %1",(_x select 0) getVariable ["GW_GROUPNUM", name (_x select 0)]];
				}
				else
				{
					_crewName = "Friendly AI";
				};
			};
			
			switch (toLower(_x select 1)) do
			{
				case "driver":
				{
					_roleImg = "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa"
				};
				case "gunner":
				{
					_roleImg = "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa"
				};
				case "commander":
				{
					_roleImg = "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa"
				};
				case "turret":
				{
					_roleImg = "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa"
				};
				default
				{
					_roleImg = "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa"
				};
			};
			
			_crewText = _crewText + format["%2  <img image='%1'/><br />",_roleImg, _crewName];
		};
	} forEach _vehicleCrew;
	_crewText = _crewText + format["</t>"];
	
	GW_CVAR_VEHICLECREW_TEXT = _crewText;
};