// Inherit the parent event
event_inherited();

detectionRadius = 180;
life = 10;

throwsProjectile = obj_air_projectile
hasToChargeAttack = true
movementStyle = EnemyMovementStyle.JUMPING;
currentAttackDelay = 0;
chargingAttackTimer = 120;
chargingAttackCountDown = chargingAttackTimer;