function src_charging_projectile_attack(){
	return function () {
		
					
		if (!instance_exists(throwsProjectile) && currentAttackDelay <= 0) {
			if (instance_exists(obj_player)) {
				face = sign(obj_player.x - x);
			}
			if (currentState == EnemyState.CHARGING_ATTACK && currentChargingDelay < 0) {
				if(sprite_index == spr_enemy_cururu_charging){
					image_index = 0;
					image_speed = 1;
					sprite_index = spr_enemy_cururu_attacking;
				}
				else if(image_index >= image_number - 1 && sprite_index == spr_enemy_cururu_attacking){
					scr_audio_play([sde_enemy_cururu_attack], emitterAudio);
					instance_create_layer(x, y-10, "Instances", throwsProjectile);
					currentAttackDelay = baseAttackDelay;
					currentChargingDelay = baseAttackDelay;
					currentState = EnemyState.CHASING;
				}
			} else if (currentState == EnemyState.CHARGING_ATTACK && currentChargingDelay >= 0) {
				currentChargingDelay--;
				if (instance_exists(obj_player)) {
					face = sign(obj_player.x - x);
				}
				if(sprite_index != spr_enemy_cururu_charging){
					//scr_audio_play([sde_enemy_cururu_charging_attack], emitterAudio);
					sprite_index = spr_enemy_cururu_charging;
					image_index = 0;
					image_speed =  60 / baseAttackDelay;
				}
			} else if (currentMovement == EnemyState.ONGROUND) {
				currentState = EnemyState.CHARGING_ATTACK;
			}
		} else if (!instance_exists(throwsProjectile)) {
			currentAttackDelay--;
		}
		
		// Checks if the enemy should still chase
		if (distance_to_object(obj_player) > detectionRadius ) {
			currentState = EnemyState.IDLE;
			return;
		}	
	}
}