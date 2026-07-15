obj_followed = noone;
x_add = noone;
y_add = noone;
_ps = noone;
_pt = noone;
_em = noone;

emitting = true;
particle_life_max = 30;

emitterAudio = audio_emitter_create();
audio_falloff_set_model(audio_falloff_linear_distance)
audio_emitter_falloff(emitterAudio, 150, obj_cam.width_, 1);
