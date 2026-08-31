if (global.hitstop > 0) {
    exit;
}

if (hit_flash > 0) hit_flash--;
if (hurt_fx_timer > 0)     hurt_fx_timer--;
if (hurt_recoil_timer > 0) hurt_recoil_timer--;
if (hurt_grav_timer > 0)   hurt_grav_timer--;

if (life <= 0){
	state = PlayerState.DYING;
}

switch (state) {
    case PlayerState.IDLE:
    case PlayerState.WALK:
    case PlayerState.WALK_TURN:
    case PlayerState.RUN_TO_IDLE:
    case PlayerState.RUN_TURN:
    case PlayerState.RUN:
    case PlayerState.RUN_JUMP:
    case PlayerState.RUN_FALL:
    case PlayerState.JUMP:
    case PlayerState.FALL:
    case PlayerState.ATTACK:
	case PlayerState.DASH:
	case PlayerState.TALKING:
		scr_combat();
	case PlayerState.INTRODUCTION:
	case PlayerState.TRANSITION:
	case PlayerState.DYING:
		scr_movement();

    break;
}

var water_instance = instance_place(x, y, obj_water);
if (water_instance != noone) {
//	state = PlayerState.SWIN;
	swimming = true
} else if (state == PlayerState.SWIN) {
	state = PlayerState.IDLE;
	
} else {
	swimming = false;
}