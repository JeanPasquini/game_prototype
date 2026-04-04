function src_grounded_idle_movement(){
	return function () {
		
		// determinates the horizontal speed
		
		if (direction == 0) hsp = 1;
		else if (direction == 180) hsp = -1;
		
		
	    if (x >= (xstart + maxRandomMovement / 2)) {
	       hsp = -1;
		   direction = 180;
	    } else if (x < (xstart - maxRandomMovement / 2)) {
	        hsp = 1;
			direction = 0;
	    }
		
		if (place_meeting(x + hsp, y, obj_wall)) {
			hsp = hsp * -1;
			if (direction == 180) direction = 0; else direction = 180;
		}
		
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