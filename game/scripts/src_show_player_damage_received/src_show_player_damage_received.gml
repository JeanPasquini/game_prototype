function src_show_player_damage_received(damage){
	if(!obj_player.invencible && obj_player.life > 0){
		
		obj_control.damage_taken ++;
		
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

		// ===== FEEDBACK DE DANO =====
		if (damage > 0) {
			with (obj_player) {
				hit_flash = hit_flash_max;
				// encolhe no impacto (a mola devolve pra 1)
				player_add_squash(-0.30, 0.22);

				// "focus" estilo Hollow Knight — só durante gameplay ativo
				var _hurt_fx_ok =
					   state != PlayerState.DYING
					&& state != PlayerState.TRANSITION
					&& state != PlayerState.INTRODUCTION
					&& !instance_exists(obj_transiction)
					&& !(instance_exists(obj_menu_boss_introduction) && obj_menu_boss_introduction.boss_introduction);

				if (_hurt_fx_ok) {
					// vinheta circular fechando/escurecendo a tela
					hurt_fx_timer = hurt_fx_duration;

					// recuo em direção a um dos cantos: pra trás (oposto ao rosto) e pra cima.
					// Aplicado como IMPULSO de velocidade (hsp/vsp) — _resolve_collisions()
					// trata as paredes, então não atravessa obj_wall nem trava dentro dela.
					hurt_recoil_timer = hurt_recoil_max;
					hsp = -face * hurt_knock_h;

					// hit no ar: "pop" pra cima + gravidade que volta suave
					// (hurt_grav_timer), pra não despencar com força total no começo
					if (!ong) {
						vsp = -hurt_knock_v;
						hurt_grav_timer = hurt_grav_max;
					}

					// trava a câmera por um instante pra valorizar o efeito
					if (instance_exists(obj_cam)) {
						obj_cam.hurt_hold = max(obj_cam.hurt_hold, obj_cam.hurt_hold_max);
					}
				}
			}
			global.hitstop = max(global.hitstop, 5);
			scr_camera_zoom_punch(0.05);
		}
	}
}