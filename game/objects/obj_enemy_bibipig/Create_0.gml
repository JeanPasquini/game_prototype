// Inherit the parent event
event_inherited();

baseAttackDelay = 90;

maxDetectionRadius = 120;
detectionRadius = maxDetectionRadius;

hasToCharge = true;
currentChargingDelay = baseAttackDelay;
currentAttackDelay = baseAttackDelay;

knockback_strength = 15;

idle_movement_script = src_grounded_idle_movement();
chasing_movement_script = src_grounded_sprint_chasing_movement();
chasing_attack_script = src_charging_sprint_attack(); // guarantees only damage from contact.

// AUDIO VARIABLES

last_step_frame = -1;

audio_attacking = scr_make_onetime_sound([sde_enemy_bibipig_attacking], emitterAudio);
audio_dying = scr_make_onetime_sound([sde_enemy_bibipig_dying], emitterAudio);