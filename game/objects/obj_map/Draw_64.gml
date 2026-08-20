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
    // STATE 3 - FULL MAP
    // =================================================
    if (minimap_state == 3) {

        var full_scale = 0.4;
        var tile_size = size * full_scale;

        var map_w = cols * tile_size;
        var map_h = rows * tile_size;

        var map_x = (screen_w - map_w) * 0.5;
        var map_y = (screen_h - map_h) * 0.5;

        var tile_icon_scale = tile_size / 16;

        draw_set_alpha(1);
        draw_set_color(c_white);

        // -----------------------------
        // TILES (floor)
        // -----------------------------
        for (var i = 0; i < rows; i++) {
            for (var j = 0; j < cols; j++) {

                if (level[j][i] != 0) {

                    var x1 = map_x + j * tile_size;
                    var y1 = map_y + i * tile_size;

                    draw_sprite_ext(
                        spr_map_icon_tile, 0,
                        x1 + tile_size * 0.5,
                        y1 + tile_size * 0.5,
                        tile_icon_scale * icon_scale_wall,
                        tile_icon_scale * icon_scale_wall,
                        0,
                        c_white,
                        1
                    );
                }
            }
        }

        // -----------------------------
        // ENEMIES
        // -----------------------------
        var enemy_icon_scale = tile_icon_scale * icon_scale_enemy;

        with (obj_enemy_parent) {
            draw_sprite_ext(
                spr_map_icon_enemy, 0,
                map_x + (x * full_scale),
                map_y + (y * full_scale),
                enemy_icon_scale, enemy_icon_scale,
                0,
                c_red,
                1
            );
        }

        // -----------------------------
        // DOORS
        // -----------------------------
        var door_icon_scale = tile_icon_scale * icon_scale_door;

        with (obj_door) {
            draw_sprite_ext(
                spr_map_icon_door, 0,
                map_x + (x * full_scale),
                map_y + (y * full_scale),
                door_icon_scale, door_icon_scale,
                0,
                c_lime,
                1
            );
        }

        // -----------------------------
        // PLAYER
        // -----------------------------
        var t = current_time / 300;
        var player_icon_scale = tile_icon_scale * icon_scale_player;

        with (obj_player) {

            var px = map_x + (x * full_scale);
            var py = map_y + (y * full_scale);

            var pulse = 4 + sin(t) * 2;

            //draw_set_alpha(0.6);
            //draw_set_color(c_aqua);
            //draw_circle(px, py, pulse, false);

            //draw_set_alpha(0.2);
            //draw_circle(px, py, pulse + 2, true);

            draw_set_alpha(1);
            draw_sprite_ext(
                spr_map_icon_player, 0,
                px, py,
                player_icon_scale, player_icon_scale,
                0,
                c_aqua,
                1
            );
        }

        draw_set_alpha(1);
        draw_set_color(c_white);
    }

    // =================================================
    // STATE 1 / 2 - CORNER MAP
    // =================================================
    else {

        draw_sprite_ext(
            spr_minimap, 0,
            cx, cy,
            _scale, _scale,
            0,
            c_white,
            alpha_map
        );

        var map_scale = scale;
        var tile_size = size * map_scale;
        var tile_icon_scale = tile_size / 16;

        var origin_x = cx - spr_w / 2;
        var origin_y = cy - spr_h / 2;

        // -----------------------------
        // "Map" title, sitting in the pill at the top of the frame art.
        // Follows the frame's own fade (alpha_map) so it disappears with it.
        // -----------------------------
        draw_set_font(fnt_ui_menu_perk_selection_description);
        draw_set_color(c_white);
        draw_set_alpha(alpha_map);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        draw_text_transformed(
            origin_x + 73 * _scale,
            origin_y + 9.5 * _scale,
            text,
            _scale,
            _scale,
            0
        );

        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_alpha(1);

        // bounds inside the frame artwork, in surface-local space
        var local_left   = pad + safe;
        var local_right  = spr_w - pad - safe;
        var local_top    = pad + safe;
        var local_bottom = spr_h - pad - safe;

        // -----------------------------
        // (re)create the offscreen surface used to composite
        // the tiles/icons before the vignette shader trims the edges
        // -----------------------------
        if (!surface_exists(map_surface) || map_surface_w != spr_w || map_surface_h != spr_h) {
            if (surface_exists(map_surface)) surface_free(map_surface);
            map_surface   = surface_create(spr_w, spr_h);
            map_surface_w = spr_w;
            map_surface_h = spr_h;
        }

        surface_set_target(map_surface);
        draw_clear_alpha(c_black, 0);

        var map_x_local = (cx - obj_player.x * map_scale) - origin_x;
        var map_y_local = (cy - obj_player.y * map_scale) - origin_y;

        // -----------------------------
        // TILES (floor)
        // -----------------------------
        draw_set_alpha(1);
        draw_set_color(c_white);

        for (var i = 0; i < rows; i++) {
            for (var j = 0; j < cols; j++) {

                if (level[j][i] != 0) {

                    var lx = map_x_local + j * tile_size + tile_size * 0.5;
                    var ly = map_y_local + i * tile_size + tile_size * 0.5;

                    if (lx >= local_left - pad && lx <= local_right + pad
                    &&  ly >= local_top  - pad && ly <= local_bottom + pad) {

                        draw_sprite_ext(
                            spr_map_icon_tile, 0,
                            lx, ly,
                            tile_icon_scale * icon_scale_wall,
                            tile_icon_scale * icon_scale_wall,
                            0,
                            c_white,
                            1
                        );
                    }
                }
            }
        }

        // -----------------------------
        // ENEMIES
        // -----------------------------
        var enemy_icon_scale = tile_icon_scale * icon_scale_enemy;

        with (obj_enemy_parent) {

            var mini_x = map_x_local + (x * map_scale);
            var mini_y = map_y_local + (y * map_scale);

            if (mini_x >= local_left - pad && mini_x <= local_right + pad
            &&  mini_y >= local_top  - pad && mini_y <= local_bottom + pad) {

                draw_sprite_ext(
                    spr_map_icon_enemy, 0,
                    mini_x, mini_y,
                    enemy_icon_scale, enemy_icon_scale,
                    0,
                    c_red,
                    1
                );
            }
        }

        // -----------------------------
        // DOORS
        // -----------------------------
        var door_icon_scale = tile_icon_scale * icon_scale_door;

        with (obj_door) {

            var mini_x = map_x_local + (x * map_scale);
            var mini_y = map_y_local + (y * map_scale);

            if (mini_x >= local_left - pad && mini_x <= local_right + pad
            &&  mini_y >= local_top  - pad && mini_y <= local_bottom + pad) {

                draw_sprite_ext(
                    spr_map_icon_door, 0,
                    mini_x, mini_y,
                    door_icon_scale, door_icon_scale,
                    0,
                    c_lime,
                    1
                );
            }
        }

        surface_reset_target();

        // -----------------------------
        // draw the composited surface back with a smooth
        // per-pixel vignette fade instead of a per-tile cutoff
        // -----------------------------
        shader_set(shd_map_vignette);
        shader_set_uniform_f(shader_get_uniform(shd_map_vignette, "u_bounds"),
            local_left  / spr_w,
            local_top   / spr_h,
            local_right / spr_w,
            local_bottom / spr_h
        );
        shader_set_uniform_f(shader_get_uniform(shd_map_vignette, "u_pad"),
            pad / spr_w,
            pad / spr_h
        );

        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_surface(map_surface, origin_x, origin_y);

        shader_reset();

        // -----------------------------
        // PLAYER (always centered, always crisp)
        // -----------------------------
        var t = current_time / 300;

        draw_set_alpha(1);
        draw_set_color(c_aqua);
        //draw_circle(cx, cy, 16 * scale, false);

        var pulse = 4 + sin(t) * 2;

        //draw_set_alpha(0.6);
        //draw_circle(cx, cy, pulse, false);

        //draw_set_alpha(0.2);
        //draw_circle(cx, cy, pulse + 2, true);

        draw_set_alpha(1);
        draw_sprite_ext(
            spr_map_icon_player, 0,
            cx, cy,
            tile_icon_scale * icon_scale_player,
            tile_icon_scale * icon_scale_player,
            0,
            c_aqua,
            1
        );

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
