enum RoomDirection {
    UP,
    DOWN,
    LEFT,
    RIGHT
}

function RoomDirectionToString(room_dir) {
	switch (room_dir) {
	case RoomDirection.LEFT:
		return "left";
	case RoomDirection.RIGHT:
		return "right";
	case RoomDirection.UP:
		return "up";
	case RoomDirection.DOWN:
		return "down";
	default:
		return noone;
	}
}