           
var pad   = 12;
var box_w = 100;
var box_h = 110;

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var col_text   = c_white;

draw_set_color(col_text);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

//var spr_w = sprite_get_width(spr_status_life);
//var spr_h = sprite_get_height(spr_status_life);

var draw_x = 16;
var draw_y = 16;

// Life frame

draw_sprite_ext(
    spr_ui_life_frame,
    0,
    draw_x,
    draw_y,
    2, 2, 0, c_white, 1
);

var life_percent = clamp(life / life_max, 0, 1);
var spr_w = sprite_get_width(spr_ui_life_bar);
var spr_h = sprite_get_height(spr_ui_life_bar);
var scale = 2;

var bar_draw_w = spr_w * life_percent * scale;
var bar_draw_h = spr_h * scale;

var bar_x = draw_x + 82;
var bar_y = draw_y + 28;

// PERK

if(perk_activatable != noone){
	draw_sprite_ext(
	    perk_activatable,
	    0,
	    draw_x + 40,
	    draw_y + 44,
	    2, 2, 0, c_white, 1
	);
}

// LIFE

draw_sprite_stretched(spr_ui_life_bar, 0, bar_x, bar_y, bar_draw_w, bar_draw_h);

// ENERGY
var energy_percent = clamp(energy / energy_max, 0, 1);
var bar_draw_w_energy = spr_w * energy_percent * scale;
draw_sprite_stretched(spr_ui_energy_bar, 0, bar_x, bar_y + 30, bar_draw_w_energy, spr_h / 2);

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var text_x = bar_x + spr_w * scale / 2;
var text_y = bar_y + bar_draw_h / 2;

draw_set_font(fnt_player_life);
draw_text_transformed(text_x, text_y, string(life) + " / " + string(life_max), 1, 1, 0);

draw_set_font(fnt_player_life);
draw_text_transformed(text_x, text_y + 25, string(energy) + " / " + string(energy_max), 1, 1, 0);

var line_h = 48;
var icon_x = draw_x + 55;
var text_money_x = draw_x + 80;

// Frame Itens

draw_sprite_ext(spr_ui_itens, image_index,
    draw_x + 8, 50 +  draw_y + line_h * 1, 2, 2, 0, c_white, 1);


draw_set_halign(fa_left);

// Money

draw_sprite_ext(spr_status_money, image_index,
    draw_x + 40, 50 +  draw_y + 27 + line_h * 1, 2, 2, 0, c_white, 1);

draw_text(text_money_x, 50 + draw_y + 28 + line_h * 1 + 16,
string_format(money, 0, 2));
draw_set_font(fnt_player_status_itens);

// Key

draw_sprite_ext(spr_status_key, image_index,
    draw_x + 40, 50 +  draw_y + 58 + line_h * 1, 2, 2, 0, c_white, 1);

draw_text(text_money_x, 50 + draw_y + 56 + line_h * 1 + 16,
string_format(key, 0, 2));
draw_set_font(fnt_player_status_itens);

// Button Status

//draw_sprite_ext(spr_ui_button_status, image_index,
//icon_x + 150, 50 +  draw_y - 10 + line_h * 1, 1.5, 1.5, 0, c_white, 1);


// Status 

