if(keyboard_check_pressed(vk_escape)){
	paused = !paused;	
	update_pause();
}

if (keyboard_check_pressed(vk_down))
{
    button_id += 1;
	if(button_id > 3){
		button_id = 1;	
	}
}

if (keyboard_check_pressed(vk_up))
{
    button_id -= 1;
	if(button_id < 1){
		button_id = 3;	
	}
}
