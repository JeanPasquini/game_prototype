if (alarm[0] <= 0) {
    instance_create_layer(x, y, "Instances", obj_trap_arrow_projectile);

    // Reset da animação
    image_index = 0;
    image_speed = 1;

    alarm[0] = 100; // reinicia o ciclo
}

if (image_index >= image_number - 1) {
    image_speed = 0;
}
