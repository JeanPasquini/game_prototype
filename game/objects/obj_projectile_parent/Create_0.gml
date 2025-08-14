enum CurrentState {
	RISING,
	FALLING
}

state = CurrentState.RISING;
xStart = x;
yStart = y;
xEnd = obj_player.x;
yEnd = obj_player.y;

mediumPoint = (xStart + xEnd) / 2; // Midpoint between launch and target H
maxHeight = yStart - 50; // Maximum launch height K

// Parabola of the launch with quadratic equation 
division = sqr(xStart - mediumPoint)
if division == 0 division = 0.0001;
a = (yStart - maxHeight) / division;

// Defines direction of movement
dir = sign(xEnd - xStart); // +1 right, -1 left

velocity = 1;