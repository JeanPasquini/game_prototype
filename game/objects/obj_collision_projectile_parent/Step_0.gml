// Inherit the parent event
event_inherited();

if (place_meeting(x, y, obj_wall)) {
	projectil_hit_effect();
	instance_destroy();
}
