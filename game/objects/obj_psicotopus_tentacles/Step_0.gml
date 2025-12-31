// Check whether this tentacle is marked to be destroyed
if (is_destroyed) {
	// Play the scale animation in reverse (shrinking)
	_scale_animation(true);
} else {
	// Play the normal scale animation (growing / staying visible)
	_scale_animation();
}

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

// Handles the scale-in and scale-out animation of the tentacle
function _scale_animation(reverse = false) {
	// Default target scale is full size (visible)
	scale_target = 1.0;
	var _grow = grow_smoothness;
	
	if (reverse) {
		// When reversing, the tentacle shrinks back to zero scale
		scale_target = 0.0;
		
		// Speed up the shrinking animation
		_grow *= 5;
	} 
	
	// Smoothly interpolate the current scale towards the target scale
	scale_current = lerp(scale_current, scale_target, _grow);
	image_yscale = scale_current;

	// Extra smoothing when the scale is very close to the target
	if (abs(scale_current - scale_target) < 0.01) {
	    scale_current = scale_target;
		
		// Once fully shrunk, safely destroy the instance
		if (reverse) {
			instance_destroy();
		}
	}
}
