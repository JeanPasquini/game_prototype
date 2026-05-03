attack_hit_confirmed = false;
event_inherited();
if (!attack_hit_confirmed) exit;
sprite_index = spr_perk_passive_elemental_ring_fire_hitting;
image_speed = 1;
image_index = 0;
obj_perk_passive_elemental_ring.alarm[0] = 200;
var sfx = [
	sde_perk_elemental_ring_hitting
];					
scr_audio_play(sfx);

