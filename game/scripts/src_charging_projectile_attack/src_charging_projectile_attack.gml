function src_charging_projectile_attack(){
	return function () {
		if (!instance_exists(throwsProjectile) && currentAttackDelay <= 0) {
			if (currentState == EnemyState.CHARGING_ATTACK && currentChargingDelay < 0) {
				instance_create_layer(x, y-10, "Instances", throwsProjectile);
				currentAttackDelay = baseAttackDelay;
				currentChargingDelay = baseAttackDelay;
				currentState = EnemyState.CHASING;
			} else if (currentState == EnemyState.CHARGING_ATTACK && currentChargingDelay >= 0) {
				currentChargingDelay--;
			} else if (currentMovement == EnemyState.ONGROUND) {
				currentState = EnemyState.CHARGING_ATTACK;
			}
		} else if (!instance_exists(throwsProjectile)) {
			currentAttackDelay--;
		}
		
		// Checks if the enemy should still chase
		if (distance_to_object(obj_player) > detectionRadius ) {
			currentState = EnemyState.IDLE;
			return;
		}	
	}
}