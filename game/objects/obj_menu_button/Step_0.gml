if(layer_get_visible("ui_run_finish")){
	if(input_menu_confirm_pressed()){
		scr_reset_character();
		scr_reset_run();
	}
}
else if(layer_get_visible("ui_menu_pause")){
	if(input_menu_confirm_pressed()){
		//scr_reset_character();
		//scr_reset_run();
	}
}