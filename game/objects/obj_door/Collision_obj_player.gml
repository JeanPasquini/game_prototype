// room_restart();

var connections = global.rooms_map[$ room_get_name(room)];
var destiny = noone;

with obj_player {

	if (x < 0 && is_outside_room(obj_player)) {
		destiny = connections.left;
	} else if (x > room_width && is_outside_room(obj_player)) {
		destiny = connections.right;
	} else if (keyboard_check(vk_up)) {
		destiny = connections.up;
	} else if (keyboard_check(vk_down)) {
		destiny = connections.down;
	}

}



if (destiny != noone) {
	
	    obj_player.x = 100;
    obj_player.y = 200;
	room_goto(destiny);
}