function src_basic_chasing_movements(_target, _spd) {
	var _dir = 0;
	if (!place_meeting(x, _target.y, _target)) {
		direction = point_direction(x, y, _target.x, y);	
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
			if (place_meeting(x + (sprite_width/2*_dir*-1), y, _target)) {
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
		enemy_falling_movement(_spd);		
		speed = _spd;
	}
}

function enemy_jumping_movement(_spd, _dir) {
	var _xspd = _spd / 2;
	var _yspd = _spd * 2;
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

function enemy_falling_movement(_spd) {
	var _yspd = _spd;
	if (place_meeting(x, y + _spd, obj_wall)) {
	while (!place_meeting(x, y + sign(_spd), obj_wall)) {
	    y += sign(_spd);
	}
		_yspd = 0;
	}
	y += _yspd;
}
