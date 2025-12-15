enum CurrentState {
	RISING,
	FALLING
}

state = CurrentState.RISING;
xStart = x;
yStart = y;
xEnd = obj_player.x;
yEnd = obj_player.y;

// Defines direction of movement
dir = sign(xEnd - xStart); // +1 right, -1 left

velocity = 1;

