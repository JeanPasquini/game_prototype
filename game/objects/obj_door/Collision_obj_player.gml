var connections = global.rooms_map[$ room_get_name(room)];
var destiny = noone;

if (instance_exists(obj_player)) {
    var p = obj_player;

    if (p.x < 0 && is_outside_room(p) || room_direction == RoomDirection.LEFT && keyboard_check(vk_enter)) {
        destiny = connections.left;
    } else if (p.x > room_width && is_outside_room(p) || room_direction == RoomDirection.RIGHT && keyboard_check(vk_enter)) {
        destiny = connections.right;
    } else if (room_direction == RoomDirection.UP && keyboard_check(vk_enter)) {
        destiny = connections.up;
		
    } else if (room_direction == RoomDirection.DOWN && keyboard_check(vk_enter)) {
        destiny = connections.down;
    }
}

if (destiny != noone) {
    obj_player.x = global.rooms_map[$ room_get_name(destiny)].px;
    obj_player.y = global.rooms_map[$ room_get_name(destiny)].py;
    room_goto(destiny);
}
