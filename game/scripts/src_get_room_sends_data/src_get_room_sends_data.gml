/// @description "sends" do slot atual da RUN (ou de um slot informado).
/// @param {string} _phase  fase (opcional)
/// @param {string} _slot   chave de slot (opcional)
function src_get_room_sends_data(_phase = noone, _slot = noone){
	var ph = (_phase != noone) ? _phase : global.current_phase;
	var sl = (_slot  != noone) ? _slot  : global.run_pos;
	var node = global.rooms_map[$ ph][$ sl];
	if (is_undefined(node)) return {};
	return node.sends;
}
