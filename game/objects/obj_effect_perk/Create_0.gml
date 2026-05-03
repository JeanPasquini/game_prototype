// Inherit the parent event
event_inherited();

obj_followed = obj_player;

alarm[0] = 30;
alarm[1] = alarm[0] + 30;

//pt_perk_effect
 _ps = part_system_create();
part_system_draw_order(_ps, true);

//Emitter
 _ptype1 = part_type_create();
part_type_sprite(_ptype1, spr_perk_effect, false, false, true)
part_type_size(_ptype1, 0.5, 0.8, 0, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 0.2, 0.6, 0, 0);
part_type_direction(_ptype1, 90, 0, 0, 0);
part_type_gravity(_ptype1, 0, 0);
part_type_orientation(_ptype1, 0, 360, 0.9, 2, false);
part_type_colour3(_ptype1, $FFFFFF, $E1FFD1, $FFD1E5);
part_type_alpha3(_ptype1, 1, 1, 1);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 8, 11);

 _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -17, 17, -25, 25, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit1, _ptype1, 1);



