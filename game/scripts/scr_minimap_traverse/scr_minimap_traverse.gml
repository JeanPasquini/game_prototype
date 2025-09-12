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

    var off = 32;

    if (!is_undefined(rdata.up) && rdata.up.link != noone) {
        minimap_traverse(room_get_name(rdata.up.link), x, y - off, visited);
    }
    if (!is_undefined(rdata.down) && rdata.down.link != noone) {
        minimap_traverse(room_get_name(rdata.down.link), x, y + off, visited);
    }
    if (!is_undefined(rdata.left) && rdata.left.link != noone) {
        minimap_traverse(room_get_name(rdata.left.link), x - off, y, visited);
    }
    if (!is_undefined(rdata.right) && rdata.right.link != noone) {
        minimap_traverse(room_get_name(rdata.right.link), x + off, y, visited);
    }
}
