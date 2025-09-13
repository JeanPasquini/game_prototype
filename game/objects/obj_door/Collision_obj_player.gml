var connections = global.rooms_map[$ room_get_name(room)];
var destiny = noone; // data from the next room link
var position = noone; // set the direction of entry into the next room, reverse of the current door

if (instance_exists(obj_player)) {
    var p = obj_player;

    if (room_direction == RoomDirection.LEFT && keyboard_check_pressed(vk_enter)) {
        destiny = connections.left.link;
        position = "right";
    } else if (room_direction == RoomDirection.RIGHT && keyboard_check_pressed(vk_enter)) {
        destiny = connections.right.link;
        position = "left";
    } else if (room_direction == RoomDirection.UP && keyboard_check_pressed(vk_enter)) {
        destiny = connections.up.link;
        position = "down";
    } else if (room_direction == RoomDirection.DOWN && keyboard_check_pressed(vk_enter)) {
        destiny = connections.down.link;
        position = "up";
    }
}

if (destiny != noone && position != noone) {
    var directions = getNextRoomPxAndPy(destiny, position);
    if (!is_undefined(directions)) {
        obj_player.x = directions.px;
        obj_player.y = directions.py;
        room_goto(destiny);
    }
}
