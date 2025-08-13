function check_state_transitions(){
	
	combo_timer = current_time;

	if (!ong) {
		if (vsp < 0) {
			if (run){
				state = PlayerState.RUN_JUMP
			}
			else{
				state = PlayerState.JUMP;
			}
	        
	    } else {
			if (run){
				state = PlayerState.RUN_FALL;
			}
			else{
				state = PlayerState.FALL;
			}
	    }
	} else {

	    if (abs(hsp) > 0.1) {
			if (run){
				state = PlayerState.RUN;
			}
			else{
				state = PlayerState.WALK;
			}
	    } else {
	        state = PlayerState.IDLE;
	    }
	}


}