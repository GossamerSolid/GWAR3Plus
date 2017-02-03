private["_attacherVehicle", "_attachedObjs"];

_attacherVehicle = _this;

_attachedObjs = attachedObjects _attacherVehicle;
if ((count _attachedObjs) > 0) then
{
	//Detach object
	detach (_attachedObjs select 0);
	
	//Mimic velocity of attacher vehicle
	(_attachedObjs select 0) setVelocity [0, 0, -1];
	(_attachedObjs select 0) setVelocity (velocity _attacherVehicle);
}
else
{
	systemChat "Unable to detach object as there was nothing attached in the first place!";
	playSound "UIFail";
};