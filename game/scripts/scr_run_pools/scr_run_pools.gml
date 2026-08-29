/*
	Descoberta automatica das salas jogaveis numa RUN.

	Varre TODAS as rooms do projeto (room_first / room_next) e separa por
	prefixo de nome. Criar uma room nova no GameMaker com o prefixo certo
	(ex.: "room_challenge_07") ja a torna sorteavel numa RUN, sem registro
	manual em lugar nenhum.

	Prefixos reconhecidos:
		room_challenge_*  -> salas de desafio
		room_miniboss_*   -> mini-bosses
		room_finalboss_*  -> boss final
*/

/// @description Devolve { challenge:[...], miniboss:[...], finalboss:[...] } com room ids.
function run_build_pools() {
	var pools = {
		challenge:  [],
		miniboss:   [],
		finalboss:  [],
	};

	var r = room_first;
	while (r != -1) {
		var n = room_get_name(r);

		if (string_pos("room_challenge_", n) == 1) {
			array_push(pools.challenge, r);
		} else if (string_pos("room_miniboss_", n) == 1) {
			array_push(pools.miniboss, r);
		} else if (string_pos("room_finalboss_", n) == 1) {
			array_push(pools.finalboss, r);
		}

		r = room_next(r);
	}

	return pools;
}

/// @description Sorteia _n salas de um pool.
/// Se o pool tiver 1 sala, devolve sempre ela. Se tiver menos que _n, permite repeticao.
/// @param {array} pool
/// @param {real}  _n
function pool_pick_n(pool, _n) {
	var total = array_length(pool);
	var out = [];

	if (total == 0) return out;

	if (total <= _n) {
		// pool pequeno: usa todas e completa repetindo o que houver
		for (var i = 0; i < _n; i++) {
			array_push(out, pool[i mod total]);
		}
		return out;
	}

	// pool suficiente: sorteia _n salas distintas
	var bag = array_create(total);
	array_copy(bag, 0, pool, 0, total);

	for (var k = 0; k < _n; k++) {
		var idx = irandom(array_length(bag) - 1);
		array_push(out, bag[idx]);
		array_delete(bag, idx, 1);
	}

	return out;
}
