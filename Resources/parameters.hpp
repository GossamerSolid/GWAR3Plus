class Params
{
	/**************************/
	/****VICTORY CONDITIONS****/
	/**************************/
	class VC_Seperator
	{
		title = "************VICTORY CONDITIONS************";
		values[] = {""};
		texts[] = {""};
		default = 0;
	};
	
	class VC_CaptureAllZones
	{
		title = "Capture All Zones";
		values[] = {true, false};
		texts[] = {"Yes", "No"};
		default = true;
	};
	
	class VC_DestroyBases
	{
		title = "Destroy Bases";
		values[] = {true, false};
		texts[] = {"Yes", "No"};
		default = true;
	};
	
	class VC_DestroyBases_Setting
	{
		title = "    What needs to be destroyed?";
		values[] = {0, 1}; //values[] = {0, 1, 2};
		texts[] = {"MHQ", "Light, Heavy, Air, MHQ"}; //texts[] = {"Light, Heavy, Air, MHQ", "All", "MHQ"};
		default = 0;
	};
	
	class VC_Tickets
	{
		title = "Tickets";
		values[] = {true};//values[] = {true, false};
		texts[] = {"Yes"};//texts[] = {"Yes", "No"};
		default = true;
	};
	
	class VC_Tickets_TicketBleed_Calculation
	{
		title = "    Ticket Bleed Calculation Method";
		values[] = {0, 1, 2};
		texts[] = {"Classic", "Difference", "New"};
		default = 0;
	};
	
	class VC_Tickets_TicketBleed_Frequency
	{
		title = "    Ticket Bleed Frequency";
		values[] = {60, 120, 180};
		texts[] = {"1 Minute", "2 Minutes", "3 Minutes"};
		default = 60;
	};
	
	class VC_Tickets_MinTimeBeforeBleed
	{
		title = "    Minimum Elapsed Time before Bleed Occurs";
		values[] = {0, 900, 1800, 2700, 3600};
		texts[] = {"No Minimum Time", "15 Minutes", "30 Minutes", "45 Minutes", "1 Hour"};
		default = 0;
	};
	
	class VC_Tickets_NumberTickets_Bluefor
	{
		title = "    Bluefor Starting Tickets";
		values[] = {200, 500, 750, 1000, 1250, 1500};
		texts[] = {"250", "500", "750", "1000", "1250", "1500"};
		default = 1000;
	};
	
	class VC_Tickets_NumberTickets_Redfor
	{
		title = "    Redfor Starting Tickets";
		values[] = {200, 500, 750, 1000, 1250, 1500};
		texts[] = {"250", "500", "750", "1000", "1250", "1500"};
		default = 1000;
	};
	
	class VC_SuddenDeath
	{
		title = "Sudden Death";
		values[] = {true, false};
		texts[] = {"Yes", "No"};
		default = false;
	};
	
	class VC_SuddenDeath_Time
	{
		title = "    Time Elapsed before Sudden Death";
		values[] = {7200, 9000, 10800, 14400, 18000};
		texts[] = {"2 Hours", "2 1/2 Hours", "3 Hours", "4 Hours", "5 Hours"};
		default = 10800;
	};

	class VC_Timelimit
	{
		title = "Time Limit";
		values[] = {false};//values[] = {true, false};
		texts[] = {"No"};//texts[] = {"Yes", "No"};
		default = false;
	};
	
	class VC_Timelimit_Time
	{
		title = "    Time";
		values[] = {10800, 14400, 18000, 21600, 25200, 28800};
		texts[] = {"3 Hours", "4 Hours", "5 Hours", "6 Hours", "7 Hours", "8 Hours"};
		default = 14400;
	};
	
	class VC_Timelimit_Decider
	{
		title = "    Victory Decision";
		values[] = {0};
		texts[] = {"Zone Ownership"};
		default = 0;
	};
	
	/************************/
	/****Mission Settings****/
	/************************/
	class MC_Seperator
	{
		title = "************MISSION CONFIGURATION************";
		values[] = {""};
		texts[] = {""};
		default = 0;
	};
	
	class MC_DBSupport
	{
		title = "Database Integration (DISABLED)";
		values[] = {false};
		texts[] = {"No"};
		default = false;
	};
	
	class MC_Starting_Money
	{
		title = "Starting Money";
		values[] = {1000, 3500, 7500, 10000, 20000, 50000, 100000};
		texts[] = {"$1,000", "$3,500", "$7,500", "$10,000", "$20,000", "$50,000", "$100,000"};
		default = 3500;
	};
	
	class MC_Starting_Supplies
	{
		title = "Starting Supplies";
		values[] = {2000, 4000, 7500, 10000};
		texts[] = {"S2,000", "S4,000", "S7,500", "S10,000"};
		default = 4000;
	};
	
	class MC_QuickTime
	{
		title = "Fast time (Every second is 60 seconds ingame)";
		values[] = {true, false};
		texts[] = {"Yes", "No"};
		default = false;
	};
	
	class MC_ZoneVisibility
	{
		title = "Zone Ownership Visibility";
		values[] = {"Classic", "Global"};
		texts[] = {"Classic", "Global"};
		default = "Classic";
	};
	
	/*******************/
	/****Map Layouts****/
	/*******************/
	class MLC_Seperator
	{
		title = "************MAP LAYOUTS************";
		values[] = {""};
		texts[] = {""};
		default = 0;
	};
	
	class ML_Altis
	{
		title = "Altis";
		values[] = {0,1,2};
		texts[] = {"Default","Right Side Only","Classic"};
		default = 0;
	};
	
	class ML_Stratis
	{
		title = "Stratis";
		values[] = {0};
		texts[] = {"Default"};
		default = 0;
	};
	
	class ML_Chernarus
	{
		title = "Chernarus";
		values[] = {0};
		texts[] = {"Default"};
		default = 0;
	};
	
	class ML_Sahrani
	{
		title = "Sahrani";
		values[] = {0};
		texts[] = {"Default"};
		default = 0;
	};
};