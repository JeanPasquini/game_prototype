function src_basic_idle_movement(){
	return function () {
		speed = movementSpeed;

	    if (x >= (xstart + maxRandomMovement / 2)) {
	        direction = 180;
	    } else if (x <= (xstart - maxRandomMovement / 2)) {
	        direction = 0;
	    }
	}
}