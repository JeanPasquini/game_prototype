function src_replace_next_phase_room(_current_phase, _current_room, _next_phase, _next_phase_room){
	global.rooms_map[$ _current_phase][$ room_get_name(_current_room)].sends = { };
	global.rooms_map[$ _current_phase][$ room_get_name(_current_room)].sends[$ _next_phase] = _next_phase_room;
}