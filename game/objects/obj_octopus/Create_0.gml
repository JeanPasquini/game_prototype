

enum OctopusState {
	STARTING_ATTACK,
	ENDING_ATTACK
}
movementSpeed = 2;
currentState = OctopusState.STARTING_ATTACK;

tentacles = ds_list_create();
max_tentacles = 8;
max_bullets = 20;

end_attack_timer = 60 * 8;

is_destroyed = false;

dir = noone;

// visual variables

spin_angle = 0;
spin_speed = 0;
spin_speed_max = 8;
spin_accel_rate = 0.02;

// AUDIO VARIABLES

emitterAudio = audio_emitter_create();
audio_falloff_set_model(audio_falloff_linear_distance)
audio_emitter_falloff(emitterAudio, 150, obj_cam.width_, 1);

audio_special_attack_octopus_attack_bubble = scr_make_onetime_sound([sde_enemy_psicotopus_special_attack_octopus_attack_bubble1, sde_enemy_psicotopus_special_attack_octopus_attack_bubble2, sde_enemy_psicotopus_special_attack_octopus_attack_bubble3, sde_enemy_psicotopus_special_attack_octopus_attack_bubble4], emitterAudio);
audio_special_attack_octopus_attack_tentacle_spawning = scr_make_onetime_sound([sde_enemy_psicotopus_special_attack_octopus_attack_tentacle_spawning], emitterAudio);