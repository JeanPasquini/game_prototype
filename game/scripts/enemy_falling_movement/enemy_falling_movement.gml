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