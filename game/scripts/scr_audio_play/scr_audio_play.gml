function scr_audio_play(sfx = []){
	var _sfx = sfx;
	audio_play_sound(_sfx[irandom(array_length(_sfx) - 1)], 1, false);
}