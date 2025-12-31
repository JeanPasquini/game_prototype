enum OctopusState {
	STARTING_ATTACK,
	ENDING_ATTACK
}
movementSpeed = 2;
currentState = OctopusState.STARTING_ATTACK;

tentacles = ds_list_create();
max_tentacles = 8;
max_bullets = 20;

end_attack_timer = 60 * 8;