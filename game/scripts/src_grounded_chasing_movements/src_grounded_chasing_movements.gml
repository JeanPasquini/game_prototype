function src_grounded_chasing_movements() {
	
	return function () {
	
		if (is_outside_room(self)) {
			instance_destroy();
		}
	
		var _dir = 0;
		if (!place_meeting(x, obj_player.y, obj_player)) {
			direction = point_direction(x, y, obj_player.x, y);	
		}	
		if (direction == 180) _dir = -1  else if (direction == 0) _dir = 1
	
		/* 
		* Checks for what movement to execute
		*/
		if (currentMovement != EnemyState.JUMPING) {
		
			if (!position_meeting(x + (sprite_width/2*_dir*-1), y + (sprite_height/2)+1, obj_wall) &&
				!position_meeting(x + (sprite_width/2*_dir), y + (sprite_height/2)+1, obj_wall)) {
				currentMovement = EnemyState.ONGROUND;
				// fazer variável ou coisa assim que "fixe" a direção oposta como correta
				// provavelmente irá afetar até que o inimigo volte para idle
			}
			else if (!position_meeting(x + (sprite_width/2*_dir*-1), y + (sprite_height/2)+1, obj_wall) &&
				!position_meeting(x + (sprite_width/2*_dir), y + (sprite_height/2)+1, obj_wall)) { // Check if it will be without ground
				currentMovement = EnemyState.FALLING;
					
			} else if (place_meeting(x + _dir, y, obj_wall) && currentMovement == EnemyState.ONGROUND) { // Check for future wall collision
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
			x += movementSpeed * _dir;
		}
	}
}
