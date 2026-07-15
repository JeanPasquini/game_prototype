// Inherit the parent event
event_inherited();
obj_effect_unicle.scr_fx_psicotopus_sword(x, y);
if (upward > 0) {
	velocity = 0.5;
}
else{
	velocity = 8;
}

if(!instance_exists(obj_psicotopus))instance_destroy();