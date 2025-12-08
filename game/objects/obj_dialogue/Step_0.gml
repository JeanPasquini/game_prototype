// Avançar fala
if (keyboard_check_pressed(vk_enter)) {
    current_line++;
    if (current_line >= array_length(dialogue_lines)) {
		obj_player.state = PlayerState.IDLE;
		obj_player.talking = false;
        instance_destroy();
    }
}
