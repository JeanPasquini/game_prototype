event_inherited();

if(currentState == EnemyState.IDLE){
		sprite_index = spr_enemy_02_running;
        image_speed = 1;
}
else if (currentState == EnemyState.CHASING){
		sprite_index = spr_enemy_02_running;
        image_speed = 1;
}