//exit;

cols = room_width div size;
rows = room_height div size;

level = 0;

var _layer = noone;
var _mapa  = noone;

if (layer_exists("tl_level")) {
    _layer = layer_get_id("tl_level");
    _mapa  = layer_tilemap_get_id(_layer);
	
	
}
else {
    //show_debug_message("Layer tl_level NÃO existe nesta room");
	return;
}

for (var i = 0; i < rows; i++) {
    for (var j = 0; j < cols; j++) {
        level[j][i] = tilemap_get(_mapa, j, i);
    }
}

var _scale       = 2;
var scale_button = 2;
var margem       = 16;
var pad          = 64;
var safe         = 24;

var spr_w = sprite_get_width(spr_minimap)  * _scale;
var spr_h = sprite_get_height(spr_minimap) * _scale;

var screen_w = display_get_gui_width();
var screen_h = display_get_gui_height();

var cx = screen_w - spr_w / 2 - margem;
var cy = spr_h / 2 + margem;

var spr_btn_w = sprite_get_width(spr_button_open_map) * scale_button;
var spr_btn_h = sprite_get_height(spr_button_open_map) * scale_button;

var cx_button = screen_w - spr_btn_w - margem;
var cy_button = margem;

var alpha_map = 0;
switch (minimap_state) {
    case 0: alpha_map = 0;   break;
    case 1: alpha_map = 1;   break;
    case 2: alpha_map = 0.5; break;
    case 3: alpha_map = 1;   break;
}

