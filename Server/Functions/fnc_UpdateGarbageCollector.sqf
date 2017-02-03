//fnc_UpdateGarbageCollector.sqf
//Written by - GossamerSolid
//Handles garbage collection update for GWAR3

private["_garbageIndexes", "_object", "_timer"];

while {GW_GAMERUNNING} do
{
	//Update garbage queue contents
	{
		//Only update if array - otherwise it's an item that should be removed from the queue
		if (typeName _x == "ARRAY") then
		{
			_object = _x select 0;
			_timer = _x select 1;
			
			//Delete object and mark index for removal if time is lower than 1, otherwise decrement time
			if (_timer < 1) then
			{
				deleteVehicle _object;
				GW_GARBAGE set [_forEachIndex, -1];
			}
			else
			{
				GW_GARBAGE set [_forEachIndex, [_object, (_timer - GW_SERVER_UPDATE_GARBAGE)]];
			};
		};
	} forEach GW_GARBAGE;
	
	//Run through and remove deleted indexes
	{
		GW_GARBAGE = GW_GARBAGE - [-1];
	} forEach GW_GARBAGE;
	
	sleep GW_SERVER_UPDATE_GARBAGE;
};