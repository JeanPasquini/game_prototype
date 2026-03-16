function src_charging_projectile_attack(){
	return function () {
		if (!instance_exists(throwsProjectile)) {
			if (currentState == EnemyState.CHARGING_ATTACK && currentAttackDelay <= 0) {
				instance_create_layer(x, y-10, "Instances", throwsProjectile);
				currentAttackDelay = baseAttackDelay;
				currentState = EnemyState.CHASING;
			} else if (currentMovement == EnemyState.ONGROUND) {
				currentState = EnemyState.CHARGING_ATTACK;
				currentAttackDelay--;
			}
		}
		
		// Checks if the enemy should still chase
		if (distance_to_object(obj_player) > detectionRadius ) {
			currentState = EnemyState.IDLE;
			return;
		}	
	}
}