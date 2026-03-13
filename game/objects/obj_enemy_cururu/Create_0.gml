// Inherit the parent event
event_inherited();

detectionRadius = 180;
life = 10;
isCharging = false;

throwsProjectile = obj_air_projectile;
idle_movement_script = src_jumping_idle_movement();
chasing_attack_script = src_charging_projectile_attack();
chasing_movement_script = src_limited_flying_movement();

enum JumpState {
    LEFT,
    LEFT_MIDDLE,
    RIGHT,
    RIGHT_MIDDLE
}

currentAttackDelay = 0;
baseAttackDelay = 30;

jump_state = JumpState.LEFT;

jump_speed = 1.2;
jump_force = 5; 
grv = 0.25;

hsp = 0;
vsp = 0;

maxRandomMovement = 40;

jump_pause = 30;
pause_timer = 0;