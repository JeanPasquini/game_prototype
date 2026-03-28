function scr_movement() {

    if (state == PlayerState.DYING) {
        _update_dying();
        return;
    }

    _update_timers();
    _update_air_states();
    _apply_gravity();
    _update_horizontal_input();
    _update_dash();
    _update_turning();
    _apply_horizontal_movement();
    _update_jump();
    _resolve_collisions();
    _apply_knockback();
    _update_sprites();
}

function _update_dying() {

    if (sprite_index != spr_player_dying && sprite_index != spr_player_dying_returning) {
        audio_play_sound(sde_player_die, 1, false);
        sprite_index = spr_player_dying;
        image_index = 0;
        image_speed = 1;
    }

    if (sprite_index == spr_player_dying && image_index >= image_number - 1) {

        life = life_max;
        global.current_phase = "phase_01";

        var directions = getNextRoomPxAndPy(HUB, "up");
        x = directions.px;
        y = directions.py;

        room_goto(HUB);

        sprite_index = spr_player_dying_returning;
        image_index = 0;
        image_speed = 1;

        audio_play_sound(sde_player_die_returning, 1, false);
    }

    if (sprite_index == spr_player_dying_returning) {
        if (image_index >= image_number - 1) {
            state = PlayerState.IDLE;
        }
    }
}

function _update_timers() {

	if(state = PlayerState.DASH){
		var _dir = dash_direction; // ou face
		obj_effect_unicle.scr_fx_dash_smoke2(x, y, _dir);	
	}

	if (keyboard_check_pressed(vk_right)) {
	    if (tap_timer_right > 0) run = true;
	    else tap_timer_right = double_tap_threshold;
	}
	if (keyboard_check_pressed(vk_left)) {
	    if (tap_timer_left > 0) run = true;
	    else tap_timer_left = double_tap_threshold;
	}
	
	if (tap_timer_left > 0) tap_timer_left--;
	if (tap_timer_right > 0) tap_timer_right--;

    // JUMP BUFFER
    if (keyboard_check_pressed(vk_up)) {
        jump_buffer_timer = jump_buffer_max;
    }

    if (jump_buffer_timer > 0) {
        jump_buffer_timer--;
    }

    // COYOTE TIMER DECAY
    if (coyote_timer > 0) {
        coyote_timer--;
    }
}

function _update_air_states() {
    if (ong) air_dash_available = true;
}

function _apply_gravity() {
    if (!is_dashing) {
        vsp += grv;
    }
}

function _update_horizontal_input() {

    move_input = 0;

    if (!talking) {
        if (keyboard_check(vk_right)) {
            move_input = 1;
            turn_target_dir = move_input;
        }
        else if (keyboard_check(vk_left)) {
            move_input = -1;
            turn_target_dir = move_input;
        }
    }
}

function _update_dash() {

    var wants_dash = keyboard_check_pressed(ord("C"));
    var can_dash = !talking && !is_dashing && alarm[2] <= 0 && (ong || air_dash_available);

    if (wants_dash && can_dash) {

        is_dashing = true;

        dash_timer = dash_duration;
        alarm[2] = dash_cooldown;

        dash_direction = (move_input != 0) ? move_input : face;
        face = dash_direction;
		var _dir = dash_direction; // ou face
		obj_effect_unicle.scr_fx_dash_smoke(x, y, _dir);
		

        turning = false;
        hsp = dash_direction * dash_speed;
        vsp = 0;

        if (!ong) {
		    air_dash_available = false;
		    air_time = 0;
		}
    }

    if (is_dashing) {

        dash_timer--;
        hsp = dash_direction * dash_speed;
        vsp = 0;

        if (dash_timer <= 0) {
            is_dashing = false;
            run = true;
        }
    }
}

