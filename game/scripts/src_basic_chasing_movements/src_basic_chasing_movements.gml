function src_basic_chasing_movements(_target, _spd) {
    direction = point_direction(x, y, _target.x, y);
	
	if (direction == 180) {
		var dir = -1;
	} else if (direction == 0) {
		var dir = 1;
	}
	
	if (place_meeting(x + (sprite_width/2*dir), y, obj_wall)) {
		// Sistema de Pulo?
		speed = 0;
	} else {
		speed = _spd;	
	}
}
