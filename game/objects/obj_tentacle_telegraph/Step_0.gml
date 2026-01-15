// If the entity is marked as destroyed, clean up tentacle data and destroy this instance
if (is_destroyed) {
	tentacles = scr_destroy_tentacles_ds(tentacles); // Safely destroy and clear the tentacle data structure
	instance_destroy();
}

// Mark the entity as destroyed after enough tentacles have been eliminated
if (count_destroyed_tentacles >= min_tentacles_to_destroy) {
	is_destroyed = true;
}

// Handle telegraph cooldown timer
if (telegraph_timer > 0) {
	telegraph_timer--;
} else {
	
	// Ensure the tentacle list is initialized and still valid
	if (tentacles != -1 && ds_exists(tentacles, ds_type_list)) {
		
		// Track the number of active tentacle instances to detect when one is destroyed
		var _cur_tent_count = instance_number(obj_psicotopus_tentacles);
		if (_cur_tent_count <= last_count_tentacles) {
			count_destroyed_tentacles++; // Increment when a tentacle count decrease is detected
		}
		last_count_tentacles = _cur_tent_count;
		
		// Enforce the maximum tentacle limit by removing the oldest one
		if (ds_list_size(tentacles) >= max_tentacles) {
			var _tent0 = tentacles[| 0];
			if (instance_exists(_tent0)) _tent0.is_destroyed = true; // Signal the tentacle to self-destruct
			ds_list_delete(tentacles, 0);
		}
	} else {
		return; // Abort execution if the tentacle list is invalid
	}
	
	// Spawn a new tentacle at the telegraphed position
	var _tent = instance_create_layer(
		telegraphX,
		telegraphY + sprite_get_height(spr_telegraph),
		"Instances",
		obj_psicotopus_tentacles
	);
	
	// Initialize tentacle behavior
	_tent.type = TentacleType.ALIVE;
	_tent.grow_direction = -1;
	ds_list_add(tentacles, _tent);
	
	// Update telegraph position to follow the player
	telegraphX = obj_player.x;
	telegraphY = obj_player.y;	
	
	// Adjust telegraph Y position based on floor distance
	var _height = scr_get_obj_floor_distance(telegraphX, telegraphY);
	telegraphY += (_height - sprite_get_height(spr_telegraph));	
	
	// Reset telegraph cooldown
	telegraph_timer = telegraph_timer_base;
}
