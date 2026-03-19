function src_jumping_idle_movement() {
    
	return function () {

	    // Handle delay between jumps to avoid continuous hopping
	    if (pause_timer > 0) {
	        pause_timer--;
	        return;
	    }

	    // Check if the enemy is currently on the ground
	    var on_ground = (place_meeting(x, y, obj_wall));

	    if (on_ground) {

	        // Define horizontal movement boundaries relative to the spawn position
	        var min_x = xstart - maxRandomMovement;
			var max_x = xstart + maxRandomMovement;

			// Enforce boundary limits before choosing movement direction
			if (x <= min_x)
			    jump_state = JumpState.LEFT_MIDDLE;

			if (x >= max_x)
			    jump_state = JumpState.RIGHT_MIDDLE;

			// Determine horizontal movement based on the current jump state
			switch (jump_state) {
			    case JumpState.LEFT:
			        hsp = -jump_speed;
			    break;

			    case JumpState.LEFT_MIDDLE:
			        hsp = jump_speed;
			    break;

			    case JumpState.RIGHT:
			        hsp = jump_speed;
			    break;

			    case JumpState.RIGHT_MIDDLE:
			        hsp = -jump_speed;
			    break;
			}
		
	        // Initiate jump by applying upward vertical speed
	        vsp = -jump_force;
			currentMovement = EnemyState.JUMPING;
	    }
	    else {
	        // Airborne phase: apply gravity and resolve vertical collisions
			if (place_meeting(x, y + vsp, obj_wall)) {
			
				// Snap the instance to the nearest valid position before collision
				while (!place_meeting(x, y + sign(vsp), obj_wall)) {
				    y += sign(vsp);
				}
			
				vsp = 0; // Stop vertical movement on collision
			} else {
				vsp += grv; // Apply gravity over time
			}
	    }

	    // Apply horizontal and vertical movement
	    x += hsp;
	    y += vsp;

	    // Detect landing and trigger jump cooldown
	    if (vsp > 0 && place_meeting(x, y + vsp, obj_wall)) {
	        pause_timer = jump_pause;
			currentMovement = EnemyState.ONGROUND;
	    }
	}

}