// Inherit the parent event
event_inherited();

// APRESENTATION

if(currentState == EnemyState.APRESENTATION){
	if (!has_reached_top) {
		audio_apresentation_flying_water();
		audio_apresentation_flying();
		sprite_index = spr_psicotopus_apresentation_flying;
		
		return;
	}
	else if(!has_landed && alarm[6] <= 0){
		direction = 180;
		scr_set_sprite_once(spr_psicotopus_apresentation_falling, "flag_spr_psicotopus_apresentation_falling");
		
		return;
	}
	else if (has_landed && sprite_index == spr_psicotopus_apresentation_falling && floor(image_index) == 3) {
		if(!flag_apresentation){
			audio_apresentation_impact();
		    obj_effect_unicle.scr_fx_fall_smoke(x, y + 17);
			obj_earthquake.start_earthquake(3, 100);
			flag_apresentation = true;
			global.force_music = sdt_phase1_mini_boss2;
		}
		return;
	}
}

	// SPECIAL ATTACK

else if (currentState == EnemyState.SPECIAL_ATTACK){
	
	// TRIPLE VERTICAL
	
	if (currentAttackState == AttackState.TRIPLE_VERTICAL){
			audio_special_attack_triple_start();
		if(!instance_exists(obj_psicotopus_energy_shield)){
			instance_create_layer(x, y - 5, "Instances", obj_psicotopus_energy_shield);
		}
		if (attack_mount == fire_count_max && alarm[5] <= 0) {
			audio_special_attack_triple_mid(false, true);
			audio_special_attack_triple_end();
	        scr_set_sprite_once(spr_psicotopus_triple_vertical_end, "flag_spr_psicotopus_triple_vertical_end");
	    }
		else{
			audio_special_attack_triple_mid();
			scr_set_sprite_once(spr_psicotopus_triple_vertical_start, "flag_spr_psicotopus_triple_vertical_start");
		}
		
		return;
	}
	
	// TRIPLE RICOCHET
	
	else if (currentAttackState == AttackState.TRIPLE_RICOCHET){
		audio_special_attack_triple_start();
		if(!instance_exists(obj_psicotopus_energy_shield)){
			instance_create_layer(x, y - 5, "Instances", obj_psicotopus_energy_shield);
		}
		scr_set_sprite_once(spr_psicotopus_triple_ricochet_start, "flag_spr_psicotopus_triple_ricochet_start");
		if(sprite_index == spr_psicotopus_triple_ricochet_mid){
			audio_special_attack_triple_mid();
			if(!instance_exists(obj_psicotopus_ship)){
				audio_special_attack_triple_mid(false, true);
				audio_special_attack_triple_end();
				scr_set_sprite_once(spr_psicotopus_triple_ricochet_end, "flag_spr_psicotopus_triple_ricochet_end");	
			}
		}
		
		return;
	}
	
	// FLOOD
	
	else if (currentAttackState == AttackState.FLOOD){
		if ((!instance_exists(obj_tentacle_telegraph) || is_destroyed)) {
		    scr_set_sprite_once(spr_psicotopus_flood_end, "flag_spr_psicotopus_flood_end");

			if (y < 338) {
			    y += 8;
			    if (y >= 338) {
			        y = 338;
			        if (!has_landed) {
						obj_earthquake.start_earthquake(1, 100);	
			            obj_effect_unicle.scr_fx_fall_smoke(x, y + 17);
						obj_effect_unicle.scr_fx_water_impact(x, y + 17, 32, 32);
			            has_landed = true;
						audio_apresentation_impact();
			        }
			    }
			}
		}
		else{
			scr_set_sprite_once(spr_psicotopus_flood_start, "flag_spr_psicotopus_flood_start");
		}
		
		return;
	}
}


// IDLE

else if (currentState == EnemyState.IDLE){
	audio_reset();
	sprite_index = spr_psicotopus_idle;
}

// CHASING

else if (currentState == EnemyState.CHASING) {

    sprite_index = spr_psicotopus_walking;

    var frames = [1, 6]; 
    var current_frame = floor(image_index);

    var is_step_frame = false;
    for (var i = 0; i < array_length(frames); i++) {
        if (current_frame == frames[i]) {
            is_step_frame = true;
            break;
        }
    }

    if (is_step_frame) {
        if (last_step_frame != current_frame) {
            scr_audio_play(
                [sde_enemy_psicotopus_chasing_step1, 
                 sde_enemy_psicotopus_chasing_step2, 
                 sde_enemy_psicotopus_chasing_step3], 
                emitterAudio
            );
            last_step_frame = current_frame;
        }
    }
    else {
        last_step_frame = -1;
    }
}

function audio_reset(){
	audio_apresentation_impact(true);
	audio_apresentation_flying(true);
}

