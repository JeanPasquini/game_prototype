var manager = obj_menu_pause_manager;

if (manager.button_id == 1 && keyboard_check_pressed(vk_enter))
{
	manager.paused = !manager.paused;
	manager.update_pause();
}
else if (manager.button_id == 2 && keyboard_check_pressed(vk_enter)){
	global.current_phase = "phase_01";

    var directions = getNextRoomPxAndPy(HUB, "up");
    x = directions.px;
    y = directions.py;

    room_goto(HUB);
	
	with(obj_player){
		state = PlayerState.DYING;
		life_max = life_max_initial;
		damage_base = damage_base_initial;
		damage = damage_initial;
		spd = spd_initial;
		spd_max = spd_max_initial;
		attack_speed = attack_speed_initial; 
		attack_recoil = attack_recoil_initial;
		attack_knockback = attack_knockback_initial;
		invencible_time = invencible_time_initial;
		critical_chance = critical_chance_initial;
		lucky_chance = lucky_chance_initial;
		perks_limit_run = perks_limit_run_initial;
		perks_obtained_run = perks_obtained_run_initial;
		perks_obtained_run_obj = perks_obtained_run_obj_initial;
		key = key_initial;
		energy_max = energy_max_initial;
		energy = energy_initial;
		perk_activatable = noone;
		perk_activatable_obj = noone;
		invencible = true;
		alarm[0] = 120;	
	}
}
else if (manager.button_id == 3 && keyboard_check_pressed(vk_enter)){
	game_end();
}