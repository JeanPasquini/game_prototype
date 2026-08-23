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

// Animação da porta sincronizada com o spr_player_transition
trans_state = "idle"; // "idle" | "opening"
trans_base_frame = 0; // primeiro frame do conjunto de 13 (normal / mini_boss / store)