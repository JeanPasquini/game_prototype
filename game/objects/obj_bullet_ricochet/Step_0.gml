// Inherit the parent event
event_inherited();

x += lengthdir_x(velocity, direction);
y += lengthdir_y(velocity, direction);

// ricochete simples
if (position_meeting(x, y, obj_wall)) {
    direction = 360 - direction; // inverte verticalmente
    bounces--;
    if (bounces <= 0) instance_destroy();
}