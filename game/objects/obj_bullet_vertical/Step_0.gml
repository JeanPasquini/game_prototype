// Inherit the parent event
event_inherited();



if (upward > 0) {
	/*
	// Bala sobe mais rápido
	var step = min(velocity, upward);
    upward -= step;	
	y -= step;
	*/
	upward--;
	y--;
			
	if (upward <= 0) {
		dir = point_direction(x, y, obj_player.x, obj_player.y)
		direction = dir;	
	}
	
	
	
	return;
} 

x += lengthdir_x(velocity, direction);
y += lengthdir_y(velocity, direction);

