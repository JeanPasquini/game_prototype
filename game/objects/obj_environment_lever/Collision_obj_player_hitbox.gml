if(!activated){
	activated = true;
	image_speed = 1;
	scr_audio_play([sde_environment_lever], emitterAudio);
	with (obj_environment_gate) {
	    if (id_gate == other.id_lever) {
	        actived = true;
			image_speed = 1;
	    }
	}
	
	switch (function_lever) {
    case 1:
        scr_reset_character();
    break;
	}
}