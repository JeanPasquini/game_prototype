// Inherit the parent event
event_inherited();

obj_followed = noone;

alarm[0] = 1000;
alarm[1] = alarm[0] + 30;

//pt_effect_psicotopus_sword
_ps = part_system_create();
part_system_draw_order(_ps, true);

//Emitter
_ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_square);
part_type_size(_ptype1, 0.1, 0.1, 0, 0.1);
part_type_scale(_ptype1, 0.5, 0.5);
part_type_speed(_ptype1, 0, 0, 0, 0);
part_type_direction(_ptype1, 0, 0, 0, 0);
part_type_gravity(_ptype1, 0, 0);
part_type_orientation(_ptype1, 0, 0, 0, 100, false);
part_type_colour3(_ptype1, $6A3CD5, $6A3CD5, $6A3CD5);
part_type_alpha3(_ptype1, 1, 1, 1);
part_type_blend(_ptype1, true);
part_type_life(_ptype1, 10, 50);

_pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -26, 26, -6.5, 6.5, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit1, _ptype1, 1);

part_system_position(_ps, room_width/2, room_height/2);
