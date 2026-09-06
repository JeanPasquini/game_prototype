function enemy_jumping_movement(movementSpeed, _dir) {
	var _xspd = movementSpeed / 2;
	var _yspd = movementSpeed * 2;
	speed = 0;
	
	if (scr_enemy_solid(x + _xspd * _dir, y)) {
	    while (!scr_enemy_solid(x + sign(_xspd) * _dir, y)) {
	        x += sign(_xspd) * _dir;
	    }
	    _xspd = 0;
	}
	x += _xspd * _dir;

	if (scr_enemy_solid(x, y - _yspd)) {
	    while (!scr_enemy_solid(x, y - sign(_yspd))) {
	        y -= sign(_yspd);
	    }
	    _yspd = 0;
	}
	y -= _yspd;

	if (!scr_enemy_solid(x + _dir, y+1)) currentMovement = EnemyState.ONGROUND;
}