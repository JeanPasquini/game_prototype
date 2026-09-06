function src_jumping_idle_movement() {

	return function () {

	    // Handle delay between jumps to avoid continuous hopping
	    if (pause_timer > 0) {
	        pause_timer--;
	        return;
	    }

	    // No chao = ha solido logo abaixo dos PES (ponto no centro-baixo da mascara)
	    // E nao estou subindo. Um teste de mascara inteira aqui daria "no chao"
	    // tambem quando o sapo so encosta de lado numa quina de parede caindo.
	    var on_ground = (vsp >= 0) && scr_enemy_point_solid(x, bbox_bottom + 1);

	    if (on_ground) {

	        // Define horizontal movement boundaries relative to the spawn position
	        var min_x = xstart - maxRandomMovement;
			var max_x = xstart + maxRandomMovement;

			// Enforce boundary limits before choosing movement direction
			if (x <= min_x) jump_state = JumpState.LEFT_MIDDLE;
			if (x >= max_x) jump_state = JumpState.RIGHT_MIDDLE;

			// Determine horizontal movement based on the current jump state
			switch (jump_state) {
			    case JumpState.LEFT:         hsp = -jump_speed; break;
			    case JumpState.LEFT_MIDDLE:  hsp =  jump_speed; break;
			    case JumpState.RIGHT:        hsp =  jump_speed; break;
			    case JumpState.RIGHT_MIDDLE: hsp = -jump_speed; break;
			}

			if (hsp != 0) face = sign(hsp);

	        // Initiate jump by applying upward vertical speed
	        vsp = -jump_force;
			currentMovement = EnemyState.JUMPING;
			scr_audio_play([sde_enemy_cururu_jump], emitterAudio);
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
	            jump_state = (hsp > 0) ? JumpState.RIGHT : JumpState.LEFT;
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
