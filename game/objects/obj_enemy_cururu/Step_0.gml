// Inherit the parent event
event_inherited();

if (currentState == EnemyState.CHARGING_ATTACK) {
	movementStyle = EnemyMovementStyle.STOPPED;
	
	if (chargingAttackCountDown > 0) {
		chargingAttackCountDown--;
		return;
	}
	
	currentState = EnemyState.CHASING;
	movementStyle = EnemyMovementStyle.NORMAL;
	chargingAttackCountDown = chargingAttackTimer;
}
