/*
	Geracao dinamica da RUN.

	Monta global.rooms_map com UMA fase ("run"), indexada por CHAVE DE SLOT
	(string), nao por nome de sala. Isso permite que a MESMA sala apareca varias
	vezes numa RUN — ex.: so existe room_challenge_01, mas a RUN sempre tem 3
	desafios antes do mini-boss (repetindo a sala).

	Estrutura fixa (escopo DEMO, ate o 1o mini-boss):
		HUB  -> s0 (room_safe / safe_room, SEMPRE a 1a sala, SEM porta de volta pro HUB)
		s0   -> s1 (desafio 1)
		s1   -> s2 (desafio 2)
		s2   -> s3 (desafio 3)  + ramificacao "store" (store_room)  -> 1 loja no caminho
		s3   -> s4 (mini-boss, terminal: matar encerra a RUN)

	shuffle_rooms() randomiza as direcoes das portas e garante o caminho de volta
	em toda sala.

	global.run_pos guarda a chave do slot ATUAL do player (mantida por
	obj_transiction ao trocar de sala e por scr_room_init ao entrar no HUB).
*/

/// @description Monta um no do mapa.
/// @param {Id.Room} _room     asset da room usada neste slot
/// @param {array}   _sends    chaves de slot para onde este slot envia
/// @param {bool}    _returns  (informativo) se a sala permite retorno
/// @param {Id.Sound} _music   musica da sala (ou noone)
function run_make_node(_room, _sends, _returns, _music) {
	var sends = {};
	for (var i = 0; i < array_length(_sends); i++) {
		sends[$ _sends[i]] = _sends[i];
	}

	var lp = room_link_points_for(room_get_name(_room));

	return {
		room:        _room,
		sends:       sends,
		connections: {},          // preenchido por shuffle_rooms()
		returns:     _returns,
		music:       _music,
		up:    { px: lp.up.px,    py: lp.up.py    },
		down:  { px: lp.down.px,  py: lp.down.py  },
		left:  { px: lp.left.px,  py: lp.left.py  },
		right: { px: lp.right.px, py: lp.right.py },
	};
}

/// @description Sorteia _n salas de um pool, COM repeticao quando o pool e menor.
function run_pick_rooms(pool, _n, _fallback) {
	var out = pool_pick_n(pool, _n);
	while (array_length(out) < _n) array_push(out, _fallback);
	return out;
}

/// @description TESTE: forca TODOS os desafios da RUN a serem uma sala especifica.
/// Troque o "return noone" por, ex.: "return room_challenge_05;" para testar uma
/// sala. Volte pra noone para o sorteio normal.
function run_debug_forced_challenge() {
	return noone // room_challenge_05;
}

/// @description (Re)gera global.rooms_map para uma nova RUN.
function generate_run() {
	randomize();

	var pools = run_build_pools();

	var _forced = run_debug_forced_challenge();
	var ch = (_forced != noone)
		? [_forced, _forced, _forced]
		: run_pick_rooms(pools.challenge, 3, room_challenge_01);

	var mb_arr = pool_pick_n(pools.miniboss, 1);
	var mb = (array_length(mb_arr) > 0) ? mb_arr[0] : room_miniboss_01;

	var run = {};

	run[$ "HUB"]   = run_make_node(HUB,        ["s0"],          false, sdt_hub);
	run[$ "s0"]    = run_make_node(safe_room,  ["s1"],          false, sdt_phase1); // sem porta de volta pro HUB
	run[$ "s1"]    = run_make_node(ch[0],      ["s2"],          true,  sdt_phase1);
	run[$ "s2"]    = run_make_node(ch[1],      ["s3", "store"], true,  sdt_phase1);
	run[$ "s3"]    = run_make_node(ch[2],      ["s4"],          true,  sdt_phase1);
	run[$ "s4"]    = run_make_node(mb,         [],              true,  sdt_phase1_mini_boss1);
	run[$ "store"] = run_make_node(store_room, [],              true,  sdt_phase1);

	run[$ "next_phase"] = "run";

	global.rooms_map       = { run: run };
	global.first_room_name = HUB;   // legado
	global.current_phase   = "run";
	global.run_pos         = "HUB";

	shuffle_rooms();

	show_debug_message("generate_run: s1=" + room_get_name(ch[0])
		+ " s2=" + room_get_name(ch[1])
		+ " s3=" + room_get_name(ch[2])
		+ " s4=" + room_get_name(mb));
}
