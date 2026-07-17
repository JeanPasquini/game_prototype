// Inherit the parent event
image_xscale = face;

event_inherited();

if(currentState == EnemyState.IDLE || currentState == EnemyState.CHASING){
	if(currentMovement == EnemyState.JUMPING && sprite_index != spr_enemy_cururu_falling){
		sprite_index = spr_enemy_cururu_jumping;
        image_speed = 1;
	}
	else if(currentMovement = EnemyState.ONGROUND){
		sprite_index = spr_enemy_cururu_idle;
        image_speed = 1;
	}
}
else if (currentState == EnemyState.CHARGING_ATTACK) {
	if (instance_exists(obj_player)) {
		face = sign(obj_player.x - x);
	}
			
	if (currentChargingDelay >= 0) {
		if (sprite_index != spr_enemy_cururu_charging) {
			sprite_index = spr_enemy_cururu_charging;
			image_index = 0;
			image_speed = 60 / baseAttackDelay;
		}
	} else {
		if (sprite_index != spr_enemy_cururu_attacking) {
			sprite_index = spr_enemy_cururu_attacking;
			image_index = 0;
			image_speed = 1;
			scr_audio_play([sde_enemy_cururu_attack], emitterAudio);
		}
	}
}
else if(currentState == EnemyState.DYING) {
	audio_dying();
	scr_set_sprite_once(spr_enemy_cururu_dying, "flag_spr_enemy_cururu_dying");	
}

