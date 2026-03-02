function scr_get_obj_floor_distance(_x = x, _y = y, _height = 0){
	// Calcula altura em pixels até encontrar parede
	while (!position_meeting(_x, _y + _height, obj_wall)) {
		_height++;
	}
	return _height;
}