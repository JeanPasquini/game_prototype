if (variable_global_exists("rooms_map")) {
    var room_key = room_get_name(room);
    if (!variable_struct_exists(global.rooms_map, room_key)) return; // sala não existe

    var dir_str = RoomDirectionToString(room_direction);
    var room_data = global.rooms_map[$ room_key];

    // verifica se a direção existe
    if (!variable_struct_exists(room_data, dir_str)) return;

    var destiny = room_data[$ dir_str][$ "link"];
    
    if (destiny == noone) {
		instance_destroy();
	}
	
	
}
