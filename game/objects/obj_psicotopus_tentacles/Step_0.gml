// Check whether this tentacle is marked to be destroyed
if (is_destroyed) {
	// Play the scale animation in reverse (shrinking)
	scr_scale_animation(true);
} else {
	// Play the normal scale animation (growing / staying visible)
	scr_scale_animation();
}

switch (type) {
	case TentacleType.ORBITAL:
		_orbitalRotation();
	default:
		break;
}


function _orbitalRotation() {
	var centro_x = room_width / 2;
	var centro_y = room_height / 2;
	// Position the tentacle using polar coordinates relative to the room center
	// radius defines the distance from the center
	// angle_offset + angle_rotation defines the current angular position
	x = centro_x + lengthdir_x(radius, angle_offset + angle_rotation);
	y = centro_y + lengthdir_y(radius, angle_offset + angle_rotation);

	// Tangent alignment:
	// To make the tentacle perpendicular to the radius, add 90 degrees to the angle
	image_angle = angle_offset + angle_rotation + 90; 

	// Only start rotating once the scaling animation has reached its target size
	if (scale_current >= scale_target) {
		// Increment the rotation angle to spin the tentacle around the center
		angle_rotation += movementSpeed;
	}
}
