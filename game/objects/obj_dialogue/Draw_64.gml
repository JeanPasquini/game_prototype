if (array_length(dialogue_lines) > 0) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    var bar_height = 40;
    var margin_bottom = 32;
    var padding_text = 40;
    var sprite_w = sprite_get_width(spr_ui_dialogue_menu) * 2;
    var sprite_h = sprite_get_height(spr_ui_dialogue_menu) * 2
	
    var sprite_x = gui_w / 2;
    var sprite_y = gui_h - bar_height - margin_bottom - (sprite_h / 2);
    draw_sprite_ext(spr_ui_dialogue_menu, 1, sprite_x, sprite_y, 2, 2, 0, c_white, 1);

	draw_set_font(fnt_player_dialogue);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(sprite_x - (sprite_w / 2) + padding_text, sprite_y - (sprite_h / 2) + padding_text + 40, dialogue_lines[current_line] + " [" + string(current_line) + "]");
}
