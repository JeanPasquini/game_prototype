// Check whether this tentacle is flagged for destruction

scr_audio_emitter(x, y, emitterAudio);

alpha = lerp(alpha, 0, 0.1);

if (is_destroyed) {
	// Play the scale animation in reverse to visually retract the tentacle
	is_invencible = true;
	scr_scale_animation(true);
	return;
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
	var centro_x = 880;
	var centro_y = room_height / 2 - 50;

	x = center_x + lengthdir_x(0, angle_rotation + 180);
	y = center_y + lengthdir_y(0, angle_rotation + 180);

    image_angle = angle_offset + angle_rotation + 90;

    if (scale_current >= scale_target) {
        angle_rotation += movementSpeed;
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