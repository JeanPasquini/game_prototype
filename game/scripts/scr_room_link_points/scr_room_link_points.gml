/*
	Ponto de entrada do player (px, py) ao chegar numa sala por cada direcao.

	IMPORTANTE: cada valor aqui deve bater com a POSICAO da porta daquela direcao
	na sala. Assim, ao entrar numa sala o player nasce exatamente em cima da porta
	de retorno (a porta da mesma direcao pela qual ele entrou), garantindo a regra
	"toda sala tem uma porta de volta no lugar onde eu spawnei".

	- Salas com layout proprio tem entrada explicita (coordenadas das portas).
	- Salas sorteadas sem entrada propria usam "_default_challenge" / "_default_miniboss".
	- Ao criar uma room nova, adicione a entrada dela aqui com as coordenadas das
	  4 portas, ou ajuste o default.
*/

/// @description Devolve struct { nome_sala: { up:{px,py}, down:{px,py}, left:{px,py}, right:{px,py} }, ... }
function room_link_points() {
	return {
		HUB: {
			// player nasce no centro do HUB (nao em cima das portas)
			up:    { px: 471, py: 401 },
			down:  { px: 471, py: 401 },
			left:  { px: 471, py: 401 },
			right: { px: 471, py: 401 },
		},
		tutorial_room: {
			up:    { px: 672, py: 196 },
			down:  { px: 672, py: 196 },
			left:  { px: 672, py: 196 },
			right: { px: 672, py: 196 },
		},
		// room_safe: SEMPRE nasce no mesmo lugar, venha por qual porta vier.
		// Mude so o px/py abaixo para reposicionar o ponto padrao.
		safe_room: {
			up:    { px: 160, py: 261 },
			down:  { px: 160, py: 261 },
			left:  { px: 160, py: 261 },
			right: { px: 160, py: 261 },
		},
		store_room: {
			up:    { px: 563, py: 448 },
			down:  { px: 488, py: 453 },
			left:  { px: 32,  py: 453 },
			right: { px: 976, py: 453 },
		},

		// Salas challenge NAO precisam de entrada aqui: o scr_room_init posiciona
		// o player automaticamente na obj_door pela qual ele entrou.

		room_miniboss_01: {
			up:    { px: 160, py: 320 },
			down:  { px: 160, py: 320 },
			left:  { px: 160, py: 320 },
			right: { px: 160, py: 320 },
		},
		room_finalboss_01: {
			up:    { px: 418, py: 384 },
			down:  { px: 686, py: 408 },
			left:  { px: 32,  py: 408 },
			right: { px: 975, py: 408 },
		},

		// fallback provisorio (1 frame, tela preta) ate o scr_room_init ajustar
		_default_challenge: {
			up:    { px: 512, py: 400 },
			down:  { px: 512, py: 400 },
			left:  { px: 512, py: 400 },
			right: { px: 512, py: 400 },
		},
		_default_miniboss: {
			up:    { px: 160, py: 320 },
			down:  { px: 160, py: 320 },
			left:  { px: 160, py: 320 },
			right: { px: 160, py: 320 },
		},
	};
}

/// @description Pega os 4 pontos de ligacao de uma sala, com fallback pelo tipo.
/// @param {string} room_name
function room_link_points_for(room_name) {
	var t = room_link_points();

	if (variable_struct_exists(t, room_name)) return t[$ room_name];

	if (string_pos("room_miniboss_", room_name) == 1)  return t._default_miniboss;
	if (string_pos("room_finalboss_", room_name) == 1) return t._default_miniboss;

	return t._default_challenge;
}
