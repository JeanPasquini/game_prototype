	audio_special_attack_flood_tentacle_attack(true);
	audio_special_attack_flood_tentacle_preparing_attack(true);
	audio_special_attack_flood_tentacle_spawning(true);
if(sprite_index == spr_psicotopus_tentacle_spawning && obj_psicotopus.currentAttackState == AttackState.FLOOD){
	image_index = 0;
	sprite_index = spr_psicotopus_tentacle_idle;
}
else if(sprite_index == spr_octopus_octopus_attack_tentacle_spawning && obj_psicotopus.currentAttackState == AttackState.OCTOPUS_ATTACK){
	image_index = 0;
	sprite_index = spr_octopus_octopus_attack_tentacle_idle;
}
else if(sprite_index == spr_psicotopus_tentacle_attacking){
	image_index = 0;
	is_attacking = false;
}

