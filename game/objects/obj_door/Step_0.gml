if (variable_global_exists("rooms_map")) {
    var room_key = room_get_name(room);
    if (!variable_struct_exists(global.rooms_map[$ global.current_phase], room_key)) return; // sala não existe

    var dir_str = RoomDirectionToString(room_direction);
    var room_data = global.rooms_map[$ global.current_phase][$ room_key];
	
	// Checks if this door sends or returs to any room, based on it's direction (left, right...)
    if (!variable_struct_exists(room_data.sends, dir_str)) {
		 if (!variable_struct_exists(room_data.returns, dir_str)) {
			instance_destroy();
		 }
	}
}
