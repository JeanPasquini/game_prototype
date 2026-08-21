paused = false;
layer_name = "ui_menu_pause"
button_id = 1;

update_pause = function(){
	if(!layer_get_visible(layer_name)){
		if (!scr_menu_lock_try("pause")) return;
		button_id = 1;
		layer_set_visible(layer_name, true);
		obj_player.state = PlayerState.TALKING;
		obj_player.talking = true;
	}
	else{
		layer_set_visible(layer_name, false);
		obj_player.state = PlayerState.IDLE;
		obj_player.talking = false;
		scr_menu_lock_release("pause");
	}

}

