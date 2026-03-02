draw_set_font(fnt_player_action);
if(combo_streak > 0){
	draw_set_alpha(1);
}
else{
	draw_set_alpha(0);
}

var hits_text = "HITS " + string(combo_streak) + "x";

var text_w = string_width(hits_text);
var text_h = string_height(hits_text);

var margin = 32;
var xx = display_get_gui_width() - text_w - margin;
var yy = display_get_gui_height() * 0.5 - text_h * 0.5;

var scale = 1 + pulse_scale;

var tilt = tilt_angle;

draw_set_color(c_black);
draw_text_transformed(xx + 2, yy + 2, hits_text, scale, scale, tilt);

draw_text_transformed(xx - 1, yy, hits_text, scale, scale, tilt);
draw_text_transformed(xx + 1, yy, hits_text, scale, scale, tilt);
draw_text_transformed(xx, yy - 1, hits_text, scale, scale, tilt);
draw_text_transformed(xx, yy + 1, hits_text, scale, scale, tilt);

draw_set_color(c_red);
draw_text_transformed(xx, yy, hits_text, scale, scale, tilt);
draw_set_alpha(1);