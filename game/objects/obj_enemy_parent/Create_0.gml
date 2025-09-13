enum EnemyState {
	IDLE,
	CHASING
}

currentState = EnemyState.IDLE;
detectionRadius = 100;
maxRandomMovement = 100;
movementSpeed = 0.5;
throwsProjectile = noone;
projectileDelay = 1 * 60;

// Movement
hsp = 0;
face = 1;
vsp = 0;
grv = 0.5;

speed = movementSpeed;
direction = 0;  // 180 = left, 0 = right