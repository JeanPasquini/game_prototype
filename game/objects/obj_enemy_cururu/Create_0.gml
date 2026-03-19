// Inherit the parent event
event_inherited();

// Enemy detection and basic stats
detectionRadius = 180;
life = 10;

// Attack state control
isCharging = false;

// Projectile object used by this enemy
throwsProjectile = obj_air_projectile;

// Behavior scripts assigned to the enemy AI states
idle_movement_script = src_jumping_idle_movement();
chasing_attack_script = src_charging_projectile_attack();
chasing_movement_script = src_jumping_chasing_movement();

// Defines the possible jump directions/states used by the movement logic
enum JumpState {
    LEFT,
    LEFT_MIDDLE,
    RIGHT,
    RIGHT_MIDDLE
}

// Attack cooldown control
currentAttackDelay = 0;
currentChargingDelay = 0;
baseAttackDelay = 60;


// Current jump state used by the movement state machine
jump_state = JumpState.LEFT;
jump_force = 6; // Vertical jump force (jump height)
grv = 0.25; // Gravity factor used to adjust vertical movement behavior

var air_time = (jump_force * 2) / grv;
jump_speed = maxRandomMovement / air_time;

// Delay between jumps to prevent continuous movement
jump_pause = 30;
pause_timer = 0;

// Maximum horizontal randomness applied to movement
// Can be exceeded if required to complete a movement transition
maxRandomMovement = 40;

// Horizontal and vertical speed
hsp = 0;
vsp = 0;
