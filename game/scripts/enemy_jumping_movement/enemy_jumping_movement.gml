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