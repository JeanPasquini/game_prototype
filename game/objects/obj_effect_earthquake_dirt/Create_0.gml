// Inherit the parent event
event_inherited();

obj_followed = id;
active = false;

//pt_earthquake_dirt
_ps = part_system_create();
part_system_draw_order(_ps, true);
part_system_layer(_ps, layer);

//Emitter
_ptype1 = part_type_create();
part_type_sprite(_ptype1, spr_effect_dirt, false, false, true)
part_type_size(_ptype1, 0.1, 0.5, 0, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 0, 0, 0, 0);
part_type_direction(_ptype1, 0, 0, 0, 0);
part_type_gravity(_ptype1, 0.02, 271);
part_type_orientation(_ptype1, 100, 160, 0, 0, false);
part_type_colour3(_ptype1, $999999, $B2B2B2, $999999);
part_type_alpha3(_ptype1, 1, 1, 0);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 40, 120);

_pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -8.488369, 8.488369, -8, 8, ps_shape_rectangle, ps_distr_invgaussian);
part_emitter_stream(_ps, _pemit1, _ptype1, 1);

part_system_position(_ps, room_width/2, room_height/2);
