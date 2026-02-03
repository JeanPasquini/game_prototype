audio_listener_set_position(0, x, y, 0);

if (life <= 0){
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

	obj_combo_streak.alarm[0] = 1;
	var layer_id = layer_get_id("perk_in_run");

	if (layer_id != -1)
	{
	    with (all)
	    {
	        if (layer == layer_id)
	        {
	            instance_destroy();
	        }
	    }
	}



}

switch (state) {
    case PlayerState.IDLE:
    case PlayerState.WALK:
    case PlayerState.WALK_TURN:
    case PlayerState.RUN_TO_IDLE:
    case PlayerState.RUN_TURN:
    case PlayerState.RUN:
    case PlayerState.RUN_JUMP:
    case PlayerState.RUN_FALL:
    case PlayerState.JUMP:
    case PlayerState.FALL:
    case PlayerState.ATTACK:
	case PlayerState.TALKING:
		scr_combat();
	case PlayerState.DYING:
		scr_movement(); 
    break;
}
