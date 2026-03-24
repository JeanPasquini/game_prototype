// Inherit the parent event
event_inherited();

// Moves towards the target
x += dir * velocity;

// Update Y based on quadratic function
y = a * sqr(x - mediumPoint) + maxHeight;

image_angle++;