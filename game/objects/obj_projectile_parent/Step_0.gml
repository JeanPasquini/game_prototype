// Moves towards the target
x += dir * velocity;

// Update Y based on quadratic function
y = a * sqr(x - mediumPoint) + maxHeight;

image_angle++;

// Destroys if collided
if (
    place_meeting(x, y, obj_player) ||
    place_meeting(x, y, obj_wall) ||
    is_outside_room(id)
) {
    instance_destroy();
}