/// @function scr_scale_animation
/// @description Handles the scale-in and scale-out animation of the tentacle using smooth interpolation
/// @param {bool} [reverse=false] If true, animates the tentacle shrinking to 0 and destroys the instance when complete
/// 
/// @requires scale_target {real} Target scale value (typically 1.0)
/// @requires scale_current {real} Current scale value (starts at 0.0)
/// @requires grow_smoothness {real} Interpolation speed factor (e.g., 0.05)
/// @requires image_yscale {real} Built-in GML property for vertical scaling
/// 
/// @note When reverse is true, the shrinking animation is 5x faster than the growing animation
/// @note The instance is automatically destroyed when the reverse animation completes
/// @note Uses a 0.01 threshold for snapping to the target value to avoid floating-point precision issues
function scr_scale_animation(reverse = false) {
	// Sets the default values for the grow animation
	var _grow = grow_smoothness;
	var _scale_targ = scale_target;	
	
	if (reverse) {
		// When reversing, the tentacle shrinks back to zero scale
		_scale_targ = 0.0;		
		// Speed up the shrinking animation by 5x
		_grow *= 5;
	}
	
	// Smoothly interpolate the current scale towards the target scale
	scale_current = lerp(scale_current, _scale_targ, _grow);
	image_yscale = scale_current;
	
	// Extra smoothing when the scale is very close to the target
	// Snaps to target to avoid floating-point precision issues
	if (abs(scale_current - _scale_targ) < 0.01) {
	    scale_current = _scale_targ;
		
		// Once fully shrunk, safely destroy the instance
		if (reverse) {
			instance_destroy();
		}
	}
}