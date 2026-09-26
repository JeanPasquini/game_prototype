audio_listener_set_position(0, camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) * 0.5,
                               camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) * 0.5,
                               0);

// ===== CÂMERA FIXA DA SALA (global.room_cam, definido via scr_room_init) =====
// Só vale enquanto NADA com prioridade acontece. A ordem abaixo já dá prioridade
// a fixed_point (boss), hurt_hold (dano) e center_on_target (porta); aqui ainda
// soltamos a câmera nas cenas do player (porta/introdução) ou se ele sair do
// enquadramento. TALKING NÃO solta: ele também é usado por pause/menus de perk,
// e a câmera deve continuar parada atrás do menu.
var _rc = (variable_global_exists("room_cam") && is_struct(global.room_cam)) ? global.room_cam : noone;
var _room_fixed_active = false;
if (_rc != noone && instance_exists(target_)) {
    var _busy = target_.state == PlayerState.TRANSITION
        || target_.state == PlayerState.INTRODUCTION;

    // salas maiores que a view: se o player chega perto da borda do quadro fixo, volta a segui-lo
    var _half_w = base_width_  * _rc.zoom * 0.5 - room_fixed_margin;
    var _half_h = base_height_ * _rc.zoom * 0.5 - room_fixed_margin;
    var _inside = abs(target_.x - _rc.x) < _half_w && abs(target_.y - _rc.y) < _half_h;

    _room_fixed_active = !_busy && _inside;
}

// ===== SAÍDA SUAVE DO PONTO FIXO =====
// Ao sair do ponto fixo (porta, borda do quadro...), a velocidade do follow não
// entra de uma vez: sobe numa curva ease-in-out durante room_fixed_release_frames.
// _follow_ease multiplica o lerp do follow normal e do center_on_target.
if (_room_fixed_active) {
    room_fixed_release = 0;
} else {
    room_fixed_release = min(room_fixed_release + 1 / room_fixed_release_frames, 1);
}
var _follow_ease = 1;
if (_rc != noone) {
    var _t = room_fixed_release;
    _follow_ease = lerp(room_fixed_release_min, 1, _t * _t * (3 - 2 * _t)); // smoothstep
}

// ===== FOLLOW BASE =====
if (fixed_point) {
    x = lerp(x, point_x, 0.1);
    y = lerp(y, point_y, 0.1);
} else if (hurt_hold > 0) {
    // câmera congelada no lugar durante o "focus" de dano;
    // o hitstop não conta como tempo de trava
    if (global.hitstop <= 0) hurt_hold--;
} else if (instance_exists(target_)) {
    if (center_on_target) {
        // transição de porta: player no centro exato da tela (sem offset nem look-ahead)
        fall_look   = lerp(fall_look, 0, 0.22);
        look_offset = lerp(look_offset, 0, 0.2);
        look_hold   = 0;
        x = lerp(x, target_.x, center_lerp * _follow_ease);
        y = lerp(y, target_.y, center_lerp * _follow_ease);
    } else if (_room_fixed_active) {
        // ponto fixo da sala: sem look-ahead nem olhar pra cima/baixo
        fall_look   = lerp(fall_look, 0, 0.22);
        look_offset = lerp(look_offset, 0, 0.2);
        look_hold   = 0;
        x = lerp(x, _rc.x, room_fixed_lerp);
        y = lerp(y, _rc.y, room_fixed_lerp);
    } else {
        // ===== LOOK-AHEAD DE QUEDA =====
        // enquanto o alvo cai rápido, a câmera "adianta" pra baixo pra mostrar o pouso;
        // ao encostar no chão volta rápido, dando a sensação de impacto.
        var _fl_target = 0;
        if (variable_instance_exists(target_, "ong") && !target_.ong && target_.vsp > 5) {
            _fl_target = clamp((target_.vsp - 5) * 4, 0, 40);
        }
        fall_look = lerp(fall_look, _fl_target, (_fl_target > fall_look) ? 0.12 : 0.22);

        // ===== OLHAR PRA CIMA/BAIXO (segurar analogico PARADO, estilo Hollow Knight) =====
        // -1 = cima, 1 = baixo, 0 = nada. Só conta se o player está no chão, imóvel
        // e sem menu travando o mundo. Precisa segurar look_hold_max frames antes de
        // a câmera começar a deslizar; ao soltar/andar volta mais rápido.
        var _look_dir = input_look_dir();
        var _player_still = variable_instance_exists(target_, "ong")
            && target_.ong
            && abs(target_.hsp) < 0.2
            && target_.state == PlayerState.IDLE
            && !global.world_was_blocked;

        if (_look_dir != 0 && _player_still) {
            look_hold = min(look_hold + 1, look_hold_max);
        } else {
            look_hold = max(look_hold - 2, 0);
        }

        var _look_target = (look_hold >= look_hold_max) ? (_look_dir * look_max) : 0;
        // desliza devagar pra fora, mas recentra mais rapido quando solta/anda
        var _look_lerp = (_look_target != 0) ? 0.06 : 0.12;
        look_offset = lerp(look_offset, _look_target, _look_lerp);

        x = lerp(x, target_.x, 0.1 * _follow_ease);
        y = lerp(y, target_.y - height_ * follow_y_ratio + fall_look + look_offset, 0.1 * _follow_ease);
    }
}
// se nenhuma condição bater, x/y simplesmente mantêm o valor do frame anterior
// em vez de matar o evento inteiro

// ===== UPDATE SHAKE =====
if (shake_time > 0) {
    var tx = random_range(-shake_force, shake_force);
    var ty = random_range(-shake_force, shake_force);
    shake_x = lerp(shake_x, tx, 0.6);
    shake_y = lerp(shake_y, ty, 0.6);

    // só começa a decair a força quando faltar pouco tempo (ex: últimos 15 frames)
    if (shake_time <= 15) {
        shake_force *= shake_decay_force;
    }

    shake_time--;
} else {
    shake_x = lerp(shake_x, 0, shake_decay_pos);
    shake_y = lerp(shake_y, 0, shake_decay_pos);
}

// ===== UPDATE ZOOM =====
zoom_punch = lerp(zoom_punch, 0, 0.12);   // recuo de zoom decai sozinho
var _zoom = zoom_target + zoom_punch;
if (_room_fixed_active) _zoom *= _rc.zoom;   // zoom opcional do ponto fixo da sala

width_  = lerp(width_,  base_width_  * _zoom, 0.08);
height_ = lerp(height_, base_height_ * _zoom, 0.08);
camera_set_view_size(view_camera[0], width_, height_);

// ===== LIMITES DA SALA =====
// a view nunca mostra área fora da sala (antes o "object following" nativo garantia isso);
// se a sala for menor que a view, centraliza em vez de clampar
var _view_x = (x - width_  / 2) + shake_x;
var _view_y = (y - height_ / 2) + shake_y;
_view_x = (room_width  > width_)  ? clamp(_view_x, 0, room_width  - width_)  : (room_width  - width_)  / 2;
_view_y = (room_height > height_) ? clamp(_view_y, 0, room_height - height_) : (room_height - height_) / 2;

camera_set_view_pos(view_camera[0], _view_x, _view_y);