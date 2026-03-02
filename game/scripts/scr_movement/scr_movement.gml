function scr_movement() {
if (state == PlayerState.DYING) {

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

    exit;
}

else
{

	    if (tap_timer_left > 0) tap_timer_left--;
	    if (tap_timer_right > 0) tap_timer_right--;
	

	    // === GRAVITY ===
	    vsp += grv;
	
	    // === MOVEMENT ===
		
	        // --- RUN ---
		
	        if (keyboard_check_pressed(vk_right)) {
	            if (tap_timer_right > 0) run = true;
	            else tap_timer_right = double_tap_threshold;
	        }
	        if (keyboard_check_pressed(vk_left)) {
	            if (tap_timer_left > 0) run = true;
	            else tap_timer_left = double_tap_threshold;
	        }

	        // === HORIZONTAL MOVE ===
	        var base_spd = run ? spd * 2 : spd;
	        var accel = 0.3;
	        var fric  = 0.15;
	        var move_input = 0;

	if(!talking){
	        if (keyboard_check(vk_right)) { move_input = 1; turn_target_dir = move_input;}
	        else if (keyboard_check(vk_left)) {move_input = -1; turn_target_dir = move_input;}
			}

	        if (move_input != 0 && move_input != face && !turning) {
	            turning = true;
	            turn_timer = 0;
	            turn_duration = 10;
	            turn_target_dir = move_input;

				if (state != PlayerState.ATTACK) {
					image_index = 0;
					state = run ? PlayerState.RUN_TURN : PlayerState.WALK_TURN;
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

			if(!talking){
		        if (!keyboard_check(vk_right) && !keyboard_check(vk_left)) {
		            if (abs(hsp) < 1 && !turning) run = false;
		        }

		        // === JUMP ===
		        if (keyboard_check_pressed(vk_up) && ong) {
		            vsp = jmp;
					//audio_play_sound(sde_jump, 1, false);
		        }
		        if (!keyboard_check(vk_up) && vsp < 0) {
		            vsp *= 0.5;
		        }
			}
    

		function col(xp, yp) {

		    if (place_meeting(xp, yp, obj_wall)) {
		        return true;
		    }

		    var door = instance_place(xp, yp, obj_parent_enviroment_door);

		    if (door != noone) {
		        return !door.open;
		    }

		    return false;
		}
		
		if (col(x, y)) {

		    for (var i = 1; i <= 16; i++) {
		        if (!col(x, y - i)) {
		            y -= i;
		            break;
		        }
		    }

		    if (col(x, y)) {
		        for (var i = 1; i <= 16; i++) {
		            if (!col(x, y + i)) {
		                y += i;
		                break;
		            }
		        }
		    }

		    if (col(x, y)) {
		        for (var i = 1; i <= 16; i++) {
		            if (!col(x - i, y)) {
		                x -= i;
		                break;
		            }
		        }
		    }

		    if (col(x, y)) {
		        for (var i = 1; i <= 16; i++) {
		            if (!col(x + i, y)) {
		                x += i;
		                break;
		            }
		        }
		    }
		}


		// HORIZONTAL
		if (col(x + hsp, y)) {
		    while (!col(x + sign(hsp), y)) {
		        x += sign(hsp);
		    }
		    hsp = 0;
		}
		x += hsp;

		// VERTICAL
		ong = false;
		if (col(x, y + vsp)) {
		    while (!col(x, y + sign(vsp))) {
		        y += sign(vsp);
		    }
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
    
	    // === SPRITES ===
		
	    if (state != PlayerState.ATTACK) {

			if (swimming) {
				vsp *= 0.75;
				hsp *= 0.75;
			}

	        if (!ong) {
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




	                } else {
	                    state = PlayerState.IDLE;
	                    sprite_index = spr_player_idle;
	                    image_speed = 1;
	                }
	            }
	        }
			image_xscale = face;
	    }


		// SMOKE EFFECT
	    if (state == PlayerState.RUN && ong) {
	        if (!instance_exists(smoke_instance)) {
	            smoke_instance = instance_create_layer(x, y, "Instances", obj_dirt);
	        } else {
	            smoke_instance.x = x;
	            smoke_instance.y = y;
	        }
	    }
	    else {
	        if (instance_exists(smoke_instance)) {
	            instance_destroy(smoke_instance);
	            smoke_instance = noone;
	        }
	    }
	}
}

//function scr_movement() {
//	if (state == PlayerState.DYING) {

//	    if (sprite_index != spr_player_dying && sprite_index != spr_player_dying_returning) {
//	        audio_play_sound(sde_player_die, 1, false);
//	        sprite_index = spr_player_dying;
//	        image_index = 0;
//	        image_speed = 1;
//	    }

//	    if (sprite_index == spr_player_dying && image_index >= image_number - 1) {

//	        life = life_max;
//	        global.current_phase = "phase_01";

//	        var directions = getNextRoomPxAndPy(HUB, "up");
//	        x = directions.px;
//	        y = directions.py;

//	        room_goto(HUB);

//	        sprite_index = spr_player_dying_returning;
//	        image_index = 0;
//	        image_speed = 1;

//	        audio_play_sound(sde_player_die_returning, 1, false);
//	    }

//	    if (sprite_index == spr_player_dying_returning) {
//	        if (image_index >= image_number - 1) {
//	            state = PlayerState.IDLE;
//	        }
//	    }

//	    exit;
//	}

//	else
//	{

//		    if (tap_timer_left > 0) tap_timer_left--;
//		    if (tap_timer_right > 0) tap_timer_right--;
	

//		    // === GRAVITY ===
//		    vsp += grv;
	
//		    // === MOVEMENT ===
		
//		        // --- RUN ---
		
//		        if (keyboard_check_pressed(vk_right)) {
//		            if (tap_timer_right > 0) run = true;
//		            else tap_timer_right = double_tap_threshold;
//		        }
//		        if (keyboard_check_pressed(vk_left)) {
//		            if (tap_timer_left > 0) run = true;
//		            else tap_timer_left = double_tap_threshold;
//		        }

//		        // === HORIZONTAL MOVE ===
//		        var base_spd = run ? spd * 2 : spd;
//		        var accel = 0.3;
//		        var fric  = 0.15;
//		        var move_input = 0;

//		if(!talking){
//		        if (keyboard_check(vk_right)) { move_input = 1; turn_target_dir = move_input;}
//		        else if (keyboard_check(vk_left)) {move_input = -1; turn_target_dir = move_input;}
//				}

//		        if (move_input != 0 && move_input != face && !turning) {
//		            turning = true;
//		            turn_timer = 0;
//		            turn_duration = 10;
//		            turn_target_dir = move_input;

//					if (state != PlayerState.ATTACK) {
//						image_index = 0;
//						state = run ? PlayerState.RUN_TURN : PlayerState.WALK_TURN;
//					}
			
            
//		        }

//		        if (turning) {
//		            turn_timer++;
//		            var target_spd = turn_target_dir * (base_spd * 0.5);
//		            hsp = lerp(hsp, target_spd, accel);

//		            if (turn_timer >= turn_duration) {
//		                face = turn_target_dir;
//		                turning = false;
//		                run = false;
//		            }
//		        }
//		        else {
//		            if (move_input != 0) {
//		                var target_spd = move_input * base_spd;
//		                hsp = lerp(hsp, target_spd, accel);
//		            } else {
//		                hsp = lerp(hsp, 0, fric);
//		                if (abs(hsp) < 0.1) hsp = 0;
//		            }
//		        // === JUMP ===
//		        if (keyboard_check_pressed(vk_up) && ong) {
//		            vsp = jmp;
//		        } else if (keyboard_check_pressed(vk_up) && swimming) {
//					vsp = jmp;
//				}
			
			
//		        if (!keyboard_check(vk_up) && vsp < 0) {
//		            vsp *= 0.5;
//		        }

//				if(!talking){
//			        if (!keyboard_check(vk_right) && !keyboard_check(vk_left)) {
//			            if (abs(hsp) < 1 && !turning) run = false;
//			        }

//			        // === JUMP ===
//			        if (keyboard_check_pressed(vk_up) && ong) {
//			            vsp = jmp;
//						//audio_play_sound(sde_jump, 1, false);
//			        }
//			        if (!keyboard_check(vk_up) && vsp < 0) {
//			            vsp *= 0.5;
//			        }
//				}
    

//			function col(xp, yp) {

//			    if (place_meeting(xp, yp, obj_wall)) {
//			        return true;
//			    }

//			    var door = instance_place(xp, yp, obj_parent_enviroment_door);

//			    if (door != noone) {
//			        return !door.open;
//			    }

//			    return false;
//			}
		
//			if (col(x, y)) {

//			    for (var i = 1; i <= 16; i++) {
//			        if (!col(x, y - i)) {
//			            y -= i;
//			            break;
//			        }
//			    }

//			    if (col(x, y)) {
//			        for (var i = 1; i <= 16; i++) {
//			            if (!col(x, y + i)) {
//			                y += i;
//			                break;
//			            }
//			        }
//			    }

//			    if (col(x, y)) {
//			        for (var i = 1; i <= 16; i++) {
//			            if (!col(x - i, y)) {
//			                x -= i;
//			                break;
//			            }
//			        }
//			    }

//			    if (col(x, y)) {
//			        for (var i = 1; i <= 16; i++) {
//			            if (!col(x + i, y)) {
//			                x += i;
//			                break;
//			            }
//			        }
//			    }
//			}


//			// HORIZONTAL
//			if (col(x + hsp, y)) {
//			    while (!col(x + sign(hsp), y)) {
//			        x += sign(hsp);
//			    }
//			    hsp = 0;
//			}
//			x += hsp;

//			// VERTICAL
//			ong = false;
//			if (col(x, y + vsp)) {
//			    while (!col(x, y + sign(vsp))) {
//			        y += sign(vsp);
//			    }
//			    if (vsp > 0) ong = true;
//			    vsp = 0;
//			}
//			y += vsp;


//		    // === KNOCKBACK ===
//		    if (abs(knockback_x) > 0.1 || abs(knockback_y) > 0.1) {
//		        var nx = x + knockback_x * 0.5;
//		        var ny = y + knockback_y * 0.5;
//		        if (!place_meeting(nx, ny, obj_wall)) {
//		            x = nx;
//		            y = ny;
//		        }
//		        knockback_x *= 0.95;
//		        knockback_y *= 0.95;
//		    } else {
//		        knockback_x = 0;
//		        knockback_y = 0;
//		    }
    
//		    // === SPRITES ===
		
//		    if (state != PlayerState.ATTACK) {
	
//		if (swimming) {
//			vsp *= 0.75;
//			hsp *= 0.75;
//		}
	

//		        if (!ong) {
//		            // --- ON AIR ---
//		            if (vsp < 0) {
//		                if (state != PlayerState.JUMP && state != PlayerState.RUN_JUMP) {
//		                    state = run ? PlayerState.RUN_JUMP : PlayerState.JUMP;
//		                    sprite_index = spr_player_jumping;
//		                    image_index = 0;
//		                    image_speed = 1;
//		                }

//		                if (sprite_index == spr_player_jumping &&
//		                    image_index >= image_number - 1) {
//		                    image_index = image_number - 1;
//		                    image_speed = 0;
//		                }
//		            }
//		            else {
//		                if (state != PlayerState.FALL && state != PlayerState.RUN_FALL) {
//		                    state = run ? PlayerState.RUN_FALL : PlayerState.FALL;
//		                    sprite_index = spr_player_falling;
//		                    image_index = 0;
//		                    image_speed = 1;
//		                }

//		                if (sprite_index == spr_player_falling &&
//		                    image_index >= image_number - 1) {
//		                    sprite_index = spr_player_falling_loop;
//		                    image_index = 0;
//		                    image_speed = 1;
//		                }
//		            }
//		        }
//		        else {
//		            // --- ON FLOOR ---
//		            if (state == PlayerState.WALK_TURN) {
//		                if (sprite_index != spr_player_walking_turn) {
//		                    sprite_index = spr_player_walking_turn;
//		                    image_speed = 1;
//		                    image_index = 0;
//		                }

//		                if (image_index >= image_number - 1) {
//		                    image_speed = 0;
//		                    image_index = image_number - 1;

//		                    state = (abs(hsp) > 0.1) ? PlayerState.WALK : PlayerState.IDLE;

//		                    sprite_index = (state == PlayerState.WALK)
//		                        ? spr_player_walking
//		                        : spr_player_idle;

//		                    image_speed = 1;
//		                }
//		            }

//		            else if (state == PlayerState.RUN_TURN) {

//		                if (sprite_index != spr_player_running_turn) {
//		                    sprite_index = spr_player_running_turn;
//		                    image_speed = 1.4;
//		                    image_index = 0;
//		                }

//		                var forward_push = 2.0 * face;
//		                hsp += forward_push * 0.5;

//		                var target_spd = face * (spd * 1.2);
//		                hsp = lerp(hsp, target_spd, 0.25);

//		                if (image_index >= image_number - 1) {
//		                    image_speed = 0;
//		                    image_index = image_number - 1;

//		                    state = PlayerState.RUN;
//		                    sprite_index = spr_player_running;
//		                    image_speed = 1;
//		                }
//		            }

//		            else {
//		                if (abs(hsp) > 0.1) {
//		                    state = run ? PlayerState.RUN : PlayerState.WALK;
//		                    sprite_index = run ? spr_player_running : spr_player_walking;
//		                    image_speed = 1;
					
//							// === FOOTSTEP BY ANIMATION ===
//							if (ong && (state == PlayerState.WALK || state == PlayerState.RUN)) {

//							    var frames = (state == PlayerState.RUN) ? footstep_frames_run : footstep_frames_walk;
//							    var current_frame = floor(image_index);

//							    // verifica se o current_frame é um frame de passo
//							    for (var i = 0; i < array_length(frames); i++) {

//							        if (current_frame == frames[i]) {

//							            // só toca se mudou o frame
//							            if (last_foot_frame != current_frame) {
//							                var steps = [
//											    sde_player_step1,
//											    sde_player_step2,
//											    sde_player_step
//											];

//											audio_play_sound(steps[irandom(array_length(steps) - 1)], 1, false);

//							                last_foot_frame = current_frame;
//							            }
//							        }
//							    }

//							    if (!array_contains(frames, current_frame)) {
//							        last_foot_frame = -1;
//							    }
//							}
//							else {
//							    last_foot_frame = -1;
//							}




//		                } else {
//		                    state = PlayerState.IDLE;
//		                    sprite_index = spr_player_idle;
//		                    image_speed = 1;
//		                }
//		            }
//		        }
//				image_xscale = face;
//		    }


//			// SMOKE EFFECT
//		    if (state == PlayerState.RUN && ong) {
//		        if (!instance_exists(smoke_instance)) {
//		            smoke_instance = instance_create_layer(x, y, "Instances", obj_dirt);
//		        } else {
//		            smoke_instance.x = x;
//		            smoke_instance.y = y;
//		        }
//		    }
//		    else {
//		        if (instance_exists(smoke_instance)) {
//		            instance_destroy(smoke_instance);
//		            smoke_instance = noone;
//		        }
//		    }
//		}
//	}
//}