// Check if the octopus is starting its attack behavior
if (currentState == OctopusState.STARTING_ATTACK && !is_destroyed) {
	var centro_x = room_width / 2;
	var centro_y = room_height / 2;

	// Check if the instance is not yet exactly at the center of the room
	if x != centro_x || y != centro_y {
		// Needs to be centralized in the room
		// Move towards the center while the remaining distance is greater than the movement speed
		if (point_distance(x, y, centro_x, centro_y) > movementSpeed) {
			// Set motion direction pointing to the center with a fixed speed
			motion_set(point_direction(x, y, centro_x, centro_y), movementSpeed);
		} else {
			// Perform the final snap movement to the exact center position
			speed = 0;
			x = centro_x;
			y = centro_y;
			
			// Once centralized, spawn tentacles and bullets to start the attack phase
			_create_tentacles();
			_create_bullets();
		}
	}
}
// Check if the octopus is finishing its attack behavior
else if (currentState == OctopusState.ENDING_ATTACK || is_destroyed) {
	
	// Wait for the end attack delay timer to finish before proceeding
	if (end_attack_timer > 0 && !is_destroyed) {
		end_attack_timer--;
		return;
	}
	
	// If the tentacles list still exists, destroy all remaining tentacles
	if (ds_exists(tentacles, ds_type_list)) {
		scr_destroy_tentacles_ds(tentacles);
		if is_destroyed instance_destroy();
		return;
	}
	
	// Check if the instance is not yet back at its starting position
	if (x != obj_psicotopus.x || y != obj_psicotopus.y) {
		// Needs to be moved back to its initial spawn position
		if (point_distance(x, y, xstart, ystart) > movementSpeed) {
			// Move towards the starting position
			motion_set(point_direction(x, y, xstart, ystart), movementSpeed);
		} else {
			// Perform the final snap movement to the exact starting position
			speed = 0;
			x = xstart;
			y = ystart;
			
			// Destroy the octopus instance after completing the return movement
			instance_destroy();
		}
	}
}

// Creates a spread of ricochet bullets originating from the octopus position
function _create_bullets() {
	var angle_start = 0;
	var angle_step = 180 / max_bullets;

	// Create bullets evenly distributed across a 180-degree arc
	for (var i = 0; i < max_bullets; i++) {
	    var _b = instance_create_layer(x, y, "Instances", obj_bullet_ricochet);
	    
	    // Assign a unique direction for each bullet
	    _b.direction = angle_start + (angle_step * i);
	    
	    // Define how many times the bullet can bounce
	    _b.bounces = 3;
	    
	    // Set bullet movement speed
	    _b.velocity = 5; 
	}
}

// Creates and registers the octopus tentacles
function _create_tentacles() {
	
	for (var i = 0; i < max_tentacles; i++) {
		var _tent = instance_create_layer(x, y, "Instances", obj_psicotopus_tentacles);		
		
		// Ensure a different angle for each tentacle:
		// 0°, 45°, 90°, 135°, 180°, 225°, etc.
		// The current list size is used to calculate a unique angular offset
		_tent.angle_offset = (360 / max_tentacles) * ds_list_size(tentacles);
		_tent.type = TentacleType.ORBITAL;
		
		// Store the tentacle reference in the list for later management
		ds_list_add(tentacles, _tent);
	}
	
	// After creating all tentacles, transition to the ending attack state
	currentState = OctopusState.ENDING_ATTACK;
}
