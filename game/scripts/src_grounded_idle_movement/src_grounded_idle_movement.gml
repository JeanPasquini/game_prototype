function src_grounded_idle_movement(){
	return function () {
		// determinates the direction
		var _dir = 0;
		
		if (direction == 0) _dir = 1;
		else if (direction == 180) _dir = -1;
		
	    if (x >= (xstart + maxRandomMovement / 2)) {
	       _dir = -1;
		   direction = 180;
	    } else if (x < (xstart - maxRandomMovement / 2)) {
	        _dir = 1;
			direction = 0;
	    }
		/* 
		* Checks for what movement to execute
		*/
		
		if (currentMovement != EnemyState.JUMPING) {
			if (!scr_enemy_point_solid(x + (sprite_width/2*_dir*-1), y + (sprite_height/2)+1) &&
				!scr_enemy_point_solid(x + (sprite_width/2*_dir), y + (sprite_height/2)+1)) { // Check if it will be without ground
				currentMovement = EnemyState.FALLING;
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
		} else if (currentMovement == EnemyState.FALLING) {
				enemy_falling_movement(2.2);
		} else {
			currentMovement = EnemyState.ONGROUND;
			enemy_falling_movement(movementSpeed);
			var _step = movementSpeed * _dir;
			if (scr_enemy_solid(x + _step, y)) {
				// para colado na parede e, na patrulha, inverte o sentido
				while (!scr_enemy_solid(x + sign(_step), y)) x += sign(_step);
				direction = (direction == 0) ? 180 : 0;
			} else {
				x += _step;
			}
		}

	}
}