function src_grounded_sprint_chasing_movement(){
	return function () {
	
		var _dir = 0;
		var _movSpd = movementSpeed * 4;
		
		if (!place_meeting(x, obj_player.y, obj_player) &&
			currentState != EnemyState.CHASING) {
			direction = point_direction(x, y, obj_player.x, y);	
		}	
		if (direction == 180) _dir = -1  else if (direction == 0) _dir = 1
	
		/* 
		* Checks for what movement to execute
		*/
		if (currentMovement != EnemyState.JUMPING) {
			// Detects if it is close to falling (first vertex without ground).
			if (!scr_enemy_point_solid(x + (sprite_width/2*-1) + _dir, y + (sprite_height/2)+1)) {
				// returning state.
				currentState = EnemyState.IDLE;
				detectionRadius = 10;
				exit;
			} else if (wall_jump_enabled && scr_enemy_solid(x + _dir, y) && currentMovement == EnemyState.ONGROUND) { // Check for future wall collision
				jump_direction = _dir;
				currentMovement = EnemyState.JUMPING;
			} else {
				currentMovement = EnemyState.ONGROUND;
			}
		}
		/* 
		* Executes the enemy movement by the current state
		*/
		if (currentMovement == EnemyState.JUMPING) {
			enemy_jumping_movement(2, jump_direction);
		} else if (currentMovement == EnemyState.FALLING || currentState == EnemyState.CHARGING_ATTACK) {
			enemy_falling_movement(2.2);
		} else if (currentState == EnemyState.CHASING) {
			currentMovement = EnemyState.ONGROUND;
			enemy_falling_movement(_movSpd);
			var _step = _movSpd * _dir;
			if (scr_enemy_solid(x + _step, y)) {
				// para colado na parede em vez de escala-la / atravessa-la
				while (!scr_enemy_solid(x + sign(_step), y)) x += sign(_step);
			} else {
				x += _step;
			}
		}
	}
}