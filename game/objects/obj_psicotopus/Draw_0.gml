// Inherit the parent event
event_inherited();

if (currentState == EnemyState.SPECIAL_ATTACK){
	if (currentAttackState == AttackState.TRIPLE_VERTICAL){
		scr_set_sprite_once(spr_psicotopus_triple_vertical_start, "flag_triple_vertical_start_sprite");
	}
	else if (currentAttackState == AttackState.FLOOD){
		scr_set_sprite_once(spr_psicotopus_flood_start, "flag_flood_sprite");	
	}
}
else{
	if(currentState == EnemyState.CHASING){
		sprite_index = spr_psicotopus_walking;
	}
}

