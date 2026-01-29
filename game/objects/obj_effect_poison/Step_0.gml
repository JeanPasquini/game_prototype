if (instance_exists(target)) {
    x = target.x;
    y = target.y;
    part_system_position(_ps, x, y);
} else {
    instance_destroy(); // alvo morreu
}
