// states
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
	WAIT_ATTACK
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

// Status
life_max = 10;
life = 10;
damage_base = 1;
damage = damage_base;
spd = 2.5;
spd_max = 10;
attack_speed = 1; // max 2.9
attack_recoil = 2;
attack_knockback = 5;
invencible_time = 50;

// Moves Attacks

timer_attack = 15;

// Merchant Status
money = 0;

// Additions Variables

invencible = false;

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

depth = 0;

