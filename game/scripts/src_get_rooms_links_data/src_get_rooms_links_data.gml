/// @description Ponto (px,py) onde o player nasce ao entrar no slot _dir dado.
/// @param {string} next_key  chave de slot do mapa da RUN (ex.: "s1", "HUB")
/// @param {string} dir       "up" | "down" | "left" | "right"
function getNextRoomPxAndPy(next_key, dir) {
	var node = global.rooms_map[$ global.current_phase][$ next_key];
	if (is_undefined(node)) return undefined;

	var p = node[$ dir];
	if (is_undefined(p)) return undefined;

	return { px: p.px, py: p.py };
}
