function scr_reset_run(){
	
	audio_stop_all();
	global.current_phase = "run";
	global.menu_lock = noone;

	// Salas que ficaram persistentes durante a run voltam ao estado original:
	// como nao usamos a flag nativa "persistent", basta limpar o estado; o
	// GameMaker recarrega cada .yy limpo na proxima entrada. O HUB, ao ser
	// carregado logo abaixo, ainda regenera o mapa (scr_room_init -> generate_run).
	run_state_reset();
	global.run_pos = "HUB";
	global.run_entry_dir = noone;

    var directions = getNextRoomPxAndPy("HUB", "up");
    if (!is_undefined(directions)) {
        obj_player.x = directions.px;
        obj_player.y = directions.py;
    }
		
	obj_control.time_run = 0;
	obj_control.enemy_killed = 0;
	obj_control.damage_taken = 0;
	obj_control.damage_caused = 0;
	obj_control.perk_adquired = 0;
	global.force_music = noone;

	obj_map.explored_data = {}; // reseta o fog of war do mapa para a nova run
	
    room_goto(HUB);

    audio_play_sound(sde_player_die_returning, 1, false);
		
	if(layer_get_visible("ui_run_finish"))layer_set_visible("ui_run_finish", false);
		
	obj_cam.fixed_point = noone;
	obj_cam.shake_force = noone;
	obj_cam.shake_time = noone;
}