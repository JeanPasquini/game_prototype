// states
enum PlayerState {
    IDLE,
	WALK,
    RUN,
    JUMP,
	RUN_JUMP,
    FALL,
	RUN_FALL,
	LIGHT_ATTACK,
	HEAVY_ATTACK,
	TALKING
}
state = PlayerState.IDLE;

// Movement
hsp = 0;
face = 1;
vsp = 0;
grv = 0.5;
jmp = -10;
ong = false;

// Status
life_max = 5;
life = 5;
damage_base = 1;
damage = damage_base;
spd = 1.5;
spd_max = 10;
kd = 0;
run = false;

// Moves Attacks

attack_timer = 0;
//light_attack_duration = 15; // frames
//heavy_attack_duration = 25; // frames

tap_timer_left = 0;
tap_timer_right = 0;
double_tap_threshold = 15; // time for double tap

// Merchant Status
money = 0;

depth = -10000;