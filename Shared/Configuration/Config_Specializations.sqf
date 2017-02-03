//0 - Specialization Name (Needs to be unique)
//1 - Description (HTML formatting supported)
//2 - Image
//3 - Maximum per team (-1 means unlimited)

GW_DATA_SPECIALIZATIONS = 
[
	[
		"Officer",
		"<t size='0.9' shadow='1' align='left' font='PuristaMedium' color='#269024'>+ 4 added to maximum squad size<br />+ Ability to recruit squad members from units that spawned in for Zone defense<br />+ Officers are always in communications range, regardless of position<br />+ 100% Money for infantry kills<br />+ 25% XP for unit kills</t>",
		"\a3\ui_f\data\gui\cfg\Ranks\general_gs.paa",
		3
	],
	
	[
		"Special Forces",
		"<t size='0.9' shadow='1' align='left' font='PuristaMedium' color='#269024'>+ No fatigue<br />+ Marked units/structures display for 3 minutes instead of 1 minute<br />+ Ability to call in special forces infantry on player location<br /></t><t size='0.9' shadow='1' align='left' font='PuristaMedium' color='#c75454'>- Max squad size of 8</t>",
		GW_MISSIONROOT + "Resources\images\special_forces.paa",
		3
	],
	
	[
		"Engineer",
		"<t size='0.9' shadow='1' align='left' font='PuristaMedium' color='#269024'>+ Doesn't require toolkit to repair vehicles<br />+ Ability to salvage destroyed vehicles and receive 25% of their original cost (requires toolkit)<br />+ Ability to build defensive structures when near a support vehicle<br />+ 20% Money for vehicle kills</t>",
		GW_MISSIONROOT + "Resources\images\engineer.paa",
		3
	],
	
	[
		"Medic",
		"<t size='0.9' shadow='1' align='left' font='PuristaMedium' color='#269024'>+ Doesn't require first aid kits or medikits to heal friendlies<br />+ Player acts as a deployment point (Same rules as a zone camp)</t>",
		GW_MISSIONROOT + "Resources\images\medic.paa",
		3
	],
	
	[
		"Pilot",
		"<t size='0.9' shadow='1' align='left' font='PuristaMedium' color='#269024'>+ 20% cost reduction on all aircraft<br /></t><t size='0.9' shadow='1' align='left' font='PuristaMedium' color='#c75454'>- Max squad size of 3</t>",
		GW_MISSIONROOT + "Resources\images\pilot.paa",
		3
	]
];
GW_SPECIALIZATIONS = GW_DATA_SPECIALIZATIONS;