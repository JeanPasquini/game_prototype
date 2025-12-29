if (currentState == OctopusState.STARTING_ATTACK) {
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
			_create_tentacles();
		}
	}
} else if (currentState == OctopusState.ENDING_ATTACK) {
	
	if (end_attack_timer > 0) {
		end_attack_timer--;
		return;
	}
	
	if (ds_exists(tentacles, ds_type_list)) {
		_destroy_tentacles();
	}
	
	// Caso ainda não esteja no centro
	if (x != xstart && y != ystart) {
		// Needs to be moved to its start position
		if (point_distance(x, y, xstart, ystart) > movementSpeed) {
			motion_set(point_direction(x, y, xstart, ystart), movementSpeed);
		} else {
			// Realiza o último movimento ao ponto central
			speed = 0;
			x = xstart;
			y = ystart;
			instance_destroy();
		}
	}
}


function _create_tentacles() {
	
	for (var i = 0; i < max_tentacles; i++) {
		var _tent = instance_create_layer(x, y, "Instances", obj_psicotopus_tentacles);		
		// Garente um ângulo diferente para cada tentáculo: 0°, 45°, 90°, 135°, 180°, 225°...
		_tent.angle_offset = (360 / max_tentacles) * ds_list_size(tentacles);
		
		ds_list_add(tentacles, _tent);
	}
	currentState = OctopusState.ENDING_ATTACK;
}

function _destroy_tentacles() {
	for (var i = 0; i < ds_list_size(tentacles); i++) {
	    var tentacle = tentacles[| i];
    
	    if (instance_exists(tentacle)) {
	        instance_destroy(tentacle);
	    }
	}

	ds_list_clear(tentacles);
	ds_list_destroy(tentacles);
	tentacles = -1;
}