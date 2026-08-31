function scr_movement() {

    if (state == PlayerState.DYING) {
        _update_dying();
        return;
    }

    if (state == PlayerState.INTRODUCTION) {
        _update_introduction();
        return;
    }

    if (state == PlayerState.TRANSITION) {
        _update_transition();
        return;
    }

	if (instance_exists(obj_menu_boss_introduction) && obj_menu_boss_introduction.boss_introduction) {
	    hsp = 0;
		is_dashing = false;
		dash_timer = 0;
	    _apply_gravity();
	    _resolve_collisions();
	    _update_sprites();
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
    scr_player_squash_stretch();
}

function _update_dying() {

    if (sprite_index != spr_player_dying && sprite_index != spr_player_dying_returning) {
        scr_menu_lock_try("dying");
        audio_play_sound(sde_player_die, 1, false);
        sprite_index = spr_player_dying;
        image_index = 0;
        image_speed = 1;
    }

    if (sprite_index == spr_player_dying && image_index >= image_number - 1) {
		sprite_index = spr_player_dying_returning;
        image_index = 0;
        image_speed = 1;
        scr_reset_run();
		scr_reset_character();
    }

    if (sprite_index == spr_player_dying_returning) {
        if (image_index >= image_number - 1) {
            state = PlayerState.IDLE;
        }
    }
}

function _update_introduction() {

	face = 1;

    if (sprite_index != spr_player_introduction_idle && sprite_index != spr_player_introduction_start) {
        sprite_index = spr_player_introduction_idle;
        image_index = 0;
        image_speed = 1;
    }

    if (introduction_start && sprite_index == spr_player_introduction_idle) {
        sprite_index = spr_player_introduction_start;
        image_index = 0;
        image_speed = 1;
    }

    if (sprite_index == spr_player_introduction_start && image_index >= image_number - 1) {
        introduction_start = false;
        talking = false;
        state = PlayerState.IDLE;
    }
}

function _update_transition() {

    is_dashing = false;
    dash_timer = 0;

    if (transition_phase == 0) {

        // anda sozinho até centralizar com a porta, ignorando input
        var _dir = sign(transition_target_x - x);
        var _dist = abs(transition_target_x - x);

        if (_dist > 1) {

            if (_dir != 0) face = _dir;

            hsp = lerp(hsp, _dir * (run ? spd * 2 : spd), 0.3);

            var _spr = run ? spr_player_running : spr_player_walking;
            if (sprite_index != _spr) {
                sprite_index = _spr;
                image_speed = 1;
            }
        }
        else {
            // centralizado: trava a posição e começa a animação de transição
            x = transition_target_x;
            hsp = 0;

            transition_phase = 1;

            // a animação da porta (spr_player_transition) sempre virada pra direita
            face = 1;

            sprite_index = spr_player_transition;
            image_index = 0;
            image_speed = 1;
        }
    }
    else if (transition_phase == 1) {

        // mantém virada pra direita durante toda a animação de transição
        face = 1;

        hsp = 0;

        // segura no último frame até então criar a troca de sala
        if (image_index >= image_number - 1) {

            image_index = image_number - 1;
            image_speed = 0;

            if (!transition_room_started) {

                transition_room_started = true;

                var _t = instance_create_layer(0, 0, "Instances", obj_transiction);
                _t.destiny = transition_destiny;
                _t.px = transition_px;
                _t.py = transition_py;
                _t.is_boss_door = transition_is_boss_door;
            }
        }
    }

    _apply_gravity();
    _resolve_collisions();
}

function _update_timers() {

	if (talking) return;

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
		if(ong){
			var sfx = [
				jump
			];						
			scr_audio_play(sfx);
		}
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

    if (is_dashing) return;

    var _g = grv_rise;

    // gravidade assimétrica: a queda "pesa" mais do que a subida
    if (vsp > 0) _g *= fall_grv_mult;

    if (hurt_grav_timer > 0) {
        // retomada SUAVE da gravidade logo após um hit no ar:
        // ~0 no instante do golpe -> 100% ao fim da janela (não despenca de uma vez).
        // (o timer decrementa no Step)
        _g *= max(1 - (hurt_grav_timer / hurt_grav_max), 0.05);
    }
    else if (!ong && vsp > -2 && keyboard_check(vk_down) && !talking) {
        // fast-fall: segurar pra baixo no ar mergulha o personagem
        _g *= fast_fall_mult;
    }

    vsp += _g;

    // velocidade terminal de queda
    if (vsp > vsp_max_fall) vsp = vsp_max_fall;
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
		var sfx = [
			dash_1,
			dash_2
		];						
		scr_audio_play(sfx);
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

        // estica na horizontal no arranque do dash
        player_add_squash(0.34, -0.24);
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

    if (move_input != 0 && move_input != face && !turning && !is_dashing && hurt_recoil_timer <= 0) {

        turning = true;
        turn_timer = 0;
        turn_duration = 10;
        turn_target_dir = move_input;

        // pequena compressão ao trocar de direção
        player_add_squash(-0.12, 0.05);

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

    // recuo ao levar dano: vence qualquer controle horizontal, ignora input
    // e desacelera até parar (timer decrementa no Step).
    if (hurt_recoil_timer > 0) {
        hsp = lerp(hsp, 0, 0.15);
        return;
    }

    if (is_dashing || turning) return;

    // deslize pra frente logo após o golpe (dá "peso" e fluidez ao ataque)
    if (attack_lunge_timer > 0) {
        attack_lunge_timer--;
        hsp = lerp(hsp, 0, 0.22);
        return;
    }

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

    if (talking || is_dashing || hurt_recoil_timer > 0) return;

    var can_jump = (ong || coyote_timer > 0);

    if (jump_buffer_timer > 0 && can_jump) {

        vsp = jmp;

        jump_buffer_timer = 0;
        coyote_timer = 0;

        // estica na vertical ao sair do chão
        player_add_squash(-0.18, 0.30);
    }

    // JUMP CUT (pulo variável)
    if (!keyboard_check(vk_up) && vsp < 0) {
        vsp *= 0.5;
    }
}

function _col(xp, yp) {

    if (place_meeting(xp, yp, obj_wall)) return true;

    if (place_meeting(xp, yp, obj_wall_block)) return true;

    var door = instance_place(xp, yp, obj_parent_enviroment_door);
    if (door != noone) return !door.open;

    var gate = instance_place(xp, yp, obj_environment_gate);
    if (gate != noone) return !gate.open;

    return false;
}

/// @function _unstick()
/// @description Se o player está sobreposto a uma parede na posição ATUAL,
///              busca em anel (raio 1..max) o ponto livre mais próximo e
///              reposiciona ali. Prioriza sair pra cima, depois pelos lados,
///              depois pra baixo, e só então nas diagonais.
///              Barato: sai de imediato quando não há sobreposição.
function _unstick() {

    if (!_col(x, y)) return;

    // Só encostar/pisar no chão também acusa colisão na posição atual, mas isso
    // NÃO é ficar preso — o resolver normal cuida. Se dá pra "subir" 1px e sair
    // da sobreposição, então é só contato de chão: ignora.
    if (!_col(x, y - 1)) return;

    var _max  = 24;   // alcance máximo da busca, em pixels
    var _dirs = [
        [  0, -1 ], [ -1,  0 ], [  1,  0 ], [  0,  1 ],
        [ -1, -1 ], [  1, -1 ], [ -1,  1 ], [  1,  1 ]
    ];

    for (var _r = 1; _r <= _max; _r++) {
        for (var _i = 0; _i < array_length(_dirs); _i++) {

            var _nx = x + _dirs[_i][0] * _r;
            var _ny = y + _dirs[_i][1] * _r;

            if (!_col(_nx, _ny)) {
                x = _nx;
                y = _ny;

                // zera a velocidade no(s) eixo(s) em que empurramos pra fora,
                // pra não voltar a entrar na parede no mesmo frame
                if (_dirs[_i][0] != 0) hsp = 0;
                if (_dirs[_i][1] != 0) { vsp = 0; is_dashing = false; }

                return;
            }
        }
    }
}

function _resolve_collisions() {

    // rede de segurança: se por qualquer motivo o player terminou DENTRO de
    // uma parede (spawn, porta/portão fechando, empurrão, tunelamento…),
    // procura o ponto livre mais próximo e reposiciona ali.
    _unstick();

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

    var _land_impact = 0;

    if (_col(x, y + vsp)) {

        while (!_col(x, y + sign(vsp))) {
            y += sign(vsp);
        }

        if (vsp > 0) {
            ong = true;
            _land_impact = vsp; // velocidade no instante do toque no chão
        }
        vsp = 0;
    }

    if (!is_dashing) y += vsp;

	if (ong && !previous_ong) {

        // 0..1 conforme a força da queda
        var _land_t = clamp(_land_impact / vsp_max_fall, 0, 1);

        // aterrissagem: achata na vertical, espalha na horizontal
        player_add_squash(0.12 + 0.55 * _land_t, -(0.12 + 0.45 * _land_t));

        // quedas fortes tremem a câmera e dão um recuo de zoom
        if (_land_impact >= hard_land_vsp) {
            scr_camera_shake(2 + 4 * _land_t, 5 + 7 * _land_t);
            scr_camera_zoom_punch(0.03 + 0.06 * _land_t);
        }

	    if (air_time >= 30) {
	        obj_effect_unicle.scr_fx_fall_smoke(x, y + 14);
	    }

	    air_time = 0;
	    air_dash_available = true;
		var sfx = [
			fall
		];
		scr_audio_play(sfx);
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
		
		if (!place_meeting(nx, ny, obj_wall_block)) {
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

    // durante o recuo do dano, congela a animação atual: evita o "flicker"
    // de trocar pra pulo/queda no instante do hit (não existe sprite de dano).
    if (hurt_recoil_timer > 0) {
        return;
    }

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
	                // debounce da parada: só vira IDLE depois de alguns frames sem movimento,
	                // evitando piscar walk<->idle em micro-paradas / trocas de direção
	                if (abs(hsp) > 0.1 || move_input != 0) idle_delay = 6;
	                else if (idle_delay > 0) idle_delay--;

	                if (abs(hsp) > 0.1 || idle_delay > 0) {
						if(!is_dashing){
		                    state = run ? PlayerState.RUN : PlayerState.WALK;

		                    // troca walk<->run preservando a fase da animação (sem "pulo")
		                    var _want_spr = run ? spr_player_running : spr_player_walking;
		                    if (sprite_index != _want_spr) {
		                        var _phase = (sprite_get_number(sprite_index) > 0)
		                            ? (image_index / sprite_get_number(sprite_index)) : 0;
		                        sprite_index = _want_spr;
		                        image_index  = _phase * sprite_get_number(_want_spr);
		                    }
		                    image_speed = 1;

							// === FOOTSTEP BY ANIMATION ===
							if (ong && abs(hsp) > 0.1 && (state == PlayerState.WALK || state == PlayerState.RUN)) {

							    var frames = (state == PlayerState.RUN) ? footstep_frames_run : footstep_frames_walk;
							    var current_frame = floor(image_index);

							    // verifica se o current_frame é um frame de passo
							    for (var i = 0; i < array_length(frames); i++) {

							        if (current_frame == frames[i]) {
							            // só toca se mudou o frame
							            if (last_foot_frame != current_frame) {
							                var steps = [
											    footstep_1,
											    footstep_2,
											    footstep_3
											];
											
											if(run) obj_effect_unicle.scr_fx_run_smoke(x, y + 10);
											scr_audio_play(steps);

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
	    }
}

/// @function player_add_squash(amount_x, amount_y)
/// @description Injeta um "empurrão" instantâneo na escala do personagem.
///              A mola em scr_player_squash_stretch() traz de volta para 1.
///              amount_y > 0 = esticar na vertical | amount_y < 0 = achatar.
///              Normalmente amount_x e amount_y têm sinais opostos (preserva volume).
function player_add_squash(_amount_x, _amount_y) {
    sns_x += _amount_x;
    sns_y += _amount_y;

    sns_x = clamp(sns_x, 0.55, 1.7);
    sns_y = clamp(sns_y, 0.55, 1.7);
}

/// @function scr_player_squash_stretch()
/// @description Atualiza (1x por frame) a mola de squash & stretch do personagem.
///              sns_x / sns_y são multiplicadores que oscilam em torno de 1 e
///              são aplicados por cima da escala base no evento Draw.
function scr_player_squash_stretch() {

    // "respiração" sutil parado no chão
    var _breath_x = 0;
    var _breath_y = 0;

    if (state == PlayerState.IDLE && ong && !is_dashing) {
        sns_breath_t += 0.08;
        _breath_y = sin(sns_breath_t) * 0.02;
        _breath_x = -_breath_y * 0.6;
    }
    else {
        sns_breath_t = 0;
    }

    var _target_x = 1 + _breath_x;
    var _target_y = 1 + _breath_y;

    // mola amortecida em direção ao alvo
    sns_xspd += (_target_x - sns_x) * sns_stiffness;
    sns_yspd += (_target_y - sns_y) * sns_stiffness;

    sns_xspd *= sns_damping;
    sns_yspd *= sns_damping;

    sns_x += sns_xspd;
    sns_y += sns_yspd;

    sns_x = clamp(sns_x, 0.55, 1.7);
    sns_y = clamp(sns_y, 0.55, 1.7);
}

