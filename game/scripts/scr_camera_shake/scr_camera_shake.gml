function scr_camera_shake(force, time) {
    if (!instance_exists(obj_cam)) exit;

    obj_cam.shake_force = max(obj_cam.shake_force, force);
    obj_cam.shake_time  = max(obj_cam.shake_time,  time);
}
