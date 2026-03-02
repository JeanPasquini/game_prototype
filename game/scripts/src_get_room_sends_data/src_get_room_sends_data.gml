function src_get_room_sends_data(_phase = noone, _room = noone){
	if (_phase != noone && _room != noone) {
		return  global.rooms_map[$ _phase][$ room_get_name(_room)].sends;
	}
	return global.rooms_map[$ global.current_phase][$ room_get_name(room)].sends;
}