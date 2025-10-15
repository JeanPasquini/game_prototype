enum EnemyState {
	IDLE,
	CHASING,
	JUMPING,
	ONGROUND,
	FALLING,
	STAGGER,
	DOWNED
}

currentState = EnemyState.IDLE;
currentMovement = EnemyState.ONGROUND;
detectionRadius = 100;
maxRandomMovement = 100;
movementSpeed = 1;
throwsProjectile = noone;
baseAttackDelay = 1 * 60;
currentAttackDelay = baseAttackDelay;
meleeRange = 10;
jump_direction = 1;

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