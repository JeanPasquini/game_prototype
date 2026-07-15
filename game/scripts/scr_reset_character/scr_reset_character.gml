function scr_reset_character(){
	with(obj_player){
		
				state = PlayerState.IDLE;
			    talking = false;
		
				life_max = life_max_initial;
				life = life_max;
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
				array_resize(perks_obtained_run, 0);
				array_resize(perks_obtained_run_obj, 0);
				key = key_initial;
				energy_max = energy_max_initial;
				energy = energy_initial;
				perk_activatable = noone;
				perk_activatable_obj = noone;
				perk_activatable_active = noone;
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
}