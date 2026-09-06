function enemy_falling_movement(movementSpeed) {
	var _yspd = movementSpeed;
	if (scr_enemy_solid(x, y + movementSpeed)) {
	while (!scr_enemy_solid(x, y + sign(movementSpeed))) {
	    y += sign(movementSpeed);
	}
		_yspd = 0;
	}
	y += _yspd;
}