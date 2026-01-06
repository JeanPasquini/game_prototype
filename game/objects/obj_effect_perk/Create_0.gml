alarm[0] = 30;
alarm[1] = alarm[0] + 30;

ps = part_system_create();
part_system_draw_order(ps, true);
part_system_position(ps, x, y);

pt = part_type_create();
part_type_sprite(pt, spr_perk_effect, false, false, false);
part_type_size(pt, 0.05, 0.1, 0, 0);
part_type_scale(pt, 3, 3);
part_type_speed(pt, 0.2, 0.6, 0, 0);
part_type_direction(pt, 90, 0, 0, 0);
part_type_gravity(pt, 0, 0);
part_type_life(pt, 8, 11);
part_type_alpha3(pt, 1, 0.5, 0);
part_type_blend(pt, false);

em = part_emitter_create(ps);
part_emitter_region(ps, em, -17, 17, -25, 25, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(ps, em, pt, 2);