if (keyboard_check(vk_tab)) {

    var center_x = gui_w * 0.5;
    var center_y = gui_h * 0.5;

    var menu_scale = 2.5;

    var menu_w = sprite_get_width(spr_ui_status_menu)  * menu_scale;
    var menu_h = sprite_get_height(spr_ui_status_menu) * menu_scale;

    var menu_x = center_x;
    var menu_y = center_y;

    draw_sprite_ext(
        spr_ui_status_menu,
        0,
        menu_x,
        menu_y,
        menu_scale,
        menu_scale,
        0,
        c_white,
        1
    );

    var origin_x = menu_x - menu_w * 0.5;
    var origin_y = menu_y - menu_h * 0.5;

    var padding_left        = (24 + 14) * menu_scale;
    var padding_top         = (38 + 14) * menu_scale;

    var padding_left_perks  = (221 + 9) * menu_scale;
    var padding_top_perks   = (27 + 9) * menu_scale;

    var line_h        = 34 * menu_scale;
    var text_scale    = menu_scale - 0.5;
    var icon_scale    = menu_scale;
    var perk_scale    = menu_scale - 0.5;

    var start_x = origin_x + padding_left;
    var start_y = origin_y + padding_top;

    var start_x_perks = origin_x + padding_left_perks;
    var start_y_perks = origin_y + padding_top_perks;

    draw_set_font(fnt_player_status);
    draw_set_color(c_white);

    // =====================
    // STATUS
    // =====================

    // ATTACK DAMAGE
    draw_sprite_ext(
        spr_status_attack_damage,
        0,
        start_x,
        start_y + line_h * 0,
        icon_scale,
        icon_scale,
        0,
        c_white,
        1
    );

    draw_text_transformed(
        start_x + 30 * menu_scale,
        start_y + line_h * 0,
        string_format(obj_player.damage, 0, 2),
        text_scale,
        text_scale,
        0
    );
	
	// LIFE MAX
    draw_sprite_ext(
        spr_status_life_max,
        0,
        start_x + (96 * menu_scale),
        start_y + line_h * 0,
        icon_scale,
        icon_scale,
        0,
        c_white,
        1
    );

    draw_text_transformed(
        start_x + 30 * menu_scale + (96 * menu_scale),
        start_y + line_h * 0,
        string_format(obj_player.life_max, 0, 2),
        text_scale,
        text_scale,
        0
    );

    // ATTACK SPEED
    draw_sprite_ext(
        spr_status_attack_speed,
        0,
        start_x,
        start_y + line_h * 1,
        icon_scale,
        icon_scale,
        0,
        c_white,
        1
    );

    draw_text_transformed(
        start_x + 30 * menu_scale,
        start_y + line_h * 1,
        string_format(obj_player.attack_speed, 0, 2),
        text_scale,
        text_scale,
        0
    );
	
	// CRITICAL CHANCE
    draw_sprite_ext(
        spr_status_critical,
        0,
        start_x + (96 * menu_scale),
        start_y + line_h * 1,
        icon_scale,
        icon_scale,
        0,
        c_white,
        1
    );

    draw_text_transformed(
        start_x + 30 * menu_scale + (96 * menu_scale),
        start_y + line_h * 1,
        string_format(obj_player.critical_chance, 0, 2),
        text_scale,
        text_scale,
        0
    );

    // MOVE SPEED
    draw_sprite_ext(
        spr_status_move_speed,
        0,
        start_x,
        start_y + line_h * 2,
        icon_scale,
        icon_scale,
        0,
        c_white,
        1
    );

    draw_text_transformed(
        start_x + 30 * menu_scale,
        start_y + line_h * 2,
        string_format(obj_player.spd, 0, 2),
        text_scale,
        text_scale,
        0
    );
	
	// LUCKY
    draw_sprite_ext(
        spr_status_lucky,
        0,
        start_x + (96 * menu_scale),
        start_y + line_h * 2,
        icon_scale,
        icon_scale,
        0,
        c_white,
        1
    );

    draw_text_transformed(
        start_x + 30 * menu_scale + (96 * menu_scale),
        start_y + line_h * 2,
        string_format(obj_player.lucky_chance, 0, 2),
        text_scale,
        text_scale,
        0
    );

    // =====================
    // PERKS
    // =====================
    var cols = 3;

    for (var i = 0; i < array_length(self.perks_obtained_run); i++) {
        var spr = self.perks_obtained_run[i];

        var col = i mod cols;
        var row = i div cols;

        draw_sprite_ext(
            spr,
            0,
            start_x_perks + (23 * menu_scale * col),
            start_y_perks + (22 * menu_scale * row),
            perk_scale,
            perk_scale,
            0,
            c_white,
            1
        );
    }
	
	for (var i = 0; i < perks_limit_max; i++) {
        var spr = spr_ui_padlock;

        var col = i mod cols;
        var row = i div cols;
		
		if (i >= perks_limit_run){
	        draw_sprite_ext(
	            spr,
	            0,
	            start_x_perks + (23 * menu_scale * col),
	            start_y_perks + (22 * menu_scale * row),
	            perk_scale,
	            perk_scale,
	            0,
	            c_white,
	            1
	        );
		}
    }
}
