enum EnemyState {
	IDLE,
	CHASING,
	STAGGER,
	DOWNED
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

// Status Combat
stagger = 0;
downed = false;


speed = movementSpeed;
direction = 0;  // 180 = left, 0 = right

knockback_x = 0;
knockback_y = 0;