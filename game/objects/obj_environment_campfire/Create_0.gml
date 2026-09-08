emitterAudio = audio_emitter_create();
audio_falloff_set_model(audio_falloff_linear_distance)
audio_emitter_falloff(emitterAudio, 150, obj_cam.width_, 1);

audio_campfire = scr_make_onetime_sound([sde_environment_campfire], emitterAudio, true);
audio_campfire();