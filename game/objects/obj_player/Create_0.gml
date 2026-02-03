// States
enum PlayerState {
    IDLE,
	WALK,
	WALK_TURN,
    RUN,
    RUN_TURN,
    RUN_TO_IDLE,
    JUMP,
	RUN_JUMP,
    FALL,
	RUN_FALL,
	ATTACK,
	TALKING,
	WAIT_ATTACK,
	DYING
}
state = PlayerState.IDLE;

// Movement
hsp = 0;
face = 1;
vsp = 0;
grv = 0.5;
jmp = -10;
ong = false;
knockback_x = 0;
knockback_y = 0;
knockback_strength = 5;

// Status
life_max = 100;
life = 60;
energy_max = 0;
energy = 0;
damage_base = 1;
damage = damage_base;
spd = 2.5;
spd_max = 10;
attack_speed = 0.5; // max 2.5
attack_recoil = 2;
attack_knockback = 5;
invencible_time = 50;
critical_chance = 0;
lucky_chance = 0;
key = 10;

// Status Alternable

invencible = false;

// Perks

perks_limit_max = 18;
perks_limit_run = 6;
perks_obtained_run = [];
perks_obtained_run_obj = [];

perk_activatable = noone;
perk_activatable_obj = noone;
perk_activatable_active = noone;

// Moves Attacks

timer_attack = 15;

// Merchant Status

money = 1000;


// Additions Variables

move_input = 0;

face = 1;
turn_target_dir = 0;
turning = false;
turn_timer = 0;
turn_duration = 0;
pending_face = 1;

run = false;
tap_timer_left = 0;
tap_timer_right = 0;
double_tap_threshold = 15;

previous_state = state;
smoke_instance = noone;

talking = false;

depth = 0;

// Sounds Frames Step

footstep_frames_walk = [0, 6];
footstep_frames_run  = [2, 7];
last_foot_frame = -1;

// Config Sound Orientation

audio_listener_set_position(0, x, y, 0);
audio_listener_set_orientation(
    0,
    0, 0, -1, 
    0, 1, 0    
);

// Initial Status

life_max_initial = life_max;
damage_base_initial = damage_base;
damage_initial = damage;
spd_initial = spd;
spd_max_initial = spd_max;
attack_speed_initial = attack_speed;
attack_recoil_initial = attack_recoil;
attack_knockback_initial = attack_knockback;
invencible_time_initial = invencible_time;
critical_chance_initial = critical_chance;
lucky_chance_initial = lucky_chance;
perks_limit_run_initial = perks_limit_run;
perks_obtained_run_initial = [];
perks_obtained_run_obj_initial = [];
key_initial = key;
energy_max_initial = energy_max;
energy_initial = energy;