if (alpha_map > 0) {

    // =================================================
    // STATE 3
    // =================================================
    if (minimap_state == 3) {

        var full_scale = 0.4;
        var tile_size = size * full_scale;

        var map_w = cols * tile_size;
        var map_h = rows * tile_size;

        var map_x = (screen_w - map_w) * 0.5;
        var map_y = (screen_h - map_h) * 0.5;
		
		var spr_scale_x = map_w / sprite_get_width(spr_minimap);
	    var spr_scale_y = map_h / sprite_get_height(spr_minimap);

	    draw_set_alpha(1);
	    draw_set_color(c_white);

	    //draw_sprite_ext(
	    //    spr_minimap,
	    //    0,
	    //    map_x + map_w * 0.5,
	    //    map_y + map_h * 0.5,
	    //    _scale * 2,
	    //    _scale * 2,
	    //    0,
	    //    c_white,
	    //    1
	    //);

        draw_set_alpha(1);
        draw_set_color(c_white);

        for (var i = 0; i < rows; i++) {
            for (var j = 0; j < cols; j++) {

                if (level[j][i] != 0) {

                    var x1 = map_x + j * tile_size;
                    var y1 = map_y + i * tile_size;

                    draw_rectangle(
                        x1, y1,
                        x1 + tile_size,
                        y1 + tile_size,
                        false
                    );
                }
            }
        }
		
		draw_set_color(c_aqua);
		draw_set_alpha(1);

		var t = current_time / 300;

		with (obj_player) {

		    var px = map_x + (x * full_scale);
		    var py = map_y + (y * full_scale);

		    draw_set_alpha(1);
		    draw_circle(px, py, 3, false);
		    draw_circle(px, py, 2, true);

		    var pulse = 4 + sin(t) * 2;

		    draw_set_alpha(0.6);
		    draw_circle(px, py, pulse, false);
			
		    draw_set_alpha(0.2);
		    draw_circle(px, py, pulse + 2, true);
		}

		draw_set_alpha(1);
		draw_set_color(c_white);


        // ENEMIES
        draw_set_color(c_red);
        with (obj_enemy_parent) {
            draw_circle(
                map_x + (x * full_scale),
                map_y + (y * full_scale),
                4,
                false
            );
        }

        // DOORS
        draw_set_color(c_lime);
        with (obj_door) {
            draw_circle(
                map_x + (x * full_scale),
                map_y + (y * full_scale),
                4,
                false
            );
        }

        draw_set_alpha(1);
        draw_set_color(c_white);
    }

        else {

        draw_sprite_ext(
            spr_minimap, 0,
            cx, cy,
            _scale, _scale,
            0,
            c_white,
            alpha_map
        );

        var left   = cx - spr_w / 2 + pad + safe;
        var right  = cx + spr_w / 2 - pad - safe;
        var top    = cy - spr_h / 2 + pad + safe;
        var bottom = cy + spr_h / 2 - pad - safe;

        var tile_size = size * scale;
        var map_x = cx - (obj_player.x * scale);
        var map_y = cy - (obj_player.y * scale);

        // -----------------------------
        // TILES
        // -----------------------------
        for (var i = 0; i < rows; i++) {
            for (var j = 0; j < cols; j++) {

                if (level[j][i] != 0) {

                    var x1 = map_x + j * tile_size;
                    var y1 = map_y + i * tile_size;
                    var x2 = x1 + tile_size;
                    var y2 = y1 + tile_size;

                    var tx = (x1 + x2) * 0.5;
                    var ty = (y1 + y2) * 0.5;

                    var a = 1;

                    if (tx < left)   a *= clamp((tx - (left - pad))   / pad, 0, 1);
                    if (tx > right)  a *= clamp(((right + pad) - tx)  / pad, 0, 1);
                    if (ty < top)    a *= clamp((ty - (top - pad))    / pad, 0, 1);
                    if (ty > bottom) a *= clamp(((bottom + pad) - ty) / pad, 0, 1);

                    if (a > 0) {
                        draw_set_alpha(a);
                        draw_set_color(c_white);
                        draw_rectangle(x1, y1, x2, y2, false);
                    }
                }
            }
        }

        // -----------------------------
        // PLAYER
        // -----------------------------
		
		var t = current_time / 300;
		
        draw_set_alpha(1);
        draw_set_color(c_aqua);
        draw_circle(cx, cy, 16 * scale, false);
		
		draw_set_alpha(1);
		draw_circle(cx, cy, 3, false);
		draw_circle(cx, cy, 2, true);

		var pulse = 4 + sin(t) * 2;

		draw_set_alpha(0.6);
		draw_circle(cx, cy, pulse, false);

		draw_set_alpha(0.2);
		draw_circle(cx, cy, pulse + 2, true);

        var map_scale     = scale;
        var icon_scale    = 0.5;
        var map_x_local   = map_x;
        var map_y_local   = map_y;

        // -----------------------------
        // ENEMIES
        // -----------------------------
        draw_set_color(c_red);

        with (obj_enemy_parent) {

            var mini_x = map_x_local + (x * map_scale);
            var mini_y = map_y_local + (y * map_scale);

            var a = 1;

            if (mini_x < left)   a *= clamp((mini_x - (left - pad))   / pad, 0, 1);
            if (mini_x > right)  a *= clamp(((right + pad) - mini_x)  / pad, 0, 1);
            if (mini_y < top)    a *= clamp((mini_y - (top - pad))    / pad, 0, 1);
            if (mini_y > bottom) a *= clamp(((bottom + pad) - mini_y) / pad, 0, 1);

            if (a > 0) {
                draw_set_alpha(a);
                draw_circle(
                    mini_x,
                    mini_y,
                    6 * icon_scale,
                    false
                );
            }
        }

        // -----------------------------
        // DOORS
        // -----------------------------
        draw_set_color(c_lime);

        with (obj_door) {

            var mini_x = map_x_local + (x * map_scale);
            var mini_y = map_y_local + (y * map_scale);

            var a = 1;

            if (mini_x < left)   a *= clamp((mini_x - (left - pad))   / pad, 0, 1);
            if (mini_x > right)  a *= clamp(((right + pad) - mini_x)  / pad, 0, 1);
            if (mini_y < top)    a *= clamp((mini_y - (top - pad))    / pad, 0, 1);
            if (mini_y > bottom) a *= clamp(((bottom + pad) - mini_y) / pad, 0, 1);

            if (a > 0) {
                draw_set_alpha(a);
                draw_circle(
                    mini_x,
                    mini_y,
                    6 * icon_scale,
                    false
                );
            }
        }

        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}
else {
    draw_sprite_ext(
        spr_button_open_map, 0,
        cx_button, cy_button,
        scale_button, scale_button,
        0,
        c_white,
        1
    );
}
