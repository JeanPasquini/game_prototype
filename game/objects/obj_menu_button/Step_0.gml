var manager = obj_menu_pause_manager;

if (manager.button_id == 1 && keyboard_check_pressed(vk_enter))
{
	manager.paused = !manager.paused;
	manager.update_pause();
}
else if (manager.button_id == 2 && keyboard_check_pressed(vk_enter)){
	game_end();
}