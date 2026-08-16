
if(keyboard_check_pressed(vk_escape)){	
	update_pause();
}

if(layer_get_visible("ui_menu_pause")){
	if (keyboard_check_pressed(vk_down))
	{
	    button_id += 1;
		if(button_id > 4){
			button_id = 1;	
		}
	}

	if (keyboard_check_pressed(vk_up))
	{
	    button_id -= 1;
		if(button_id < 1){
			button_id = 4;	
		}
	}

	if(keyboard_check_pressed(ord("E"))){
		if(button_id == 1){ // resume
			update_pause();
		}
		else if (button_id == 2){ // return to hub
			scr_reset_character();
			scr_reset_run();
			
			update_pause();
		}
		else if (button_id == 3){
		
		}
		else if (button_id == 4){ // exit game
			game_end();
		}
	}
}