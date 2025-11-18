function minimap_traverse(room_name, x, y, visited) {
    if (ds_map_exists(visited, room_name)) return;
    ds_map_add(visited, room_name, true);

	var scale = 2;

	if (room_name == room_get_name(room)) {
	    draw_sprite_ext(spr_room_current, 0, x, y, scale, scale, 0, c_white, 1);
	} else if (room_name == "safe_room"){
		draw_sprite_ext(spr_room_safe, 0, x, y, scale, scale, 0, c_white, 1);
	}else {
	    draw_sprite_ext(spr_room, 0, x, y, scale, scale, 0, c_white, 1);
	}

    var rdata = global.rooms_map[$ global.current_phase][$ room_name];
	
    if (is_undefined(rdata)) return;
	
	var connections = rdata.connections;

    var off = 32;

    if (variable_struct_exists(connections, "up")) {
        minimap_traverse(room_get_name(connections.up), x, y - off, visited);
    }
    if (variable_struct_exists(connections, "down")) {
        minimap_traverse(room_get_name(connections.down), x, y + off, visited);
    }
    if (variable_struct_exists(connections, "left")) {
        minimap_traverse(room_get_name(connections.left), x - off, y, visited);
    }
    if (variable_struct_exists(connections, "right")) {
        minimap_traverse(room_get_name(connections.right), x + off, y, visited);
    }
}
