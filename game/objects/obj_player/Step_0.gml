if (life <= 0){
	instance_destroy();
	room_restart();
}

switch (state) {
    case PlayerState.IDLE:
    case PlayerState.WALK:
    case PlayerState.RUN:
        check_state_transitions(); 
        movement();
        combat();
    break;
    
    case PlayerState.RUN_JUMP:
    case PlayerState.RUN_FALL:
    case PlayerState.JUMP:
    case PlayerState.FALL:
        check_state_transitions();
        movement(); 
    break;

    case PlayerState.LIGHT_ATTACK:
    case PlayerState.HEAVY_ATTACK:
        attack_timer--;
        if (attack_timer <= 0) {
            state = PlayerState.IDLE;
        }
    break;
}
