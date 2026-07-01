function src_lunge_attack(){
	return function () {
		if (distance_to_object(obj_player) > detectionRadius ) {
			currentState = EnemyState.IDLE;
			maxOffsetUp = 0;
			maxOffsetDown = 0;
			return;
		}

		if (currentState == EnemyState.RETREAT) {
	        retreatTimer--;
	        if (retreatTimer <= 0) {
				currentState = EnemyState.CHASING;
				currentAttackDelay = baseAttackDelay;
	        }
	    }
	   
	}
}