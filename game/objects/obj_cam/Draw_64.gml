var visited = ds_map_create();
var cx = width_*2 - 128;
var cy = 128;

draw_sprite(spr_minimap, 0, width_*2 - 128, 128);

minimap_traverse(room_get_name(room), cx, cy, visited);

ds_map_destroy(visited);
