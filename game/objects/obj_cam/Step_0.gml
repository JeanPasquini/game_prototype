audio_listener_set_position(0, camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) * 0.5,
                               camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) * 0.5,
                               0);

if (!instance_exists(target_)) exit;



// ===== FOLLOW BASE =====
x = lerp(x, target_.x, 0.1);
y = lerp(y, target_.y - height_ / 4, 0.1);

// ===== UPDATE SHAKE =====
if (shake_time > 0) {

    // gera alvo aleatório
    var tx = random_range(-shake_force, shake_force);
    var ty = random_range(-shake_force, shake_force);

    // suaviza deslocamento (permite Y funcionar!)
    shake_x = lerp(shake_x, tx, 0.6);
    shake_y = lerp(shake_y, ty, 0.6);

    shake_force *= shake_decay_force;
    shake_time--;
} else {
    // retorno suave ao centro
    shake_x = lerp(shake_x, 0, shake_decay_pos);
    shake_y = lerp(shake_y, 0, shake_decay_pos);
}

// ===== APPLY ONCE =====
camera_set_view_pos(
    view_camera[0],
    (x - width_  / 2) + shake_x,
    (y - height_ / 2) + shake_y
);
