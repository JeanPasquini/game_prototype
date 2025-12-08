if (life <= 0){
	life = life_max;
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
		scr_combat();
		scr_movement(); 
	case PlayerState.TALKING:
    break;
}
