/// @description Retorna o destino da proxima fase a partir do slot atual, ou undefined.
function src_get_next_phase_room(){
	var _next_phase = src_get_next_phase();
	var node = global.rooms_map[$ global.current_phase][$ global.run_pos];
	if (is_undefined(node)) return undefined;
	return node.sends[$ _next_phase];
}
