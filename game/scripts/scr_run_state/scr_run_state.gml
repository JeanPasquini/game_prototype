/*
	Estado persistente das salas DENTRO de uma RUN.

	global.run_state[$ nome_sala] = {
		visited:       bool,   // player ja entrou nesta sala nesta run
		cleared:       bool,   // hordas / desafio da sala ja concluidos
		merchant_used: bool,   // store_room: o npc_merchant ja vendeu nesta run
	}

	Nao usamos a flag nativa "persistent" das rooms: o GameMaker recarrega o .yy
	limpo a cada entrada e o scr_room_init() reaplica este estado. Assim o
	scr_reset_run() so precisa limpar este struct para "voltar as salas como eram".
*/

/// @description Garante e devolve o struct de estado da sala informada.
/// @param {string} room_name
function run_state_get(room_name) {
	if (!variable_global_exists("run_state") || !is_struct(global.run_state)) {
		global.run_state = {};
	}

	if (!variable_struct_exists(global.run_state, room_name)) {
		global.run_state[$ room_name] = {
			visited:       false,
			cleared:       false,
			merchant_used: false,
		};
	}

	return global.run_state[$ room_name];
}

/// @description Marca uma sala como concluida (hordas / desafio terminados).
/// @param {string} room_name
function run_state_mark_cleared(room_name) {
	run_state_get(room_name).cleared = true;
}

/// @description Zera todo o estado de sala. Chamado no inicio de cada RUN nova.
function run_state_reset() {
	global.run_state = {};
}

/// @description true enquanto a sala atual ainda tem hordas ativas.
/// Enquanto for true, as portas ficam travadas e sem aura.
function run_room_has_active_horde() {
	return instance_exists(obj_wave_manager)
		&& obj_wave_manager.state != WaveState.COMPLETE;
}
