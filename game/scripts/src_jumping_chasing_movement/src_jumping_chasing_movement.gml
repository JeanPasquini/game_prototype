function src_jumping_chasing_movement(){

	return function () {

	    // Handle jump cooldown and prevent movement during charging attack state
	    if (pause_timer > 0 || currentState == EnemyState.CHARGING_ATTACK) {
	        pause_timer--;
	        return;
	    }

	    // No chao = ha solido logo abaixo dos PES E nao estou subindo (ver comentario
	    // em src_jumping_idle_movement: teste de ponto, nao de mascara inteira).
	    var on_ground = (vsp >= 0) && scr_enemy_point_solid(x, bbox_bottom + 1);

	    if (on_ground) {

			// Get horizontal distance to the player
			var target = obj_player.x;
			var dist = target - x;

			// Define a "deadzone" where the enemy should not attempt to jump
			var deadzone = maxRandomMovement;

			// Determine desired movement direction toward the player
			var dir = sign(dist);
			face = dir;

			// Estimate total air time based on jump physics
			var air_time = (jump_force * 2) / grv;

			// Predict horizontal displacement during the jump
			var projected_move = dir * jump_speed * air_time;

			// Predict future X position after completing the jump
			var projected_x = x + projected_move;

			// Calculate future distance to the player after the jump
			var future_dist = target - projected_x;

			// Decide whether to perform the jump based on current and predicted distances
			if (abs(dist) > deadzone) {

			    // Only jump if it will not overshoot the target excessively
			    if (abs(future_dist) >= deadzone) {
			        hsp = dir * jump_speed;
			    }
			    else {
			        hsp = 0; // Cancel movement to avoid overshooting
			    }
			}
			else {
			    hsp = 0; // Stay idle if already within the deadzone
			}

			// Initiate jump only if horizontal movement was approved
			if (hsp != 0) {
	            vsp = -jump_force;
				scr_audio_play([sde_enemy_cururu_jump], emitterAudio);
				currentMovement = EnemyState.JUMPING;
				currentChargingDelay = baseAttackDelay;
			}
	    }
	    else {
	        // Fase aerea: gravidade, com teto por ponto (bateu a cabeca subindo)
			if (vsp < 0 && scr_enemy_point_solid(x, bbox_top - 1)) {
				vsp = 0;
			}
			vsp += grv;
			if (vsp > GRV_MAX_FALL) vsp = GRV_MAX_FALL;
	    }

	    // --- Horizontal ---
	    // Bateu (mesmo de raspao) numa parede no ar -> inverte a direcao do salto.
	    // Probes A FRENTE do corpo, em 3 alturas, e ACIMA dos pes: senao o proprio
	    // chao (que tambem e solido) contaria como parede e travava o hsp.
	    if (hsp != 0) {
	        var _ahead = x + sign(hsp) * ((bbox_right - bbox_left) * 0.5 + 2);
	        if (scr_enemy_point_solid(_ahead, bbox_top + 3)
	         || scr_enemy_point_solid(_ahead, (bbox_top + bbox_bottom) * 0.5)
	         || scr_enemy_point_solid(_ahead, bbox_bottom - 6)) {
	            hsp = -hsp;
	            face = sign(hsp);
	        }
	        x += hsp;
	    }

	    // --- Vertical passo-a-passo, parando no ponto dos pes (descendo) / teto (subindo) ---
	    var _vdir = sign(vsp);
	    repeat (ceil(abs(vsp))) {
	        var _probe_y = (_vdir > 0) ? bbox_bottom + 1 : bbox_top - 1;
	        if (scr_enemy_point_solid(x, _probe_y)) {
	            vsp = 0;
	            break;
	        }
	        y += _vdir;
	    }

	    // Aterrissou -> cooldown do proximo pulo
	    if (vsp >= 0 && scr_enemy_point_solid(x, bbox_bottom + 1)) {
	        pause_timer = jump_pause;
			currentMovement = EnemyState.ONGROUND;
	    }
	}

}
