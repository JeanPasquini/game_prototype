var sw = display_get_gui_width();
var sh = display_get_gui_height();

// intensidade do escurecimento (0 a 1)
var bg_alpha = 0.65;

// fundo preto semi-transparente
draw_set_colour(c_black);
draw_set_alpha(bg_alpha);
draw_rectangle(0, 0, sw, sh, false);

// reset
draw_set_alpha(1);
draw_set_colour(c_white);

var text = "PRESS [INTERACT_BUTTON] TO SELECT";

var xx = display_get_gui_width() * 0.5;
var yy = display_get_gui_height() * 0.90;

var text_scale = 1;
var alpha_warning = 1;

draw_set_font(fnt_ui_menu_perk_selection_title)
var text_w = scr_rich_text_width(text, text_scale);

var total_w = text_w;

var start_x = xx - total_w * 0.5;

scr_draw_rich_text(
    start_x,
    yy,
    text,
    text_scale,
    alpha_warning
);