function _update_turning() {

    var base_spd = run ? spd * 2 : spd;
    var accel = 0.3;

    if (move_input != 0 && move_input != face && !turning && !is_dashing) {

        turning = true;
        turn_timer = 0;
        turn_duration = 10;
        turn_target_dir = move_input;

        if (state != PlayerState.ATTACK) {
            image_index = 0;
            state = run ? PlayerState.RUN_TURN : PlayerState.WALK_TURN;
        }
    }

    if (turning && !is_dashing) {

        turn_timer++;

        var target_spd = turn_target_dir * (base_spd * 0.5);
        hsp = lerp(hsp, target_spd, accel);

        if (turn_timer >= turn_duration) {
            face = turn_target_dir;
            turning = false;
            run = false;
        }
    }
}

function _apply_horizontal_movement() {

    if (is_dashing || turning) return;

    var base_spd = run ? spd * 2 : spd;
    var accel = 0.3;
    var fric  = 0.15;

    if (move_input != 0) {
        var target_spd = move_input * base_spd;
        hsp = lerp(hsp, target_spd, accel);
    }
    else {
        hsp = lerp(hsp, 0, fric);
        if (abs(hsp) < 0.1) hsp = 0;

        if (abs(hsp) < 1) run = false;
    }
}

function _update_jump() {

    if (talking || is_dashing) return;

    var can_jump = (ong || coyote_timer > 0);

    if (jump_buffer_timer > 0 && can_jump) {

        vsp = jmp;

        jump_buffer_timer = 0;
        coyote_timer = 0;
    }

    // JUMP CUT (pulo variável)
    if (!keyboard_check(vk_up) && vsp < 0) {
        vsp *= 0.5;
    }
}

function _col(xp, yp) {

    if (place_meeting(xp, yp, obj_wall)) return true;

    var door = instance_place(xp, yp, obj_parent_enviroment_door);
    if (door != noone) return !door.open;

    return false;
}

function _resolve_collisions() {

	if (!ong) {
	    air_time++;
	}

    // HORIZONTAL
    if (_col(x + hsp, y)) {

        while (!_col(x + sign(hsp), y)) {
            x += sign(hsp);
        }

        hsp = 0;

        if (is_dashing) {
            is_dashing = false;
            dash_timer = 0;
        }
    }

    x += hsp;

    // VERTICAL
    var previous_ong = ong;
    ong = false;

    if (_col(x, y + vsp)) {

        while (!_col(x, y + sign(vsp))) {
            y += sign(vsp);
        }

        if (vsp > 0) ong = true;
        vsp = 0;
    }

    if (!is_dashing) y += vsp;

	if (ong && !previous_ong) {

	    if (air_time >= 60) {
	        obj_effect_unicle.scr_fx_fall_smoke(x, y + 13);
	    }

	    air_time = 0;
	    air_dash_available = true;
	}
	
		// COYOTE TIME
	if (ong) {
	    coyote_timer = coyote_max;
	}
}

function _apply_knockback() {

    if (abs(knockback_x) > 0.1 || abs(knockback_y) > 0.1) {

        var nx = x + knockback_x * 0.5;
        var ny = y + knockback_y * 0.5;

        if (!place_meeting(nx, ny, obj_wall)) {
            x = nx;
            y = ny;
        }

        knockback_x *= 0.95;
        knockback_y *= 0.95;
    }
    else {
        knockback_x = 0;
        knockback_y = 0;
    }
}

