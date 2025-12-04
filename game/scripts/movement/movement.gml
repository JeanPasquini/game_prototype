function movement() {

    // === ATUALIZAÇÃO DE TEMPORIZADORES ===
    if (tap_timer_left > 0) tap_timer_left--;
    if (tap_timer_right > 0) tap_timer_right--;

    // === GRAVIDADE ===
    vsp += grv;

    // === BLOQUEIO DE MOVIMENTO QUANDO ABAIXADO OU ATACANDO ===
    if (state == PlayerState.DOWNED) return;

    if (state != PlayerState.LIGHT_ATTACK && 
        state != PlayerState.HEAVY_ATTACK && 
        state != PlayerState.WAIT_ATTACK) {

        // --- DETECÇÃO DE DUPLO TOQUE (CORRIDA) ---
        if (keyboard_check_pressed(vk_right)) {
            if (tap_timer_right > 0) run = true;
            else tap_timer_right = double_tap_threshold;
        }
        if (keyboard_check_pressed(vk_left)) {
            if (tap_timer_left > 0) run = true;
            else tap_timer_left = double_tap_threshold;
        }

        // === MOVIMENTO HORIZONTAL ===
        var base_spd = run ? spd * 2 : spd;
        var accel = 0.3;
        var fric  = 0.15;
        var move_input = 0;

        if (keyboard_check(vk_right)) move_input = 1;
        else if (keyboard_check(vk_left)) move_input = -1;

        // --- VIRADA SUAVE ---
        if (move_input != 0 && move_input != face && !turning) {
            turning = true;
            turn_timer = 0;
            turn_duration = 10;
            turn_target_dir = move_input;
			if(run){
				state = PlayerState.RUN_TURN;
			}
			else{
				state = PlayerState.WALK_TURN;
			}
            
        }

        if (turning) {
            turn_timer++;
            var target_spd = turn_target_dir * (base_spd * 0.5);
            hsp = lerp(hsp, target_spd, accel);

            if (turn_timer >= turn_duration) {
                face = turn_target_dir;
                turning = false;
				run = false;
            }
        } 
        else {
            if (move_input != 0) {
                var target_spd = move_input * base_spd;
                hsp = lerp(hsp, target_spd, accel);
            } else {
                hsp = lerp(hsp, 0, fric);
                if (abs(hsp) < 0.1) hsp = 0;
            }
        }

        // --- CORRIDA DESLIGADA SE PARAR ---
        if (!keyboard_check(vk_right) && !keyboard_check(vk_left)) {
            if (abs(hsp) < 1 && !turning) run = false;
        }

        // === PULO ===
        if (keyboard_check_pressed(vk_up) && ong) {
            vsp = jmp;
        }
        if (!keyboard_check(vk_up) && vsp < 0) {
            vsp *= 0.5;
        }
    }

    // === COLISÕES ===
    // HORIZONTAL
    if (place_meeting(x + hsp, y, obj_wall)) {
        while (!place_meeting(x + sign(hsp), y, obj_wall)) x += sign(hsp);
        hsp = 0;
    }
    x += hsp;

    // VERTICAL
    ong = false;
    if (place_meeting(x, y + vsp, obj_wall)) {
        while (!place_meeting(x, y + sign(vsp), obj_wall)) y += sign(vsp);
        if (vsp > 0) ong = true;
        vsp = 0;
    }
    y += vsp;

    // === KNOCKBACK ===
    if (abs(knockback_x) > 0.1 || abs(knockback_y) > 0.1) {
        var nx = x + knockback_x * 0.5;
        var ny = y + knockback_y * 0.5;
        if (!place_meeting(nx, ny, obj_wall)) {
            x = nx;
            y = ny;
        }
        knockback_x *= 0.95;
        knockback_y *= 0.95;
    } else {
        knockback_x = 0;
        knockback_y = 0;
    }

    // === DIREÇÃO DO SPRITE ===
    image_xscale = face;

    // === ESTADOS E SPRITES ===
    if (!ong) {
        // --- NO AR ---
        if (vsp < 0) {
            if (state != PlayerState.JUMP && state != PlayerState.RUN_JUMP) {
                state = run ? PlayerState.RUN_JUMP : PlayerState.JUMP;
                obj_player.sprite_index = spr_player_jumping;
                obj_player.image_index = 0;
                obj_player.image_speed = 1;
            }

            if (obj_player.sprite_index == spr_player_jumping &&
                obj_player.image_index >= obj_player.image_number - 1) {
                obj_player.image_index = obj_player.image_number - 1;
                obj_player.image_speed = 0;
            }
        } else {
            if (state != PlayerState.FALL && state != PlayerState.RUN_FALL) {
                state = run ? PlayerState.RUN_FALL : PlayerState.FALL;
                obj_player.sprite_index = spr_player_falling;
                obj_player.image_index = 0;
                obj_player.image_speed = 1;
            }

            if (obj_player.sprite_index == spr_player_falling &&
                obj_player.image_index >= obj_player.image_number - 1) {
                obj_player.sprite_index = spr_player_falling_loop;
                obj_player.image_index = 0;
                obj_player.image_speed = 1;
            }
        }
    } 
    else {
        // --- NO CHÃO ---
        if (state == PlayerState.WALK_TURN) {
            if (obj_player.sprite_index != spr_player_walking_turn) {
                obj_player.sprite_index = spr_player_walking_turn;
                obj_player.image_speed = 1;
                obj_player.image_index = 0;
            }

            if (obj_player.image_index >= image_number - 1) {
                obj_player.image_speed = 0;
                obj_player.image_index = image_number - 1;

                state = (abs(hsp) > 0.1)
                    ? PlayerState.WALK
                    : PlayerState.IDLE;

                obj_player.sprite_index = (state == PlayerState.WALK)
                    ? spr_player_walking
                    : spr_player_idle;

                obj_player.image_speed = 1;
            }
        } 
		else if (state == PlayerState.RUN_TURN) {
		    if (obj_player.sprite_index != spr_player_running_turn) {
		        obj_player.sprite_index = spr_player_running_turn;
		        obj_player.image_speed = 1.4;
		        obj_player.image_index = 0;
		    }

		    // impulso de avanço durante a virada
		    var forward_push = 2.0 * face;

		    hsp += forward_push * 0.5;

		    // suaviza a virada
		    var target_spd = face * (spd * 1.2);
		    hsp = lerp(hsp, target_spd, 0.25);

		    // termina a animação e volta ao estado de corrida
		    if (obj_player.image_index >= image_number - 1) {
		        obj_player.image_speed = 0;
		        obj_player.image_index = image_number - 1;

		        state = PlayerState.RUN;
		        obj_player.sprite_index = spr_player_running;
		        obj_player.image_speed = 1;
		    }
		}



        else {
            if (abs(hsp) > 0.1) {
                state = run ? PlayerState.RUN : PlayerState.WALK;
                obj_player.sprite_index = run ? spr_player_running : spr_player_walking;
                obj_player.image_speed = 1;
            } else {
                state = PlayerState.IDLE;
                obj_player.sprite_index = spr_player_idle;
                obj_player.image_speed = 1;
            }
        }
    }
	
	// --- CONTROLE DA FUMAÇA DE CORRIDA ---
	if (state == PlayerState.RUN && ong) {
	    // cria a fumaça se ainda não existir
	    if (!instance_exists(smoke_instance)) {
	        smoke_instance = instance_create_layer(x, y, "Instances", obj_dirt);
	    } else {
	        // atualiza posição da fumaça (segue o personagem)
	        smoke_instance.x = x;
	        smoke_instance.y = y;
	    }
	} else {
	    // se não estiver correndo, destrói a fumaça
	    if (instance_exists(smoke_instance)) {
	        instance_destroy(smoke_instance);
	        smoke_instance = noone;
	    }
	}

}


