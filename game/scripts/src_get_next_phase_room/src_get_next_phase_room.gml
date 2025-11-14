/// @description Retorna um par direction: room_ref
function src_get_next_phase_room(){
	var _next_phase = src_get_next_phase();
	return global.rooms_map[$ global.current_phase][$ room_get_name(room)].sends[$ _next_phase];
}