// Inherit the parent event
event_inherited();

if (upward > 0) {
	sprite_index = spr_psicotopus_projectile_preparing;
}
else{
	sprite_index = spr_psicotopus_projectile;
	image_angle = direction - 180;
}