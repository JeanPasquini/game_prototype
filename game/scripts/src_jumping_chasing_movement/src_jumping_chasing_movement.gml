function src_jumping_chasing_movement(){

	return function () {

	    // Handle jump cooldown and prevent movement during charging attack state
	    if (pause_timer > 0 || currentState == EnemyState.CHARGING_ATTACK) {
	        pause_timer--;
	        return;
	    }

	    // Check if the enemy is currently on the ground
	    var on_ground = (place_meeting(x, y, obj_wall));

	    if (on_ground) {
			
			// Get horizontal distance to the player
			var target = obj_player.x;
			var dist = target - x;

			// Define a "deadzone" where the enemy should not attempt to jump
			var deadzone = maxRandomMovement;

			// Determine desired movement direction toward the player
			var dir = sign(dist);

			// Estimate total air time based on jump physics
			var air_time = (jump_force * 2) / grv;

			// Predict horizontal displacement during the jump
			var projected_move = dir * jump_speed * air_time;

			// Predict future X position after completing the jump
			var projected_x = x + projected_move;

			// Calculate future distance to the player after the jump
			var future_dist = target - projected_x;

			// Decide whether to perform the jump based on current and predicted distances
			if (abs(dist) > deadzone) {
			
			    // Only jump if it will not overshoot the target excessively
			    if (abs(future_dist) >= deadzone) {
			        hsp = dir * jump_speed;
			    }
			    else {
			        hsp = 0; // Cancel movement to avoid overshooting
			    }
			}
			else {
			    hsp = 0; // Stay idle if already within the deadzone
			}
		
			// Initiate jump only if horizontal movement was approved
			if (hsp != 0) {
	            vsp = -jump_force;
				currentMovement = EnemyState.JUMPING;
			}
	    }
	    else {
	        // Airborne phase: apply gravity and resolve vertical collisions
			if (place_meeting(x, y + vsp, obj_wall)) {
			
				// Snap to the nearest valid position before collision
				while (!place_meeting(x, y + sign(vsp), obj_wall)) {
				    y += sign(vsp);
				}
			
				vsp = 0;
			} else {
				vsp += grv;
			}
	    }

	    // Apply movement
	    x += hsp;
	    y += vsp;

	    // Detect landing and trigger jump cooldown
	    if (vsp > 0 && place_meeting(x, y + vsp, obj_wall)) {
	        pause_timer = jump_pause;
			currentMovement = EnemyState.ONGROUND;
	    }
	}

}