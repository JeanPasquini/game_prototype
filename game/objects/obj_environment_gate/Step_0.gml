scr_audio_emitter(x, y, emitterAudio);

// define sprite baseado no type


if(actived){
	if (!played_sound) {
	    scr_audio_play([sde_environment_gate], emitterAudio);
	    played_sound = true;
	}


	if (image_index >= image_number - 1) {
	    image_index = image_number - 1;
	    image_speed = 0;

	    if (type == 1) open = true;
	    if (type == 2) open = false;
	}
}