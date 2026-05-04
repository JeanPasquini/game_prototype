activated = false;
image_speed = 0;
emitterAudio = audio_emitter_create();
audio_falloff_set_model(audio_falloff_linear_distance)
audio_emitter_falloff(emitterAudio, 150, obj_cam.width_, 1);
