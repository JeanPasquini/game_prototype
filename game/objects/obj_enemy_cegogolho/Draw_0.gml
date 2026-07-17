// Inherit the parent event
event_inherited();

if(currentState == EnemyState.DYING) {
	audio_dying();
	scr_set_sprite_once(spr_enemy_cegogolho_dying, "flag_spr_cegogolho_dying");
}
else if(currentState == EnemyState.CHASING || currentState == EnemyState.IDLE){
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
                [sde_enemy_cegogolho_wings_1, 
                 sde_enemy_cegogolho_wings_2, 
                 sde_enemy_cegogolho_wings_3], 
                emitterAudio
            );
            last_step_frame = current_frame;
        }
    }
    else {
        last_step_frame = -1;
    }	
}


