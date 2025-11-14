function src_get_next_phase(_phase = noone){
	if (_phase != noone) {
		return  global.rooms_map[$ _phase].next_phase;
	}
	return global.rooms_map[$ global.current_phase].next_phase;
}