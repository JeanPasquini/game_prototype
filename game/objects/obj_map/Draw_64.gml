//exit;
if(layer_get_visible("ui_menu_main")){
	exit;
}
if (scr_menu_lock_blocks_world()) {
	exit;
}


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

// -----------------------------
// fog of war: pega (ou cria) o grid de tiles já explorados desta sala.
// fica guardado em explored_data pelo nome da room, então se o player
// sair e voltar dentro da mesma run o que já foi visto continua visível.
// -----------------------------
var _room_key = room_get_name(room);

if (!variable_struct_exists(explored_data, _room_key)) {
    var _grid = array_create(cols);
    for (var j = 0; j < cols; j++) {
        _grid[j] = array_create(rows, 0);
    }
    variable_struct_set(explored_data, _room_key, _grid);
}

explored = variable_struct_get(explored_data, _room_key);

// revela em um raio circular ao redor do player, subindo de 0 a 1 aos
// poucos (em vez de acender o tile inteiro de uma vez) para dar um fade
// suave por tile enquanto o player anda
var _pcol = clamp(obj_player.x div size, 0, cols - 1);
var _prow = clamp(obj_player.y div size, 0, rows - 1);

var _r = reveal_radius;
var _r_sqr = _r * _r;

for (var i = max(0, _prow - _r); i <= min(rows - 1, _prow + _r); i++) {
    for (var j = max(0, _pcol - _r); j <= min(cols - 1, _pcol + _r); j++) {
        if (explored[j][i] < 1 && (sqr(j - _pcol) + sqr(i - _prow)) <= _r_sqr) {
            explored[j][i] = min(1, explored[j][i] + reveal_speed);
        }
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

// cluster do canto sup. direito: ICONE do mapa em cima, BOTAO a apertar embaixo.
// o botao troca entre tecla (M) e controle (Share) conforme o ultimo dispositivo.
var spr_map_icon   = spr_button_icon_map;
var spr_map_button = scr_prompt_sprite("OPEN_MAP_BUTTON");

var icon_btn_w = sprite_get_width(spr_map_icon)   * scale_button;
var icon_btn_h = sprite_get_height(spr_map_icon)  * scale_button;
var key_btn_h  = sprite_get_height(spr_map_button) * scale_button;

var btn_gap = 6; // espaco vertical entre icone e botao

// ancora do cluster = canto sup. esq. do ICONE (elemento de cima)
var cx_button = screen_w - icon_btn_w - margem;
var cy_button = margem;

// mantido pro morph do painel: usa o tamanho do icone como referencia
var spr_btn_w = icon_btn_w;
var spr_btn_h = icon_btn_h;

var alpha_map = 0;
switch (minimap_state) {
    case 0: alpha_map = 0;   break;
    case 1: alpha_map = 1;   break;
    case 2: alpha_map = 0.5; break;
    case 3: alpha_map = 1;   break;
}

// eases from 0 (the instant the state just changed) to 1 (settled)
var t_ease = 1 - power(1 - state_anim_t, 3);

if (alpha_map > 0) {

    // =================================================
    // STATE 3 - FULL MAP
    // =================================================
    if (minimap_state == 3) {

        var full_scale = 0.4 * lerp(0.7, 1, t_ease);
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

                if (level[j][i] != 0 && explored[j][i] > 0) {

                    var x1 = map_x + j * tile_size;
                    var y1 = map_y + i * tile_size;
                    var x2 = x1 + tile_size;
                    var y2 = y1 + tile_size;

                    // só desenha a borda do lado que NÃO tem um tile vizinho
                    // já revelado - assim tiles grudados formam um bloco só,
                    // sem linha no meio, em vez de cada um ficar preenchido
                    var _has_up    = (i > 0)        && level[j][i - 1] != 0 && explored[j][i - 1] > 0;
                    var _has_down  = (i < rows - 1) && level[j][i + 1] != 0 && explored[j][i + 1] > 0;
                    var _has_left  = (j > 0)        && level[j - 1][i] != 0 && explored[j - 1][i] > 0;
                    var _has_right = (j < cols - 1) && level[j + 1][i] != 0 && explored[j + 1][i] > 0;

                    draw_set_color(c_white);
                    draw_set_alpha(t_ease * explored[j][i]);

                    if (!_has_up)    draw_line_width(x1, y1, x2, y1, border_width);
                    if (!_has_down)  draw_line_width(x1, y2, x2, y2, border_width);
                    if (!_has_left)  draw_line_width(x1, y1, x1, y2, border_width);
                    if (!_has_right) draw_line_width(x2, y1, x2, y2, border_width);
                }
            }
        }

        draw_set_alpha(1);
        draw_set_color(c_white);

        // -----------------------------
        // ENEMIES
        // -----------------------------
        var enemy_icon_scale = tile_icon_scale * icon_scale_enemy;

        with (obj_enemy_parent) {
            var _ecol = clamp(x div other.size, 0, other.cols - 1);
            var _erow = clamp(y div other.size, 0, other.rows - 1);
            var _eexplored = other.explored[_ecol][_erow];

            if (_eexplored > 0) {
                draw_sprite_ext(
                    spr_map_icon_enemy, 0,
                    map_x + (x * full_scale),
                    map_y + (y * full_scale),
                    enemy_icon_scale, enemy_icon_scale,
                    0,
                    c_red,
                    t_ease * _eexplored
                );
            }
        }

        // -----------------------------
        // DOORS
        // -----------------------------
        var door_icon_scale = tile_icon_scale * icon_scale_door;

        with (obj_door) {
            var _dcol = clamp(x div other.size, 0, other.cols - 1);
            var _drow = clamp(y div other.size, 0, other.rows - 1);
            var _dexplored = other.explored[_dcol][_drow];

            if (_dexplored > 0) {
                draw_sprite_ext(
                    spr_map_icon_door, 0,
                    map_x + (x * full_scale),
                    map_y + (y * full_scale),
                    door_icon_scale, door_icon_scale,
                    0,
                    c_lime,
                    t_ease * _dexplored
                );
            }
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
                t_ease
            );
        }

        draw_set_alpha(1);
        draw_set_color(c_white);
    }

    // =================================================
    // STATE 1 / 2 - CORNER MAP
    // =================================================
    else {

        // -----------------------------
        // (re)create the compose surface: the whole corner-map panel
        // (frame + title + tiles/icons + player) gets drawn into this at
        // its normal, fully-open look. We then blit THAT as one image with
        // a scale/position transform that makes it grow out of the little
        // map button and settle into its corner spot - like the button
        // itself is opening up into the panel.
        // -----------------------------
        if (!surface_exists(map_compose_surface) || map_compose_surface_w != screen_w || map_compose_surface_h != screen_h) {
            if (surface_exists(map_compose_surface)) surface_free(map_compose_surface);
            map_compose_surface   = surface_create(screen_w, screen_h);
            map_compose_surface_w = screen_w;
            map_compose_surface_h = screen_h;
        }

        surface_set_target(map_compose_surface);
        draw_clear_alpha(c_black, 0);

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

                if (level[j][i] != 0 && explored[j][i] > 0) {

                    var lx = map_x_local + j * tile_size + tile_size * 0.5;
                    var ly = map_y_local + i * tile_size + tile_size * 0.5;

                    if (lx >= local_left - pad && lx <= local_right + pad
                    &&  ly >= local_top  - pad && ly <= local_bottom + pad) {

                        var x1 = map_x_local + j * tile_size;
                        var y1 = map_y_local + i * tile_size;
                        var x2 = x1 + tile_size;
                        var y2 = y1 + tile_size;

                        var _has_up    = (i > 0)        && level[j][i - 1] != 0 && explored[j][i - 1] > 0;
                        var _has_down  = (i < rows - 1) && level[j][i + 1] != 0 && explored[j][i + 1] > 0;
                        var _has_left  = (j > 0)        && level[j - 1][i] != 0 && explored[j - 1][i] > 0;
                        var _has_right = (j < cols - 1) && level[j + 1][i] != 0 && explored[j + 1][i] > 0;

                        draw_set_color(c_white);
                        draw_set_alpha(explored[j][i]);

                        if (!_has_up)    draw_line_width(x1, y1, x2, y1, border_width);
                        if (!_has_down)  draw_line_width(x1, y2, x2, y2, border_width);
                        if (!_has_left)  draw_line_width(x1, y1, x1, y2, border_width);
                        if (!_has_right) draw_line_width(x2, y1, x2, y2, border_width);
                    }
                }
            }
        }

        draw_set_alpha(1);
        draw_set_color(c_white);

        // -----------------------------
        // ENEMIES
        // -----------------------------
        var enemy_icon_scale = tile_icon_scale * icon_scale_enemy;

        with (obj_enemy_parent) {

            var mini_x = map_x_local + (x * map_scale);
            var mini_y = map_y_local + (y * map_scale);

            var _ecol = clamp(x div other.size, 0, other.cols - 1);
            var _erow = clamp(y div other.size, 0, other.rows - 1);
            var _eexplored = other.explored[_ecol][_erow];

            if (_eexplored > 0
            &&  mini_x >= local_left - pad && mini_x <= local_right + pad
            &&  mini_y >= local_top  - pad && mini_y <= local_bottom + pad) {

                draw_sprite_ext(
                    spr_map_icon_enemy, 0,
                    mini_x, mini_y,
                    enemy_icon_scale, enemy_icon_scale,
                    0,
                    c_red,
                    _eexplored
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

            var _dcol = clamp(x div other.size, 0, other.cols - 1);
            var _drow = clamp(y div other.size, 0, other.rows - 1);
            var _dexplored = other.explored[_dcol][_drow];

            if (_dexplored > 0
            &&  mini_x >= local_left - pad && mini_x <= local_right + pad
            &&  mini_y >= local_top  - pad && mini_y <= local_bottom + pad) {

                draw_sprite_ext(
                    spr_map_icon_door, 0,
                    mini_x, mini_y,
                    door_icon_scale, door_icon_scale,
                    0,
                    c_lime,
                    _dexplored
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

        draw_set_alpha(alpha_map);
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
            alpha_map
        );

        draw_set_alpha(1);
        draw_set_color(c_white);

        surface_reset_target();

        // -----------------------------
        // blit the composed panel, growing out of the map button
        // (minimap_state == 1 = just opened from hidden) or, for state 2,
        // just fading in place (no movement/scale change).
        // -----------------------------
        var morphing = (minimap_state == 1);

        var anchor_x = morphing ? (cx_button + spr_btn_w * 0.5) : cx;
        var anchor_y = morphing ? (cy_button + spr_btn_h * 0.5) : cy;
        var scale_from = morphing ? 0.12 : 1;

        var panel_scale = lerp(scale_from, 1, t_ease);
        var pivot_x     = lerp(anchor_x, cx, t_ease);
        var pivot_y     = lerp(anchor_y, cy, t_ease);

        var blit_x = pivot_x - cx * panel_scale;
        var blit_y = pivot_y - cy * panel_scale;

        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_surface_ext(
            map_compose_surface,
            blit_x, blit_y,
            panel_scale, panel_scale,
            0,
            c_white,
            t_ease
        );
    }
}
else {
    // ICONE do mapa (em cima) - origem top-left
    draw_sprite_ext(
        spr_map_icon, 0,
        cx_button, cy_button,
        scale_button, scale_button,
        0,
        c_white,
        1
    );

    // BOTAO a apertar (embaixo, centralizado sob o icone) - origem ~central
    var _key_cx = cx_button + icon_btn_w * 0.5;
    var _key_cy = cy_button + icon_btn_h + btn_gap + key_btn_h * 0.5;

    draw_sprite_ext(
        spr_map_button, 0,
        _key_cx, _key_cy,
        scale_button, scale_button,
        0,
        c_white,
        1
    );
}
