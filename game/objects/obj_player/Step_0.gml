if (life <= 0){
	life = life_max; // redefines the player life 
	// teleports the player to the origin of the room
	global.current_phase = "phase_01";
	var directions = getNextRoomPxAndPy(HUB, "up");
	obj_player.x = directions.px;
    obj_player.y = directions.py;
	room_goto(HUB); // reload the other objects from the room
}

if(downed) state = PlayerState.DOWNED
attackSmoothing();

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
	case PlayerState.WAIT_ATTACK:
		combat();
    case PlayerState.LIGHT_ATTACK:
    case PlayerState.HEAVY_ATTACK:
		movement(); 
        attack_timer--;
        if (attack_timer <= 0 && state != PlayerState.WAIT_ATTACK) {
            state = PlayerState.WAIT_ATTACK;
        }
	case PlayerState.TALKING:
	case PlayerState.DOWNED:
		movement(); 
    break;
}
