if(life <= 0){
	for (var i = 0; i < 5; i++) {
    instance_create_layer(x, y, "drop", obj_coin);
}
	instance_destroy();	
}

switch (currentState) {
    case EnemyState.IDLE:
        state_idle();
        break;
    case EnemyState.CHASING:
        state_chasing();
        break;
}

if ( place_meeting(x + hsp, y, obj_wall) || place_meeting(x + hsp, y, obj_player) ) {
    while ( !place_meeting(x + sign(hsp), y, obj_wall)
         && !place_meeting(x + sign(hsp), y, obj_player) ) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

ong = false;
if ( place_meeting(x, y + vsp, obj_wall) || place_meeting(x, y + vsp, obj_player) ) {
    while ( !place_meeting(x, y + sign(vsp), obj_wall)
         && !place_meeting(x, y + sign(vsp), obj_player) ) {
        y += sign(vsp);
    }
    if (vsp > 0) ong = true;
    vsp = 0;
}
y += vsp;

function state_idle() {
    speed = movementSpeed;

    if (x >= (xstart + maxRandomMovement/2)) {
        direction = 180;
    } else if (x <= (xstart - maxRandomMovement/2)) {
        direction = 0;
    }

    if (distance_to_object(obj_player) < detectionRadius) {
        currentState = EnemyState.CHASING;
    }
}

function state_chasing() {
    if (distance_to_object(obj_player) < detectionRadius) {

        if (!place_meeting(x, y, obj_player)) {

            direction = point_direction(x, y, obj_player.x, y);

            if ( (direction == 0   && x >= (xstart + maxRandomMovement/2)) ||
                 (direction == 180 && x <= (xstart - maxRandomMovement/2)) ) {
                speed = 0; 
            } else {
                speed = movementSpeed;
            }

        } else {
            speed = 0; 
        }

        if (throwsProjectile != noone) {
            if (!instance_exists(throwsProjectile)) {
                if (projectileDelay <= 0) {
                    instance_create_layer(x, y, "Instances", throwsProjectile);
                    projectileDelay = 60;
                } else {
                    projectileDelay--;
                }
            }
        }

    } else {
        currentState = EnemyState.IDLE;
    }
}