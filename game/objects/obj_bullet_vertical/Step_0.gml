// Inherit and execute the parent Step event logic
event_inherited();

// Check if the bullet is still in its upward movement phase
if (upward > 0) {
	/*
	// Faster upward movement variant (currently disabled)
	// Moves the bullet upward by a variable step amount
	var step = min(velocity, upward);
    upward -= step;	
	y -= step;
	*/
	
	// Default upward movement: move 1 pixel per step
	upward--;
	y--;
			
	// Once the upward phase ends, retarget the bullet towards the player
	if (upward <= 0) {
		// Calculate direction from the bullet to the player
		dir = point_direction(x, y, obj_player.x, obj_player.y);
		
		// Apply the new direction so the bullet starts homing
		direction = dir;	
	}
	
	// Skip the normal movement while going upward
	return;
} 

// Normal movement after the upward phase ends
x += lengthdir_x(velocity, direction);
y += lengthdir_y(velocity, direction);
