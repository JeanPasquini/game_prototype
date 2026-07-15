// Inherit the parent event
event_inherited();

obj_followed = id;
active = false;

//pt_earthquake_stone
_ps = part_system_create();
part_system_draw_order(_ps, true);
part_system_layer(_ps, layer);

//Emitter
_ptype1 = part_type_create();
part_type_sprite(_ptype1, spr_effect_stone, false, true, true)
part_type_size(_ptype1, 0.5, 1, 0, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 0, 3, 0, 0);
part_type_direction(_ptype1, -90, -90, 0, 0);
part_type_gravity(_ptype1, 0.05, 270);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptype1, 1, 1, 0);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 400, 400);
_ptype2 = part_type_create();
part_type_sprite(_ptype2, spr_effect_dirt, false, false, true)
part_type_size(_ptype2, 0.1, 0.5, 0, 0);
part_type_scale(_ptype2, 1, 1);
part_type_speed(_ptype2, 0, 0, 0, 0);
part_type_direction(_ptype2, 0, 0, 0, 0);
part_type_gravity(_ptype2, 0, 0);
part_type_orientation(_ptype2, 100, 160, 0, 0, false);
part_type_colour3(_ptype2, $999999, $B2B2B2, $999999);
part_type_alpha3(_ptype2, 0.38, 0.322, 0);
part_type_blend(_ptype2, false);
part_type_life(_ptype2, 40, 80);
part_type_step(_ptype1, 1, _ptype2);

_pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -8, 8, -8, 8, ps_shape_rectangle, ps_distr_invgaussian);
part_emitter_stream(_ps, _pemit1, _ptype1, 1);
part_emitter_delay(_ps, _pemit1, 0, 2, time_source_units_seconds)
part_emitter_interval(_ps, _pemit1, 1, 4, time_source_units_seconds);

