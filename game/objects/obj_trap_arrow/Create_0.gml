damage = 1;

emitter = audio_emitter_create();
audio_emitter_position(emitter, x, y, 0);
audio_falloff_set_model(audio_falloff_linear_distance)
audio_emitter_falloff(emitter, 10, obj_cam.width_, 1);