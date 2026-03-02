if (keyboard_check_pressed(ord("M"))) {
    minimap_state += 1;
    if (minimap_state > 3) minimap_state = 0;
}