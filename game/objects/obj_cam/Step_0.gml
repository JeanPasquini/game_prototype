audio_listener_set_position(0, camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) * 0.5,
                               camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) * 0.5,
                               0);

// ===== FOLLOW BASE =====
if (fixed_point) {
    x = lerp(x, point_x, 0.1);
    y = lerp(y, point_y, 0.1);
} else if (instance_exists(target_)) {
    if (center_on_target) {
        // transição de porta: player no centro exato da tela
        x = lerp(x, target_.x, center_lerp);
        y = lerp(y, target_.y, center_lerp);
    } else {
        x = lerp(x, target_.x, 0.1);
        y = lerp(y, target_.y - height_ / 4, 0.1);
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
width_  = lerp(width_,  base_width_  * zoom_target, 0.08);
height_ = lerp(height_, base_height_ * zoom_target, 0.08);
camera_set_view_size(view_camera[0], width_, height_);

camera_set_view_pos(
    view_camera[0],
    (x - width_  / 2) + shake_x,
    (y - height_ / 2) + shake_y
);