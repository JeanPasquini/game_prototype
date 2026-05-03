join = true;
next = false;

// dados
destiny = noone;
px = 0;
py = 0;
is_boss_door = false;

// animação
img = 0;
img_vel = sprite_get_speed(spr_quad) / game_get_speed(gamespeed_fps);
img_num = sprite_get_number(spr_quad) - 1;

size = sprite_get_width(spr_quad);

var view_w = display_get_gui_width();
var view_h = display_get_gui_height();

cols = ceil(view_w / size);
lins = ceil(view_h / size);