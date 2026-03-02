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
