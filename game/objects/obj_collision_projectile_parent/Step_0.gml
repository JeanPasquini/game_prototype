// Inherit the parent event
event_inherited();

if (place_meeting(x, y, obj_wall)) {
	instance_destroy();
}
