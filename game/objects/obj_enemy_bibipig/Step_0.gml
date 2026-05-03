// Inherit the parent event
event_inherited();
image_xscale = image_xscale * -1;
if(currentState == EnemyState.IDLE){
		sprite_index = spr_enemy_bibipig_walking;
        image_speed = 1;
}
else if (currentState == EnemyState.CHARGING_ATTACK){
		sprite_index = spr_enemy_bibipig_charging;
        image_speed = 1;
}
else if (currentState == EnemyState.CHASING){
		sprite_index = spr_enemy_bibipig_attacking;
        image_speed = 1;	
}
