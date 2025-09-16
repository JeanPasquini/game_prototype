
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
	// Checks if the enemy should still chase
	var player_distance = distance_to_object(obj_player);
	if (player_distance < detectionRadius)  {
		// Checks if the enemy can still move
		direction = point_direction(x, y, obj_player.x, y);
		if (direction = 0 && x >= (xstart + maxRandomMovement/2) || direction == 180 && x <= (xstart - maxRandomMovement/2)) {
			speed = 0;
		} else {
			speed = movementSpeed;	
		}
		
		// Check if enemy throws a projectile and create a new object
		if (throwsProjectile != noone) {
			if (!instance_exists(throwsProjectile)) {
				if (currentAttackDelay == 0) {
					instance_create_layer(x, y, "Instances", throwsProjectile);
					currentAttackDelay = baseAttackDelay;
				} else {
					currentAttackDelay--;
				}
			}
		} 
		// If the enemy doesn't have a projectile, is a melee 
		else {
			// Cooldown for the attack
			if (player_distance <= meleeRange) {
				if (currentAttackDelay == 0) {
					src_show_player_damage_received();
					currentAttackDelay = baseAttackDelay;
				} else {
					currentAttackDelay--;
				}
			}
			// Movimentation 
		}
		
	} else {
		currentState = EnemyState.IDLE;
	}
	
}