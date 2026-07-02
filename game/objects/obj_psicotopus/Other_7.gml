if(sprite_index == spr_psicotopus_flood_start){
	sprite_index = spr_psicotopus_flood_mid;	
}
else if (sprite_index == spr_psicotopus_triple_vertical_start){
	sprite_index = spr_psicotopus_triple_vertical_mid;	
}
else if (sprite_index == spr_psicotopus_triple_vertical_end){
	flag_triple_vertical_start_sprite = false;
	flag_triple_vertical_end_sprite = false;
	_reset_attack();
}



