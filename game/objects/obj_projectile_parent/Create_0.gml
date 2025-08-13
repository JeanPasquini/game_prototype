enum CurrentState {
	RISING,
	FALLING
}

state = CurrentState.RISING;
movementSpeed = 2;
maximumHeight = 10;
verticalAcceleration = 0.5;

direction = point_direction(x, y, obj_player.x, y);
speed = movementSpeed;