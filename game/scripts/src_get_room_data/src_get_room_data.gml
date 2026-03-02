function src_get_room_data(room_ref, room_phase){
	return global.rooms_map[$ room_phase][$ room_get_name(room_ref)];
}