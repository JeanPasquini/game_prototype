function scr_reset_run(){
	
	audio_stop_all();
	global.current_phase = "phase_01";
	global.menu_lock = noone;

    var directions = getNextRoomPxAndPy(HUB, "up");
    obj_player.x = directions.px;
    obj_player.y = directions.py;
		
	obj_control.time_run = 0;
	obj_control.enemy_killed = 0;
	obj_control.damage_taken = 0;
	obj_control.damage_caused = 0;
	obj_control.perk_adquired = 0;
	global.force_music = noone;
	
    room_goto(HUB);

    audio_play_sound(sde_player_die_returning, 1, false);
		
	if(layer_get_visible("ui_run_finish"))layer_set_visible("ui_run_finish", false);
		
	obj_cam.fixed_point = noone;
	obj_cam.shake_force = noone;
	obj_cam.shake_time = noone;
}