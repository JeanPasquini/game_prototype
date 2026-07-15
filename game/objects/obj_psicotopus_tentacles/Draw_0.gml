draw_self();
if (alpha > 0) {
    gpu_set_fog(true, color, 0, 0);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, alpha);
    gpu_set_fog(false, color, 0, 0);
}
if(sprite_index == spr_psicotopus_tentacle_spawning){
	if(floor(image_index) == 1){
		audio_special_attack_flood_tentacle_spawning();	
	}
}
if(sprite_index == spr_psicotopus_tentacle_attacking){
	audio_special_attack_flood_tentacle_preparing_attack();
	if(floor(image_index) == 11){
		audio_special_attack_flood_tentacle_attack();
		var _offset_x = (player_angle_dir == -90) ? 100 : -100;
		obj_effect_unicle.scr_fx_water_impact(x + _offset_x, y + 17, 64, 16);
		//_water_fx_triggered = true;
	}
}
if(is_destroyed){
	if(obj_psicotopus.currentAttackState == AttackState.FLOOD){	
		audio_special_attack_flood_tentacle_dying();
		scr_set_sprite_once(spr_psicotopus_tentacle_diying, "flag_spr_psicotopus_tentacle_diying");
	}
	else if (obj_psicotopus.currentAttackState == AttackState.OCTOPUS_ATTACK){	
		scr_set_sprite_once(spr_octopus_octopus_attack_tentacle_diying, "flag_spr_psicotopus_tentacle_diying");
	}
}