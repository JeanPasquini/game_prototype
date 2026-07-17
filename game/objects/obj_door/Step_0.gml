if (variable_global_exists("rooms_map")) {
    var room_key = room_get_name(room);
	
	 // sala não existe, para troca de fases
    if (!variable_struct_exists(global.rooms_map[$ global.current_phase], room_key)) return;
    var dir_str = RoomDirectionToString(room_direction);	
	var room_data = global.rooms_map[$ global.current_phase][$ room_get_name(room)];
	
	// Checks if this door sends or returns to any room, based on it's direction (left, right...)
    if (!variable_struct_exists(room_data.connections, dir_str)) {
		instance_destroy();
		exit; // PARA a execução aqui, senão o código abaixo roda mesmo destruída
	}
	
	var target_room = room_data.connections[$ dir_str];
	var target_name = room_get_name(target_room);
	
	if (string_pos("mini_boss", target_name) > 0) {
		image_index = 0;
	}
	else if (string_pos("store", target_name) > 0) {
		image_index = 1;
	} 
	else {
		image_index = 2;
	}
}