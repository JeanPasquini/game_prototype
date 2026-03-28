// Check whether this tentacle is flagged for destruction
if (is_destroyed) {
	// Play the scale animation in reverse to visually retract the tentacle
	scr_scale_animation(true);
} else {
	// Play the normal scale animation (grow or remain visible)
	//scr_scale_animation();
}

// Execute behavior based on the current tentacle type
switch (type) {
    case TentacleType.ORBITAL:
        _orbitalRotation();
        break;
		
    case TentacleType.ALIVE:
        _tentacleAttack();
        break;
		
    default:
        break;
}


function _orbitalRotation() {
	// Calculate the room center as the rotation pivot
	var centro_x = room_width / 2;
	var centro_y = room_height / 2;
	
	// Position the tentacle using polar coordinates around the room center
	x = centro_x + lengthdir_x(radius, angle_offset + angle_rotation);
	y = centro_y + lengthdir_y(radius, angle_offset + angle_rotation);

	// Align the sprite tangentially to the orbit (perpendicular to the radius)
	image_angle = angle_offset + angle_rotation + 90; 

	// Start rotating only after the scale animation has fully reached its target size
	if (scale_current >= scale_target) {
		angle_rotation += movementSpeed; // Advance orbital rotation
	}
}


function _tentacleAttack() {
	if(sprite_index == spr_psicotopus_tentacle_spawning) return;
	if (!is_attacking) {
		if (point_distance(x, y, obj_player.x, obj_player.y) <= attack_range) {
			is_attacking = true;
			image_index = 0;
			sprite_index = spr_psicotopus_tentacle_attacking;
			// Decide attack direction based on player's horizontal position
			if (obj_player.x > x) {
				image_xscale = -1;
				player_angle_dir = -90;
			} else {
				image_xscale = 1;
				player_angle_dir = 90;
			}
		} else {
			sprite_index = spr_psicotopus_tentacle_idle;
			return; // Abort if the player is out of range
		}
	} else {
		// End the attack once the tentacle returns to its neutral angle
		//if (round(image_angle) == 0) {
		//	is_attacking = false;
		//	//sprite_index = spr_psicotopus_tentacle_idle;
		//}
	}
	
	
	
    // Smoothly interpolate the tentacle angle toward the target direction
    //image_angle = lerp(image_angle, player_angle_dir, 0.03);
	
	// Reset target angle after reaching the maximum swing
	if (round(image_angle) >= 90 || round(image_angle) <= -90) {
		player_angle_dir = 0;
	}
}


if(sprite_index == spr_psicotopus_tentacle_spawning){
	image_index = 0;
	sprite_index = spr_psicotopus_tentacle_idle;
}
if(sprite_index == spr_psicotopus_tentacle_attacking){
	image_index = 0;
	is_attacking = false;
}