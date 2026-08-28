audio_listener_set_position(0, camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) * 0.5,
                               camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) * 0.5,
                               0);

// ===== FOLLOW BASE =====
if (fixed_point) {
    x = lerp(x, point_x, 0.1);
    y = lerp(y, point_y, 0.1);
} else if (instance_exists(target_)) {

    // ===== LOOK-AHEAD DE QUEDA =====
    // enquanto o alvo cai rápido, a câmera "adianta" pra baixo pra mostrar o pouso;
    // ao encostar no chão volta rápido, dando a sensação de impacto.
    var _fl_target = 0;
    if (variable_instance_exists(target_, "ong") && !target_.ong && target_.vsp > 5) {
        _fl_target = clamp((target_.vsp - 5) * 4, 0, 40);
    }
    fall_look = lerp(fall_look, _fl_target, (_fl_target > fall_look) ? 0.12 : 0.22);

    x = lerp(x, target_.x, 0.1);
    y = lerp(y, target_.y - height_ / 4 + fall_look, 0.1);
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

width_  = lerp(width_,  base_width_  * _zoom, 0.08);
height_ = lerp(height_, base_height_ * _zoom, 0.08);
camera_set_view_size(view_camera[0], width_, height_);

camera_set_view_pos(
    view_camera[0],
    (x - width_  / 2) + shake_x,
    (y - height_ / 2) + shake_y
);