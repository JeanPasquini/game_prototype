function src_grounded_idle_movement(){
	return function () {

		// determinates the horizontal speed
	    if (x >= (xstart + maxRandomMovement / 2)) {
	       hsp = -1;
		   direction = 180;
	    } else if (x < (xstart - maxRandomMovement / 2)) {
	        hsp = 1;
			direction = 0;
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