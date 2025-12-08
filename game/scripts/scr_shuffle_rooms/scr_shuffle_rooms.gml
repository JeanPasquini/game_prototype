function shuffle_rooms() {
    randomize(); // guarantees different randomness in each Run
    var visited = ds_list_create();
    _shuffle_room(global.first_room_name, global.current_phase, noone, noone, visited);
    ds_list_destroy(visited);
}

// Shuffle simply swaps the positions of the existing outputs.
function _shuffle_room(room_ref, phase, back_room, back_dir, visited) {
	
	// Check if the specified room has already been visited.
    var key = _room_key(room_ref);
    if (ds_list_find_index(visited, key) != -1) return;
    ds_list_add(visited, key);

	// If the room does not exist, return to avoid generating an error.
    if (!variable_struct_exists(global.rooms_map[$ phase], key)) return;
	
	var room_data = src_get_room_data(room_ref, phase);
	
	var dirs = ["up", "down", "left", "right"];	
	var connections = {};
	
	// It checks if it should return, ruling out as a possibility the direction already used for that purpose.
	if (back_room != noone && back_dir != noone && room_data.returns) {
		connections[$ back_dir] = back_room;
		
		var new_dirs = [];
		for (var i = 0; i < array_length(dirs); i++) {
			if (dirs[i] != back_dir) {
			    array_push(new_dirs, dirs[i]);
			}
		}
		dirs = new_dirs;
	}

	// retrieves the next rooms from the connection as strings and adds them to an array.
	var send_rooms = variable_struct_get_names(room_data.sends);
	
	show_debug_message(json_stringify(send_rooms, true));

	// loop over each room name ("challenge_01", "challenge_02"...)
	for (var i = 0; i < array_length(send_rooms); i++)
	{
	    var send_room  = send_rooms[i]; // Get the name of the current room or the next phase.
	    var _room = room_data.sends[$ send_room]; // Get the reference to the room, by string or phase.
		
		if (room_get_name(_room) != send_room) {
			// There is a phase change, with send_room being the new phase.
			phase = send_room;
			
			// If the room has already been visited (as a safe_room), remove it from the list for a new visit in the current phase.
			var index = ds_list_find_index(visited, _room_key(_room));
			if (index != -1) {
			    ds_list_delete(visited, index);
			}
			
			_shuffle_room(_room, phase, noone, noone, visited);
			return;
		}

		show_debug_message(json_stringify(_room, true));

	    // choose a random direction from the remaining options
	    var idx = irandom(array_length(dirs) - 1);
	    var dir = dirs[idx];

	    // link in the final result
	    connections[$ dir] = _room;

	    // remove the direction used
	    array_delete(dirs, idx, 1);
		
		// recursively calls the function for all connections.
		_shuffle_room(_room, phase, room_ref, _opposite_dir(dir), visited);
	}
	// Define the new connections generated.
    global.rooms_map[$ phase][$ room_get_name(room_ref)].connections = connections;

}


function _opposite_dir(dir) {
    var opp;
    switch (dir) {
        case "up": opp = "down"; break;
        case "down": opp = "up"; break;
        case "left": opp = "right"; break;
        case "right": opp = "left"; break;
        default: return;
    }
	return opp;
}


function _room_key(room_ref) {
    if (is_string(room_ref)) return room_ref;
    return room_get_name(room_ref);
}
