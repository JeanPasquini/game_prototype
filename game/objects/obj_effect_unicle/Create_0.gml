persistent = true;

global.PS = part_system_create();
//part_system_depth(global.PS, -1000);

// =======================
// SMOKE
// =======================

global.PT_SMOKE = part_type_create();

part_type_sprite(global.PT_SMOKE, spr_dirt2, true, true, true)
part_type_size(global.PT_SMOKE, 1, 1, 0, 0);
part_type_scale(global.PT_SMOKE, 1, 1);
part_type_speed(global.PT_SMOKE, 0, 1, 0, 0);
part_type_direction(global.PT_SMOKE, 90, 100, 0, 0);
part_type_gravity(global.PT_SMOKE, 0, 270);
part_type_orientation(global.PT_SMOKE, 0, 0, 0, 0, false);
part_type_colour3(global.PT_SMOKE, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(global.PT_SMOKE, 1, 1, 1);
part_type_blend(global.PT_SMOKE, false);
part_type_life(global.PT_SMOKE, 20, 30);

//HIT IMPACT

global.PT_HIT_IMPACT = part_type_create();
part_type_sprite(global.PT_HIT_IMPACT, spr_hit_impact, true, true, false)
part_type_size(global.PT_HIT_IMPACT, 1, 1, 0, 0);
part_type_scale(global.PT_HIT_IMPACT, 1, 1);
part_type_speed(global.PT_HIT_IMPACT, 0, 0, 0, 0);
part_type_direction(global.PT_HIT_IMPACT, 0, 360, 1, 0);
part_type_gravity(global.PT_HIT_IMPACT, 0, 0);
part_type_orientation(global.PT_HIT_IMPACT, 0, 360, 0, 0, false);
part_type_colour3(global.PT_HIT_IMPACT, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(global.PT_HIT_IMPACT, 1, 1, 1);
part_type_blend(global.PT_HIT_IMPACT, false);
part_type_life(global.PT_HIT_IMPACT, 10, 10);

//HIT IMPACT

global.PT_FALL_SMOKE = part_type_create();
part_type_sprite(global.PT_FALL_SMOKE, spr_player_effect_fall_smoke, true, true, false)
part_type_size(global.PT_FALL_SMOKE, 1, 1, 0, 0);
part_type_scale(global.PT_FALL_SMOKE, 1, 1);
part_type_speed(global.PT_FALL_SMOKE, 0, 0, 0, 0);
part_type_direction(global.PT_FALL_SMOKE, 80, 100, 0, 0);
part_type_gravity(global.PT_FALL_SMOKE, 0, 270);
part_type_orientation(global.PT_FALL_SMOKE, 0, 0, 0, 0, false);
part_type_colour3(global.PT_FALL_SMOKE, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(global.PT_FALL_SMOKE, 1, 1, 1);
part_type_blend(global.PT_FALL_SMOKE, false);
part_type_life(global.PT_FALL_SMOKE, 20, 20);


// =======================
// FUNÇÃO
// =======================

scr_fx_run_smoke = function(_x, _y) {
    part_particles_create(global.PS, _x, _y, global.PT_SMOKE, 1);
}

scr_fx_hit_impact = function(_x, _y) {
    part_particles_create(global.PS, _x, _y, global.PT_HIT_IMPACT, 1);
}

scr_fx_fall_smoke = function(_x, _y) {
    part_particles_create(global.PS, _x, _y, global.PT_FALL_SMOKE, 1);
}