
draw_self();
var texto = life;
var texto_x = other.x;
var texto_y = other.y-30;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

draw_text(texto_x, texto_y, texto);