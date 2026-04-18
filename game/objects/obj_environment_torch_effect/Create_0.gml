// Inherit the parent event
event_inherited();
obj_followed = noone;
x_add = 0;
y_add = -5;

//pt_environment_torch
_ps = part_system_create();
part_system_layer(_ps, "drop");
part_system_draw_order(_ps, true);

//Emitter
_ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_square);
part_type_size(_ptype1, 0.1, 0.1, 0, 0.02);
part_type_scale(_ptype1, 0.2, 0.2);
part_type_speed(_ptype1, 0.5, 0.2, 0, 0);
part_type_direction(_ptype1, 90, 90, 0, 10);
part_type_gravity(_ptype1, 0, 0);
part_type_orientation(_ptype1, 0, 100, 100, 8, false);
part_type_colour3(_ptype1, $B2F3FF, $4CCFFF, $4C88FF);
part_type_alpha3(_ptype1, 1, 1, 1);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 20, 30);

_pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -1, 1, 0, 0, ps_shape_rectangle, ps_distr_invgaussian);
part_emitter_stream(_ps, _pemit1, _ptype1, 1);

part_system_position(_ps, room_width/2, room_height/2);

