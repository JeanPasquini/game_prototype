if (life <= 0){
	state = PlayerState.DYING;
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
	case PlayerState.DYING:
		scr_movement(); 
    break;
}
