if (!playing) {
    if (layer_get_visible(layer_name)) {
        if (keyboard_check_pressed(vk_down)) { button_id += 1; if (button_id > 2) button_id = 1; }
        if (keyboard_check_pressed(vk_up))   { button_id -= 1; if (button_id < 1) button_id = 2; }
        if (keyboard_check_pressed(ord("E"))) {
            if (button_id == 1) {
                playing = true;
                layer_set_visible(layer_name, false);
                obj_cam.zoom_target = 1;
                obj_player.introduction_start = true;
            } else if (button_id == 2) {
                game_end();
            }
        }
    }
}
// espera o obj_player terminar sozinho a animação de início (ver _update_introduction em scr_movement)
else if (obj_player.state == PlayerState.IDLE) {
    obj_cam.target_ = obj_player;
    obj_cam.fixed_point = false;

    layer_set_visible(layer_get_id("ui_hud_player"), true);
    layer_set_visible(layer_get_id("ui_vignette"), true);

    instance_destroy();
}
