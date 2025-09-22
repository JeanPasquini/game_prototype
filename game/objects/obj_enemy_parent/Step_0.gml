
if(life <= 0){
	for (var i = 0; i < 5; i++) {
    instance_create_layer(x, y, "drop", obj_coin);
}
	instance_destroy();	
}

// === Enemy Random Moviment ===

switch (currentState) {
	case EnemyState.IDLE:
		state_idle();	
		break;
	case EnemyState.CHASING:
		state_chasing();
		break;
}

function state_idle() {
	// Controls the constant movement
	speed = movementSpeed;
	if (x >= (xstart + maxRandomMovement/2)) {
		direction = 180;
	} else if (x <= (xstart - maxRandomMovement/2)) {
		direction = 0;
	}
	// Controls the state change condition
	if (distance_to_object(obj_player) < detectionRadius) {
		currentState = EnemyState.CHASING;
	}
}

function state_chasing() {	
	var player_distance = distance_to_object(obj_player);
	
	// Melee Enemy Controls 
	if (currentState == EnemyState.CHASING && throwsProjectile == noone) {
		src_basic_chasing_movements(obj_player, movementSpeed);		
		// Cooldown for the attack
		if (player_distance <= meleeRange) {
			if (currentAttackDelay == 0) {
				src_show_player_damage_received();
				currentAttackDelay = baseAttackDelay;
			} else {
				currentAttackDelay--;
			}
		}
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