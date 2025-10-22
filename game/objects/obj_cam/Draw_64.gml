var scale = 3;
var scale_button = 2;
var margem = 16;

var spr_w = sprite_get_width(spr_minimap) * scale;
var spr_h = sprite_get_height(spr_minimap) * scale;

var screen_w = display_get_gui_width();
var screen_h = display_get_gui_height();

var cx = screen_w - spr_w / 2 - margem;
var cy = spr_h / 2 + margem;

var spr_btn_w = sprite_get_width(spr_button_open_map) * scale_button;
var spr_btn_h = sprite_get_height(spr_button_open_map) * scale_button;

var cx_button = screen_w - spr_btn_w - margem;
var cy_button = margem;

var alpha_map = 0;
switch (minimap_state) {
    case 0: alpha_map = 0; break;      
    case 1: alpha_map = 1; break;    
    case 2: alpha_map = 0.5; break;    
}

if (alpha_map > 0) {
    var visited = ds_map_create();
    draw_sprite_ext(spr_minimap, 0, cx, cy, scale, scale, 0, c_white, alpha_map);
    minimap_traverse(room_get_name(room), cx, cy, visited);
    ds_map_destroy(visited);

    var btn_x = cx - (spr_btn_w / 2) + 6;                       
    var btn_y = cy + (spr_h / 2) / 2 + 10;                  
    //draw_sprite_ext(spr_button_open_map, 0, btn_x, btn_y, scale_button, scale_button, 0, c_white, 1);

} else {
    draw_sprite_ext(spr_button_open_map, 0, cx_button, cy_button, scale_button, scale_button, 0, c_white, 1);
}
