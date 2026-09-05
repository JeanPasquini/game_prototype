// Percorre o grafo da RUN por CHAVE DE SLOT (ver scr_generate_run / scr_shuffle_rooms).
function minimap_traverse(slot_key, x, y, visited) {
    if (ds_map_exists(visited, slot_key)) return;
    ds_map_add(visited, slot_key, true);

	var scale = 2;

	var rdata = global.rooms_map[$ global.current_phase][$ slot_key];
	if (is_undefined(rdata)) return;

	var rname = room_get_name(rdata.room);

	if (slot_key == global.run_pos) {
	    draw_sprite_ext(spr_room_current, 0, x, y, scale, scale, 0, c_white, 1);
		if (slot_key == "HUB") return;
	} else if (rname == "safe_room") {
		draw_sprite_ext(spr_room_safe, 0, x, y, scale, scale, 0, c_white, 1);
	} else {
	    draw_sprite_ext(spr_room, 0, x, y, scale, scale, 0, c_white, 1);
	}

	var connections = rdata.connections;
    var off = 32;

    if (variable_struct_exists(connections, "up")) {
        minimap_traverse(connections.up, x, y - off, visited);
    }
    if (variable_struct_exists(connections, "down")) {
        minimap_traverse(connections.down, x, y + off, visited);
    }
    if (variable_struct_exists(connections, "left")) {
        minimap_traverse(connections.left, x - off, y, visited);
    }
    if (variable_struct_exists(connections, "right")) {
        minimap_traverse(connections.right, x + off, y, visited);
    }
}
