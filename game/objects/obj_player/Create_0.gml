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
	LIGHT_ATTACK,
	HEAVY_ATTACK,
	TALKING,
	DOWNED,
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
// thresholds
moving_threshold = 0.2;
stopping_threshold = 0.5;

// controle de transição
stopping = false;


// Status
life_max = 5;
life = 5;
damage_base = 1;
damage = damage_base;
spd = 2.5;
spd_max = 10;
kd = 0;
run = false;
downed = false;
downed_time = 0;
attack_push = 0;

face = 1;
turning = false;
turn_timer = 0;
turn_duration = 0;
pending_face = 1;


// Moves Attacks

attack_timer = 0;
combo_stage = 0;
combo_timer = 0;
comboGuide = "";
combo_finish = false;
//light_attack_duration = 15; // frames
//heavy_attack_duration = 25; // frames

tap_timer_left = 0;
tap_timer_right = 0;
double_tap_threshold = 15; // time for double tap



// Merchant Status
money = 0;

depth = 0;

previous_state = state;
// Cria o cachecol
smoke_instance = noone;
// Define a profundidade (quanto maior o número, mais atrás)

// Cria a fumaça
var dirt = instance_create_layer(x, y, "Instances", obj_dirt);

// Define a profundidade (quanto maior o número, mais atrás)
if (random(1) < 0.5) {
    dirt.depth = obj_player.depth + 10; // atrás
} else {
    dirt.depth = obj_player.depth - 10; // na frente
}

