function src_basic_chasing_movements(_target, _spd) {
    direction = point_direction(x, y, _target.x, y);
	
	if (place_meeting(x, y + 2, obj_wall)) {
		speed = 0;
	} else {
		speed = _spd;	
	}
}
