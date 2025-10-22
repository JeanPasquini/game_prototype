persistent = true;



particlesystem = part_system_create();

global._ptype1 = part_type_create();
part_type_shape(global._ptype1, pt_shape_square);
part_type_size(global._ptype1, 0.05, 0.05, 0, 0);
part_type_scale(global._ptype1, 2, 2);
part_type_speed(global._ptype1, 0, 0, 0, 0.1);
part_type_direction(global._ptype1, 270, 0, 0, 100);
part_type_gravity(global._ptype1, 0.05, 270); 
part_type_orientation(global._ptype1, 0, 0, 0, 0, false);
part_type_colour3(global._ptype1, $6F4B43, $4F2E2B, $84594E);
part_type_alpha3(global._ptype1, 1, 1, 1);
part_type_blend(global._ptype1, false);
part_type_life(global._ptype1, 15, 15);


// Cria o emitter
emitter = part_emitter_create(particlesystem);
