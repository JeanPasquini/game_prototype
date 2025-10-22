function check_state_transitions(){
		if (!ong) {
			if (vsp < 0) {
				if (run){
					state = PlayerState.RUN_JUMP
					obj_player.sprite_index = spr_player_jumping;
				}
				else{
					state = PlayerState.JUMP;
					obj_player.sprite_index = spr_player_jumping;
				}
	        
		    } else {
				if (run){
					state = PlayerState.RUN_FALL;
					obj_player.sprite_index = spr_player_falling;
				}
				else{
					state = PlayerState.FALL;
					obj_player.sprite_index = spr_player_falling;
				}
		    }
		} else {

		    if (abs(hsp) > 0.1) {
				if (run){
					state = PlayerState.RUN;
					obj_player.sprite_index = spr_player_running;
				}
				else{
					state = PlayerState.WALK;
					obj_player.sprite_index = spr_player_running;
				}
		    } else {
		        state = PlayerState.IDLE;
				obj_player.sprite_index = spr_player_idle;
		    }
		}
	
}