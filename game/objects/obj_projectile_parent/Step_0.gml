// Destroys if collided
if (
    place_meeting(x, y, obj_wall) ||
    is_outside_room(id)
) {
    instance_destroy();
}

