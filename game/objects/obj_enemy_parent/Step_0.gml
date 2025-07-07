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
	if (distance_to_object(obj_player) < detectionRadius)  {
		// Checks if the enemy can still move
		direction = point_direction(x, y, obj_player.x, y);
		if (direction = 0 && x >= (xstart + maxRandomMovement/2) || direction == 180 && x <= (xstart - maxRandomMovement/2)) {
			speed = 0;
		} else {
			speed = movementSpeed;	
		}
			
	} else {
		currentState = EnemyState.IDLE;
	}
	
}