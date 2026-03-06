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
				!position_meeting(x + (sprite_width/2*_dir), y + (sprite_height/2)+1, obj_wall)) { // Check if it will be without ground
				currentMovement = EnemyState.FALLING;
					
			} else if (place_meeting(x + _dir, y, obj_wall) && currentMovement == EnemyState.ONGROUND) { // Check for future wall collision
				jump_direction = _dir;
				currentMovement = EnemyState.JUMPING;
			} else {
				currentMovement = EnemyState.ONGROUND;
				if (place_meeting(x + (sprite_width/2*_dir*-1), y, obj_player)) {
					speed = 0;
					return;
				}
			}
		}
		/* 
		* Executes the enemy movement by the current state
		*/
		if (currentMovement == EnemyState.JUMPING) {
				enemy_jumping_movement(2, jump_direction);
		} else if (currentMovement == EnemyState.FALLING) {
				hspeed = 0;
				enemy_falling_movement(2.2);
		} else {
			currentMovement = EnemyState.ONGROUND;
			enemy_falling_movement(movementSpeed);		
			speed = movementSpeed;
		}
	}
}

/**
** Helper functions
**/
function enemy_jumping_movement(movementSpeed, _dir) {
	var _xspd = movementSpeed / 2;
	var _yspd = movementSpeed * 2;
	speed = 0;
	
	if (place_meeting(x + _xspd * _dir, y, obj_wall)) {
	    while (!place_meeting(x + sign(_xspd) * _dir, y, obj_wall)) {
	        x += sign(_xspd) * _dir;
	    }
	    _xspd = 0;
	}
	x += _xspd * _dir;
	
	if (place_meeting(x, y - _yspd, obj_wall)) {
	    while (!place_meeting(x, y - sign(_yspd), obj_wall)) {
	        y -= sign(_yspd);
	    }
	    _yspd = 0;
	}
	y -= _yspd;
	
	if (!position_meeting(x + (sprite_width/2*_dir)+_dir, y+sprite_height, obj_wall)) currentMovement = EnemyState.ONGROUND;
}

function enemy_falling_movement(movementSpeed) {
	var _yspd = movementSpeed;
	if (place_meeting(x, y + movementSpeed, obj_wall)) {
	while (!place_meeting(x, y + sign(movementSpeed), obj_wall)) {
	    y += sign(movementSpeed);
	}
		_yspd = 0;
	}
	y += _yspd;
}
