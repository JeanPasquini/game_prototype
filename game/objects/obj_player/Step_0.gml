switch (state) {
    case PlayerState.IDLE:
    case PlayerState.WALK:
    case PlayerState.RUN:
		check_state_transitions(); 
		movement();
	break;
	
    case PlayerState.RUN_JUMP:
    case PlayerState.RUN_FALL:
	case PlayerState.JUMP:
	case PlayerState.FALL:
	    check_state_transitions();
	    movement(); 
	    break;
}
//teste