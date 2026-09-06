// Inherit and execute the parent object's Create event logic
name = "PSICOTOPUS";


event_inherited();

currentState = EnemyState.APRESENTATION;

enum AttackState {	
	FLOOD,              // Area-filling or flooding type attack
	OCTOPUS_ATTACK,     // Main octopus attack pattern
	TRIPLE_VERTICAL,    // Fires three bullets vertically
    //HOMING_SINGLE,      // Fires a single homing projectile
    TRIPLE_RICOCHET,    // Fires three ricochet bullets
	WAITING,            // Idle state between attacks
}

// Index or counter used to cycle through attack states
// Must be "count(AttackState)-1" to properly ignore the WAITING state when cycling
idle_movement_script = src_grounded_idle_movement();
chasing_movement_script = src_grounded_chasing_movements();
countAttackStates = 4;
currentAttackState = AttackState.WAITING;

is_attacking = false;
attack_cooldown = 0;

change_attack_cooldown = 0;

movementSpeed = 0.5;

// Randomized time range (in steps) between attacks: 3 to 4 seconds
range_time_between_attacks = [180, 240];

life = 10;    
damage = 1;   

tentacles = -1

attack_mount = 0;
fire_count_max = 3;

// visual variables

obj_menu_boss_introduction.scr_introduction_point(880, 246, name, 180);

has_reached_top = false;
has_landed = false;
flag_apresentation = false;

// audio variables

last_step_frame = -1;

audio_special_attack_triple_start = scr_make_onetime_sound([sde_enemy_psicotopus_special_attack_triple_start], emitterAudio);
audio_special_attack_triple_mid = scr_make_onetime_sound([sde_enemy_psicotopus_special_attack_triple_mid], emitterAudio, true);
audio_special_attack_triple_end = scr_make_onetime_sound([sde_enemy_psicotopus_special_attack_triple_end], emitterAudio);

audio_apresentation_flying_water = scr_make_onetime_sound([sde_enemy_psicotopus_apresentation_flying_water], emitterAudio);
audio_apresentation_flying = scr_make_onetime_sound([sde_enemy_psicotopus_apresentation_flying], emitterAudio);
audio_apresentation_impact = scr_make_onetime_sound([sde_enemy_psicotopus_apresentation_impact], emitterAudio);