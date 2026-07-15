image_xscale = 1.5;
image_yscale = 1.5;
image_speed	= 0;

shake_amount = 0;
shake_max = 4; 
shake_decay = 0.5;

// AUDIO VARIABLES

emitterAudio = audio_emitter_create();
audio_falloff_set_model(audio_falloff_linear_distance)
audio_emitter_falloff(emitterAudio, 150, obj_cam.width_, 1);

audio_hit_shield = scr_make_onetime_sound([sde_enemy_psicotopus_shield_hit1,
sde_enemy_psicotopus_shield_hit2,
sde_enemy_psicotopus_shield_hit3], emitterAudio);

