join = true;
next = false;

scr_menu_lock_force("transition");

// dados
destiny = noone;       // asset da room de destino (room_goto)
destiny_slot = noone;  // chave de slot no mapa da RUN (global.run_pos)
entry_dir = noone;     // "up"/"down"/"left"/"right": porta de entrada (global.run_entry_dir)
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