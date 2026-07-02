event_inherited();
if (count_ricochet >= count_ricochet_max) {
    instance_destroy();
}
if (place_meeting(x + lengthdir_x(speed, direction),
                  y + lengthdir_y(speed, direction),
                  obj_wall))
{
    count_ricochet++;
    move_bounce_solid(0);
}
image_angle = direction;