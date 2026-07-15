if(layer_get_visible("ui_run_finish")){
	if(keyboard_check_pressed(ord("E"))){
		scr_reset_character();
		scr_reset_run();
	}
}