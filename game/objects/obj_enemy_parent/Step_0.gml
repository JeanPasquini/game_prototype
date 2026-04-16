if (global.hitstop > 0) {
	speed = 0;
    exit;
}
	
knockbackSmoothing();

if (life <= 0 && !is_destroyed) {
    scr_drop_roll(drops, x, y, "drop");
    is_destroyed = true;
}

// Idle State
if (currentState == EnemyState.IDLE) {
	idle_movement_script();
	if (distance_to_object(obj_player) < detectionRadius) {
		if (hasToCharge) currentState = EnemyState.CHARGING_ATTACK; else currentState = EnemyState.CHASING;
	} else if (detectionRadius < maxDetectionRadius && alarm[4] < 0) {
		alarm[4] = 60;
	}
} 
// Attacking State
else if (currentState == EnemyState.CHASING || currentState == EnemyState.CHARGING_ATTACK) {
	chasing_movement_script();
	chasing_attack_script();
}

// Ajusta o movimento para não atravessar a Parede e nem o Player
// Pode causar efeito colateral no movimento esperado
if (place_meeting(x + hsp, y, obj_wall) || place_meeting(x + hsp, y, obj_player)) {
	while (!place_meeting(x + sign(hsp), y, obj_wall)
	    && !place_meeting(x + sign(hsp), y, obj_player)) {
	    x += sign(hsp);
	}
	hsp = 0;
}

if (place_meeting(x, y + vsp, obj_wall) || place_meeting(x, y + vsp, obj_player)) {
	while (!place_meeting(x, y + sign(vsp), obj_wall)
	    && !place_meeting(x, y + sign(vsp), obj_player)) {
	    y += sign(vsp);
	}
	vsp = 0;
}

function knockbackSmoothing(){
	if (abs(knockback_x) > 0.1 || abs(knockback_y) > 0.1) {
	    var nx = x + knockback_x * 0.5;
		var ny = y + knockback_y * 0.5;

	    if (!place_meeting(nx, ny, obj_wall) && !place_meeting(nx, ny, obj_player)) {
		    x = nx;
		    y = ny;
		}

	    knockback_x *= 0.95;
	    knockback_y *= 0.95;
	} else {
	    knockback_x = 0;
	    knockback_y = 0;
	}
}

function state_stagger() {
    hsp = 0;
    speed = 0;
    if (stagger <= 0) {
        currentState = EnemyState.IDLE;
    }
}

scr_damage_with_knockback();

if (direction == 180) {
    image_xscale = 1;
} else {
    image_xscale = -1;
}

alpha = lerp(alpha, 0, 0.1);