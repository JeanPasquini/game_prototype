// Inherit the parent event
event_inherited();
life = 5;
maxDetectionRadius = 180;
throwsProjectile = obj_projectile;
idle_movement_script = src_random_flying_idle_movement();
chasing_attack_script = src_lunge_attack();
chasing_movement_script = src_random_flying_chasing_movement();
damage = 1;
knockback_strength = 5;
baseAttackDelay = 1 * 60;
currentAttackDelay = baseAttackDelay;

// FLYING CONTROL
fallSpeed = 0;     
thrustCooldown = 0;
maxOffsetUp   = 0; 
maxOffsetDown = 0;  
retreatTimer = 0;	


// AUDIO VARIABLES

last_step_frame = -1;

audio_dying = scr_make_onetime_sound([sde_enemy_cegogolho_dying], emitterAudio);