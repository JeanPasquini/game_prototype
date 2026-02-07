function scr_destroy_tentacles_ds(_tentacles){
	// Handles the cleanup and destruction of all tentacles
	for (var i = 0; i < ds_list_size(_tentacles); i++) {
	    var tentacle = _tentacles[| i];
    
	    // Safely mark the tentacle for destruction if it still exists
	    if (instance_exists(tentacle)) {
	        tentacle.is_destroyed = true;
	    }
	}

	// Clear and destroy the tentacle list to free memory
	ds_list_clear(_tentacles);
	ds_list_destroy(_tentacles);
	return -1;
}