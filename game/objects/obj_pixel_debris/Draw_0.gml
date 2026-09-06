// Bloco solido da cor amostrada do sprite do inimigo. draw_rectangle e barato o
// bastante pro volume esperado no desktop (teto por morte + teto global no script).
var _h = chunk_size * 0.5;

draw_set_color(col);
draw_set_alpha(image_alpha);
draw_rectangle(x - _h, y - _h, x + _h - 1, y + _h - 1, false);
draw_set_alpha(1);
draw_set_color(c_white);
