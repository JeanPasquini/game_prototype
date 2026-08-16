if(layer_get_visible("ui_run_finish")){
	if(keyboard_check_pressed(ord("E"))){
		scr_reset_character();
		scr_reset_run();
	}
}
else if(layer_get_visible("ui_menu_pause")){
	if(keyboard_check_pressed(ord("E"))){
		//scr_reset_character();
		//scr_reset_run();
	}
}