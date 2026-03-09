scr_music_room();
if (global.hitstop > 0) {
	global.hitstop--;
	with(all){
		for (var i = 0; i < 12; i++) {
	        if (alarm[i] > 0) alarm[i]++;
	    }
	}
}
	



if (audio_target != audio_current) {

    if (audio_current != noone) {
        audio_stop_sound(audio_current);
    }

    if (audio_target != noone) {
        audio_play_sound(audio_target, 1, true);
    }

    audio_current = audio_target;
}
