if (alarm[0] <= 0) {
	var arrow = instance_create_layer(x, y, "Instances", obj_trap_arrow_projectile);
	arrow.direction = image_angle + 270;
	arrow.image_angle = arrow.direction - 270;

	audio_play_sound_on(emitter, sde_trap_arrow, false, 0);


    // Reset da animação
    image_index = 0;
    image_speed = 1;

    alarm[0] = 100; // reinicia o ciclo
}

if (image_index >= image_number - 1) {
    image_speed = 0;
}
