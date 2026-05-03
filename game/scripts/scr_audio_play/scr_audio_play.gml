function scr_audio_play(sfx = [], emitter = noone){
	var _sfx = sfx;
	if(emitter == noone){
		audio_play_sound(_sfx[irandom(array_length(_sfx) - 1)], 1, false);
	}
	else{
		audio_play_sound_on(emitter, _sfx[irandom(array_length(_sfx) - 1)], false, 1);
	}
}

