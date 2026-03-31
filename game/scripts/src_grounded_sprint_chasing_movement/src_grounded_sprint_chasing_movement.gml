function src_grounded_sprint_chasing_movement(){
	return function () {
		
		//if (hsp == 0) {  hsp = sign(obj_player.x - x); }
		
	
		hsp = 0
		 if (currentState == EnemyState.CHASING) {
			if (!place_meeting(x, y, obj_wall)) {
				 hsp = sign(obj_player.x - x)*3;
			} else {
				hsp = 0
			}
		 }
		
		/*
		// determinates the horizontal speed
	    if (x >= (xstart + maxRandomMovement / 2)) {
	       hsp = -1;
		   direction = 180;
	    } else if (x < (xstart - maxRandomMovement / 2)) {
	        hsp = 1;
			direction = 0;
	    }
		*/
		
		// determinates the vertical speed
		if (place_meeting(x, y+1, obj_wall)) {
			vsp = 0;
		} else {
			vsp = 1;
		}
		
		x += hsp;
		y += vsp;
	}
}