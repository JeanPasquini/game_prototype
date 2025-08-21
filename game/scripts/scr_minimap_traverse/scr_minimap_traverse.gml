function minimap_traverse(room_name, x, y, visited) {
    if (ds_map_exists(visited, room_name)) return;
    ds_map_add(visited, room_name, true);

	if (room_name == room_get_name(room)) {
	    draw_sprite(spr_room_current, 0, x, y);
	} else {
	    draw_sprite(spr_room, 0, x, y);
	}

    var rdata = global.rooms_map[$ room_name];
    if (is_undefined(rdata)) return;

    var off = 64;

    if (rdata.up != noone) {
        minimap_traverse(rdata.up, x, y - off, visited);
    }
    if (rdata.down != noone) {
        minimap_traverse(rdata.down, x, y + off, visited);
    }
    if (rdata.left != noone) {
        minimap_traverse(rdata.left, x - off, y, visited);
    }
    if (rdata.right != noone) {
        minimap_traverse(rdata.right, x + off, y, visited);
    }
}
