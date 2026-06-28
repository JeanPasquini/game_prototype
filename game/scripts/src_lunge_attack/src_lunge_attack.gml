function src_lunge_attack(){
	return function () {
		if (distance_to_object(obj_player) > detectionRadius ) {
			currentState = EnemyState.IDLE;
			return;
		}
		
		if (currentState == EnemyState.CHASING) {
	        currentAttackDelay--;

	        if (currentAttackDelay <= 0) {
	            retreatTimer = 30;
	            currentState = EnemyState.RETREAT;
	        }
	    } else if (currentState == EnemyState.RETREAT) {
	        retreatTimer--;
	        if (retreatTimer <= 0) {
				currentState = EnemyState.CHASING;
				currentAttackDelay = baseAttackDelay;
	        }
	    }
	   
	}
}