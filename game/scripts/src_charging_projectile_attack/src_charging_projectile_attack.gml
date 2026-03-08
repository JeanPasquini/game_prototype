function src_charging_projectile_attack(){
	return function () {
		if (!instance_exists(throwsProjectile)) {
			if (currentAttackDelay == 0) {
				isCharging = false;
				instance_create_layer(x, y, "Instances", throwsProjectile);
				currentAttackDelay = baseAttackDelay;
			} else {
				isCharging = true;
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