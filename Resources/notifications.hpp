class CfgNotifications
{
	class GWAR3_Default
	{
		title = "TEMPLATE";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIcon_ca.paa";
		description = "<t size='0.5' shadow='1' align='left'>TEMPLATE</t>";
		color[] = {1,1,1,1};
		duration = 4;
		priority = 0;
		sound = "message";
	};
	
	class GWAR3_ZoneCaptured : GWAR3_Default
	{
		title = "Zone Captured";
		iconPicture = "\A3\ui_f\data\map\markers\military\flag_CA.paa";
		description = "%1 has been captured by your team";
		sound = "friendlyCapture";
	};
	
	class GWAR3_ZoneLost : GWAR3_ZoneCaptured
	{
		title = "Zone Lost";
		description = "%1 has been lost";
		sound = "enemyCapture";
	};
	
	class GWAR3_ZoneUnderAttack : GWAR3_ZoneCaptured
	{
		title = "Zone Under Attack";
		description = "%1 is under attack!";
		sound = "underAttack";
	};
	
	class GWAR3_CampCaptured : GWAR3_Default
	{
		title = "Camp Captured";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\Bunker_CA.paa";
		description = "A camp has been captured in %1";
		sound = "friendlyCapture";
	};
	
	class GWAR3_CampLost: GWAR3_CampCaptured
	{
		title = "Camp Lost";
		description = "A camp has been lost in %1";
		sound = "enemyCapture";
	};
	
	class GWAR3_UnitKilled : GWAR3_Default
	{
		title = "Unit Killed";
		iconPicture = "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";
		description = "$%1/%2XP killing %3";
		duration = 3;
		sound = "message";
	};
	
	class GWAR3_UnitKilled_Player : GWAR3_UnitKilled
	{
		title = "Player Killed";
		iconPicture = "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";
		description = "$%1 extra for killing %2";
		duration = 3;
		sound = "message";
	};
	
	class GWAR3_UnitTeamkilled : GWAR3_UnitKilled
	{
		title = "Unit Teamkilled";
		description = "-$%1/-%2XP teamkilling %3";
		duration = 3;
		sound = "message";
	};
	
	class GWAR3_UnitTeamkilled_Player : GWAR3_UnitKilled
	{
		title = "Player Teamkilled";
		description = "-$%1 extra for teamkilling %2";
		duration = 3;
		sound = "message";
	};
	
	class GWAR3_StructureCreated : GWAR3_Default
	{
		title = "Structure Created";
		iconPicture = "%2";
		description = "%1 constructed";
		sound = "message";
	};
	
	class GWAR3_StructureDestroyed : GWAR3_StructureCreated
	{
		title = "Structure Destroyed";
		iconPicture = "%4";
		description = "<t size='0.75' align='left'>%1 killed a %2 at %3</t>";
		sound = "message";
	};
	
	class GWAR3_StructureLost : GWAR3_StructureCreated
	{
		title = "Structure Lost";
		iconPicture = "%4";
		description = "<t size='0.75' align='left'>%1 killed our %2 at %3</t>";
		sound = "message";
	};
	
	class GWAR3_StructureTeamkilled : GWAR3_StructureCreated
	{
		title = "Structure Teamkilled";
		iconPicture = "%4";
		description = "<t size='0.75' align='left'>%1 teamkilled a %2 at %3</t>";
		sound = "message";
	};
	
	class GWAR3_StructureAttacked : GWAR3_StructureCreated
	{
		title = "Structure Under Attack";
		iconPicture = "%3";
		description = "Our %1 is under attack near %2";
		sound = "underAttack";
	};
	
	class GWAR3_CommVoteStart : GWAR3_Default
	{
		title = "Commander Voting";
		iconPicture = "a3\ui_f\data\gui\cfg\Ranks\general_gs.paa";
		description = "Our team is voting for a new commander";
		sound = "message";
	};
	
	class GWAR3_CommVoteResults : GWAR3_Default
	{
		title = "New Commander";
		iconPicture = "a3\ui_f\data\gui\cfg\Ranks\general_gs.paa";
		description = "%1 has been chosen as team commander";
		sound = "message";
	};
	
	class GWAR3_CommVoteResultsSame : GWAR3_Default
	{
		title = "Same Commander";
		iconPicture = "a3\ui_f\data\gui\cfg\Ranks\general_gs.paa";
		description = "%1 was voted commander again";
		sound = "message";
	};
	
	class GWAR3_CommVoteResultsNil : GWAR3_CommVoteResults
	{
		title = "No Commander";
		description = "No commander was selected";
		sound = "message";
	};
	
	class GWAR3_CommanderDisconnect : GWAR3_CommVoteResults
	{
		title = "Commander Disconnected";
		description = "Our commander has disconnected from the server";
		sound = "message";
	};
	
	class GWAR_ObjectBlockingConstruction : GWAR3_Default
	{
		title = "Construction Obstruction";
		iconPicture = "Resources\images\exit_button.paa";
		description = "<t size='0.70' align='left'>Production halted at %1(%2). Position not clear.</t>";
		duration = 3;
		sound = "message";
	};
	
	class GWAR_RefundedUnit : GWAR3_Default
	{
		title = "Unit Refunded";
		iconPicture = "Resources\images\money.paa";
		description = "$%1 refunded due to lack of room in squad.";
		duration = 3;
		sound = "message";
	};
	
	class GWAR_RankUp : GWAR3_Default
	{
		title = "Promotion";
		iconPicture = "a3\ui_f\data\gui\cfg\Ranks\%1_gs.paa";
		description = "You have been promoted to %1";
		sound = "message";
	};
	
	class GWAR_VehicleConstructed : GWAR3_Default
	{
		title = "Vehicle Constructed";
		iconPicture = "%2";
		description = "Your %1 has been constructed!";
		sound = "message";
	};
	
	class GWAR_UnitRecruited : GWAR3_Default
	{
		title = "Unit Recruited";
		iconPicture = "Resources\images\squad_size.paa";
		description = "Your %1 has arrived!";
		sound = "message";
	};
	
	class GWAR_MHQRepaired : GWAR3_Default
	{
		title = "MHQ Repaired";
		iconPicture = "Resources\images\struct_hq.paa";
		description = "The MHQ has been repaired!";
		sound = "message";
	};
	
	class GWAR_MHQDestroyed : GWAR3_Default
	{
		title = "MHQ Destroyed";
		iconPicture = "Resources\images\struct_hq.paa";
		description = "%1 killed our MHQ!";
		sound = "message";
	};
	
	class GWAR_MHQKilled : GWAR3_Default
	{
		title = "MHQ Killed";
		iconPicture = "Resources\images\struct_hq.paa";
		description = "%1 killed the enemy MHQ!";
		sound = "message";
	};
	
	class GWAR_MHQTeamkilled : GWAR3_Default
	{
		title = "MHQ Teamkilled";
		iconPicture = "Resources\images\struct_hq.paa";
		description = "%1 teamkilled our MHQ!";
		sound = "message";
	};
	
	class GWAR_ReceivedMoney : GWAR3_Default
	{
		title = "Money Received";
		iconPicture = "Resources\images\money.paa";
		description = "%1 sent you $%2";
		duration = 3;
		sound = "message";
	};
	
	class GWAR3_SuppliesPurchased : GWAR3_Default
	{
		title = "Supplies Purchased";
		iconPicture = "Resources\images\supplies.paa";
		description = "%1 purchased S%2 for the team";
		duration = 3;
		sound = "message";
	};
	
	class GWAR3_SuppliesSold : GWAR3_Default
	{
		title = "Supplies Sold";
		iconPicture = "Resources\images\supplies.paa";
		description = "%1 sold S%2. Each player gets $%3.";
		duration = 3;
		sound = "message";
	};
	
	class GWAR_ZoneDefended : GWAR3_Default
	{
		title = "Zone Defended";
		iconPicture = "\A3\ui_f\data\map\markers\military\flag_CA.paa";
		description = "%1 has been successfully defended!";
		sound = "friendlyCapture";
	};
	
	class GWAR_ZoneAttackFailed : GWAR_ZoneDefended
	{
		title = "Zone Attack Failed";
		description = "We've failed to capture %1!";
		sound = "enemyCapture";
	};
	
	class GWAR3_Money : GWAR3_Default
	{
		title = "Money Awarded";
		iconPicture = "Resources\images\money.paa";
		description = "$%1 awarded for %2";
		duration = 3;
		sound = "message";
	};
	
	class GWAR3_XP : GWAR3_Default
	{
		title = "XP Awarded";
		iconPicture = "Resources\images\xp.paa";
		description = "%1XP awarded for %2";
		duration = 3;
		sound = "message";
	};
	
	class GWAR3_MoneyXP : GWAR3_Default
	{
		title = "Money/XP Awarded";
		iconPicture = "Resources\images\xp.paa";
		description = "$%1/%2XP awarded for %3";
		duration = 3;
		sound = "message";
	};
	
	class GWAR3_TicketBleed : GWAR3_Default
	{
		title = "Ticket Bleed";
		iconPicture = "Resources\images\ticket.paa";
		description = "Our team is suffering from a ticket bleed of %1!";
		duration = 4;
		sound = "message";
	};
	
	class GWAR3_TicketWarning : GWAR3_Default
	{
		title = "Ticket Warning";
		iconPicture = "Resources\images\ticket.paa";
		description = "Our team has %1 tickets left!";
		duration = 4;
		sound = "message";
	};
	
	class GWAR3_StructureDisband : GWAR3_Default
	{
		title = "Structure Disbanded";
		iconPicture = "%1";
		description = "%2 has disbanded at %3";
		duration = 4;
		sound = "message";
	};
	
	class GWAR3_StructureDisband_Refund : GWAR3_Default
	{
		title = "Structure Disbanded";
		iconPicture = "%1";
		description = "%2 has disbanded at %3. %4 supplies refunded.";
		duration = 4;
		sound = "message";
	};
	
	class GWAR3_SpecializationChosen : GWAR3_Default
	{
		title = "Specialization Chosen";
		iconPicture = "%1";
		description = "You have specialized as a %2";
		duration = 4;
		sound = "message";
	};
	
	class GWAR3_ResearchDone : GWAR3_Default
	{
		title = "Tech Researched";
		iconPicture = "Resources\images\struct_research.paa";
		description = "%1 has been researched";
		sound = "researchDone";
	};
	
	class GWAR_TeamSwapAttempt : GWAR3_Default
	{
		title = "Player Team Swap";
		iconPicture = "Resources\images\squad_size.paa";
		description = "%1 has attempted to teamswap from %2 to %3!";
		sound = "message";
	};
	
	class GWAR_TeamStackAttempt : GWAR3_Default
	{
		title = "Player Team Stack";
		iconPicture = "Resources\images\squad_size.paa";
		description = "%1 has attempted to stack %2!";
		sound = "message";
	};
	
	class GWAR_SessionBanConnect : GWAR3_Default
	{
		title = "Player Session Ban";
		iconPicture = "Resources\images\squad_size.paa";
		description = "%1 has a session ban - %2";
		sound = "message";
	};
	
	class GWAR3_SuddenDeath : GWAR3_Default
	{
		title = "Sudden Death!";
		iconPicture = "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";
		description = "Sudden Death!";
		sound = "SuddenDeath";
		duration = 8;
	};
};