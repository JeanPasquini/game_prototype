telegraph = noone;
alarm[0] = obj_tentacle_telegraph.telegraph_timer_base;

 _ps = part_system_create();
part_system_draw_order(_ps, true);

//Emitter
_ptype1 = part_type_create();
part_type_sprite(_ptype1, spr_psicotopus_bubble, false, true, false)
part_type_size(_ptype1, 1, 2, 0, 0);
part_type_scale(_ptype1, 0.25, 0.25);
part_type_speed(_ptype1, 1, 2, 0, 0);
part_type_direction(_ptype1, 80, 100, 0, 0);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptype1, 1, 1, 1);
part_type_blend(_ptype1, true);
part_type_life(_ptype1, 30, 60);

 _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -38, 38, -1.5, 1.5, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit1, _ptype1, -4);