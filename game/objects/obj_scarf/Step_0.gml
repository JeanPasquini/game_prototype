if (instance_exists(obj_player)) {

    var offset_x = 5;
    var offset_y = -15; 

    if (obj_player.image_xscale < 0) {
        x = obj_player.x + offset_x;
    } else {
        x = obj_player.x - offset_x;
    }

    y = obj_player.y + offset_y;

    part_emitter_region(particlesystem, emitter, x, x, y, y, 0, 0);

    part_emitter_burst(particlesystem, emitter, global._ptype1, 1 + irandom(1));
}
