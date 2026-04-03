var rdata = undefined;

if (current_room != noone && current_phase != noone) {
	rdata = global.rooms_map[$ current_phase][$ room_get_name(current_room)];
} else {
	rdata = global.rooms_map[$ global.current_phase][$ room_get_name(room)];
}

if (is_undefined(rdata)) instance_destroy();

var connections = rdata.connections;
var destiny = noone; // data from the next room link
var position = noone; // set the direction of entry into the next room, reverse of the current door

if (instance_exists(obj_player)) {
    var p = obj_player;

    if (room_direction == RoomDirection.LEFT && keyboard_check_pressed(vk_enter)) {
        destiny = connections.left;
        position = "right";
    } else if (room_direction == RoomDirection.RIGHT && keyboard_check_pressed(vk_enter)) {
        destiny = connections.right;
        position = "left";
    } else if (room_direction == RoomDirection.UP && keyboard_check_pressed(vk_enter)) {
        destiny = connections.up;
        position = "down";
    } else if (room_direction == RoomDirection.DOWN && keyboard_check_pressed(vk_enter)) {
        destiny = connections.down;
        position = "up";
    }
	
	
}

if (destiny != noone && position != noone) {
    
    var directions = getNextRoomPxAndPy(destiny, position);

    if (!is_undefined(directions)) {

        if (obj_player.state != PlayerState.WAIT) {

            var transition = instance_create_layer(0, 0, "Instances", obj_transiction);

            // 🔥 passa os dados pra transição
            transition.destiny = destiny;
            transition.px = directions.px;
            transition.py = directions.py;
            transition.is_boss_door = is_boss_door;

            // trava o player
            obj_player.state = PlayerState.WAIT;
        }
    }
}
