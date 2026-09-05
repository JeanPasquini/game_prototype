if (variable_global_exists("rooms_map") && variable_global_exists("run_pos")) {

	var _phase = (current_room != noone && current_phase != noone) ? current_phase : global.current_phase;
	var _key   = (current_room != noone && current_phase != noone) ? current_room  : global.run_pos;

    if (!variable_struct_exists(global.rooms_map[$ _phase], _key)) return;

    var dir_str   = RoomDirectionToString(room_direction);
	var room_data = global.rooms_map[$ _phase][$ _key];

	// A porta so existe se este slot tem conexao nesta direcao (ida OU volta).
    if (!variable_struct_exists(room_data.connections, dir_str)) {
		instance_destroy();
		exit;
	}

	var target_slot = room_data.connections[$ dir_str];
	var target_node = global.rooms_map[$ _phase][$ target_slot];
	var target_name = is_undefined(target_node) ? "" : room_get_name(target_node.room);

	if (string_pos("miniboss", target_name) > 0 || string_pos("mini_boss", target_name) > 0) {
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
