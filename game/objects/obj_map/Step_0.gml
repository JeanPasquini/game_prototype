if (keyboard_check_pressed(ord("M"))) {
    if (minimap_state == 0) {
        if (scr_menu_lock_try("map")) {
            minimap_state += 1;
        }
    } else {
        minimap_state += 1;
        if (minimap_state > 3) {
            minimap_state = 0;
            scr_menu_lock_release("map");
        }
    }
}