if(sprite_index == spr_octopus_octopus_attack_swiming){
	audio_special_attack_octopus_attack_bubble(true);
}
else if(sprite_index == spr_octopus_octopus_attack_preparing){
	image_speed = 0;
    scr_get_last_sprite(id);
	audio_special_attack_octopus_attack_tentacle_spawning();
	audio_special_attack_octopus_attack_bubble(true);
}
//if(sprite_index == spr_octopus_octopus_attack_mid_loop && currentState == OctopusState.ENDING_ATTACK){
//	sprite_index = spr_octopus_octopus_attack_start_loop;
//}
