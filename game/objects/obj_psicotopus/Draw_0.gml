// Inherit the parent event
event_inherited();

if (currentState == EnemyState.SPECIAL_ATTACK){
	if (currentAttackState == AttackState.TRIPLE_VERTICAL){
		sprite_index = spr_psicotopus_attacking;
	}
}
else{
	if(currentState == EnemyState.CHASING){
		sprite_index = spr_psicotopus_walking;
	}
}