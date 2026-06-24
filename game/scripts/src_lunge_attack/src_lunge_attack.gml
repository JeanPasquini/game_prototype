function src_lunge_attack(){
	return function () {
		if (distance_to_object(obj_player) > detectionRadius ) {
			currentState = EnemyState.IDLE;
			return;
		}
	}
}