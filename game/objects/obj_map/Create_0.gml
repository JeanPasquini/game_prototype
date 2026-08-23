size = 32;
scale = 0.3;
text = "Map"

// desenha atrás do menu de status do obj_player (GUI: menor depth = na frente).
// obj_player fica na layer "Instances" (depth 1000+); precisa ser bem maior que isso.
depth = 1000000;

icon_scale_wall   = 1.0;
icon_scale_enemy  = 1.5;
icon_scale_door   = 1.5;
icon_scale_player = 1.0;

minimap_state = 0;

// 0 -> 1 progress of the "just switched map state" animation
state_anim_t = 1;

cols = room_width div size;
rows = room_height div size;

level = 0;

map_surface = -1;
map_surface_w = 0;
map_surface_h = 0;

map_compose_surface   = -1;
map_compose_surface_w = 0;
map_compose_surface_h = 0;

//show_message(level);