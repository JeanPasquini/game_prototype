enum TrapSpearState {
    NOT_DAMAGE,
	DAMAGE
}
state = TrapSpearState.NOT_DAMAGE;
damage = 1;
knockback_strength = 4;
image_speed = 1;

emitterAudio = audio_emitter_create();
audio_falloff_set_model(audio_falloff_linear_distance)
audio_emitter_falloff(emitterAudio, 150, obj_cam.width_, 1);
