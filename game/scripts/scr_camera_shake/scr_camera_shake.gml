function scr_camera_shake(force, time) {
    if (!instance_exists(obj_cam)) exit;

    obj_cam.shake_force = max(obj_cam.shake_force, force);
    obj_cam.shake_time  = max(obj_cam.shake_time,  time);
}

/// @function scr_camera_zoom_punch(amount)
/// @description Dá um "recuo" instantâneo no zoom da câmera que decai sozinho.
///              amount > 0 = afasta (mostra mais cena) — bom pra impacto de queda.
function scr_camera_zoom_punch(amount) {
    if (!instance_exists(obj_cam)) exit;

    obj_cam.zoom_punch = max(obj_cam.zoom_punch, amount);
}
