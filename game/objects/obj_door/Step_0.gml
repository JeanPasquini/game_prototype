if (variable_global_exists("rooms_map")) {

	var _phase = (current_room != noone && current_phase != noone) ? current_phase : global.current_phase;
	var _room_ref = (current_room != noone && current_phase != noone) ? current_room : room;
    var room_key = room_get_name(_room_ref);

    if (!variable_struct_exists(global.rooms_map[$ _phase], room_key)) return;
    var dir_str = RoomDirectionToString(room_direction);
	var room_data = global.rooms_map[$ _phase][$ room_key];

	// Checks if this door sends or returns to any room, based on it's direction (left, right...)
    if (!variable_struct_exists(room_data.connections, dir_str)) {
		instance_destroy();
		exit; 
	}
	
	var target_room = room_data.connections[$ dir_str];
	var target_name = room_get_name(target_room);
	
	if (string_pos("mini_boss", target_name) > 0) {
		trans_base_frame = 13;
		
	}
	else if (string_pos("store", target_name) > 0) {
		trans_base_frame = 26;
	}
	else {
		trans_base_frame = 0;
	}
}

// ==========================
// ANIMAÇÃO DA PORTA
// ==========================
if (trans_state == "opening") {

	var _anim = 0;

	if (instance_exists(obj_player) && obj_player.sprite_index == spr_player_transition) {
		_anim = floor(obj_player.image_index);
	}

	image_index = trans_base_frame + clamp(_anim, 0, 12);
}
else {
	image_index = trans_base_frame;
}