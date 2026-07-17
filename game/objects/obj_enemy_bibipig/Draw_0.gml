// Inherit the parent event
image_xscale = image_xscale * -1;

event_inherited();


if(currentState == EnemyState.IDLE){
		audio_attacking(true);
		sprite_index = spr_enemy_bibipig_walking;
        image_speed = 1;
}
else if(currentState == EnemyState.DYING){
	audio_dying();
	scr_set_sprite_once(spr_enemy_bibipig_dying, "flag_spr_bibipig_dying");
}
else if (currentState == EnemyState.CHARGING_ATTACK){
		sprite_index = spr_enemy_bibipig_charging;
        image_speed = 1;
		
			var frames = [1]; 
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
		                [sde_enemy_bibipig_puff], 
		                emitterAudio
		            );
					
					scr_audio_play(
		                [sde_enemy_bibipig_pig_sound_1,
						 sde_enemy_bibipig_pig_sound_2], 
		                emitterAudio
		            );
		            last_step_frame = current_frame;
		        }
		    }
		    else {
		        last_step_frame = -1;
		    }	
}
else if (currentState == EnemyState.CHASING){
		audio_attacking();
		sprite_index = spr_enemy_bibipig_attacking;
        image_speed = 1;
		
		var frames = [1]; 
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
		                [sde_enemy_bibipig_attacking_walking_1,
						 sde_enemy_bibipig_attacking_walking_2,
						 sde_enemy_bibipig_attacking_walking_3,], 
		                emitterAudio
		            );
		            last_step_frame = current_frame;
		        }
		    }
		    else {
		        last_step_frame = -1;
		    }	
}
