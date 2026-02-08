paused = false;
layer_name = "ui_pause_layer"
button_id = 1;

update_pause = function(){
	if(paused){
		instance_deactivate_all(true);
		layer_set_visible(layer_name, true);
		button_id = 1;
	}
	else{
		instance_activate_all();
		layer_set_visible(layer_name, false);
	}
}

update_pause();

