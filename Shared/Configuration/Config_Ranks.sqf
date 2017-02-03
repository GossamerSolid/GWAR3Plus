//0 - Rank Name (Needs to be unique)
//1 - Points to next rank (-1 means no ranking higher)
//2 - Max Squad Size
//3 - Bounty Income Modifier (What percentage of the unit cost are you rewarded when killing them)
//4 - Kill Bonus (Money - Awarded to killer!)
//5 - Kill Bonus (Rank Points - Awarded to killer!)

GW_DATA_RANKS = 
[
	[
		"Private",
		50,
		1,
		0.3,
		250,
		25
	],
	
	[
		"Corporal",
		100,
		2,
		0.35,
		500,
		50
	],
	
	[
		"Sergeant",
		200,
		3,
		0.4,
		750,
		75
	],
	
	[
		"Lieutenant",
		450,
		4,
		0.45,
		1000,
		100
	],
	
	[
		"Captain",
		800,
		6,
		0.5,
		1250,
		125
	],
	
	[
		"Major",
		1200,
		8,
		0.55,
		1500,
		150
	],
	
	[
		"Colonel",
		-1,
		10,
		0.6,
		1750,
		175
	],
	
	//General is special reserved for commanders, can't get it any other way
	[
		"General",
		-1,
		10,
		0.65,
		2000,
		200
	]
];
GW_RANKS = GW_DATA_RANKS;

GW_RANK_CAMP_CAPTURE_RATIO = 0.15; //15% of the zone's radius is awarded in rank points
GW_RANK_ZONE_CAPTURE = 0.3; //30% of the zone's radius is awarded in rank points
GW_RANK_KILL_RATIO = 0.01; //1% of unit's cost given in rank points
GW_RANK_TEAMKILL_RATIO = 0.1; //10% of the unit's cost is subtracted in rank points
GW_RANK_REGULAR_POINTS = 3; //3 points is given to all players every minute