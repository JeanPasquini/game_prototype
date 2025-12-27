var centro_x = room_width / 2;
var centro_y = room_height / 2;

// Caso ainda não esteja no centro
if x != centro_x && y != centro_y {
	// Needs to be centralized in the room
	if (point_distance(x, y, centro_x, centro_y) > movementSpeed) {
		motion_set(point_direction(x, y, centro_x, centro_y), movementSpeed);
	} else {
		// Realiza o último movimento ao ponto central
		speed = 0;
		x = centro_x;
		y = centro_y;
		alarm[0] = spawn_tentacles_timer;
	}
}







if keyboard_check_pressed(ord("G")) instance_destroy();