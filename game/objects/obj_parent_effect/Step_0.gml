if (!instance_exists(obj_followed)) {
    instance_destroy();
    exit;
}

x = obj_followed.x;
y = obj_followed.y;
part_system_position(_ps, x + x_add, y + y_add);
