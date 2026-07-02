event_inherited();

float_timer += 0.1;

if (upward > 0) {
	upward--;
	y--;
			
	if (upward <= 0) {
		dir = point_direction(x, y, obj_player.x, obj_player.y);
		direction = dir;	
	}
	
	return;
} 

x += lengthdir_x(velocity, direction);
y += lengthdir_y(velocity, direction);