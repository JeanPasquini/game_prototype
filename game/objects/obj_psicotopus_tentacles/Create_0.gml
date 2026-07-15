enum TentacleType {
	ORBITAL,
	STATIC,
	ALIVE,
}

type = TentacleType.STATIC;
scale_target = 1.0;
scale_current = 0.0;
grow_smoothness = 0.05;
grow_direction = 1; // 1 up-down, -1 down-up
is_invencible = false;

is_destroyed = false
damage = 1;
life = 3;

angle_rotation = 0;
angle_offset = 0;

radius = 30;
movementSpeed = 2;

// Propriedades para controle de ataque ao player
is_attacking = false;
player_angle_dir = 0;
attack_range = sprite_height; // alcance máximo = altura do sprite
alpha = 0;
color = c_white;

if(obj_psicotopus.currentAttackState == AttackState.FLOOD){
	image_index = 0;
	sprite_index = spr_psicotopus_tentacle_spawning;
}
else if(obj_psicotopus.currentAttackState == AttackState.OCTOPUS_ATTACK){
	image_index = 0;
	sprite_index = spr_octopus_octopus_attack_tentacle_spawning;
}

// AUDIO VARIABLES

emitterAudio = audio_emitter_create();
audio_falloff_set_model(audio_falloff_linear_distance)
audio_emitter_falloff(emitterAudio, 150, obj_cam.width_, 1);

audio_special_attack_flood_tentacle_dying = scr_make_onetime_sound([sde_enemy_psicotopus_special_attack_flood_tentacle_dying], emitterAudio);
audio_special_attack_flood_tentacle_spawning = scr_make_onetime_sound([sde_enemy_psicotopus_special_attack_flood_tentacle_spawning], emitterAudio);
audio_special_attack_flood_tentacle_preparing_attack = scr_make_onetime_sound([sde_enemy_psicotopus_special_attack_flood_tentacle_preparing_attack1], emitterAudio);
audio_special_attack_flood_tentacle_attack = scr_make_onetime_sound([sde_enemy_psicotopus_special_attack_flood_tentacle_attack1], emitterAudio);



