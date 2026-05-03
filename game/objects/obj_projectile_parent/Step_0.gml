// Destroys if collided
scr_audio_emitter(x, y, emitterAudio);

if (is_outside_room(id)) {
	projectil_hit_effect();
    instance_destroy();
}

