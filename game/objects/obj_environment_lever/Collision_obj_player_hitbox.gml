if(!activated){
	activated = true;
	image_speed = 1;
	scr_audio_play([sde_environment_lever], emitterAudio);
	with (obj_environment_gate) {
	    if (id_gate == other.id_lever) {
	        actived = true;
			image_speed = 1;
	    }
	}
	
	switch (function_lever) {
    case 1:
        with(obj_player){
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
				money = 0;
				key = key_initial;
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
    break;
	}
}