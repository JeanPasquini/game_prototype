
draw_self(); 

var range = 30;

if (!variable_global_exists("show_prompt")) {
    global.show_prompt = false;
}

var dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist < range && !global.show_prompt) {
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top); 
    
    global.show_prompt = true;
}

if (dist >= range) {
    global.show_prompt = false;
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (instance_exists(obj_player)) {
    if (dist < range) {

        var xx = x;
        var yy = y + 60;

        var w = string_width(prompt_text) + 10;
        var h = 20;
		
		var height_menu_perk = sprite_get_height(spr_ui_perk_menu);
		var width_menu_perk  = sprite_get_width(spr_ui_perk_menu);
		var padding = 25;

		draw_sprite(spr_ui_perk_menu, 0, xx, yy - height_menu_perk);

		draw_sprite_ext(
		    name, 0, 
		    xx - (width_menu_perk / 2) + 29, 
		    yy - height_menu_perk - (height_menu_perk / 2) + 42, 
		    1, 1, 0, c_white, 1
		);

		draw_set_font(fnt_ui_menu_perk_title);
		draw_set_color(c_white);
		draw_set_alpha(1);
		
		draw_text_transformed(
		    xx - (width_menu_perk / 2) + 52, 
		    yy - height_menu_perk - (height_menu_perk / 2) + 36, 
		    prompt_text, 0.5, 0.5, 0
		);

		draw_set_font(fnt_ui_menu_perk_description);
		draw_set_color(c_white);
		draw_set_alpha(1);

		var text_scale = 0.5;
		var max_width  = (width_menu_perk - (padding * 2)) / text_scale;

		var text_x = xx - (width_menu_perk / 2) + padding;
		var text_y = yy - height_menu_perk - (height_menu_perk / 2) + 70;

		scr_draw_text_wrap_scaled(
		    prompt_text_description,
		    text_x,
		    text_y,
		    max_width,
		    text_scale,
		    fnt_ui_menu_perk_description
		);
    }
}