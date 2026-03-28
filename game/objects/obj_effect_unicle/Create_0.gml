persistent = true;

global.PS = part_system_create();
var layer_id = layer_get_id("drop");
part_system_layer(global.PS, layer_id);
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

//FALL SMOKE

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

//DASH SMOKE

global.PT_DASH_SMOKE = part_type_create();
part_type_sprite(global.PT_DASH_SMOKE, spr_player_effect_dash_smoke, true, true, false)
part_type_size(global.PT_DASH_SMOKE, 1, 1, 0, 0);
part_type_scale(global.PT_DASH_SMOKE, 1, 1);
part_type_speed(global.PT_DASH_SMOKE, 0, 0, 0, 0);
part_type_direction(global.PT_DASH_SMOKE, 80, 100, 0, 0);
part_type_gravity(global.PT_DASH_SMOKE, 0, 270);
part_type_orientation(global.PT_DASH_SMOKE, 180, 0, 0, 0, false);
part_type_colour3(global.PT_DASH_SMOKE, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(global.PT_DASH_SMOKE, 0.5, 0.5, 0);
part_type_blend(global.PT_DASH_SMOKE, false);
part_type_life(global.PT_DASH_SMOKE, 15, 15);

//DASH SMOKE 2

global.PT_DASH_SMOKE2 = part_type_create();
part_type_sprite(global.PT_DASH_SMOKE2, spr_player_effect_dash, false, false, false)
part_type_size(global.PT_DASH_SMOKE2, 1, 1, 0, 0);
part_type_scale(global.PT_DASH_SMOKE2, 1, 1);
part_type_speed(global.PT_DASH_SMOKE2, 0, 0, 0, 0);
part_type_direction(global.PT_DASH_SMOKE2, 0, 0, 0, 0);
part_type_gravity(global.PT_DASH_SMOKE2, 0, 270);
part_type_orientation(global.PT_DASH_SMOKE2, 0, 0, 0, 0, false);
part_type_colour3(global.PT_DASH_SMOKE2, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(global.PT_DASH_SMOKE2, 0.2, 0.1, 0);
part_type_blend(global.PT_DASH_SMOKE2, false);
part_type_life(global.PT_DASH_SMOKE2, 30, 30);

// PSICOTOPUS BUBBLE FLOATING

global.PT_PSICOTOPUS_BUBBLE_FLOATING = part_type_create();
part_type_sprite(global.PT_PSICOTOPUS_BUBBLE_FLOATING, spr_psicotopus_bubble, false, true, false)
part_type_size(global.PT_PSICOTOPUS_BUBBLE_FLOATING, 1, 2, 0, 0);
part_type_scale(global.PT_PSICOTOPUS_BUBBLE_FLOATING, 0.25, 0.25);
part_type_speed(global.PT_PSICOTOPUS_BUBBLE_FLOATING, 0.5, 0.75, 0, 0);
part_type_direction(global.PT_PSICOTOPUS_BUBBLE_FLOATING, 0, 360, 0, 1);
part_type_gravity(global.PT_PSICOTOPUS_BUBBLE_FLOATING, 0, 270);
part_type_orientation(global.PT_PSICOTOPUS_BUBBLE_FLOATING, 0, 0, 0, 0, false);
part_type_colour3(global.PT_PSICOTOPUS_BUBBLE_FLOATING, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(global.PT_PSICOTOPUS_BUBBLE_FLOATING, 1, 1, 1);
part_type_blend(global.PT_PSICOTOPUS_BUBBLE_FLOATING, true);
part_type_life(global.PT_PSICOTOPUS_BUBBLE_FLOATING, 30, 60);



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

scr_fx_dash_smoke = function(_x, _y, _dir) {
	if(_dir < 0){
		_dir = 0;	
	}
	else{
		_dir = 180;	
	}
    part_type_orientation(global.PT_DASH_SMOKE, _dir, _dir, 0, 0, 0); // se quiser inverter a direção das partículas
	part_particles_create(global.PS, _x, _y, global.PT_DASH_SMOKE, 1);
}

scr_fx_dash_smoke2 = function(_x, _y, _dir) {
	part_type_scale(global.PT_DASH_SMOKE2, _dir, 1);
	part_particles_create(global.PS, _x, _y, global.PT_DASH_SMOKE2, 1);
}

scr_fx_psicotopus_bubble_floating = function(_x, _y, _dir) {
	part_type_direction(global.PT_PSICOTOPUS_BUBBLE_FLOATING, _dir - 45 , _dir + 45, 0, 1);
    part_particles_create(global.PS, _x, _y, global.PT_PSICOTOPUS_BUBBLE_FLOATING, 3);
}