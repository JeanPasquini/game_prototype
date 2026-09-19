if (!playing) {
    switch (phase) {
        // ===== 0: tela "Press any button to start" =====
        case 0:
            // "press any button" só aparece (fade in) depois da logo completa, e só então aceita input
            var _logo_ready = instance_exists(obj_menu_logo) && obj_menu_logo.image_alpha >= 1;
            intro_text_alpha = _logo_ready ? min(intro_text_alpha + 1 / intro_text_fade_frames, 1) : 0;
            intro_text_set_alpha(intro_text_alpha);

            var _any = _logo_ready && (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_any));
            for (var _i = 0; _logo_ready && !_any && _i < gamepad_get_device_count(); _i++) {
                if (!gamepad_is_connected(_i)) continue;
                for (var _b = gp_face1; _b <= gp_padr; _b++) {
                    if (gamepad_button_check_pressed(_i, _b)) { _any = true; break; }
                }
            }
            if (_any) {
                audio_play_sound(sde_menu_selection, 1, false);
                // "tira foto" da logo da UI e a esconde; o Draw GUI a redesenha ancorada no mundo
                with (obj_menu_logo) {
                    other.logo_snap = { spr: sprite_index, img: image_index, x: x, y: y,
                                        xs: image_xscale, ys: image_yscale, alpha: image_alpha };
                    visible = false;
                }
                intro_view_y0 = camera_get_view_y(view_camera[0]);
                phase = 1;
            }
            break;

        // ===== 1: obj_cam_follow desce até o player (a câmera acompanha com o lerp dela) =====
        case 1:
            // o "press any button" some rápido; a logo sobe junto com a descida (ver End Step)
            intro_text_alpha = max(intro_text_alpha - 1 / 30, 0);
            intro_text_set_alpha(intro_text_alpha);

            // ease-in-out (smootherstep): sai devagar, acelera no meio e "pousa" suave no player
            cam_descend_t = min(cam_descend_t + 1 / cam_descend_frames, 1);
            var _e = cam_descend_t * cam_descend_t * cam_descend_t * (cam_descend_t * (cam_descend_t * 6 - 15) + 10);
            obj_cam_follow.y = lerp(cam_descend_from, obj_player.y, _e);
            obj_cam_follow.x = lerp(obj_cam_follow.x, obj_player.x, 0.02);
            if (cam_descend_t >= 1) {
                layer_set_visible(layer_get_id("ui_introduction"), false);
                layer_set_visible(layer_get_id(layer_name), true);
                button_id = 1;
                phase = 2;
            }
            break;

        // ===== 2: menu principal (Play / Exit) =====
        case 2:
            if (input_menu_down_pressed()) { button_id += 1; if (button_id > 2) button_id = 1; audio_play_sound(sde_perk_selection_change, 1, false); }
            if (input_menu_up_pressed())   { button_id -= 1; if (button_id < 1) button_id = 2; audio_play_sound(sde_perk_selection_change, 1, false); }
            if (input_menu_confirm_pressed()) {
                audio_play_sound(sde_menu_selection, 1, false);

                if (button_id == 1) {
                    playing = true;
                    layer_set_visible(layer_name, false);
                    obj_cam.zoom_target = 1;
                    obj_player.introduction_start = true;
                } else if (button_id == 2) {
                    game_end();
                }
            }
            break;
    }
}
// espera o obj_player terminar sozinho a animação de início (ver _update_introduction em scr_movement)
else if (obj_player.state == PlayerState.IDLE) {
    obj_cam.target_ = obj_player;
    obj_cam.fixed_point = false;

    layer_set_visible(layer_get_id("ui_hud_player"), true);
    layer_set_visible(layer_get_id("ui_vignette"), true);

    scr_menu_lock_release("introduction");
    global.intro_done = true;
    instance_destroy();
}
