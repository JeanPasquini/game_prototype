function src_advance_to_next_phase(){
	global.current_phase = global.rooms_map[$ global.current_phase].next_phase;
}