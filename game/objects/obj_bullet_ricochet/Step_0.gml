// Inherit the parent event
event_inherited();

// prever a próxima posição
var nx = x + lengthdir_x(velocity, direction);
var ny = y + lengthdir_y(velocity, direction) + sign(displacement)*2;

// se vai bater, reduzir bounce
if (place_meeting(nx, ny, obj_wall)) {
    bounces--;
    if (bounces <= 0) {
        instance_destroy();
        exit;
    }
}

// agora mover
x = nx;
y = ny;

// agora ricochetear
move_bounce_solid(true);
