if(sprite_index == spr_psicotopus_apresentation_falling){
	audio_apresentation_impact(true);
	scr_get_last_sprite(id);
	sprite_index = spr_psicotopus_idle;
}
else if (sprite_index == spr_psicotopus_triple_ricochet_start){
	sprite_index = spr_psicotopus_triple_ricochet_mid;	
}
else if (sprite_index == spr_psicotopus_triple_ricochet_end){
	flag_spr_psicotopus_triple_ricochet_start = false;
	flag_spr_psicotopus_triple_ricochet_end = false;
	audio_special_attack_triple_start(true);
	audio_special_attack_triple_mid(true);
	audio_special_attack_triple_end(true);
	_reset_attack();
}
else if (sprite_index == spr_psicotopus_triple_vertical_start){
	sprite_index = spr_psicotopus_triple_vertical_mid;	
}
else if (sprite_index == spr_psicotopus_triple_vertical_end){
	flag_spr_psicotopus_triple_vertical_start = false;
	flag_spr_psicotopus_triple_vertical_end = false;
	audio_special_attack_triple_start(true);
	audio_special_attack_triple_mid(true);
	audio_special_attack_triple_end(true);
	_reset_attack();
}
else if(sprite_index == spr_psicotopus_flood_start){
	sprite_index = spr_psicotopus_flood_mid;	
}
else if(sprite_index == spr_psicotopus_flood_end){
	flag_spr_psicotopus_flood_start = false;
	flag_spr_psicotopus_flood_end = false;
	has_landed = false;
	_reset_attack();
}



