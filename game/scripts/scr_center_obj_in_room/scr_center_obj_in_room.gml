function scr_center_obj_in_room(_movementSpeed){
	var centro_x = room_width / 2;
	var centro_y = room_height / 2;

	// Check if the instance is not yet exactly at the center of the room
	if x != centro_x || y != centro_y {
		// Needs to be centralized in the room
		// Move towards the center while the remaining distance is greater than the movement speed
		if (point_distance(x, y, centro_x, centro_y) > _movementSpeed) {
			// Set motion direction pointing to the center with a fixed speed
			motion_set(point_direction(x, y, centro_x, centro_y), _movementSpeed);
		} else {
			// Perform the final snap movement to the exact center position
			speed = 0;
			x = centro_x;
			y = centro_y;
		}
	}
}