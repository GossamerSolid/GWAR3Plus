sounds[] = {enemyCapture, friendlyCapture, message, teamPing, researchDone, UISuccess, UIFail, underAttack, SuddenDeath};

//Enemy captured a camp or depot
class enemyCapture
{
	name = "enemyCapture";
	sound[] = {"resources\sounds\enemyCapture.ogg", db0, 1.0};
	titles[] = {};
};
//Friendly captured a camp or depot
class friendlyCapture
{
	name = "friendlyCapture";
	sound[] = {"resources\sounds\friendlyCapture.ogg", db0, 1.0};
	titles[] = {};
};
//Structure or Zone under attack
class underAttack
{
	name = "underAttack";
	sound[] = {"resources\sounds\underattack.ogg", db0, 1.0};
	titles[] = {};
};
//A message sent
class message
{
	name = "message";
	sound[] = {"resources\sounds\message.ogg", db0, 1.0};
	titles[] = {};
};
//A teammate pinged a spot on the map
class teamPing
{
	name = "teamPing";
	sound[] = {"resources\sounds\teamPing.ogg", db0, 1.0};
	titles[] = {};
};
class researchDone
{
	name = "researchDone";
	sound[] = {"resources\sounds\research.ogg", db0, 1.0};
	titles[] = {};
};
//UI ok
class UISuccess
{
	name = "UISuccess"; //
	sound[] = {"resources\sounds\addItemOK.wss", db0, 1.0};
	titles[] = {	};
};
//UI Failed
class UIFail
{
	name = "UIFail";
	sound[] = {"resources\sounds\addItemFailed.wss", db0, 1.0};
	titles[] = {	};
};
class SuddenDeath
{
	name = "SuddenDeath";
	sound[] = {"resources\sounds\suddendeath.ogg", db0, 1.0};
	titles[] = {   };
};