
draw_set_font(fnt_player_action)
draw_set_color(c_red);
draw_set_alpha(1);


var combo_streak_text = "COMBO STREAK: " + string(combo_streak);
var time_text = "COMBO TIME: " + string(alarm[0] == -1 ? 0 : alarm[0]);


var text_width = string_width(combo_streak_text);
var text_height = string_height(combo_streak_text);

var x_pos = display_get_gui_width() - text_width - 32;
var y_pos = (display_get_gui_height() - text_height) / 2;

//draw_text_transformed(x_pos, y_pos, combo_streak_text, 0.5, 0.5, 0);
//draw_text_transformed(x_pos, y_pos + 10, time_text,  0.5, 0.5, 0);
