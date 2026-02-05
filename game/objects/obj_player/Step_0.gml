if (life <= 0){
	life = life_max; // redefines the player life 
	// teleports the player to the origin of the room
	global.current_phase = "phase_01";
	var directions = getNextRoomPxAndPy(HUB, "up");
	obj_player.x = directions.px;
    obj_player.y = directions.py;
	room_goto(HUB);
}

switch (state) {
    case PlayerState.IDLE:
    case PlayerState.WALK:
    case PlayerState.WALK_TURN:
    case PlayerState.RUN_TO_IDLE:
    case PlayerState.RUN_TURN:
    case PlayerState.RUN:
    case PlayerState.RUN_JUMP:
    case PlayerState.RUN_FALL:
    case PlayerState.JUMP:
    case PlayerState.FALL:
    case PlayerState.ATTACK:
	case PlayerState.TALKING:
		scr_combat();
		scr_movement(); 
    break;
}

var water_instance = instance_place(x, y, obj_water);
if (water_instance != noone) {
//	state = PlayerState.SWIN;
	swimming = true
} else if (state == PlayerState.SWIN) {
	state = PlayerState.IDLE;
	
} else {
	swimming = false;
}