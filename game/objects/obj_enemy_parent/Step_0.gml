knockbackSmoothing();

if (life <= 0) {
    scr_drop_roll(drops, x, y, "drop");
    instance_destroy();
}

switch (currentState) {
    case EnemyState.IDLE:
        state_idle();
        break;
    case EnemyState.CHASING:
        state_chasing();
        break;
	case EnemyState.SPECIAL_ATTACK:
		break;
}

if (place_meeting(x + hsp, y, obj_wall) || place_meeting(x + hsp, y, obj_player)) {
    while (!place_meeting(x + sign(hsp), y, obj_wall)
        && !place_meeting(x + sign(hsp), y, obj_player)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

if (place_meeting(x, y + vsp, obj_wall) || place_meeting(x, y + vsp, obj_player)) {
    while (!place_meeting(x, y + sign(vsp), obj_wall)
        && !place_meeting(x, y + sign(vsp), obj_player)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;

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

function state_idle() {
    speed = movementSpeed;

    if (x >= (xstart + maxRandomMovement / 2)) {
        direction = 180;
    } else if (x <= (xstart - maxRandomMovement / 2)) {
        direction = 0;
    }

    if (distance_to_object(obj_player) < detectionRadius) {
        currentState = EnemyState.CHASING;
    }
}

function state_chasing() {	
	var player_distance = distance_to_object(obj_player);
	
	// Melee Enemy Controls 
	if (currentState == EnemyState.CHASING && throwsProjectile == noone) {
		if (is_outside_room(self)) {
			instance_destroy();
		}
		src_basic_chasing_movements(obj_player, movementSpeed);		
		return;
	} 
	
	// Projectile Enemy Controls
	if (throwsProjectile != noone) {
		// Checks if the enemy can still move
		direction = point_direction(x, y, obj_player.x, y);
		if (direction = 0 && x >= (xstart + maxRandomMovement/2) || direction == 180 && x <= (xstart - maxRandomMovement/2)) {
			speed = 0;
		} else {
			speed = movementSpeed;	
		}
			
		if (!instance_exists(throwsProjectile)) {
			if (currentAttackDelay == 0) {
				instance_create_layer(x, y, "Instances", throwsProjectile);
				currentAttackDelay = baseAttackDelay;
			} else {
				currentAttackDelay--;
			}
		}
	} 
	
	// Checks if the enemy should still chase
	if (player_distance > detectionRadius ) {
		currentState = EnemyState.IDLE;
		return;
	}	
}

//function state_chasing() {
//    if (distance_to_object(obj_player) < detectionRadius) {
//        if (!place_meeting(x, y, obj_player)) {

//            direction = point_direction(x, y, obj_player.x, y);

//            if ((direction == 0   && x >= (xstart + maxRandomMovement / 2)) ||
//                (direction == 180 && x <= (xstart - maxRandomMovement / 2))) {
//                speed = 0;
//            } else {
//                speed = movementSpeed;
//            }

//        } else {
//            speed = 0;
//        }

//        if (throwsProjectile != noone) {
//            if (!instance_exists(throwsProjectile)) {
//                if (projectileDelay <= 0) {
//                    instance_create_layer(x, y, "Instances", throwsProjectile);
//                    projectileDelay = 60;
//                } else {
//                    projectileDelay--;
//                }
//            }
//        }
//    } else {
//        currentState = EnemyState.IDLE;
//    }
//}

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