function _update_sprites() {

    if (state == PlayerState.ATTACK){

	return;
	}

    image_xscale = face;

// === SPRITES ===
		
	    if (state != PlayerState.ATTACK) {

			if (is_dashing) {
				state = PlayerState.DASH;
				sprite_index = spr_player_dash;
				image_speed = 1;
			}

			if (swimming && !is_dashing) {
				vsp *= 0.75;
				hsp *= 0.75;
			}

	        if (!is_dashing && !ong) {
	            // --- ON AIR ---
	            if (vsp < 0) {
	                if (state != PlayerState.JUMP && state != PlayerState.RUN_JUMP) {
	                    state = run ? PlayerState.RUN_JUMP : PlayerState.JUMP;
	                    sprite_index = spr_player_jumping;
	                    image_index = 0;
	                    image_speed = 1;
	                }

	                if (sprite_index == spr_player_jumping &&
	                    image_index >= image_number - 1) {
	                    image_index = image_number - 1;
	                    image_speed = 0;
	                }
	            }
	            else {
	                if (state != PlayerState.FALL && state != PlayerState.RUN_FALL) {
	                    state = run ? PlayerState.RUN_FALL : PlayerState.FALL;
	                    sprite_index = spr_player_falling;
	                    image_index = 0;
	                    image_speed = 1;
	                }

	                if (sprite_index == spr_player_falling &&
	                    image_index >= image_number - 1) {
	                    sprite_index = spr_player_falling_loop;
	                    image_index = 0;
	                    image_speed = 1;
	                }
	            }
	        }
	        else {
	            // --- ON FLOOR ---
	            if (state == PlayerState.WALK_TURN) {
	                if (sprite_index != spr_player_walking_turn) {
	                    sprite_index = spr_player_walking_turn;
	                    image_speed = 1;
	                    image_index = 0;
	                }

	                if (image_index >= image_number - 1) {
	                    image_speed = 0;
	                    image_index = image_number - 1;

	                    state = (abs(hsp) > 0.1) ? PlayerState.WALK : PlayerState.IDLE;

	                    sprite_index = (state == PlayerState.WALK)
	                        ? spr_player_walking
	                        : spr_player_idle;

	                    image_speed = 1;
	                }
	            }

	            else if (state == PlayerState.RUN_TURN) {

	                if (sprite_index != spr_player_running_turn) {
	                    sprite_index = spr_player_running_turn;
	                    image_speed = 1.4;
	                    image_index = 0;
	                }

	                var forward_push = 2.0 * face;
	                hsp += forward_push * 0.5;

	                var target_spd = face * (spd * 1.2);
	                hsp = lerp(hsp, target_spd, 0.25);

	                if (image_index >= image_number - 1) {
	                    image_speed = 0;
	                    image_index = image_number - 1;

	                    state = PlayerState.RUN;
	                    sprite_index = spr_player_running;
	                    image_speed = 1;
	                }
	            }

	            else {
	                if (abs(hsp) > 0.1) {
						if(!is_dashing){
		                    state = run ? PlayerState.RUN : PlayerState.WALK;
		                    sprite_index = run ? spr_player_running : spr_player_walking;
		                    image_speed = 1;
					
							// === FOOTSTEP BY ANIMATION ===
							if (ong && (state == PlayerState.WALK || state == PlayerState.RUN)) {

							    var frames = (state == PlayerState.RUN) ? footstep_frames_run : footstep_frames_walk;
							    var current_frame = floor(image_index);

							    // verifica se o current_frame é um frame de passo
							    for (var i = 0; i < array_length(frames); i++) {

							        if (current_frame == frames[i]) {
							            // só toca se mudou o frame
							            if (last_foot_frame != current_frame) {
							                var steps = [
											    sde_player_step1,
											    sde_player_step2,
											    sde_player_step
											];
											
											if(run) obj_effect_unicle.scr_fx_run_smoke(x, y + 10);
											audio_play_sound(steps[irandom(array_length(steps) - 1)], 1, false);

							                last_foot_frame = current_frame;
							            }
							        }
							    }

							    if (!array_contains(frames, current_frame)) {
							        last_foot_frame = -1;
							    }
							}
							else {
							    last_foot_frame = -1;
							}
						}
						else{
							sprite_index = spr_player_dash;
		                    image_speed = 1;
						}




	                } else {
	                    state = PlayerState.IDLE;
	                    sprite_index = spr_player_idle;
	                    image_speed = 1;
	                }
	            }
	        }
			image_xscale = face;
	    }
}

