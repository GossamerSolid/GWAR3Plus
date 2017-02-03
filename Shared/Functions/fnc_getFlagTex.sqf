private["_side", "_returnTexture"];

_side = toLower(str(_this select 0));
_returnTexture = "";

switch (_side) do
{
	case "west":
	{
		_returnTexture = "\a3\data_f\Flags\flag_nato_co.paa";
	};
	case "east":
	{
		_returnTexture = "\a3\data_f\Flags\flag_csat_co.paa";
	};
	case "guer":
	{
		_returnTexture = GW_MISSIONROOT + "Resources\images\flag_resistance_co.paa";
	};
	default
	{
		_returnTexture = "\a3\data_f\Flags\flag_white_co.paa";
	};
};

_returnTexture 