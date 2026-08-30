scr_audio_emitter(x, y, emitterAudio);

if(floor(image_index) == 0 && image_speed > 0){
	state = TrapSpearState.NOT_DAMAGE;
	image_speed = 0;
	alarm[0] = 60;
	scr_audio_play([sde_trap_spear_back],emitterAudio);
}

if(image_index == 8 && image_speed > 0){
	state = TrapSpearState.DAMAGE;
	image_speed = 0;
	alarm[1] = 60;
	scr_audio_play([sde_trap_spear_done],emitterAudio);
}

if(state == TrapSpearState.DAMAGE){
	scr_damage_with_knockback();	
}