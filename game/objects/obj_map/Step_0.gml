if (input_map_toggle_pressed()) {
    if (minimap_state == 0) {
        if (scr_menu_lock_try("map")) {
            minimap_state += 1;
            state_anim_t = 0;
        }
    } else {
        minimap_state += 1;
        if (minimap_state > 3) {
            minimap_state = 0;
            scr_menu_lock_release("map");
        }
        state_anim_t = 0;
    }
}

state_anim_t = clamp(state_anim_t + (1 / 12), 0, 1);

