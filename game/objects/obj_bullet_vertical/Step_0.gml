// Inherit the parent event
event_inherited();

var dx = target_x - x;
var dy = target_y - y;
var dir = point_direction(x, y, target_x, target_y)

direction = lerp(direction, dir, curvature);
x += lengthdir_x(velocity, direction);
y += lengthdir_y(velocity, direction);