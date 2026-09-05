// Avançar fala
if (input_dialogue_advance_pressed() && obj_player.state == PlayerState.TALKING) {
    current_line++;
    if (current_line >= array_length(dialogue_lines)) {
		obj_player.state = PlayerState.IDLE;
		obj_player.talking = false;
        instance_destroy();
    }
}
