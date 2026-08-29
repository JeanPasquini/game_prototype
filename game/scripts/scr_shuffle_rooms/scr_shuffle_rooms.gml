/*
	Randomiza as DIRECOES das portas do mapa da RUN (sensacao de labirinto),
	mantendo:
	  - o caminho de volta SEMPRE presente: toda sala tem uma porta de retorno
	    para a sala anterior, na direcao oposta a que o player usou para entrar
	    (e portanto no mesmo ponto onde ele spawnou).
	  - o sistema de portas cima/baixo/esquerda/direita.

	O mapa e indexado por CHAVE DE SLOT (string: "HUB", "s0", "s1", ...), nao por
	nome de sala, para permitir que a mesma sala apareca varias vezes na RUN
	(ex.: so existe room_challenge_01, mas a RUN tem 3 desafios).

	No de mapa:
	  global.rooms_map[fase][slot] = {
	      room:        <asset da room>,
	      sends:       { slot_destino: slot_destino, ... },
	      connections: { dir: slot_destino, ... },   // preenchido aqui
	      returns, music, up/down/left/right
	  }
*/

function shuffle_rooms() {
	randomize();
	var visited = ds_map_create();
	_shuffle_node("HUB", noone, noone, visited);
	ds_map_destroy(visited);
}

function _shuffle_node(key, back_key, back_dir, visited) {
	if (ds_map_exists(visited, key)) return;
	ds_map_add(visited, key, true);

	var node = global.rooms_map[$ global.current_phase][$ key];
	if (is_undefined(node)) return;

	var dirs = ["up", "down", "left", "right"];
	var conn = {};

	// caminho de volta: reservado quando o no permite retorno (node.returns).
	// Ex.: a room_safe (1a sala da RUN) tem returns=false -> sem porta de volta pro HUB.
	if (back_key != noone && back_dir != noone && node.returns) {
		conn[$ back_dir] = back_key;

		var kept = [];
		for (var i = 0; i < array_length(dirs); i++) {
			if (dirs[i] != back_dir) array_push(kept, dirs[i]);
		}
		dirs = kept;
	}

	// distribui as saidas ("sends") em direcoes aleatorias das que sobraram
	var targets = variable_struct_get_names(node.sends);
	for (var i = 0; i < array_length(targets); i++) {
		if (array_length(dirs) == 0) break; // seguranca: no maximo 4 conexoes

		var tkey = node.sends[$ targets[i]];

		var di = irandom(array_length(dirs) - 1);
		var d  = dirs[di];
		array_delete(dirs, di, 1);

		conn[$ d] = tkey;

		_shuffle_node(tkey, key, _opposite_dir(d), visited);
	}

	node.connections = conn;
}


function _opposite_dir(dir) {
	switch (dir) {
		case "up":    return "down";
		case "down":  return "up";
		case "left":  return "right";
		case "right": return "left";
	}
	return noone;
}
