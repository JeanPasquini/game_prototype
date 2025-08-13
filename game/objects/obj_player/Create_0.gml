// states
enum PlayerState {
    IDLE,
	WALK,
    RUN,
    JUMP,
	RUN_JUMP,
    FALL,
	RUN_FALL
}
state = PlayerState.IDLE;

// Movement
hsp = 0;
face = 1;
vsp = 0;
grv = 0.5;
jmp = -10;
spd = 1.5;
ong = false;

tap_timer_left = 0;
tap_timer_right = 0;
double_tap_threshold = 15; // time for double tap
run = false;

