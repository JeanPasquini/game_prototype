if(sprite_index != spr_perk_passive_elemental_ring_ice_hitting){
	if(other.is_invencible == true) return;

	sprite_index = spr_perk_passive_elemental_ring_ice_hitting;
	image_speed = 1;
	image_index = 0;

	other.alarm[1] = 500;
	other.movementSpeed = 0.5;
	other.freeze_alpha = 0.8;
	other.freeze = true;

	obj_perk_passive_elemental_ring.alarm[1] = 200;
	var sfx = [
		sde_perk_elemental_ring_hitting
	];					
	scr_audio_play(sfx);

}

