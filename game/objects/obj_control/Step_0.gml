scr_music_room();


if (audio_target != audio_current) {

    if (audio_current != noone) {
        audio_stop_sound(audio_current);
    }

    if (audio_target != noone) {
        audio_play_sound(audio_target, 1, true);
    }

    audio_current = audio_target;
}
