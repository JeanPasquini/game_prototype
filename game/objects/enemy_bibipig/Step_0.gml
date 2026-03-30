// Inherit the parent event
event_inherited();

if(currentState == EnemyState.IDLE || currentState == EnemyState.CHASING){
		sprite_index = spr_enemy_bibipig;
        image_speed = 1;
}
else if (currentState == EnemyState.CHARGING_ATTACK){
		sprite_index = spr_enemy_bibipig_charging;
        image_speed = 1;
}
