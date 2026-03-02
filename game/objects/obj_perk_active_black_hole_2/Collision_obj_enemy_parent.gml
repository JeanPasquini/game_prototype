var cx = x;
var cy = y;

var dir  = point_direction(other.x, other.y, cx, cy);
var dist = point_distance(other.x, other.y, cx, cy);

var pull_force = clamp(pull_force_max - dist / 40, 0.1, pull_force_max);

other.x += lengthdir_x(pull_force, dir);
other.y += lengthdir_y(pull_force, dir);
