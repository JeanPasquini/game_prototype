function src_charging_sprint_attack(){
	return function () {
		
		if (currentState == EnemyState.CHARGING_ATTACK && currentChargingDelay < 0) {
			// Check to attack after charging 
			currentAttackDelay = baseAttackDelay;
			currentChargingDelay = baseAttackDelay;
			currentState = EnemyState.CHASING;
		} else if (currentState == EnemyState.CHARGING_ATTACK && currentChargingDelay >= 0) {
			// Chargin attack timer 
			currentChargingDelay--;
		} else if (
			// Check to charge the attack after chasing
			currentState == EnemyState.CHASING 
			&& currentAttackDelay <= 0 
			&& currentMovement == EnemyState.ONGROUND) {
			currentState = EnemyState.CHARGING_ATTACK;
		} else if (
			// Attack interval timer
			currentState == EnemyState.CHASING 
			&& currentAttackDelay > 0 
			&& currentMovement == EnemyState.ONGROUND) {
			currentAttackDelay--;
		} else if (distance_to_object(obj_player) > detectionRadius ) {
			currentState = EnemyState.IDLE;
			return;
		}
		
	}
}