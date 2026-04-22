function src_show_player_damage_received(damage){
	if(!obj_player.invencible && obj_player.life > 0){
		scr_camera_shake(10,10);

		if(instance_exists(obj_perk_passive_energy_shield))
		{
			obj_perk_passive_energy_shield.count_hits = 0;
		}
		if(instance_exists(obj_perk_passive_energy_shield_2))
		{
			damage = 0;
			obj_perk_passive_energy_shield.count_hits = 0;
			instance_destroy(obj_perk_passive_energy_shield_2);
			var sfx = [
				sde_perk_energy_shield_broked
			];					
			scr_audio_play(sfx);
		}
		else
		{
			if(instance_exists(obj_perk_passive_berseker)) damage = damage * obj_perk_passive_berseker.damage_multiplication_taken;
			audio_play_sound(sde_player_receive_damage, 1, false);
		}
		
		var dmg = instance_create_layer(obj_player.x, obj_player.y, "instances", obj_damage_text);
		dmg.text = "- " + string(damage);
		obj_player.life -= damage;
		obj_player.invencible = true;
		obj_player.alarm[0] = obj_player.invencible_time;
		obj_combo_streak.combo_streak = 0;
	}
}