enum OctopusState {
	STARTING_ATTACK,
	ENDING_ATTACK
}


bodyX = x;
bodyY = y;
movementSpeed = 2;
currentState = OctopusState.STARTING_ATTACK;

tentacles = ds_list_create();
max_tentacles = 8;
spawn_tentacles_timer = 60;
end_attack_timer = 60 * 8;