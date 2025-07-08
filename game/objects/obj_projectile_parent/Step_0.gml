if (instance_exists(obj_projectile_parent)) {
	if (
		place_meeting(x+1, y+1, obj_player) || 
		place_meeting(x+1, y+1, obj_wall) ||
		is_outside_room(id)
		) 
	{
		instance_destroy();
	} else {
		if (y <= maximumHeight && CurrentState.RISING) {
			y += verticalAcceleration;
		} else {
			state = CurrentState.FALLING;
			y -= verticalAcceleration;
		}
	}
}