/// @function scr_enemy_lock_mask(_spr)
/// @description Fixa a MASCARA DE COLISAO do inimigo num unico sprite: ela para de
///              mudar de forma com a animacao e nunca mais espelha/escala junto com
///              o desenho. O flip visual passa a ser feito no obj_enemy_parent Draw
///              via "face_scale" (image_xscale fica 1 pra sempre). Mesma ideia do
///              obj_player (mask_index = spr_player_idle fixo).
/// @param {Asset.GMSprite} _spr  sprite usado so como mascara de colisao
function scr_enemy_lock_mask(_spr) {
    mask_index   = _spr;
    image_xscale = 1;
    image_yscale = 1;
}

/// @function scr_enemy_solid(_x, _y)
/// @description Teste UNICO de "isto e solido pra um inimigo" com a mascara inteira
///              na posicao dada: parede, ou portao/porta FECHADOS. Portao e porta so
///              bloqueiam enquanto "open" nao for true (mesma regra do obj_player em
///              scr_movement/_col). Inimigo NUNCA colide com obj_player.
/// @param {Real} _x
/// @param {Real} _y
/// @returns {Bool}
function scr_enemy_solid(_x, _y) {

    if (place_meeting(_x, _y, obj_wall)) return true;

    var _gate = instance_place(_x, _y, obj_environment_gate);
    if (_gate != noone && !_gate.open) return true;

    var _door = instance_place(_x, _y, obj_parent_enviroment_door);
    if (_door != noone && !_door.open) return true;

    return false;
}

/// @function scr_enemy_point_solid(_px, _py)
/// @description Igual ao scr_enemy_solid mas testando um PONTO (nao a mascara toda) —
///              usado pela logica de pulo/queda pra nao confundir uma parede lateral
///              que a mascara encosta com chao/teto.
/// @param {Real} _px
/// @param {Real} _py
/// @returns {Bool}
function scr_enemy_point_solid(_px, _py) {

    if (collision_point(_px, _py, obj_wall, false, true) != noone) return true;

    var _gate = collision_point(_px, _py, obj_environment_gate, false, true);
    if (_gate != noone && !_gate.open) return true;

    var _door = collision_point(_px, _py, obj_parent_enviroment_door, false, true);
    if (_door != noone && !_door.open) return true;

    return false;
}

/// @function scr_enemy_unstick()
/// @description Rede de seguranca: se o inimigo terminou DENTRO de um solido
///              (spawn, knockback, pouso pixel-perfect, portao fechando...), procura
///              em anel (raio 1..max) o ponto livre mais proximo e reposiciona ali.
///              Prioriza sair pelos lados, depois pra cima, depois pra baixo, e so
///              entao nas diagonais. Barato: sai de imediato quando nao ha
///              sobreposicao real. So apoio no chao (some ao subir 1px) e ignorado,
///              pra nao teleportar inimigo parado no chao todo frame.
function scr_enemy_unstick() {

    if (!scr_enemy_solid(x, y)) return;
    if (!scr_enemy_solid(x, y - 1)) return; // so encostou no chao, nao esta preso

    var _max  = 48;
    var _dirs = [
        [ -1, 0 ], [ 1, 0 ], [ 0, -1 ], [ 0, 1 ],
        [ -1, -1 ], [ 1, -1 ], [ -1, 1 ], [ 1, 1 ]
    ];

    for (var _r = 1; _r <= _max; _r++) {
        for (var _i = 0; _i < array_length(_dirs); _i++) {

            var _nx = x + _dirs[_i][0] * _r;
            var _ny = y + _dirs[_i][1] * _r;

            if (!scr_enemy_solid(_nx, _ny)) {
                x = _nx;
                y = _ny;

                // zera a velocidade no(s) eixo(s) em que empurramos pra fora,
                // pra nao voltar a entrar no solido no mesmo frame
                if (_dirs[_i][0] != 0) hsp = 0;
                if (_dirs[_i][1] != 0) vsp = 0;

                return;
            }
        }
    }
}
