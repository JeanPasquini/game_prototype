enum EnemyState {
	IDLE,
	CHASING
}

currentState = EnemyState.IDLE;
detectionRadius = 100;
maxRandomMovement = 100;
movementSpeed = 0.5;
throwsProjectile = noone;
baseAttackDelay = 1 * 60;
currentAttackDelay = baseAttackDelay;
meleeRange = 10;

speed = movementSpeed;
direction = 0;  // 180 = left, 0 = right