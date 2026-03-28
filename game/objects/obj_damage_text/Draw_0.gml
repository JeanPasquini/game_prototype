draw_self();

draw_set_font(fnt_player_action);
draw_set_alpha(alpha);
draw_set_color(color);
draw_text_transformed(x, y-8, text, 0.5, 0.5, 0);

draw_set_alpha(1);