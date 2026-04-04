function src_charging_sprint_attack(){
	return function () {
		
		if (currentState == EnemyState.CHARGING_ATTACK && currentChargingDelay < 0) {
			// increases the enemy speed? Just set a special state?
			currentAttackDelay = baseAttackDelay;
			currentChargingDelay = baseAttackDelay;
			currentState = EnemyState.CHASING;
		} else if (currentState == EnemyState.CHARGING_ATTACK && currentChargingDelay >= 0) {
			currentChargingDelay--;
		} else if (currentState == EnemyState.CHASING && currentAttackDelay <= 0) {
			currentState = EnemyState.CHARGING_ATTACK;
		} else {
			currentAttackDelay--;
		}
		
		// Checks if the enemy should still chase
		if (distance_to_object(obj_player) > detectionRadius ) {
			currentState = EnemyState.IDLE;
			return;
		}	
	}
}