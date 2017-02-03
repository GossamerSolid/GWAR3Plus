private["_sideWinner", "_victoryType", "_sideWinStr"];

//Remove all actions from player
removeAllActions player; 

//Close any gui that's open
[] Call fnc_clt_closeAllDialogs;

//Black out
12452 cutText [format[""],"BLACK OUT",2];
sleep 2;

//Close any gui that's open
[] Call fnc_clt_closeAllDialogs;

//If args are passed, client was already ingame, else new joiner
if ((count _this) > 0) then
{
	_sideWinner = _this select 0;
	_victoryType = _this select 1;
}
else
{
	//TO-DO: Request endgame args from server
};

//Countdown to lobby
_sideWinStr = _sideWinner Call fnc_shr_getSideName;
12452 cutText [format["%1 wins by %2\n\nReturning to Lobby in %3 Seconds",_sideWinStr,_victoryType,GW_ENDGAME_TIMER],"BLACK FADED",999999];
while {GW_ENDGAME_TIMER >= 0} do
{
	sleep 0.1;
	12452 cutText [format["%1 wins by %2\n\nReturning to Lobby in %3 Seconds",_sideWinStr,_victoryType,GW_ENDGAME_TIMER],"BLACK FADED",999999];
};
endMission "END1";

