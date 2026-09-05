
if(input_pause_pressed()){
	update_pause();
}

if(layer_get_visible("ui_menu_pause")){

	if (input_menu_back_pressed()){ // círculo: sai do menu de pause
		update_pause();
	}

	if (input_menu_down_pressed())
	{
	    button_id += 1;
		if(button_id > 4){
			button_id = 1;
		}
	}

	if (input_menu_up_pressed())
	{
	    button_id -= 1;
		if(button_id < 1){
			button_id = 4;
		}
	}

	if(input_menu_confirm_pressed()){
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