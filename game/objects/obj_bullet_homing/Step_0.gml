// Inherit the parent event
event_inherited();

if (follow_time > 0) {
    follow_time--;
    direction = point_direction(x, y, obj_player.x, obj_player.y);
} 
// depois segue reto
x += lengthdir_x(velocity, direction);
y += lengthdir_y(velocity, direction);
