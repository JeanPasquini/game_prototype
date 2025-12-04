persistent = true;

// --- Define profundidade aleatória ---
particlesystem = part_system_create();

global._ptype1 = part_type_create();
part_type_sprite(global._ptype1, spr_dirt, true, false, false)
part_type_size(global._ptype1, 0.03, 0.06, 0, 0);
part_type_scale(global._ptype1, 3, 3);
part_type_speed(global._ptype1, 0, 0, 0, 1);
part_type_direction(global._ptype1, 0, 360, 5, 5);
part_type_gravity(global._ptype1, 0, 0);
part_type_orientation(global._ptype1, 0, 360, 0, 0, true);
part_type_colour3(global._ptype1, $CCCCCC, $999999, $CCCCCC);
part_type_alpha3(global._ptype1, 1, 1, 1);
part_type_blend(global._ptype1, false);
part_type_life(global._ptype1, 8, 30);


// Cria o emitter
emitter = part_emitter_create(particlesystem);

