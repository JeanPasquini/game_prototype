/*
	Colisão dos drops (filhos de obj_drop_parent).

	Usa EXATAMENTE o mesmo teste de sólido do obj_player (_col, em scr_movement):
	obj_wall, obj_wall_block, portas (obj_parent_enviroment_door) e portões
	(obj_environment_gate) fechados. Assim, se o player ganhar um sólido novo,
	os drops ganham junto. Além disso os drops param em cima de obj_spike (pra
	não caírem dentro do buraco de espinhos e ficarem impossíveis de pegar).
*/

/// @function scr_drop_solid(xp, yp)
/// @description true se a máscara do drop em (xp, yp) bate em algo sólido.
function scr_drop_solid(_xp, _yp) {
	if (_col(_xp, _yp)) return true;
	if (place_meeting(_xp, _yp, obj_spike)) return true;
	return false;
}

/// @function scr_drop_unstick()
/// @description Mesmo princípio do _unstick() do player: se o drop nasceu /
///              terminou DENTRO de um sólido (ex.: cristal pendurado no teto,
///              inimigo morto encostado na parede, portão fechando), procura
///              em anel o ponto livre mais próximo e reposiciona ali.
function scr_drop_unstick() {

	if (!scr_drop_solid(x, y)) return;

	// só encostado no chão (sair 1px pra cima resolve) não é estar preso
	if (!scr_drop_solid(x, y - 1)) return;

	var _max  = 32;
	var _dirs = [
		[  0, -1 ], [ -1,  0 ], [  1,  0 ], [  0,  1 ],
		[ -1, -1 ], [  1, -1 ], [ -1,  1 ], [  1,  1 ]
	];

	for (var _r = 1; _r <= _max; _r++) {
		for (var _i = 0; _i < array_length(_dirs); _i++) {

			var _nx = x + _dirs[_i][0] * _r;
			var _ny = y + _dirs[_i][1] * _r;

			if (!scr_drop_solid(_nx, _ny)) {
				x = _nx;
				y = _ny;
				if (_dirs[_i][0] != 0) hsp = 0;
				if (_dirs[_i][1] != 0) vsp = 0;
				return;
			}
		}
	}
}

/// @function scr_drop_move()
/// @description Gravidade + atrito + resolução de colisão por eixo (mesmo
///              formato do _resolve_collisions() do player), com um quique
///              leve no chão/paredes.
function scr_drop_move() {

	scr_drop_unstick();

	// GRAVIDADE
	vsp = min(vsp + grv, GRV_MAX_FALL);

	// ATRITO (mais forte encostado no chão, pra não deslizar pela sala toda)
	on_ground = scr_drop_solid(x, y + 1);
	var _fric = on_ground ? friction_ground : friction_air;
	if (abs(hsp) > _fric) hsp -= _fric * sign(hsp);
	else hsp = 0;

	// HORIZONTAL
	if (scr_drop_solid(x + hsp, y)) {
		while (!scr_drop_solid(x + sign(hsp), y)) {
			x += sign(hsp);
		}
		hsp = -hsp * bounce_wall;
	} else {
		x += hsp;
	}

	// VERTICAL
	if (scr_drop_solid(x, y + vsp)) {
		while (!scr_drop_solid(x, y + sign(vsp))) {
			y += sign(vsp);
		}
		// quica no chão só se caiu com força; teto só zera
		vsp = (vsp > bounce_min_vsp) ? -vsp * bounce_floor : 0;
	} else {
		y += vsp;
	}
}
