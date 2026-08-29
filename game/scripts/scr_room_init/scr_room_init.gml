/*
	Setup comum de toda sala, chamado no fim do creation code de cada room.

	Responsavel por:
	  1. Garantir/gerar o mapa da RUN (global.rooms_map) e a posicao (global.run_pos).
	     - Ao entrar no HUB: sempre (re)gera uma RUN nova e zera o estado de sala.
	     - Nas demais salas: gera so se ainda nao existir (boot / sala de teste).
	  2. Aplicar a persistencia da sala (scr_run_state), indexada pelo SLOT atual
	     (global.run_pos), nao pelo nome da sala — assim a mesma sala usada em
	     varios slots tem estados independentes:
	     - se o slot ja foi concluido nesta RUN, remove hordas/inimigos para
	       ela nao "resetar" ao ser revisitada.
	  3. Disparar o aviso central de ANOMALIA, se a sala declarou uma.

	--- Como declarar uma anomalia numa sala ---
	No creation code da room, ANTES de chamar scr_room_init(), defina:

		global.room_anomaly_enabled = true;
		global.room_anomaly_id      = "no_solid_visual";
		global.room_anomaly_title   = "SEM COLISAO VISIVEL";
		global.room_anomaly_desc    = "Os blocos solidos ficam invisiveis.";
*/

function scr_room_init() {
	var _room_name = room_get_name(room);

	// -------- 1. mapa da RUN + posicao --------
	if (_room_name == "HUB") {
		global.run_pos = "HUB";
		run_state_reset();
		generate_run();
	} else if (!variable_global_exists("rooms_map")) {
		generate_run();
	}
	if (!variable_global_exists("run_pos")) global.run_pos = "HUB";

	// -------- 1b. spawn automatico na porta de entrada --------
	// HUB / safe_room / store_room / tutorial_room usam ponto manual (scr_room_link_points).
	// Qualquer outra sala: o player nasce EXATAMENTE na obj_door cuja direcao bate
	// com a porta pela qual ele entrou. Basta colocar as 4 portas na sala, sem
	// configurar ponto de spawn. O "voltar pela mesma porta" continua valendo
	// porque essa porta e justamente a que o shuffle reservou de volta.
	var _fixed_spawn = (_room_name == "HUB" || _room_name == "safe_room"
		|| _room_name == "store_room" || _room_name == "tutorial_room");

	if (!_fixed_spawn
		&& variable_global_exists("run_entry_dir") && global.run_entry_dir != noone
		&& instance_exists(obj_player)) {

		var _want = room_dir_from_string(global.run_entry_dir);
		var _door = noone;
		with (obj_door) {
			if (room_direction == _want) { _door = id; break; }
		}
		if (_door != noone) {
			obj_player.x = _door.x;
			obj_player.y = _door.y;
		}
	}

	// -------- 2. persistencia do slot --------
	var st = run_state_get(global.run_pos);
	st.visited = true;

	var _is_challenge = (string_pos("room_challenge_", _room_name) == 1);

	if (st.cleared && _is_challenge) {
		// slot ja concluido: nao recria hordas nem inimigos ao revisitar
		with (obj_spawn_enemy)  instance_destroy();
		with (obj_wave_manager) instance_destroy();
		with (obj_enemy_parent) instance_destroy();
	}

	// -------- 3. aviso de anomalia --------
	var _an_enabled = variable_global_exists("room_anomaly_enabled") && global.room_anomaly_enabled;
	var _an_id      = variable_global_exists("room_anomaly_id")    ? global.room_anomaly_id    : "";
	var _an_title   = variable_global_exists("room_anomaly_title") ? global.room_anomaly_title : "";
	var _an_desc    = variable_global_exists("room_anomaly_desc")  ? global.room_anomaly_desc  : "";

	// zera as globais para a proxima sala nao herdar
	global.room_anomaly_enabled = false;
	global.room_anomaly_id      = "";
	global.room_anomaly_title   = "";
	global.room_anomaly_desc    = "";

	// guarda no estado do slot (para logica de anomalia que o dev fizer depois)
	st.anomaly = _an_enabled ? { id: _an_id, title: _an_title, desc: _an_desc } : noone;

	// A UI e desenhada/animada por obj_control (persistente). Aqui so sinalizamos.
	// anomaly_ui_active volta a false ao trocar de sala (mata aviso pendente da
	// sala anterior, se o player saiu no meio).
	global.anomaly_ui_active     = false;
	global.anomaly_pending       = _an_enabled;
	global.anomaly_pending_title = _an_title;
	global.anomaly_pending_desc  = _an_desc;

	// enquanto true, o obj_wave_manager segura as hordas (so comecam depois que o
	// aviso de anomalia some da tela). Definido ja no creation code = antes do
	// 1o Step do wave manager, sem corrida.
	global.anomaly_block_waves = _an_enabled;

	show_debug_message("[anomaly] sala=" + _room_name + " enabled=" + string(_an_enabled)
		+ " title='" + string(_an_title) + "'");
}

/// @description "left"/"right"/"up"/"down" -> RoomDirection.*  (ou noone)
function room_dir_from_string(_s) {
	switch (_s) {
		case "up":    return RoomDirection.UP;
		case "down":  return RoomDirection.DOWN;
		case "left":  return RoomDirection.LEFT;
		case "right": return RoomDirection.RIGHT;
	}
	return noone;
}
